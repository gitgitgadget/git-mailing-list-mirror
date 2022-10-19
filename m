Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A745C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 01:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJSBDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 21:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSBDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 21:03:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D8DED38
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j16so26581500wrh.5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUs4gYllbwQQa3QUVj4MC3IPdEk/QC28Kut0M2cVom4=;
        b=JYGV4THeFjmaroGWu2zbtIuEoTrdQEqj+0KA6QnttVxOqayGBAlMuez/e8xeM2QtlM
         BoKdCdwECkxwBnDKdVgqttgYpIn2QVpj8GO507IYkV4hzRX0ixIDL8LR1axfiYVkOroF
         sFoTKFNOz6UZ9BplQ1wnL+wV9o28A6aImYwoJNsdlKapI6WNV0uB+sjVD3hDJyTGIYRN
         l4dHV80dPQptQpiIPrSvSOc9nqaI32YQaZhJXocHq/ARMwqsOrCaMGWYDMOGDTf+45ra
         1ZM3Js09ziLiGJMR/5o3LWvLo34szLb33K+HxUVa6ZiahrBiLFHGoNNIYStqrr4rqDNb
         ANsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUs4gYllbwQQa3QUVj4MC3IPdEk/QC28Kut0M2cVom4=;
        b=OpdTgQZFUKQkbVLsFu/St0b9HJNq6GVF3Bwwcd2S52CNok8ii6bXBy5rzSDVH80URV
         +czUPYAbjcdzb+ufvFRGXfRe9adJOSB2OQWHMZXBr0RWYqRVPBwHhWuNFlS0kZo1OWNw
         /jY6/k273OS99Ses5gZkTx24RQRy1I3cvFaBakvs4CWm3AWgYbp1CGlJE2UWepur47Pu
         nVdgEea8dmV6FYi4MonL1YlzFXUnhi+N22LSGCb/ZQ1gvfSYXD7+JbqTeJyWGrK07EMu
         NoslFwU2i/sJhEc+RmDwa1dbYo3Ut2ugrdJfVmh3R5fj8XtJud/R/bWRAFvTwOk5pwGk
         0D6w==
X-Gm-Message-State: ACrzQf3ZDbKWEU1/CHLHKJCd5ze2mNy1MNWQWF0sEh7FJS+CfzCVl/YP
        Ai+n7SG9G4Q9ju8wxBu7PihkOlga/HREeA==
X-Google-Smtp-Source: AMsMyM7hUbmeN+uG7GMLtpOzdF5ym7gDpqLtG72O9cM+l3lChuJ6bP9k2bqGBm08LUrIxTCIJTg0jg==
X-Received: by 2002:a5d:47c5:0:b0:22e:655e:f258 with SMTP id o5-20020a5d47c5000000b0022e655ef258mr3171425wrc.569.1666141413276;
        Tue, 18 Oct 2022 18:03:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3-20020a056000136300b0022e3cba367fsm12161315wrz.100.2022.10.18.18.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:03:32 -0700 (PDT)
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
Subject: [PATCH v2 3/4] Makefile: really use and document sha1collisiondetection by default
Date:   Wed, 19 Oct 2022 03:03:21 +0200
Message-Id: <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcd4a685f0b1
In-Reply-To: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the sha1collisiondetection library was added and made the default
in [1] we never updated the documentation added in [2] early in that
series once the default was flipped to DC_SHA1 in [3]. Furthermore the
INSTALL file has been claiming that we use OpenSSL by default since
[4], and hadn't been updated for the sha1collisiondetection switch.

The interaction between NO_APPLE_COMMON_CRYPTO and DC_SHA1 seems to
have been missed in [3], so ever since DC_SHA1 was made the default
we've still used Apple's CommonCrypto instead of
sha1collisiondetection on Darwin and Mac OS X.

Instead off all of this we now:

* Don't have a DC_SHA1 know anymore (using it is an error), you need
  to set NO_DC_SHA1 instead to use any optional *_SHA1 implementation.
* Re-arranged the algorithm inclusion in hash.h to correspond to
  NO_DC_SHA1, and "#error" if we have no defined SHA_*, rather than
  silently picking block-sha1/sha1.h as a fallback.
* Have an INSTALL that reflects reality. We were still claiming to use
  OpenSSL's SHA-1 hashing by default.
* Have Darwin and Mac OS X use sha1collisiondetection, like everywhere
  else. There is still a NO_APPLE_COMMON_CRYPTO knob, but it's used for
  things unrelated to SHA-1 (see [6]).
* Have a rewritten discussion of SHA-1 and SHA-256 in the Makefile
  which covers all of this.

Let's also change the CI for "osx-clang" to test with the new
APPLE_SHA1 knob ("osx-gcc" uses the new sha1collisiondetection
default).

In practice this will spot issues like the one noted in [7], as
testing with just two backends should be enough to spot unportable
code. Ideally we'd have other CI jobs to test the various SHA-1
combinations, but for now we have better CI coverage than before.

1. 48b3693d3ce (Merge branch 'jk/sha1dc', 2017-03-24)
2. 8325e43b82d (Makefile: add DC_SHA1 knob, 2017-03-16)
3. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
4. 5beb577db8c (INSTALL: Describe dependency knobs from Makefile,
   2009-09-10)
5. 4dcd7732db0 (Makefile: add support for Apple CommonCrypto facility,
   2013-05-19)
6. 3ef2bcad02e (imap-send: use Apple's Security framework for base64
   encoding, 2013-07-29)
7. https://lore.kernel.org/git/kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL                             | 10 ++-
 Makefile                            | 98 ++++++++++++++++++++---------
 ci/lib.sh                           |  3 +
 contrib/buildsystems/CMakeLists.txt |  3 +-
 hash.h                              | 10 +--
 t/t0013-sha1dc.sh                   |  4 +-
 6 files changed, 86 insertions(+), 42 deletions(-)

diff --git a/INSTALL b/INSTALL
index 89b15d71df5..065ed81bd54 100644
--- a/INSTALL
+++ b/INSTALL
@@ -133,9 +133,13 @@ Issues of note:
 	  you are using libcurl older than 7.34.0.  Otherwise you can use
 	  NO_OPENSSL without losing git-imap-send.
 
-	  By default, git uses OpenSSL for SHA1 but it will use its own
-	  library (inspired by Mozilla's) with either NO_OPENSSL or
-	  BLK_SHA1.
+	- Git uses an altered version of SHA-1 by default which
+	  detects the SHAttered attack via the sha1collisiondetection
+	  counter-cryptanalysis library. For SHA-256 we'll select a
+	  working implementation (and ship a fallback
+	  implementation). See the "SHA-1 and SHA-256 defines" section
+	  in the Makefile for details. You should not need to tweak
+	  those settings.
 
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
diff --git a/Makefile b/Makefile
index 18ad487274e..7a7411df8c3 100644
--- a/Makefile
+++ b/Makefile
@@ -479,30 +479,62 @@ include shared.mak
 #
 # == SHA-1 and SHA-256 defines ==
 #
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
+# === SHA-1 backend ===
+#
+# Due to the SHAttered (https://shattered.io) attack vector on SHA-1
+# Git uses the sha1collisiondetection counter-cryptanalysis library
+# for SHA-1 hashing.
+#
+# You're strongly advised not to override this for any usage of Git
+# where you don't 100% trust the repository content.
 #
-# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
-# algorithm. This is slower, but may detect attempted collision attacks.
-# Takes priority over other *_SHA1 knobs.
+# ==== Options common to all SHA-1 implementations ====
 #
-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
+# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
+# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
+# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
+#
+# ===== Options for the default sha1collisiondetection implementations =====
+#
+# Define DC_SHA1_EXTERNAL if you want to build / link
 # git with the external SHA1 collision-detect library.
 # Without this option, i.e. the default behavior is to build git with its
 # own built-in code (or submodule).
 #
-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# Define DC_SHA1_SUBMODULE to use the
 # sha1collisiondetection shipped as a submodule instead of the
 # non-submodule copy in sha1dc/. This is an experimental option used
 # by the git project to migrate to using sha1collisiondetection as a
 # submodule.
 #
+# ==== Alternate implementations ====
+#
+# Git still ships with alternate SHA-1 implementations. These are
+# faster than the default, which is useful when hashing speed
+# is imperative, consider using them if you're confident that you
+# won't need to worry about SHA-1 collision attacks.
+#
+# To use them you must define NO_DC_SHA1 and one of the *_SHA1
+# variables below:
+#
+# Define BLK_SHA1 environment variable to make use of the bundled
+# optimized C SHA1 routine.
+#
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
 #
-# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
-# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
-# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
+# Define APPLE_SHA1 to use Apple's CommonCrypto SHA-1 routines on
+# Darwin/Mac OS X.
+#
+# The APPLE_SHA1 option is unrelated to the NO_APPLE_COMMON_CRYPTO
+# flag, which determines if Apple's crypto libraries are used for
+# things that aren't SHA-1.
+#
+# === SHA-256 backend ===
+#
+# Unlike SHA-1 the SHA-256 algorithm does not suffer from any known
+# vulnerabilities, so any implementation will do. BLK_SHA256 is
+# currently the default implementation (but that may change).
 #
 # Define BLK_SHA256 to use the built-in SHA-256 routines.
 #
@@ -1464,7 +1496,6 @@ ifeq ($(uname_S),Darwin)
 	endif
 	ifndef NO_APPLE_COMMON_CRYPTO
 		NO_OPENSSL = YesPlease
-		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
 	endif
 	PTHREAD_LIBS =
@@ -1825,30 +1856,19 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
-ifdef APPLE_COMMON_CRYPTO
-	# Apple CommonCrypto requires chunking
-	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
-endif
-
 ifdef PPC_SHA1
 $(error the PPC_SHA1 flag has been removed along with the PowerPC-specific SHA-1 implementation.)
 endif
 
-ifdef OPENSSL_SHA1
-	EXTLIBS += $(LIB_4_CRYPTO)
-	BASIC_CFLAGS += -DSHA1_OPENSSL
-else
-ifdef BLK_SHA1
-	LIB_OBJS += block-sha1/sha1.o
-	BASIC_CFLAGS += -DSHA1_BLK
-else
-ifdef APPLE_COMMON_CRYPTO
-	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
-	BASIC_CFLAGS += -DSHA1_APPLE
-else
-	DC_SHA1 := YesPlease
-	BASIC_CFLAGS += -DSHA1_DC
+ifdef DC_SHA1
+$(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
+endif
+ifndef NO_DC_SHA1
+	ifneq ($(OPENSSL_SHA1)$(BLK_SHA1)$(APPLE_SHA1),)
+$(error no other *_SHA1 option can be defined unless NO_DC_SHA1 is defined)
+	endif
 	LIB_OBJS += sha1dc_git.o
+
 ifdef DC_SHA1_EXTERNAL
 	ifdef DC_SHA1_SUBMODULE
 		ifneq ($(DC_SHA1_SUBMODULE),auto)
@@ -1872,6 +1892,22 @@ endif
 		-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" \
 		-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
 endif
+else # !NO_DC_SHA1
+BASIC_CFLAGS += -DNO_SHA1_DC
+ifdef OPENSSL_SHA1
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA1_OPENSSL
+else
+ifdef BLK_SHA1
+	LIB_OBJS += block-sha1/sha1.o
+	BASIC_CFLAGS += -DSHA1_BLK
+else
+ifdef APPLE_SHA1
+	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
+	BASIC_CFLAGS += -DSHA1_APPLE
+else
+$(error when defining NO_DC_SHA1 another valid *_SHA1 variable must be defined!)
+endif
 endif
 endif
 endif
@@ -3009,7 +3045,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_REGEX=\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
-	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
+	@echo NO_DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(NO_DC_SHA1)))'\' >>$@+
 	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
 	@echo SANITIZE_ADDRESS=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_ADDRESS)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57db..320f992680a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -264,6 +264,9 @@ macos-latest)
 esac
 
 case "$jobname" in
+osx-clang)
+	MAKEFLAGS="$MAKEFLAGS NO_DC_SHA1=Yes APPLE_SHA1=Yes"
+	;;
 linux32)
 	CC=gcc
 	;;
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 787738e6fa3..14ac3d49849 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1025,7 +1025,6 @@ set(NO_PERL )
 set(NO_PTHREADS )
 set(NO_PYTHON )
 set(PAGER_ENV "LESS=FRX LV=-c")
-set(DC_SHA1 YesPlease)
 set(RUNTIME_PREFIX true)
 set(NO_GETTEXT )
 
@@ -1061,7 +1060,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_DC_SHA1=''\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
diff --git a/hash.h b/hash.h
index 36b64165fc9..a7337779949 100644
--- a/hash.h
+++ b/hash.h
@@ -4,14 +4,16 @@
 #include "git-compat-util.h"
 #include "repository.h"
 
-#if defined(SHA1_APPLE)
+#if !defined(NO_SHA1_DC)
+#include "sha1dc_git.h"
+#elif defined(SHA1_APPLE)
 #include <CommonCrypto/CommonDigest.h>
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
-#elif defined(SHA1_DC)
-#include "sha1dc_git.h"
-#else /* SHA1_BLK */
+#elif defined(SHA1_BLK)
 #include "block-sha1/sha1.h"
+#else
+#error "need a SHA1_* implementation defined"
 #endif
 
 #if defined(SHA256_NETTLE)
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 9ad76080aa4..539270a2665 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -6,9 +6,9 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
-if test -z "$DC_SHA1"
+if test -n "$NO_DC_SHA1"
 then
-	skip_all='skipping sha1 collision tests, DC_SHA1 not set'
+	skip_all='skipping sha1 collision tests, NO_DC_SHA1 set'
 	test_done
 fi
 
-- 
2.38.0.1093.gcd4a685f0b1

