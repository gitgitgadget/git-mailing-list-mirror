Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DB3C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJTWn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiJTWnk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:43:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B042F22BC89
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so817280wmb.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVVu7ZNOBpsIWFXKTy7/gjkKY2wrPG70JU+PQ9DpnIs=;
        b=pqgdvpjDp0Tv93xq0UIDObdRU0xzNDyd93w2nJbDT0TSJPEEkrBvX6P3p7DToOhZpe
         X2pfNmjzX1Re4a+JesFdafgiL1AUXAoSoAi8GKI7P5cIoS14LOpfJymemrzsXxMb82y5
         MkrY5ob15og6583Z5/bAU6Yup1dT9tQZcZxSf6sOgiAPAbwI3OQXTQOc1hDBedY42VtT
         InNF1OgbaCN86DoWDlstl4rqkiK699HHuZZ62L+s6JEF2UHmtvL3uQ7sOMrv8jkqD6sQ
         7lN7HE1odyyaABH1yBF7Mon5klFF277E9MKrPw/d08TBQcs36zWTXY2pcH+i4k5RZ+pT
         bBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVVu7ZNOBpsIWFXKTy7/gjkKY2wrPG70JU+PQ9DpnIs=;
        b=D1WiPuptJnR5wWbW0B6aWT4UR9LAH9gylZZlZM3czUGKsm0wxJihsfrD+hq/OJhWEA
         S7bob6oBHLZ8pGROjEx7Rn2FKmyGMawCzztcZeygjSmJJKb7KNMliEEZtb9f/xiqX3+T
         W8ePNnAXMcXUw53/8HpfCgAZXFUyrT80DRFiU6p9VQh01MTAmDtACAz7JyQv/OJnYWOy
         C47wUyFk5fd9garwTi2oXJOiM+KBfuHbAJmwKRVABwpgCAGynKGm32V5Wb/EgGYWG5qp
         Qy029W2atwdzBsw0dDeRvgU1huV0yxvtM24Dedb32f0eRpaRQefd3bylxE9ctLkBZwEb
         CktA==
X-Gm-Message-State: ACrzQf0HHSmIM37Q1faIfhwMF6Cc5irYelTvc3TEXI0ZUqmANjWUfxeQ
        8+CEJlPSwBQfaUpUISzYZ6IPWLEbKM1Spg==
X-Google-Smtp-Source: AMsMyM4PKIQ6VJ95zEuoaRHf3FCa+xz+Ug07X6bCR/mlLFWGAivDiyV9VFXuE+gVfUgOH6WkYjMjiA==
X-Received: by 2002:a05:600c:2b94:b0:3c6:f941:a26f with SMTP id j20-20020a05600c2b9400b003c6f941a26fmr10700738wmc.8.1666305812497;
        Thu, 20 Oct 2022 15:43:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm21102746wrq.72.2022.10.20.15.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:43:31 -0700 (PDT)
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
Subject: [PATCH v3 4/9] Makefile: create and use sections for "define" flag listing
Date:   Fri, 21 Oct 2022 00:43:05 +0200
Message-Id: <patch-v3-4.9-933bef576b3-20221020T223946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
In-Reply-To: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
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
 Makefile | 218 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 126 insertions(+), 92 deletions(-)

diff --git a/Makefile b/Makefile
index e55dc870c5d..b3a717792cf 100644
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
@@ -489,6 +409,120 @@ include shared.mak
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
+# ==== Options for the sha1collisiondetection implementation ====
+#
+# Define DC_SHA1 to enable the collision-detecting sha1
+# algorithm. This is slower, but may detect attempted collision attacks.
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
+# ==== Other SHA-1 implementations ====
+#
+# Define BLK_SHA1 environment variable to make use of the bundled
+# optimized C SHA1 routine.
+#
+# Define OPENSSL_SHA1 environment variable when running make to link
+# with the SHA1 routine from openssl library.
+#
+# === SHA-256 backend ===
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
2.38.0.1178.g509f5fa8ce0

