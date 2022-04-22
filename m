Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C04BC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446281AbiDVJ4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446263AbiDVJ4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:56:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D311753E1A
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c10so10292416wrb.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sePqX8f+H4jaUZ6Quh8ZPFqH9dadargF7IBbj4gV1CA=;
        b=oaqNR+vaqlZJW+R4sGGx7+9RDaMCZNkB7fUsurX/momLrnuiusYlb69Vv6f0RbjjDg
         jSI9scEwcMlc7sQ/Sfks3+XDxAO2GOUGezfNEOSqCkLfQiH//A/MK4BOhLNIdC4oIKw+
         ogtNdHSKheWpByBEaw+kRhwe3EW9lLb7pFtDWSTXXBPE0TQyVmg/EFnZYH/MIGS769WT
         tJILjR/7pcumKE57LdIMti30uFQwGp+X88o2yj/nnD1Olk7/N30JRdeKcraaxZYwaj1F
         dFleQxLFgn2cN819o4ec2S6harPlHimAlt/ADymie1FVBY9Rhn//w2PHT/qyREIfgv8t
         ssqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sePqX8f+H4jaUZ6Quh8ZPFqH9dadargF7IBbj4gV1CA=;
        b=4+zTcAB7rkjMK655qXsq1HqehvA1++D5CGHAHzG7QRbnSCfhg3Lz33uwXXQ66c/ZrH
         4wz+B+QOvyosIoCHTOdPordqQxJ6rrtuQEfZgpRI7fhndCwQw/324Q299mTbIyg5sQLy
         HO5oU2DGHdaC0+Yz6DpmvCo0dlB/EFrsekjXqoBU56ZLt2nODJDWrC5oEQaucrjIcEVU
         1QZIt8REt7BbozxyZmttP0nLScgs2OlgxySTttLKEFgH7jGtKtdQ0uzeBf1EUpqB5RkC
         xMG3uyt16lvp11ZTzgLnx6F56/ZW7kdWWPiYk33oSPQV+8OETUgPBj/+o/ijQ/4Cbu3O
         u+ng==
X-Gm-Message-State: AOAM531tsRg7XkhayLE73kyY421AckRm7cmPW0OLvVsUfRv/1J+AFYEK
        ennY1hcJBSfzPbD101pCoTB2+iDcPWSuQA==
X-Google-Smtp-Source: ABdhPJznPv5bFvA4Y7XuW7KhOTM0zuJ346oYgY2kGubb+ixF9V3Z+AHPT8fu7qKvwcsEzqn+YyjVoA==
X-Received: by 2002:a5d:5904:0:b0:20a:bde8:ed8e with SMTP id v4-20020a5d5904000000b0020abde8ed8emr3043306wrd.215.1650621204081;
        Fri, 22 Apr 2022 02:53:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6-20020adfa506000000b0020ac34ec647sm1365561wrb.110.2022.04.22.02.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:53:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] Makefile: really use and document sha1collisiondetection by default
Date:   Fri, 22 Apr 2022 11:53:13 +0200
Message-Id: <patch-2.5-5ffb68dc77b-20220422T094624Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
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

1. 48b3693d3ce (Merge branch 'jk/sha1dc', 2017-03-24)
2. 8325e43b82d (Makefile: add DC_SHA1 knob, 2017-03-16)
3. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
4. 5beb577db8c (INSTALL: Describe dependency knobs from Makefile,
   2009-09-10)
5. 4dcd7732db0 (Makefile: add support for Apple CommonCrypto facility,
   2013-05-19)
6. 3ef2bcad02e (imap-send: use Apple's Security framework for base64
   encoding, 2013-07-29)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL                             |  11 +--
 Makefile                            | 108 ++++++++++++++++++----------
 contrib/buildsystems/CMakeLists.txt |   3 +-
 hash.h                              |  10 +--
 t/t0013-sha1dc.sh                   |   4 +-
 5 files changed, 88 insertions(+), 48 deletions(-)

diff --git a/INSTALL b/INSTALL
index 4140a3f5c8b..8fc350fc124 100644
--- a/INSTALL
+++ b/INSTALL
@@ -133,10 +133,13 @@ Issues of note:
 	  you are using libcurl older than 7.34.0.  Otherwise you can use
 	  NO_OPENSSL without losing git-imap-send.
 
-	  By default, git uses OpenSSL for SHA1 but it will use its own
-	  library (inspired by Mozilla's) with either NO_OPENSSL or
-	  BLK_SHA1.  Also included is a version optimized for PowerPC
-	  (PPC_SHA1).
+	- Git uses an altered version of SHA-1 by default which
+          detects the SHAttered attack via the sha1collisiondetection
+          counter-cryptanalysis library. For SHA-256 we'll select a
+          working implementation (and ship a fallback
+          implementation). See the "SHA-1 and SHA-256 defines" section
+          in the Makefile for details. You should not need to tweak
+          those settings.
 
 	- "libcurl" library is used for fetching and pushing
 	  repositories over http:// or https://, as well as by
diff --git a/Makefile b/Makefile
index 246f6729022..12bb9edd70a 100644
--- a/Makefile
+++ b/Makefile
@@ -468,33 +468,65 @@ include shared.mak
 #
 # == SHA-1 and SHA-256 defines ==
 #
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
+# === SHA-1 backend ===
 #
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
+# Due to the SHAttered (https://shattered.io) attack vector on SHA-1
+# Git uses the sha1collisiondetection counter-cryptanalysis library
+# for SHA-1 hashing.
+#
+# You're strongly advised not to override this for any usage of Git
+# where you don't 100% trust the repository content.
+#
+# ==== Options common to all SHA-1 implementations ====
+#
+# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
+# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
+# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
 #
-# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
-# algorithm. This is slower, but may detect attempted collision attacks.
-# Takes priority over other *_SHA1 knobs.
+# ===== Options for the default sha1collisiondetection implementations =====
 #
-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
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
+# Define PPC_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine optimized for PowerPC.
+#
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
@@ -1434,7 +1466,6 @@ ifeq ($(uname_S),Darwin)
 	endif
 	ifndef NO_APPLE_COMMON_CRYPTO
 		NO_OPENSSL = YesPlease
-		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
 	endif
 	NO_REGEX = YesPlease
@@ -1796,30 +1827,15 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
-ifdef APPLE_COMMON_CRYPTO
-	# Apple CommonCrypto requires chunking
-	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
+ifdef DC_SHA1
+$(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
 endif
-
-ifdef OPENSSL_SHA1
-	EXTLIBS += $(LIB_4_CRYPTO)
-	BASIC_CFLAGS += -DSHA1_OPENSSL
-else
-ifdef BLK_SHA1
-	LIB_OBJS += block-sha1/sha1.o
-	BASIC_CFLAGS += -DSHA1_BLK
-else
-ifdef PPC_SHA1
-	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
-	BASIC_CFLAGS += -DSHA1_PPC
-else
-ifdef APPLE_COMMON_CRYPTO
-	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
-	BASIC_CFLAGS += -DSHA1_APPLE
-else
-	DC_SHA1 := YesPlease
-	BASIC_CFLAGS += -DSHA1_DC
+ifndef NO_DC_SHA1
+	ifneq ($(OPENSSL_SHA1)$(BLK_SHA1)$(PPC_SHA1)$(APPLE_SHA1),)
+$(error no other *_SHA1 option can be defined unless NO_DC_SHA1 is defined)
+	endif
 	LIB_OBJS += sha1dc_git.o
+
 ifdef DC_SHA1_EXTERNAL
 	ifdef DC_SHA1_SUBMODULE
 		ifneq ($(DC_SHA1_SUBMODULE),auto)
@@ -1843,6 +1859,26 @@ endif
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
+ifdef PPC_SHA1
+	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+	BASIC_CFLAGS += -DSHA1_PPC
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
@@ -2884,7 +2920,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
-	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
+	@echo NO_DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(NO_DC_SHA1)))'\' >>$@+
 	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
 ifdef FSMONITOR_DAEMON_BACKEND
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 185f56f414f..10616188e4e 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -996,7 +996,6 @@ set(NO_PERL )
 set(NO_PTHREADS )
 set(NO_PYTHON )
 set(PAGER_ENV "LESS=FRX LV=-c")
-set(DC_SHA1 YesPlease)
 set(RUNTIME_PREFIX true)
 set(NO_GETTEXT )
 
@@ -1032,7 +1031,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_DC_SHA1=''\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
diff --git a/hash.h b/hash.h
index 5d40368f18a..20012167ce4 100644
--- a/hash.h
+++ b/hash.h
@@ -4,16 +4,18 @@
 #include "git-compat-util.h"
 #include "repository.h"
 
-#if defined(SHA1_PPC)
+#if !defined(NO_SHA1_DC)
+#include "sha1dc_git.h"
+#elif defined(SHA1_PPC)
 #include "ppc/sha1.h"
 #elif defined(SHA1_APPLE)
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
 
 #if defined(SHA256_GCRYPT)
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
2.36.0.879.g56a83971f3f

