Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A428C433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiCYTkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiCYTiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA9D1D78BA
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so9536510wmb.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jebbjHaz4qhMxpiExDgMytmJb25eHGi4rGb9PeG4syo=;
        b=Qg4OHN69rtGIEuOcN6zLbS3NrH8Qw2UbTQCRY/Nvmm5PaWw2drTk+5beGMeMYJ3ZkP
         YadqbthHXPCp8agy0J/A6ZSmHycSsx0MtQKLAaHsXQJsOGXa1u/ePrbSjz2bod9U41Jt
         3JVxfRxZBJ1kqBQIST2M1tvaZf0UHsx8T3lqJgfPDVLrrit6ssSFsMSORNkqnqhSABNW
         KIVAOirITMwPag5T4RrBeXgnoBdXTJPgWY7vsL7GJQrbd+oh2LWNu+sbCmsroB/HCUiz
         GCbBaJxYFeD9yn2A9PB8lCg7VH9LKj5ZUUcWVxt0qnqHFaXTq7l+Mysoc37E+byFXpPN
         D2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jebbjHaz4qhMxpiExDgMytmJb25eHGi4rGb9PeG4syo=;
        b=QCCImkFW+JnqvFGgLSaY70nqwpRfBv5lGOJziA5JV46J74giMR46CI050Lo5U/UNd5
         6P3WdKyCB7SxSIglok6s5rBs8CZogoUMSE6U0DntrI/Djk3H/Rk/kP4QyNvY6y+T0rEF
         2gqJTBirPUJOz/2vx3EfrZyQCDh9H1Bdww1r/q1XEn2xrsoiNzsBH1z6FR9HmnlFFHQm
         qYiZOvXmDp/xUabvDvHeTuTqz9opEuJTNtw9kn+LcFRnPj5UBV7HNpLUqq/m9AHfNi9y
         23SbSWY/UA1LaKEG8rZf8krkzm4aT3xuNDp1ox+QBpwag7FrO1uoQMWAJ806eCmkQD/h
         LOow==
X-Gm-Message-State: AOAM530VRtJoxlRoZGLj88SPA39zEBa1O50ZWsnIkmd9ZFrSHYJjq5EZ
        UAxfqhcnGJyGRt1me1St1j3Bl6a5czJoZg==
X-Google-Smtp-Source: ABdhPJyRfNMKo/hpkGJuF8SDVIh7VA5mEMEHMvk+UP0F5HWMvoULddYo90E2jW2yDq9BTk/IPdqPbQ==
X-Received: by 2002:a05:600c:4e93:b0:38c:92d9:c7bc with SMTP id f19-20020a05600c4e9300b0038c92d9c7bcmr11188270wmq.173.1648233520418;
        Fri, 25 Mar 2022 11:38:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:39 -0700 (PDT)
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
Subject: [PATCH v2 23/25] CI: set CC in MAKEFLAGS directly, don't add it to the environment
Date:   Fri, 25 Mar 2022 19:38:14 +0100
Message-Id: <patch-v2-23.25-b45b7cec94e-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
 ci/lib.sh                  | 27 +++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 17 deletions(-)

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
index 475e9f63a74..57c9117a35a 100755
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
@@ -152,13 +159,23 @@ linux-TEST-vars)
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
@@ -173,9 +190,11 @@ linux-musl)
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
2.35.1.1517.g20a06c426a7

