Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E5AC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLOInT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOInP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:43:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBC733C3F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:43:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1252661wms.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYyKV5pN+qHylshYA7c8ZoHhSWm2tKwnEpXtLI3i3ks=;
        b=Ow1v+u5wrY5n3H+Hl9c355mnvnkR4WFa8sN6TIEP2tAdSdV5NDZgflaDv242dwWt8I
         av4ULVsGVzGxKtsZ4qOICjyFOrkqnv98KyXHnia4Md+sZbgAh+ZFeVdwxI/d2T9XCwH7
         lspuiFpBI2JBUicwc650cTQGccIQXr3TIsZatNhj4JsnNiV7YbyRSxGWE5ztRRWZTBof
         ouegYXHegmzqyLKzCrbxwtaUN5/W3x+0MyUHsi//9e9nJfU2mXtS5AVtaEYLJ45TPd/7
         7D1EwNH6oRgwQedZX7jof4eI2ZfA+C9F+0ttlWzRkHIHRebOpe6CByMRefypfgtBAlpK
         jKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYyKV5pN+qHylshYA7c8ZoHhSWm2tKwnEpXtLI3i3ks=;
        b=kQeQwmjADbub4e3wSPLwNVfZ5KVhLhJbbSzxL2NtlCVGeymKdastH6VSq8IRYu1Xfy
         27E1j7QjtGe/QR6jAyLG1pVK1x+KIlHgtuGilchLiOYtn66//59krjEqQRf31zKKtuxB
         4sB9PMNfndeHSTSMldYMV0SL6fZUm+p8YWLSD4lcr9LibHS28MeZ/54JuGnRYydYNqRp
         H7avYB08seaF49EqaaUpv0b4+UfoZjgtzQ7HDl1OFGeZDAw0t8eJXY6qpOX0eyE8NOMq
         curuDZtYwdrLdauxAfnAfEvqoJOhox+ROf6slPPOhvJMQ7yL4Zl7DbQBoA/1ZZUxkWrc
         FvWQ==
X-Gm-Message-State: ANoB5pnbHELSrkjo2kFbU9aw4KQKnEwn2PDAhMmXGfa2ucKP/YpU+A5q
        aaFX4jqgUaI9AMTzo+eExfYJ0wnL730fUA==
X-Google-Smtp-Source: AA0mqf71BFqMrsNnx8mrNvs971U4BfLhdYtrcOdceP1TTBKpXccAVOrTqqlmBnAJTYJfrPVCRbsLFQ==
X-Received: by 2002:a05:600c:4e14:b0:3d2:4234:e8fe with SMTP id b20-20020a05600c4e1400b003d24234e8femr1669916wmq.19.1671093790279;
        Thu, 15 Dec 2022 00:43:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003d1e90717ccsm6765356wmq.30.2022.12.15.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:43:09 -0800 (PST)
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
Subject: [PATCH v2] Makefile: use sha1collisiondetection by default on OSX and Darwin
Date:   Thu, 15 Dec 2022 09:43:05 +0100
Message-Id: <patch-v2-1.1-3de7cdbd260-20221215T084129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <patch-1.1-1f4e39be97b-20221020T225305Z-avarab@gmail.com>
References: <patch-1.1-1f4e39be97b-20221020T225305Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the sha1collisiondetection library was added and made the default
in [1] the interaction with APPLE_COMMON_CRYPTO added in [2] and [3]
seems to have been missed. On modern OSX and Darwin we are able to use
Apple's CommonCrypto both for SHA-1, and as a generic (but partial)
OpenSSL replacement.

This left OSX and Darwin without protection against the SHAttered
attack when building Git in its default configuration.

Let's also use sha1collisiondetection on OSX, to do so we'll need to
split up the "APPLE_COMMON_CRYPTO" flag into that flag and a new
"APPLE_COMMON_CRYPTO_SHA1".

Because of this we can stop conflating whether we want to use Apple's
CommonCrypto at all, and whether we want to use it for SHA-1.  This
makes the CI recipe added in [4] simpler.

1. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
2. 4dcd7732db0 (Makefile: add support for Apple CommonCrypto facility, 2013-05-19)
3. 61067954ce1 (cache.h: eliminate SHA-1 deprecation warnings on Mac OS X, 2013-05-19)
4. 1ad5c3df35a (ci: use DC_SHA1=YesPlease on osx-clang job for CI,
   2022-10-20)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  1f4e39be97b ! 1:  3de7cdbd260 Makefile: use sha1collisiondetection by default on OSX and Darwin
    @@ Commit message
         split up the "APPLE_COMMON_CRYPTO" flag into that flag and a new
         "APPLE_COMMON_CRYPTO_SHA1".
     
    -    Let's also change the CI for "osx-clang" to test with the new
    -    APPLE_COMMON_CRYPTO_SHA1 knob ("osx-gcc" uses the new
    -    sha1collisiondetection default).
    -
    -    In practice this will spot issues like the one noted in [4], as
    -    testing with just two backends should be enough to spot unportable
    -    code. Ideally we'd have other CI jobs to test the various SHA-1
    -    combinations, but for now we have better CI coverage than before.
    +    Because of this we can stop conflating whether we want to use Apple's
    +    CommonCrypto at all, and whether we want to use it for SHA-1.  This
    +    makes the CI recipe added in [4] simpler.
     
         1. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
         2. 4dcd7732db0 (Makefile: add support for Apple CommonCrypto facility, 2013-05-19)
         3. 61067954ce1 (cache.h: eliminate SHA-1 deprecation warnings on Mac OS X, 2013-05-19)
    -    4. 32205655dc7 (fsmonitor OSX: compile with DC_SHA1=YesPlease, 2022-10-19)
    +    4. 1ad5c3df35a (ci: use DC_SHA1=YesPlease on osx-clang job for CI,
    +       2022-10-20)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: include shared.mak
      #
     -# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
     -# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
    --# default on that OS. We'll define NO_APPLE_COMMON_CRYPTO on Mac OS
    --# 10.4 or older ("Tiger", released in early 2005).
    +-# default on that OS. On macOS 01.4 (Tiger) or older,
    +-# NO_APPLE_COMMON_CRYPTO is defined by default.
     +# Define APPLE_COMMON_CRYPTO_SHA1 to use Apple's CommonCrypto for
     +# SHA-1.
      #
    - # === SHA-256 backend ===
    - #
    + # If don't enable any of the *_SHA1 settings in this section, Git will
    + # default to its built-in sha1collisiondetection library, which is a
     @@ Makefile: ifdef NO_POSIX_GOODIES
      	BASIC_CFLAGS += -DNO_POSIX_GOODIES
      endif
    @@ Makefile: ifdef BLK_SHA1
      else
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: macos-latest)
    - esac
    - 
    - case "$jobname" in
    -+osx-clang)
    -+	MAKEFLAGS="$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=Yes"
    -+	;;
    - linux32)
    - 	CC=gcc
    +@@ ci/lib.sh: macos-*)
    + 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
    + 	else
    + 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
    +-		MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
    +-		MAKEFLAGS="$MAKEFLAGS NO_OPENSSL=NoThanks"
    ++		MAKEFLAGS="$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=Yes"
    + 	fi
      	;;
    + esac

 Makefile  | 10 ++++------
 ci/lib.sh |  3 +--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 0f7d7ab1fd2..db447d07383 100644
--- a/Makefile
+++ b/Makefile
@@ -511,10 +511,8 @@ include shared.mak
 # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
 # with git (in the block-sha1/ directory).
 #
-# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
-# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
-# default on that OS. On macOS 01.4 (Tiger) or older,
-# NO_APPLE_COMMON_CRYPTO is defined by default.
+# Define APPLE_COMMON_CRYPTO_SHA1 to use Apple's CommonCrypto for
+# SHA-1.
 #
 # If don't enable any of the *_SHA1 settings in this section, Git will
 # default to its built-in sha1collisiondetection library, which is a
@@ -1911,7 +1909,7 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
-ifdef APPLE_COMMON_CRYPTO
+ifdef APPLE_COMMON_CRYPTO_SHA1
 	# Apple CommonCrypto requires chunking
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
@@ -1928,7 +1926,7 @@ ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
 else
-ifdef APPLE_COMMON_CRYPTO
+ifdef APPLE_COMMON_CRYPTO_SHA1
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
diff --git a/ci/lib.sh b/ci/lib.sh
index 706e3ba7e93..db7105e8a8d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -258,8 +258,7 @@ macos-*)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
-		MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
-		MAKEFLAGS="$MAKEFLAGS NO_OPENSSL=NoThanks"
+		MAKEFLAGS="$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=Yes"
 	fi
 	;;
 esac
-- 
2.39.0.rc2.1048.g0e5493b8d5b

