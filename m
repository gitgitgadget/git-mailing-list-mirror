Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1397FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiDMTzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiDMTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FDB78FD4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1830252wmz.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6hN6yhxTyL4HTmIabilzROseTzBQj4dl12uB2yOnbg=;
        b=b43QXCOuNlQS1GjRUkUdi+zgxU50/u+yu4sKKsL/+qtfxD5prSG7zQ/EpIz1kApiZM
         vyLbjw2rPU/TAYJcXkAqvdit5R+T6wpbrjNdqgXMfaRrNE1+wHsjtTYaWKySYwwomQkl
         QVpw1rUEA5VL/JjZSPlsuvQc/nPeruWJPeQApqpcMvq5nYKJHHR6ntXhBejTLx3Efkom
         1G4oRqvc/tSP6oA78WiVptfD+A0odbabMIt7rsjMJjYBzoUr1+q7yzwL6N47FzjBb9pP
         PF0RyQ030ep/oCndBalhIU+v8HWWMHv5GSsdAiT4uSBXTtaQdoMyweLyzjJXfqaHMtcj
         LMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6hN6yhxTyL4HTmIabilzROseTzBQj4dl12uB2yOnbg=;
        b=npJSEFl8V0t86lvf05ZqyBW+HKehOrD3aXvy0wGN7Z/XeM+onGo4Ia5rHw6PpL1opS
         CHpeygSV3VnzUryDjo8nfhLBUsW6UE8fVk+XK4MenPT1z1D7KsA/F4l/JnMr1pdZZVj3
         lCGcuVl8mKOhnp3TTlPfuOZWmv/TAwvQT8+nn2/VaRuyw8BVienfOW7Umh2MIP0YDWps
         616zJqkjHR16SHgq4HpjEfQEIBvCtL0RWh5HQzt6ZuVWsJts9ifUQhNtOfrcopW1Dwiq
         yKmYSRtrRs2A1sWuixE/A70BjSBJ3zZuR+1ZOuLrzos8UKVOtNv6+2TyrX1O+WfARG05
         Oo8Q==
X-Gm-Message-State: AOAM530HbLIxVuZTQp7PJL9C87awSCMCpIOiJUwhZU77EcPhpweL3VHe
        Vro+2YLpjSZmIV+7k1HYfyyTW0RQLb1d2Q==
X-Google-Smtp-Source: ABdhPJyJAI9x9qnl/W4VMiviVSrYRatrlLzhLa+KCSb2Cj5QPFj/1k4X+3qNI+iqvR2irNDd0Oy1oQ==
X-Received: by 2002:a05:600c:1e17:b0:38e:ba41:2465 with SMTP id ay23-20020a05600c1e1700b0038eba412465mr284859wmb.132.1649879538637;
        Wed, 13 Apr 2022 12:52:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:18 -0700 (PDT)
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
Subject: [PATCH v3 25/29] CI: set CC in MAKEFLAGS directly, don't add it to the environment
Date:   Wed, 13 Apr 2022 21:51:38 +0200
Message-Id: <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than pass a "$CC" and "$CC_PACKAGE" in the environment to be
picked up in ci/lib.sh let's instead have ci/lib.sh itself add it
directly to MAKEFLAGS.

Setting CC=gcc by default made for confusing trace output, and since a
preceding change to carry it and others over across "steps" in the
GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
confusingly has CC=gcc set, even though it builds with MSVC.

Let's instead reply on the Makefile default of CC=cc, and only
override it for those jobs where it's needed. This does mean that
we'll need to set it for the "pedantic" job, which previously relied
on the default CC=gcc in case "clang" become the default on that
platform.

This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
"$jobname" to select packages & config, 2021-11-23), i.e. we're now
aiming to only set those variables specific jobs need.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 13 -------------
 ci/lib.sh                  | 27 ++++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 16 deletions(-)

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
index 8fb0bfd43e1..c73b107d9c7 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -51,6 +51,10 @@ setenv () {
 	fi
 }
 
+# Clear variables that may come from the outside world.
+CC=
+CC_PACKAGE=
+
 # How many jobs to run in parallel?
 NPROC=10
 
@@ -70,8 +74,6 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 
 case "$CI_TYPE" in
 github-actions)
-	CC="${CC:-gcc}"
-
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
 	GIT_TEST_OPTS="--verbose-log -x"
 	test Windows != "$RUNNER_OS" ||
@@ -143,9 +145,16 @@ vs-test)
 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
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
@@ -160,13 +169,23 @@ linux-TEST-vars)
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
+	CC=gcc
 	# Don't run the tests; we only care about whether Git can be
 	# built.
 	setenv --build DEVOPTS pedantic
@@ -181,9 +200,11 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 linux-leaks)
+	CC=gcc
 	setenv --build SANITIZE leak
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
 
-setenv --build MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
+MAKEFLAGS="$MAKEFLAGS${CC:+ CC=$CC}"
+setenv --build MAKEFLAGS "$MAKEFLAGS"
-- 
2.36.0.rc2.843.g193535c2aa7

