Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D88C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 01:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJSBDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 21:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJSBDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 21:03:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641D1C96DE
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j16so26581394wrh.5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8biJdfaHi62aToj7AOwaWjqJyAzqgafwYNCQ53dWkzA=;
        b=eMRB1ZOcllboyp28P6DJQewKhuEUCtUc8yMXx+OhKoEbcRa8iJHWCB8L2F/XhNYqwE
         9Sl7B+HaPntKn1ntkA8+lHlBTQTLEL2SnwrLxJc9RrxEIEKKnCy5tP5a1EDOiBlCH0xf
         LrTbslQ4347G7g4DXi7cZYHcKyUcrcnBNatfeJjw5KhRqImJWfrpP+qOTZKMXKdzZYZc
         FQmGhMwbb82oAKVywGLLYIz1Rb6jaBQNBdSIEMVF2OuMiMkSgtA1NYjgh7Lzh2dCJgno
         tsc3HhsmYUOpiSxOb9wGGJ0ZxifYtBvUMIdJxfg9GpMY17xRPEjLwcJpoEu3ex5qlgmS
         Wdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8biJdfaHi62aToj7AOwaWjqJyAzqgafwYNCQ53dWkzA=;
        b=C92vRCzZhOIXPx6VisVS7kJVN/B/rHWUGkEqi6uGlkH2UoYa4Ug0bCt5kHJRNVgaX4
         CfF0KW5CFh1EBp9LY2nfdTCldS1i0eYGgv7XdchcSOs+M0Sh4jq+XaiJ3xULEkD3HeI3
         rBOwtnnfUU4x5OPirrTC/BboFVnB4fgL5L3Ne359V/eeevcJ8y38L2cEegyB+eBczUxV
         U027Sk4kinkTnX3216hpQn8qzJUhFAyiD5apPbzrgYTmpxlsNVkCK9nBjKsyGw+iYTM7
         jJkK8ehcrbOcgVcm6XgXTuEs0aucpQ113bvc+VVkeaJzZN+42g4FHYuEnfYzq9/0/wwx
         bi9g==
X-Gm-Message-State: ACrzQf1eIdkPXG4XikAo3+fLoh4H8JkxPyk1wAPKSeUrgcBBas144NGS
        KMHwNOEeZVSsPSRCXJla0TASk25ZwiCIYw==
X-Google-Smtp-Source: AMsMyM7BWigTCThGwzZ82M+EvgjiZ6tp20I3wi7+RPwXOaccQOlWm3G1DwbqtpnoAM0vrnYGiGy+6g==
X-Received: by 2002:a5d:64aa:0:b0:230:71e5:c540 with SMTP id m10-20020a5d64aa000000b0023071e5c540mr3435363wrp.625.1666141410156;
        Tue, 18 Oct 2022 18:03:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3-20020a056000136300b0022e3cba367fsm12161315wrz.100.2022.10.18.18.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 18:03:29 -0700 (PDT)
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
Subject: [PATCH v2 0/4] core: update our SHA-1 docs, use sha1collisiondetection on OSX too
Date:   Wed, 19 Oct 2022 03:03:18 +0200
Message-Id: <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcd4a685f0b1
In-Reply-To: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sha1collisiondetection alternative to SHA-1 has been our default
everywhere for a while, except on OSX. As 3/4 notes this seems to have
been a mistake.

Furthermore our documentation (INSTALL) was still claiming that we
used OpenSSL for SHA-1 by default, etc. See 3/4 for all the details.

This series was previously submitted in April[1], at the time it
included a change to remove the SHA-1 implementation in PPC
assembly. That part has since landed on master in fd1ec82547d (Merge
branch 'ab/retire-ppc-sha1', 2022-09-09).

I meant to re-send this anyway, but was prompted by the failure
report(s) in [2]. The 1/4 here un-breaks "master", and could be peeled
off.

For a branch for this & passing CI see:
https://github.com/avar/git/tree/avar/sha1dc-really-everywhere-and-no-ppc-sha1-2

1. https://lore.kernel.org/git/cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqo7u9wyt7.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (4):
  fsmonitor OSX: compile with DC_SHA1=YesPlease
  Makefile: create and use sections for "define" flag listing
  Makefile: really use and document sha1collisiondetection by default
  Makefile: rephrase the discussion of *_SHA1 knobs

 INSTALL                             |  10 +-
 Makefile                            | 288 +++++++++++++++++-----------
 ci/lib.sh                           |   3 +
 compat/fsmonitor/fsm-ipc-darwin.c   |  10 +-
 contrib/buildsystems/CMakeLists.txt |   3 +-
 hash.h                              |  10 +-
 t/t0013-sha1dc.sh                   |   4 +-
 7 files changed, 198 insertions(+), 130 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  392fabdb456 fsmonitor OSX: compile with DC_SHA1=YesPlease
1:  3a80fcb6784 ! 2:  7ae22276aa7 Makefile: create and use sections for "define" flag listing
    @@ Makefile: include shared.mak
     -# Define BLK_SHA1 environment variable to make use of the bundled
     -# optimized C SHA1 routine.
     -#
    --# Define PPC_SHA1 environment variable when running make to make use of
    --# a bundled SHA1 routine optimized for PowerPC.
    --#
     -# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
     -# algorithm. This is slower, but may detect attempted collision attacks.
     -# Takes priority over other *_SHA1 knobs.
    @@ Makefile: include shared.mak
     -#
     -# Define BLK_SHA256 to use the built-in SHA-256 routines.
     -#
    +-# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
    +-#
     -# Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
     -#
     -# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
    @@ Makefile: include shared.mak
      #
      # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
     @@ Makefile: include shared.mak
    - # `compat/fsmonitor/fsm-listen-<name>.c` that implements the
    - # `fsm_listen__*()` routines.
    + # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
    + # that implements the `fsm_os_settings__*()` routines.
      #
     +# === Optional library: libintl ===
     +#
    @@ Makefile: include shared.mak
     +# Define BLK_SHA1 environment variable to make use of the bundled
     +# optimized C SHA1 routine.
     +#
    -+# Define PPC_SHA1 environment variable when running make to make use of
    -+# a bundled SHA1 routine optimized for PowerPC.
    -+#
     +# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
     +# algorithm. This is slower, but may detect attempted collision attacks.
     +# Takes priority over other *_SHA1 knobs.
    @@ Makefile: include shared.mak
     +#
     +# Define BLK_SHA256 to use the built-in SHA-256 routines.
     +#
    ++# Define NETTLE_SHA256 to use the SHA-256 routines in libnettle.
    ++#
     +# Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
     +#
     +# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
2:  3e250dc9d09 ! 3:  78ef8636c57 Makefile: really use and document sha1collisiondetection by default
    @@ Commit message
         * Have a rewritten discussion of SHA-1 and SHA-256 in the Makefile
           which covers all of this.
     
    +    Let's also change the CI for "osx-clang" to test with the new
    +    APPLE_SHA1 knob ("osx-gcc" uses the new sha1collisiondetection
    +    default).
    +
    +    In practice this will spot issues like the one noted in [7], as
    +    testing with just two backends should be enough to spot unportable
    +    code. Ideally we'd have other CI jobs to test the various SHA-1
    +    combinations, but for now we have better CI coverage than before.
    +
         1. 48b3693d3ce (Merge branch 'jk/sha1dc', 2017-03-24)
         2. 8325e43b82d (Makefile: add DC_SHA1 knob, 2017-03-16)
         3. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
    @@ Commit message
            2013-05-19)
         6. 3ef2bcad02e (imap-send: use Apple's Security framework for base64
            encoding, 2013-07-29)
    +    7. https://lore.kernel.org/git/kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ INSTALL: Issues of note:
      
     -	  By default, git uses OpenSSL for SHA1 but it will use its own
     -	  library (inspired by Mozilla's) with either NO_OPENSSL or
    --	  BLK_SHA1.  Also included is a version optimized for PowerPC
    --	  (PPC_SHA1).
    +-	  BLK_SHA1.
     +	- Git uses an altered version of SHA-1 by default which
    -+          detects the SHAttered attack via the sha1collisiondetection
    -+          counter-cryptanalysis library. For SHA-256 we'll select a
    -+          working implementation (and ship a fallback
    -+          implementation). See the "SHA-1 and SHA-256 defines" section
    -+          in the Makefile for details. You should not need to tweak
    -+          those settings.
    ++	  detects the SHAttered attack via the sha1collisiondetection
    ++	  counter-cryptanalysis library. For SHA-256 we'll select a
    ++	  working implementation (and ship a fallback
    ++	  implementation). See the "SHA-1 and SHA-256 defines" section
    ++	  in the Makefile for details. You should not need to tweak
    ++	  those settings.
      
      	- "libcurl" library is used for fetching and pushing
      	  repositories over http:// or https://, as well as by
    @@ Makefile: include shared.mak
     -# Define BLK_SHA1 environment variable to make use of the bundled
     -# optimized C SHA1 routine.
     +# === SHA-1 backend ===
    - #
    --# Define PPC_SHA1 environment variable when running make to make use of
    --# a bundled SHA1 routine optimized for PowerPC.
    ++#
     +# Due to the SHAttered (https://shattered.io) attack vector on SHA-1
     +# Git uses the sha1collisiondetection counter-cryptanalysis library
     +# for SHA-1 hashing.
     +#
     +# You're strongly advised not to override this for any usage of Git
     +# where you don't 100% trust the repository content.
    -+#
    -+# ==== Options common to all SHA-1 implementations ====
    -+#
    -+# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
    -+# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
    -+# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
      #
     -# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
     -# algorithm. This is slower, but may detect attempted collision attacks.
     -# Takes priority over other *_SHA1 knobs.
    -+# ===== Options for the default sha1collisiondetection implementations =====
    ++# ==== Options common to all SHA-1 implementations ====
      #
     -# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
    ++# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
    ++# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
    ++# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
    ++#
    ++# ===== Options for the default sha1collisiondetection implementations =====
    ++#
     +# Define DC_SHA1_EXTERNAL if you want to build / link
      # git with the external SHA1 collision-detect library.
      # Without this option, i.e. the default behavior is to build git with its
    @@ Makefile: include shared.mak
     -# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
     -# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
     -# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
    -+# Define PPC_SHA1 environment variable when running make to make use of
    -+# a bundled SHA1 routine optimized for PowerPC.
    -+#
     +# Define APPLE_SHA1 to use Apple's CommonCrypto SHA-1 routines on
     +# Darwin/Mac OS X.
     +#
    @@ Makefile: ifeq ($(uname_S),Darwin)
     -		APPLE_COMMON_CRYPTO = YesPlease
      		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
      	endif
    - 	NO_REGEX = YesPlease
    + 	PTHREAD_LIBS =
     @@ Makefile: ifdef NO_POSIX_GOODIES
      	BASIC_CFLAGS += -DNO_POSIX_GOODIES
      endif
    @@ Makefile: ifdef NO_POSIX_GOODIES
     -ifdef APPLE_COMMON_CRYPTO
     -	# Apple CommonCrypto requires chunking
     -	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
    -+ifdef DC_SHA1
    -+$(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
    - endif
    +-endif
     -
    + ifdef PPC_SHA1
    + $(error the PPC_SHA1 flag has been removed along with the PowerPC-specific SHA-1 implementation.)
    + endif
    + 
     -ifdef OPENSSL_SHA1
     -	EXTLIBS += $(LIB_4_CRYPTO)
     -	BASIC_CFLAGS += -DSHA1_OPENSSL
    @@ Makefile: ifdef NO_POSIX_GOODIES
     -	LIB_OBJS += block-sha1/sha1.o
     -	BASIC_CFLAGS += -DSHA1_BLK
     -else
    --ifdef PPC_SHA1
    --	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
    --	BASIC_CFLAGS += -DSHA1_PPC
    --else
     -ifdef APPLE_COMMON_CRYPTO
     -	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
     -	BASIC_CFLAGS += -DSHA1_APPLE
     -else
     -	DC_SHA1 := YesPlease
     -	BASIC_CFLAGS += -DSHA1_DC
    ++ifdef DC_SHA1
    ++$(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
    ++endif
     +ifndef NO_DC_SHA1
    -+	ifneq ($(OPENSSL_SHA1)$(BLK_SHA1)$(PPC_SHA1)$(APPLE_SHA1),)
    ++	ifneq ($(OPENSSL_SHA1)$(BLK_SHA1)$(APPLE_SHA1),)
     +$(error no other *_SHA1 option can be defined unless NO_DC_SHA1 is defined)
     +	endif
      	LIB_OBJS += sha1dc_git.o
    @@ Makefile: endif
     +	LIB_OBJS += block-sha1/sha1.o
     +	BASIC_CFLAGS += -DSHA1_BLK
     +else
    -+ifdef PPC_SHA1
    -+	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
    -+	BASIC_CFLAGS += -DSHA1_PPC
    -+else
     +ifdef APPLE_SHA1
     +	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
     +	BASIC_CFLAGS += -DSHA1_APPLE
    @@ Makefile: endif
      endif
      endif
     @@ Makefile: GIT-BUILD-OPTIONS: FORCE
    - 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
    + 	@echo NO_REGEX=\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@+
      	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
      	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
     -	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
    @@ Makefile: GIT-BUILD-OPTIONS: FORCE
      	@echo SANITIZE_ADDRESS=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_ADDRESS)))'\' >>$@+
      	@echo X=\'$(X)\' >>$@+
     
    + ## ci/lib.sh ##
    +@@ ci/lib.sh: macos-latest)
    + esac
    + 
    + case "$jobname" in
    ++osx-clang)
    ++	MAKEFLAGS="$MAKEFLAGS NO_DC_SHA1=Yes APPLE_SHA1=Yes"
    ++	;;
    + linux32)
    + 	CC=gcc
    + 	;;
    +
      ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: set(NO_PERL )
      set(NO_PTHREADS )
    @@ hash.h
      #include "git-compat-util.h"
      #include "repository.h"
      
    --#if defined(SHA1_PPC)
    +-#if defined(SHA1_APPLE)
     +#if !defined(NO_SHA1_DC)
     +#include "sha1dc_git.h"
    -+#elif defined(SHA1_PPC)
    - #include "ppc/sha1.h"
    - #elif defined(SHA1_APPLE)
    ++#elif defined(SHA1_APPLE)
      #include <CommonCrypto/CommonDigest.h>
      #elif defined(SHA1_OPENSSL)
      #include <openssl/sha.h>
    @@ hash.h
     +#error "need a SHA1_* implementation defined"
      #endif
      
    - #if defined(SHA256_GCRYPT)
    + #if defined(SHA256_NETTLE)
     
      ## t/t0013-sha1dc.sh ##
     @@ t/t0013-sha1dc.sh: TEST_PASSES_SANITIZE_LEAK=true
3:  1422c6fd497 ! 4:  f1fb9775b33 Makefile: rephrase the discussion of *_SHA1 knobs
    @@ Makefile: include shared.mak
     +# Define OPENSSL_SHA1 to link to the the SHA-1 routines from
     +# the OpenSSL library.
      #
    --# Define PPC_SHA1 environment variable when running make to make use of
    --# a bundled SHA1 routine optimized for PowerPC.
    -+# Define PPC_SHA1 to make use of optimized (in assembly)
    -+# PowerPC SHA-1 routines.
    - #
      # Define APPLE_SHA1 to use Apple's CommonCrypto SHA-1 routines on
      # Darwin/Mac OS X.
4:  ae464dbd228 < -:  ----------- Makefile + hash.h: remove PPC_SHA1 implementation
5:  730d08da6fe < -:  ----------- Makefile: use $(OBJECTS) instead of $(C_OBJ)
-- 
2.38.0.1093.gcd4a685f0b1

