Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA5AC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiKGVXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiKGVX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:23:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0A246
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:23:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so33658896ejc.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHIwFmCv0uosTLXC/BEROBHrwumgB0WeUrkYNzKWIuc=;
        b=QS7Y2maEsllZythOo125juGAv91TvOc6qpNmq4f0Z8Q9NQZBmSp2Qh6JrU7zXl8+oG
         Sv6UXbSsNd/K/TgK9gbjanT72lcrQww+AEFJ3p8u9bey/8U5vs8HYaInaHSpxAeMyO3q
         0+X9Cl52h8YfGtLOIb+gowZvkW4zPxUQkRMUNSTs92/Dn86Uy47M7YrsljjSZZI7zJFk
         Rb7rLgB0ls7nPOqNlRE0b8cIpFaIWsVTJXHQgUHPFtATJkXl3hJrdxcbXc809A+I7oRa
         igKcVETFne0deCncWfVwqeQB/qBvyrKc7MIi+aWBpwAypn6ne1pWQw5jJvEu4gsGqRI4
         iwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHIwFmCv0uosTLXC/BEROBHrwumgB0WeUrkYNzKWIuc=;
        b=AMf82AJDLFQtkFYDRHZeUbhCmAi2bp+xOfEn631nQpQulCe0fBC2KcqzuFNLzl6C2y
         ZNpVVtfQuNrkgu7gpf+eRbMvjbiuxNY1Z9ZMhKVOdJWVkegozfgN6oaFD0JbsrRPP6gc
         k3pW8dGcdKLFBrcp2r7rfSi5y6qBtt70YIeLtuVwjIWB20cOjDdw/0LcrmeusQSCgV4k
         hZJtjhALBVrIUw83ooHBbGAYdbMfeQzySXR26qBRFqyBvs29RgRFiY6wNBufIKPPjNjH
         zrGkBULna7ic4xRnxTCdpSeiNdZPjRvQBr1USXs2SarHL9/RmA8+u4txpJqtNoXojfvJ
         qVWA==
X-Gm-Message-State: ACrzQf0AGugHnRZ7k7XtukptiDyox1zPCsjqIvOoOWu02EJeqDnAKEyN
        JYs2OCWQWHz03A1A+FI/VVfNno6eOkFxoA==
X-Google-Smtp-Source: AMsMyM7LZPyGjconM7QxlZ/natjquFLHPTA0DHTYgu/zWWcrd12Fh2M5hbq7QEecdjRVpQ1EC4Ebpw==
X-Received: by 2002:a17:906:cecc:b0:78d:408a:4a18 with SMTP id si12-20020a170906cecc00b0078d408a4a18mr855816ejb.261.1667856199854;
        Mon, 07 Nov 2022 13:23:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b0077d6f628e14sm3834418ejb.83.2022.11.07.13.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:23:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/10] Makefile: create and use sections for "define" flag listing
Date:   Mon,  7 Nov 2022 22:23:06 +0100
Message-Id: <patch-v5-04.10-9ab55314296-20221107T211736Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20221107T211736Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "Define ..." template of comments at the top of the Makefile
was started in 5bdac8b3269 ([PATCH] Improve the compilation-time
settings interface, 2005-07-29) we've had a lot more flags added,
including flags that come in "groups". Not having any obvious
structure to the >500 line comment at the top of the Makefile has made
it hard to follow.

This change is almost entirely a move-only change, the two paragraphs
at the start of the first two sections are new, and so are the added
sections themselves, but other than that no lines are changed, only
moved.

We now list Makefile-only flags at the start, followed by stand-alone
flags, and then cover "optional library" flags in their respective
groups, followed by SHA-1 and SHA-256 flags, and finally
DEVELOPER-specific flags.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 220 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 128 insertions(+), 92 deletions(-)

diff --git a/Makefile b/Makefile
index 489327ecd9b..19235624684 100644
--- a/Makefile
+++ b/Makefile
@@ -4,8 +4,20 @@ all::
 # Import tree-wide shared Makefile behavior and libraries
 include shared.mak
 
+# == Makefile defines ==
+#
+# These defines change the behavior of the Makefile itself, but have
+# no impact on what it builds:
+#
 # Define V=1 to have a more verbose compile.
 #
+# == Portability and optional library defines ==
+#
+# These defines indicate what Git can expect from the OS, what
+# libraries are available etc. Much of this is auto-detected in
+# config.mak.uname, or in configure.ac when using the optional "make
+# configure && ./configure" (see INSTALL).
+#
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
 #
 # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
@@ -30,68 +42,8 @@ include shared.mak
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 #
-# Define USE_LIBPCRE if you have and want to use libpcre. Various
-# commands such as log and grep offer runtime options to use
-# Perl-compatible regular expressions instead of standard or extended
-# POSIX regular expressions.
-#
-# Only libpcre version 2 is supported. USE_LIBPCRE2 is a synonym for
-# USE_LIBPCRE, support for the old USE_LIBPCRE1 has been removed.
-#
-# Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
-# in /foo/bar/include and /foo/bar/lib directories.
-#
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that header.
 #
-# Define NO_CURL if you do not have libcurl installed.  git-http-fetch and
-# git-http-push are not built, and you cannot use http:// and https://
-# transports (neither smart nor dumb).
-#
-# Define CURLDIR=/foo/bar if your curl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
-#
-# Define CURL_CONFIG to curl's configuration program that prints information
-# about the library (e.g., its version number).  The default is 'curl-config'.
-#
-# Define CURL_LDFLAGS to specify flags that you need to link when using libcurl,
-# if you do not want to rely on the libraries provided by CURL_CONFIG.  The
-# default value is a result of `curl-config --libs`.  An example value for
-# CURL_LDFLAGS is as follows:
-#
-#     CURL_LDFLAGS=-lcurl
-#
-# Define NO_EXPAT if you do not have expat installed.  git-http-push is
-# not built, and you cannot push using http:// and https:// transports (dumb).
-#
-# Define EXPATDIR=/foo/bar if your expat header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
-#
-# Define EXPAT_NEEDS_XMLPARSE_H if you have an old version of expat (e.g.,
-# 1.1 or 1.2) that provides xmlparse.h instead of expat.h.
-#
-# Define NO_GETTEXT if you don't want Git output to be translated.
-# A translated Git requires GNU libintl or another gettext implementation,
-# plus libintl-perl at runtime.
-#
-# Define USE_GETTEXT_SCHEME and set it to 'fallthrough', if you don't trust
-# the installed gettext translation of the shell scripts output.
-#
-# Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
-# trust the langinfo.h's nl_langinfo(CODESET) function to return the
-# current character set. GNU and Solaris have a nl_langinfo(CODESET),
-# FreeBSD can use either, but MinGW and some others need to use
-# libcharset.h's locale_charset() instead.
-#
-# Define CHARSET_LIB to the library you need to link with in order to
-# use locale_charset() function.  On some platforms this needs to set to
-# -lcharset, on others to -liconv .
-#
-# Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
-# need -lintl when linking.
-#
-# Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
-# doesn't support GNU extensions like --check and --statistics
-#
 # Define HAVE_PATHS_H if you have paths.h and want to use the default PATH
 # it specifies.
 #
@@ -152,38 +104,6 @@ include shared.mak
 # and do not want to use Apple's CommonCrypto library.  This allows you
 # to provide your own OpenSSL library, for example from MacPorts.
 #
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
-#
-# Define DC_SHA1 to enable the collision-detecting sha1
-# algorithm. This is slower, but may detect attempted collision attacks.
-#
-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
-# git with the external SHA1 collision-detect library.
-# Without this option, i.e. the default behavior is to build git with its
-# own built-in code (or submodule).
-#
-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
-# sha1collisiondetection shipped as a submodule instead of the
-# non-submodule copy in sha1dc/. This is an experimental option used
-# by the git project to migrate to using sha1collisiondetection as a
-# submodule.
-#
-# Define OPENSSL_SHA1 environment variable when running make to link
-# with the SHA1 routine from openssl library.
-#
-# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
-# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
-# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
-#
-# Define BLK_SHA256 to use the built-in SHA-256 routines.
-#
-# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
-#
-# Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
-#
-# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
-#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -489,6 +409,122 @@ include shared.mak
 # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
 # that implements the `fsm_os_settings__*()` routines.
 #
+# === Optional library: libintl ===
+#
+# Define NO_GETTEXT if you don't want Git output to be translated.
+# A translated Git requires GNU libintl or another gettext implementation,
+# plus libintl-perl at runtime.
+#
+# Define USE_GETTEXT_SCHEME and set it to 'fallthrough', if you don't trust
+# the installed gettext translation of the shell scripts output.
+#
+# Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
+# trust the langinfo.h's nl_langinfo(CODESET) function to return the
+# current character set. GNU and Solaris have a nl_langinfo(CODESET),
+# FreeBSD can use either, but MinGW and some others need to use
+# libcharset.h's locale_charset() instead.
+#
+# Define CHARSET_LIB to the library you need to link with in order to
+# use locale_charset() function.  On some platforms this needs to set to
+# -lcharset, on others to -liconv .
+#
+# Define LIBC_CONTAINS_LIBINTL if your gettext implementation doesn't
+# need -lintl when linking.
+#
+# Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
+# doesn't support GNU extensions like --check and --statistics
+#
+# === Optional library: libexpat ===
+#
+# Define NO_EXPAT if you do not have expat installed.  git-http-push is
+# not built, and you cannot push using http:// and https:// transports (dumb).
+#
+# Define EXPATDIR=/foo/bar if your expat header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
+# Define EXPAT_NEEDS_XMLPARSE_H if you have an old version of expat (e.g.,
+# 1.1 or 1.2) that provides xmlparse.h instead of expat.h.
+
+# === Optional library: libcurl ===
+#
+# Define NO_CURL if you do not have libcurl installed.  git-http-fetch and
+# git-http-push are not built, and you cannot use http:// and https://
+# transports (neither smart nor dumb).
+#
+# Define CURLDIR=/foo/bar if your curl header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
+# Define CURL_CONFIG to curl's configuration program that prints information
+# about the library (e.g., its version number).  The default is 'curl-config'.
+#
+# Define CURL_LDFLAGS to specify flags that you need to link when using libcurl,
+# if you do not want to rely on the libraries provided by CURL_CONFIG.  The
+# default value is a result of `curl-config --libs`.  An example value for
+# CURL_LDFLAGS is as follows:
+#
+#     CURL_LDFLAGS=-lcurl
+#
+# === Optional library: libpcre2 ===
+#
+# Define USE_LIBPCRE if you have and want to use libpcre. Various
+# commands such as log and grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
+#
+# Only libpcre version 2 is supported. USE_LIBPCRE2 is a synonym for
+# USE_LIBPCRE, support for the old USE_LIBPCRE1 has been removed.
+#
+# Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
+# in /foo/bar/include and /foo/bar/lib directories.
+#
+# == SHA-1 and SHA-256 defines ==
+#
+# === SHA-1 backend ===
+#
+# ==== Options common to all SHA-1 implementations ====
+#
+# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
+# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
+# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
+#
+# ==== SHA-1 implementations ====
+#
+# Define DC_SHA1 to enable the collision-detecting sha1
+# algorithm. This is slower, but may detect attempted collision attacks.
+#
+# Define BLK_SHA1 environment variable to make use of the bundled
+# optimized C SHA1 routine.
+#
+# Define OPENSSL_SHA1 environment variable when running make to link
+# with the SHA1 routine from openssl library.
+#
+# ==== Options for the sha1collisiondetection library ====
+#
+# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
+# git with the external SHA1 collision-detect library.
+# Without this option, i.e. the default behavior is to build git with its
+# own built-in code (or submodule).
+#
+# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# sha1collisiondetection shipped as a submodule instead of the
+# non-submodule copy in sha1dc/. This is an experimental option used
+# by the git project to migrate to using sha1collisiondetection as a
+# submodule.
+#
+# === SHA-256 backend ===
+#
+# ==== SHA-256 implementations ====
+#
+# Define BLK_SHA256 to use the built-in SHA-256 routines.
+#
+# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
+#
+# Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
+#
+# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
+#
+# == DEVELOPER defines ==
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
-- 
2.38.0.1464.gea6794aacbc

