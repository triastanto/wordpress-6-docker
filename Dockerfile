FROM wordpress:6-php8.1-apache

# Install PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \    
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli

# Configure PHP settings
RUN { \
        echo "allow_url_fopen=On"; \
        echo "memory_limit=256M"; \
        echo "max_execution_time=600"; \
        echo "post_max_size=128M"; \
        echo "upload_max_filesize=128M"; \
    } > $PHP_INI_DIR/conf.d/wordpress.ini