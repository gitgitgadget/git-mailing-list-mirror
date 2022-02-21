Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3445C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378335AbiBUOsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378342AbiBUOrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124335FC8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso29940wmi.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXMPVqJ67+pdj8eonhYCu2kEa++EZMGukHAHBTxKv24=;
        b=NynUV5gYnc/x/o4aMENurDEmsm84bZLWT91/j5SbRuP7jf/AHUNxiiH+oXON7vxFB5
         8fh1sHZ1t4dESLohvJNieClHIAxTPjj8kq4mSavyCmcO/Vmvk7htS3qL2kfy/Lqm/ny9
         2XBtuimDqvIdI/J8shokQByhWM9dHD1s1QHtXU/gMZDR02Vja+qDJ47+S5NWisCPitmu
         n+rZr6HtWoR7bnsl8jJxOAQ95HUFG6msBdbVUUhq/2/r9l7qXKpCfWH0CBf6ClGmMe7N
         6zxU5/MUw25UbTFvGY44ltYgQKtZf3De3OcGhno61ppLCD0HUTU7N7pqH3diSmxdXjwt
         r9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXMPVqJ67+pdj8eonhYCu2kEa++EZMGukHAHBTxKv24=;
        b=KrvrKNn7y1uwbxC0X5kNoEH1k28JD8r0FlDDIwZpTXlIsXNxVWBiT2vEFoYBa1sx4w
         h7pbPQ7JcOr6kBFK9JW3GIAJK1k63wYKe/ipb45+yziM28K4QZIjeiHvH3KdLENcapyP
         lF9/9nEJ4/ZXw5nb1G7eNCn04kWVteAFFfaFfDc1yYxjsKhfOLFNgLYUTJhwih7PbhyN
         b1IveuAtzRuqxDWjsFj1c7+An5ppW/TfzQ3GLbEY708XCZb+QzadBFTPO/DWeHlBqIDX
         gGTGrH0jOPkC8xOMwsC+jqymQ1NPmxeYPsv9coZi/j3Vln44NH9nd1Lo8XRdE8cDhqIa
         atPg==
X-Gm-Message-State: AOAM532l62LMfvIR7RjhEbG9cGO2vcPqvfH0Jk8uox3fBCU/4t4AX4kG
        NG2mrxRpjNzgrvwIZDES63ugru/kGebolw==
X-Google-Smtp-Source: ABdhPJz65L3GRqSY5jNQie4QLQoHkfzrKU5sAS2lUaXIEbYkaeH5Y0lqV1Ijf75xODwUJkLkKQgDMg==
X-Received: by 2002:a05:600c:4c27:b0:37b:fa17:899a with SMTP id d39-20020a05600c4c2700b0037bfa17899amr17909083wmp.126.1645454829320;
        Mon, 21 Feb 2022 06:47:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 23/25] CI: stop over-setting the $CC variable
Date:   Mon, 21 Feb 2022 15:46:35 +0100
Message-Id: <patch-23.25-8a8b7ecf16b-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As detailed in 2c8921db2b8 (travis-ci: build with the right compiler,
2019-01-17) the reason we started using $CC in $MAKEFLAGS as opposed
to setting it in the environment was due to Travis CI clobbering $CC
in the environment.

We don't need to set it unconditionally to accomplish that, but rather
just have it set for those jobs that need them. E.g. the "win+VS
build" job confusingly has CC=gcc set, even though it builds with
MSVC.

This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
"$jobname" to select packages & config, 2021-11-23), i.e. we're now
aiming to only set those variables specific jobs need.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 13 -------------
 ci/lib.sh                  | 26 ++++++++++++++++++++++----
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0787cadc76b..6d25ec4ae3b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -238,37 +238,24 @@ jobs:
       matrix:
         vector:
           - jobname: linux-clang
-            cc: clang
             pool: ubuntu-latest
           - jobname: linux-sha256
-            cc: clang
             os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-gcc
-            cc: gcc
-            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: linux-TEST-vars
-            cc: gcc
             os: ubuntu
-            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: osx-clang
-            cc: clang
             pool: macos-latest
           - jobname: osx-gcc
-            cc: gcc
-            cc_package: gcc-9
             pool: macos-latest
           - jobname: linux-gcc-default
-            cc: gcc
             pool: ubuntu-latest
           - jobname: linux-leaks
-            cc: gcc
             pool: ubuntu-latest
     env:
-      CC: ${{matrix.vector.cc}}
-      CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
       runs_on_pool: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
diff --git a/ci/lib.sh b/ci/lib.sh
index 475e9f63a74..7064a17cfeb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -52,7 +52,9 @@ setenv () {
 	fi
 }
 
-# Clear MAKEFLAGS that may come from the outside world.
+# Clear variables that may come from the outside world.
+CC=
+CC_PACKAGE=
 MAKEFLAGS=
 
 # Common make and cmake build options
@@ -64,8 +66,6 @@ MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 
 case "$CI_TYPE" in
 github-actions)
-	CC="${CC:-gcc}"
-
 	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
 	GIT_TEST_OPTS="--verbose-log -x"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
@@ -135,9 +135,16 @@ vs-test)
 	setenv --test NO_SVN_TESTS YesPlease
 	;;
 linux-gcc)
+	CC=gcc
+	CC_PACKAGE=gcc-8
 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
 	;;
+linux-gcc-default)
+	CC=gcc
+	;;
 linux-TEST-vars)
+	CC=gcc
+	CC_PACKAGE=gcc-8
 	setenv --test GIT_TEST_SPLIT_INDEX yes
 	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
 	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
@@ -152,10 +159,19 @@ linux-TEST-vars)
 	setenv --test GIT_TEST_WRITE_REV_INDEX 1
 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
+osx-gcc)
+	CC=gcc
+	CC_PACKAGE=gcc-9
+	;;
+osx-clang)
+	CC=clang
+	;;
 linux-clang)
+	CC=clang
 	setenv --test GIT_TEST_DEFAULT_HASH sha1
 	;;
 linux-sha256)
+	CC=clang
 	setenv --test GIT_TEST_DEFAULT_HASH sha256
 	;;
 pedantic)
@@ -173,9 +189,11 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 linux-leaks)
+	CC=gcc
 	setenv --build SANITIZE leak
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
 
-setenv --all MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
+MAKEFLAGS="$MAKEFLAGS${CC:+ CC=$CC}"
+setenv --all MAKEFLAGS "$MAKEFLAGS"
-- 
2.35.1.1132.ga1fe46f8690

