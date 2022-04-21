Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B9C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391338AbiDUS1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391253AbiDUS0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BA94B1D9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so7804901wrg.12
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DswBgY57DvonvV+IlvDXZDkdUDSKRitcg2pnXHgFQQg=;
        b=FUyR3c4L8dc5NoTjxbfSdmNZGe9xelCEftyapVp1ATc7odeualdArywZK6uAwgP8hV
         dRv+Vj4dgjwb1Hpix5oor4rZl4x10UvZ4cWlXdMDc+MhBx4h92r5MmSo1rfwXkvYOKPW
         2QRvR6f7NTieFrOcddAkxa8uzhx7dujwyGLTMtPwUp2aAAtuEjRQuQauFptJ5+2QknNS
         T/qBtX/H1GR3bCJOahkygcTYOkxN4xk5hH6L3BOOJOWuPqITFK5A+ghw5iUScoOZCoJM
         o446xc1X+asMvkfF/cC96Kqk5NFNHSFR36+r771AtnEDvAcaa+i+q/LH7EyhYoXgWtof
         a3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DswBgY57DvonvV+IlvDXZDkdUDSKRitcg2pnXHgFQQg=;
        b=V1QbRM/FjtBVVgDWnGEeZ4bvI7uhY4t0U/RoZ+QFKCu2h+oXZ1ZzgYD8yiaYlzORzr
         AQKP/fodQGd/z+SEe98cBLRfSPSXiDLMjXs1qqhIE8pZewp+B7bR4fqEmYKn+EZoz2lO
         V9zJvuXPZ372Bz0fduH937/ajw5sf44s6UBJzQcCJ4vfOaquDz+Cj5hctezLuhOoWh0h
         BTRTWc6oH27BQQbcrkTqNhmV6HgKUy/cyISHDMZ0hDtFWH01456FocIFqskMTYaSdiYq
         bbJfW3nbfVt5pr3l+Vh/JUTQySsx47iKrIiXjz8UppddaCpDnDw3PZm8GYIQp2kA45Jy
         Rl0w==
X-Gm-Message-State: AOAM533/v0ZliZI1hnzL3RY80OS9esY0Xbk7BikNNXu2mZsJr/kx4xr5
        Eh0I+5oiBUU0bx3Q7azzzv7w+CRzfzVokQ==
X-Google-Smtp-Source: ABdhPJzYk05UuX2mUxLitZHL+oaLrMbkpbElKmf+hY917Fi0FApKzWsILaQ0uoI2Tcp18G2DB/+cQg==
X-Received: by 2002:a05:6000:2c9:b0:20a:8f9f:4a08 with SMTP id o9-20020a05600002c900b0020a8f9f4a08mr719848wry.297.1650565426331;
        Thu, 21 Apr 2022 11:23:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:45 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/29] CI: export variables via a wrapper
Date:   Thu, 21 Apr 2022 20:23:07 +0200
Message-Id: <patch-v5-12.29-ea35327e24c-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a "setenv" wrapper to export the variables set in
ci/lib.sh.

For now this merely adds debugging information about what variables
are set, but in a subsequent commit we'll expand this to set variables
in $GITHUB_ENV instead of the environment, and thus carry variable
settings between steps in a job.

We'll also eventually be interested in what type of variable we're
setting, and when it needs to be used, because we'll prominently
expose what variables we set in what CI "step", so having only the
ones we actually use will improve readability.

To that end call the "setenv" function with optional "--build",
"--test" and "--all" parameters to indicate whether they're needed for
building, testing or both.

We currently ignore the "varname" parameter, but will make use of it in a
subsequent commit. Adding it here reduces the needless churn, as we
won't need to change all these lines again for that subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 | 51 ++++++++++++++++++++++++++++++---------
 ci/run-build-and-tests.sh | 34 +++++++++++++-------------
 2 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2e425cb787c..e36e350e74c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -13,6 +13,35 @@ then
 	exit 1
 fi
 
+# Helper functions
+setenv () {
+	while test $# != 0
+	do
+		case "$1" in
+		--build)
+			;;
+		--test)
+			;;
+		--all)
+			;;
+		-*)
+			echo "BUG: bad setenv() option '$1'" >&2
+			exit 1
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	key=$1
+	val=$2
+	shift 2
+
+	eval "export $key=\"$val\""
+}
+
 check_unignored_build_artifacts ()
 {
 	! git ls-files --other --exclude-standard --error-unmatch \
@@ -24,7 +53,7 @@ check_unignored_build_artifacts ()
 }
 
 # GitHub Action doesn't set TERM, which is required by tput
-export TERM=${TERM:-dumb}
+setenv TERM ${TERM:-dumb}
 
 # How many jobs to run in parallel?
 NPROC=10
@@ -37,21 +66,21 @@ then
 	CI_TYPE=github-actions
 	CC="${CC:-gcc}"
 
-	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
+	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
 	GIT_TEST_OPTS="--verbose-log -x"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
-	export GIT_TEST_OPTS
+	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
 	env >&2
 	exit 1
 fi
 
-export DEVELOPER=1
-export DEFAULT_TEST_TARGET=prove
-export GIT_TEST_CLONE_2GB=true
-export SKIP_DASHED_BUILT_INS=YesPlease
+setenv --build DEVELOPER 1
+setenv --test DEFAULT_TEST_TARGET prove
+setenv --test GIT_TEST_CLONE_2GB true
+setenv --build SKIP_DASHED_BUILT_INS YesPlease
 
 case "$runs_on_pool" in
 ubuntu-latest)
@@ -67,7 +96,7 @@ ubuntu-latest)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
 	fi
 
-	export GIT_TEST_HTTPD=true
+	setenv --test GIT_TEST_HTTPD true
 	;;
 macos-latest)
 	if [ "$jobname" = osx-gcc ]
@@ -90,9 +119,9 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 linux-leaks)
-	export SANITIZE=leak
-	export GIT_TEST_PASSING_SANITIZE_LEAK=true
+	setenv --build SANITIZE leak
+	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
 
-export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+setenv --all MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index e5a21985b44..35d45a9373e 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -9,33 +9,33 @@ export MAKE_TARGETS="all test"
 
 case "$jobname" in
 linux-gcc)
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
 	;;
 linux-TEST-vars)
-	export GIT_TEST_SPLIT_INDEX=yes
-	export GIT_TEST_MERGE_ALGORITHM=recursive
-	export GIT_TEST_FULL_IN_PACK_ARRAY=true
-	export GIT_TEST_OE_SIZE=10
-	export GIT_TEST_OE_DELTA_SIZE=5
-	export GIT_TEST_COMMIT_GRAPH=1
-	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
-	export GIT_TEST_MULTI_PACK_INDEX=1
-	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
-	export GIT_TEST_ADD_I_USE_BUILTIN=1
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-	export GIT_TEST_WRITE_REV_INDEX=1
-	export GIT_TEST_CHECKOUT_WORKERS=2
+	setenv --test GIT_TEST_SPLIT_INDEX yes
+	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
+	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
+	setenv --test GIT_TEST_OE_SIZE 10
+	setenv --test GIT_TEST_OE_DELTA_SIZE 5
+	setenv --test GIT_TEST_COMMIT_GRAPH 1
+	setenv --test GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
+	setenv --test GIT_TEST_MULTI_PACK_INDEX 1
+	setenv --test GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP 1
+	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 1
+	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME master
+	setenv --test GIT_TEST_WRITE_REV_INDEX 1
+	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
 linux-clang)
-	export GIT_TEST_DEFAULT_HASH=sha1
+	setenv --test GIT_TEST_DEFAULT_HASH sha1
 	;;
 linux-sha256)
-	export GIT_TEST_DEFAULT_HASH=sha256
+	setenv --test GIT_TEST_DEFAULT_HASH sha256
 	;;
 pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
-	export DEVOPTS=pedantic
+	setenv --build DEVOPTS pedantic
 	export MAKE_TARGETS=all
 	;;
 esac
-- 
2.36.0.879.g3659959fcca

