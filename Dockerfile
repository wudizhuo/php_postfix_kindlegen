######
# See: https://hub.docker.com/_/php/
######

FROM php:7.0.5-fpm
MAINTAINER wudizhuo <wudizhuo@gmail.com>

######
# You can install php extensions using docker-php-ext-install
######


# Install kindlegen
ENV KINDLEGEN_VERSION=kindlegen_linux_2.6_i386_v2_9
ENV PATH "$PATH:/usr/local/bin"

RUN mkdir -p /tmp/kindlegen && \
	cd /tmp/kindlegen && \
	curl http://kindlegen.s3.amazonaws.com/${KINDLEGEN_VERSION}.tar.gz -o kindlegen.tar.gz && \
	tar xvf kindlegen.tar.gz && \
	chown root. kindlegen && \
	chmod 755 kindlegen && \
	mv kindlegen /usr/local/bin/ && \
	rm -rf /tmp/kindlegen

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install -j$(nproc) gd