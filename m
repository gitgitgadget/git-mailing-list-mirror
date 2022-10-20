Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46182C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJTXBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJTXBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:01:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0622E0F7
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:01:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v11so1075294wmd.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8/75L8NB7iU0IeQftLyxjOtVqsl8r+iGkXsqYVXmMY=;
        b=BCNywQgROVLvv5ZHmaSvSw8mTGLCutMn3/V/iIXndIWISFgbUU3JP39+zARx2ufGhO
         y6JDGujqNk11/DwFns2gFk2dwCO2AT65QEP4pBWm7nBKrG6eQUIAxn3e+n60UiVwcFKS
         mAejZEm5p9+9jOTP9V+OiAVjBjqPDk86pZrjq2iXB229mXMDy4j8RWKX+vgXp+pjJV0O
         bPe1S9VMj8wLJ3URInAx0yOy58fX4WRlTlbB8upO16Q5NFxigUfQiRGNpgGJxvVukOpS
         R3YcK7kgjF5dHYkCxNqEKFVaZhKPaLh/dmwd07YKnknkLnzkMygZ9QbEZVkIQtAkL/fh
         A2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8/75L8NB7iU0IeQftLyxjOtVqsl8r+iGkXsqYVXmMY=;
        b=K8YHB+vGlCmCJWPqp4I3x7uJZ+DjiVWvmaRdwCS5RIqbuCnbkKdzj77lfnuTqnMCAV
         +FnFOPYhXIOH2dKtHtr4udy5iM5rXLcbWO9IxNyzCP0QPW6GwJyT7A6XlOXhgYnyTVST
         LPGzm0/PMLv/l2R/9NG8bsdMqJnMq67lqtD1WBLUdBfUuBq2F3wzWXN6m/LJkVRzEzgB
         3kHXDNi5qvDTGLaFe2vf8/uBVEFqe25GD+DPmgpdP1TQxTQ/WAK7iiDsDGqBQzOZ4VRZ
         HDcJXykuiBsWoK+WxgJwy+0ldGpEYgM6Q4KKF2IOEqQBp+yFDEP9JFFA7mAp05MKGRo3
         KZyA==
X-Gm-Message-State: ACrzQf2l3JYQnZ6OlBkdmON/g0ABlm4QCeQ+8tLYJG0gE7Lfl308ytiX
        sFbkOhF586L5+I/Qh/QlpAyHZUUi9dUNUg==
X-Google-Smtp-Source: AMsMyM6XFfH2IK6n1tz2EjV4FtG4YZYkolMoiFQdvIwYg5IKnJDckmNl0E9RahO95MB57g5+68kvsQ==
X-Received: by 2002:a05:600c:1989:b0:3c6:fabb:ea73 with SMTP id t9-20020a05600c198900b003c6fabbea73mr10578966wmq.19.1666306887860;
        Thu, 20 Oct 2022 16:01:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0022e6f0d0d7csm20889106wrb.18.2022.10.20.16.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:01:26 -0700 (PDT)
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
Subject: [PATCH] Makefile: use sha1collisiondetection by default on OSX and Darwin
Date:   Fri, 21 Oct 2022 01:01:20 +0200
Message-Id: <patch-1.1-1f4e39be97b-20221020T225305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1178.g509f5fa8ce0
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

Let's also change the CI for "osx-clang" to test with the new
APPLE_COMMON_CRYPTO_SHA1 knob ("osx-gcc" uses the new
sha1collisiondetection default).

In practice this will spot issues like the one noted in [4], as
testing with just two backends should be enough to spot unportable
code. Ideally we'd have other CI jobs to test the various SHA-1
combinations, but for now we have better CI coverage than before.

1. e6b07da2780 (Makefile: make DC_SHA1 the default, 2017-03-17)
2. 4dcd7732db0 (Makefile: add support for Apple CommonCrypto facility, 2013-05-19)
3. 61067954ce1 (cache.h: eliminate SHA-1 deprecation warnings on Mac OS X, 2013-05-19)
4. 32205655dc7 (fsmonitor OSX: compile with DC_SHA1=YesPlease, 2022-10-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

The 1st hunk here depends on the "base" topic which prepares the docs
for this small change:
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com/

But otherwise this applies on "master".

Junio: I see in the meantime you've queued your own
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com/;
which is currently in "seen".

That patch will merge smoothly with this one, both textually and
semantically, but if we have this it's all that's needed to flip the
default and give us pretty much the same OSX CI coverage.

"Pretty much" because an unstated effect of your patch is to disable
all use of the "Apple Common Crypto" library on "osx-clang", which
includes (but is not limited to) giving us another SHA-1 backend.

Range-diff:
1:  392fabdb456 < -:  ----------- fsmonitor OSX: compile with DC_SHA1=YesPlease
2:  7ae22276aa7 < -:  ----------- Makefile: create and use sections for "define" flag listing
3:  78ef8636c57 < -:  ----------- Makefile: really use and document sha1collisiondetection by default
4:  f1fb9775b33 < -:  ----------- Makefile: rephrase the discussion of *_SHA1 knobs
-:  ----------- > 1:  1f4e39be97b Makefile: use sha1collisiondetection by default on OSX and Darwin

 Makefile  | 10 ++++------
 ci/lib.sh |  3 +++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 36d6bffd1f1..fb4f240e28b 100644
--- a/Makefile
+++ b/Makefile
@@ -529,10 +529,8 @@ include shared.mak
 # Define BLK_SHA1 to make use of optimized C SHA-1 routines bundled
 # with git (in the block-sha1/ directory).
 #
-# Define NO_APPLE_COMMON_CRYPTO on OSX to opt-out of using the
-# "APPLE_COMMON_CRYPTO" backend for SHA-1, which is currently the
-# default on that OS. We'll define NO_APPLE_COMMON_CRYPTO on Mac OS
-# 10.4 or older ("Tiger", released in early 2005).
+# Define APPLE_COMMON_CRYPTO_SHA1 to use Apple's CommonCrypto for
+# SHA-1.
 #
 # === SHA-256 backend ===
 #
@@ -1873,7 +1871,7 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
-ifdef APPLE_COMMON_CRYPTO
+ifdef APPLE_COMMON_CRYPTO_SHA1
 	# Apple CommonCrypto requires chunking
 	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
 endif
@@ -1890,7 +1888,7 @@ ifdef BLK_SHA1
 	LIB_OBJS += block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
 else
-ifdef APPLE_COMMON_CRYPTO
+ifdef APPLE_COMMON_CRYPTO_SHA1
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57db..fda7e008f26 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -264,6 +264,9 @@ macos-latest)
 esac
 
 case "$jobname" in
+osx-clang)
+	MAKEFLAGS="$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=Yes"
+	;;
 linux32)
 	CC=gcc
 	;;
-- 
2.38.0.1178.g509f5fa8ce0

