Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1642C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiGNTkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbiGNTkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:40:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F26759A
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b6so1128961wmq.5
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tC51mi1gwvw/qYlzGL+ciz40B/m09U3lklboHEXXElo=;
        b=qzQ3XmGif31jAkfxX/fcGg1nUvd0/ourVEGEao3Y3aafKbZuhfuEOk2JnUULFZKnCL
         zfLH+kqPJDkDCDtppfAe66Kj8fjXY+eHtFFieQh0kP7ghN6dRxQRwulrM4Ro/ZBPJ99i
         8aK0T865+lQt/sVKa+9H/vzvyespGl4j42JzFCQjUSeo0Uo7mbeYhk1uX++l6UpMrjax
         nUi1tnSiAcRucAPM4aZzIWpMv8r6qXL1a1MWGe8QpsCXouhxVVIMDTTVWK/nEsgI2L9J
         DLeuYFtfuljOLyFwaa4qPrFOG/YSDxfx+nUfYEesspLmdmn4qMOPziDpRqejYfUXL9px
         FDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tC51mi1gwvw/qYlzGL+ciz40B/m09U3lklboHEXXElo=;
        b=lJxL7GMC8R3GQ7VCFEEPRsqEodw7nV9m37rl0nKJSQt/lws1Bd+5m6lNWryCxXmvy0
         5LbLUwm3q5UIYaAFter9p+v4Z6l8xffGBxnh9zmNpyyA9FDzuoN7eBHVLSEsfhy5+VJM
         lzXLAfpBU2+2g2bDaXB68rX/e+tvV9043MPrytopqACbsO+5Uguo8i5bSScW+UaWLqKG
         jLg038sX1FXcy2HgxIimdNOSqsfUNJcmNUC+lSlbRADNvYcOsc8SUf2Vom6fp7pKUv/8
         OiJrnORk6T0OK13X5s2NHGq4hTlcBX7eoi2NXYdq8BKj1EpQfkzObFyKXjmHTtZSINOq
         8aEg==
X-Gm-Message-State: AJIora9nkhE/kxpKkTSVdRR1E6+nakr0AaPnlZarvryVqttMOcuMnaae
        w4IVhxg9uDVmFaSqQqtYpkXncwF4RrWboQ==
X-Google-Smtp-Source: AGRyM1v9OwCD/mIjXxG7JuyOVuE7wVDH0ML6DD36dmy20E3EZEsoKb1Sd/Q7lwcI8Phbo8lcNhwG5A==
X-Received: by 2002:a05:600c:3227:b0:3a3:be7:2917 with SMTP id r39-20020a05600c322700b003a30be72917mr68978wmp.83.1657827600305;
        Thu, 14 Jul 2022 12:40:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:39:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] CI: export variables via a wrapper
Date:   Thu, 14 Jul 2022 21:39:44 +0200
Message-Id: <patch-07.10-e6805874eb9-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
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

To that end call the "setenv" function with optional "--install",
"--build", "--test" and "--all" parameters to indicate whether they're
needed for building, testing or both.

We currently ignore the "varname" parameter, but will make use of it in a
subsequent commit. Adding it here reduces the needless churn, as we
won't need to change all these lines again for that subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                 | 69 +++++++++++++++++++++++++++++----------
 ci/run-build-and-tests.sh | 34 +++++++++----------
 2 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 44039152ebc..67b7b32a0f1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -59,6 +59,38 @@ else
 	begin_group "CI setup"
 fi
 
+# Helper functions
+setenv () {
+	while test $# != 0
+	do
+		case "$1" in
+		--install)
+			;;
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
+	eval "$key=\"$val\""
+	eval "export $key"
+}
+
 check_unignored_build_artifacts () {
 	! git ls-files --other --exclude-standard --error-unmatch \
 		-- ':/*' 2>/dev/null ||
@@ -73,7 +105,7 @@ handle_failed_tests () {
 }
 
 # GitHub Action doesn't set TERM, which is required by tput
-export TERM=${TERM:-dumb}
+setenv --all TERM ${TERM:-dumb}
 
 # How many jobs to run in parallel?
 NPROC=10
@@ -87,11 +119,11 @@ then
 	# We are running in Azure Pipelines
 	CC="${CC:-gcc}"
 
-	export GIT_PROVE_OPTS="--timer --jobs $NPROC --state=failed,slow,save"
+	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC --state=failed,slow,save"
 	GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	test Windows_NT != "$AGENT_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
-	export GIT_TEST_OPTS
+	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
 elif test true = "$GITHUB_ACTIONS"
 then
 	CI_TYPE=github-actions
@@ -118,21 +150,21 @@ then
 		return 1
 	}
 
-	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
+	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
 	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
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
@@ -148,19 +180,20 @@ ubuntu-latest)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
 	fi
 
-	export GIT_TEST_HTTPD=true
+	setenv --test GIT_TEST_HTTPD true
 
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs much more recent versions, whichever
 	# were recorded in the Homebrew database upon creating the OS X
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
-	export LINUX_GIT_LFS_VERSION="1.5.2"
+	setenv --install LINUX_P4_VERSION "16.2"
+	setenv --install LINUX_GIT_LFS_VERSION "1.5.2"
 
-	P4_PATH="$HOME/custom/p4"
-	GIT_LFS_PATH="$HOME/custom/git-lfs"
-	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	setenv --install P4_PATH "$HOME/custom/p4"
+	setenv --install GIT_LFS_PATH "$HOME/custom/git-lfs"
+	setenv --all PATH "$GIT_LFS_PATH:$P4_PATH:$PATH"
+	setenv --test GIT_TEST_HTTPD true
 	;;
 macos-latest)
 	if [ "$jobname" = osx-gcc ]
@@ -183,13 +216,13 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 linux-leaks)
-	export SANITIZE=leak
-	export GIT_TEST_PASSING_SANITIZE_LEAK=true
+	setenv --build SANITIZE leak
+	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-export MAKEFLAGS
+setenv --all MAKEFLAGS "$MAKEFLAGS"
 
 end_group
 set -x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 1a89a4967bf..b7774e4abcf 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -9,33 +9,33 @@ run_tests=t
 
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
-	export GIT_TEST_ADD_I_USE_BUILTIN=0
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
+	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 0
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
 	run_tests=
 	;;
 esac
-- 
2.37.1.996.g651fc6e809f

