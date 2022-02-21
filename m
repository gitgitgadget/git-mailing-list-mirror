Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B815AC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378318AbiBUOr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378309AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C660E0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s1so1070992wrg.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIDVvDW7dORamPdWUOqvN7ITwcMNQ/B2UzfOVfACKJc=;
        b=I57Ysoqmspfx/Mmhjuea0bx7eA20r8yvjdCgxAC9Dzf4K2ZqJG+BLyylb1BE6PHDKX
         3LWDwM/hjQJKv/TYg6BPYGGS8T35dqKXZLfaFm6SAFFur6yQOWJ1HfJnhVdXWeD9M7CY
         aN5ClK+6EyhWxBvluYaWIBXOUbq8pOcjqoxxYAOIEraQV3hX6haoqzoSTcObCmdbdd2M
         UOAB1FcMV/WMU0ko5AMQb4zAEdr/TE8+3cqo5HQehcAUbmzDXEBo9q3wCes+XjGQUfSI
         FBOR6Go1vWE85WokiRBw2DL/GxtLafHROogKe1NJG2oi0N5WAh8W38ROavIZMJAyaUjt
         cB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIDVvDW7dORamPdWUOqvN7ITwcMNQ/B2UzfOVfACKJc=;
        b=0/IwtoQ3c7KdOv0L89UIbVlxhw9nXGycziKkVTxJoJnI2cDXyFk/MAcCjHFgC7ul/H
         9X22vtU9bHmYCim+E9FbwdSotibiuxuqXGUmBulGZPK4Xk0OmYTS6USSGzSnRnSsaPV8
         74pYmdwTUBS34ufVfSNENEtR5OQsRJbEcMjFY/UWdAM6EJN8Ffd/AXXsA8PR10MWPGUa
         o7TE+aI9CsEgsxtPqBu1qfHSpsBQpTXHTWMZmnk09qgWcosBYRqjG6tD28gVJrDDcLGk
         WRLAPHsIkGVi5LxDw9K/mdXe9eqaGJPXT6gy62we57Bik03w6CVIkBPtl88TkpuBAnW2
         hB2Q==
X-Gm-Message-State: AOAM533yAZhW8bcPtq8xOZV5k8CQULR5ZZuml+P7qCjc11UQHvuc1wNc
        j/5U9+2dmK7ViHzSJY8gUupJJhmEr6kfZQ==
X-Google-Smtp-Source: ABdhPJyNzPkGwHNwdai6RjEYkObtkO2DMSe9AD+1tm9VAKxEwRuGJo73XOuZuVTcR2ViOaO9J5KXoQ==
X-Received: by 2002:a05:6000:1181:b0:1e5:a6af:7b8a with SMTP id g1-20020a056000118100b001e5a6af7b8amr15851549wrx.416.1645454817751;
        Mon, 21 Feb 2022 06:46:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:57 -0800 (PST)
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
Subject: [PATCH 11/25] CI: export variables via a wrapper
Date:   Mon, 21 Feb 2022 15:46:23 +0100
Message-Id: <patch-11.25-f2fcee5d6e4-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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

We currently ignore this parameter, but will make use of it in a
subsequent commit. Adding it here reduces the needless churn, as we
won't need to change all these lines again for that subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 | 39 ++++++++++++++++++++++++++++-----------
 ci/run-build-and-tests.sh | 34 +++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 31fe3a476a9..1a1fa0e4bb2 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -13,6 +13,23 @@ then
 	exit 1
 fi
 
+# Helper functions
+setenv () {
+	varmode=
+	case "$1" in
+	--*)
+		varmode=$1
+		shift
+		;;
+	esac
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
@@ -24,7 +41,7 @@ check_unignored_build_artifacts ()
 }
 
 # GitHub Action doesn't set TERM, which is required by tput
-export TERM=${TERM:-dumb}
+setenv TERM ${TERM:-dumb}
 
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=
@@ -34,23 +51,23 @@ then
 	CI_TYPE=github-actions
 	CC="${CC:-gcc}"
 
-	export GIT_PROVE_OPTS="--timer --jobs 10"
+	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
 	GIT_TEST_OPTS="--verbose-log -x"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
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
@@ -66,7 +83,7 @@ ubuntu-latest)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
 	fi
 
-	export GIT_TEST_HTTPD=true
+	setenv --test GIT_TEST_HTTPD true
 	;;
 macos-latest)
 	if [ "$jobname" = osx-gcc ]
@@ -89,9 +106,9 @@ linux-musl)
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
2.35.1.1132.ga1fe46f8690

