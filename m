Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99FAC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiEYKFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiEYKFO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4253C6D966
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so29410403wrg.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rbfG0lxqBh3TKDLdOki7ZzMwBV4WGgdDQKe9E14CKI=;
        b=O6cZ/kzzg0aAuHFFeb8UYsP0UfCkQcLcI7SuGjSeImk8DSysXTe3bTqJYzhPPKCGmv
         551GG0WRgkszSTB9XuWqXSzMZ8NfmvlVruBsLal0ZJjwdRu20ZUeOQMlw3h5zwGQC5HK
         MDyTrPY9QBtAr5kPbgz7Wka9OxAQ1JWtloOHfxcKa8h8rb64hKD7ccIsCUXdLaR7Nz0b
         3A1vH0+IKLL5GsOnKHCfK1yJ9o82NfV26k/NS9P+EdScv3qlx4m2E8cCq7as9Pb5ADtv
         rZJfXF5l+XD8w5LnUz4vxOWCNbFBuInetPipfjvqTWQvPxXGo9N0Hn44BQG+yEiL71OT
         bQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rbfG0lxqBh3TKDLdOki7ZzMwBV4WGgdDQKe9E14CKI=;
        b=LgsJ7WtLybAaXwqMxG53rTbsJqvy7Bgjkg/wvbrZAiHRVKT6t2i3CkjTh/L25Nu8JX
         FjG7pcq5oSzVFvJmTek3+XLyoy5SLqMiZY3YZYbu025R6nIwWhY62unxQ1Z5LT43l/3L
         MLVZ068Wtj3t6vYafqLP06NH/dLfJ1xPQ7saaz8cP+gFSfIiUZIp8pQ14/NY8NtUPwsC
         9uvP9tkkoo1KPRNIokO1P0En/GcwNbHJRxfszQOEpB+yeGhhqKfyUmg8VtiXmGNZ+e4m
         Je1TMrdvi4zD4KsxRzxsor6PfdzuyQ9ZH//P1PqUAtT4odN+ixAXgTqSvdWb+Ol8E6gs
         8xcA==
X-Gm-Message-State: AOAM532THrH2/QkhzHUvrd/UtiMtsg+BXurLITpNAeWJGPoveQ0N3U8l
        kJ0VHYq9EteKDadzGJ6vcA4gBIUtycbG5A==
X-Google-Smtp-Source: ABdhPJwNwfonorVw9mowhbAB0TvZbsiP70X2DjAttaCQygpyH0h2/ZDK2Sn+hRToiOQk+uJSJR6CQA==
X-Received: by 2002:a5d:5641:0:b0:20d:c15:1b33 with SMTP id j1-20020a5d5641000000b0020d0c151b33mr25647953wrw.66.1653473112485;
        Wed, 25 May 2022 03:05:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:11 -0700 (PDT)
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
Subject: [PATCH v6 29/29] CI: make it easy to use ci/*.sh outside of CI
Date:   Wed, 25 May 2022 12:04:08 +0200
Message-Id: <patch-v6-29.29-4d8a8f3be07-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the ci/.sh scripts have lost most of their
CI-specific assumptions. Let's go even further and explicitly support
running ci/lib.sh outside of CI.

This was possible before by faking up enough CI-specific variables,
but as shown in the new "help" output being added here using the
ci/lib.sh to provide "CI-like" has now become trivial.

The ci/print-test-failures.sh scripts can now be used outside of CI as
well, the only GitHub CI-specific part is now guarded by a check that
we'll pass if outside of GitHub CI.

There's also a special-case here to not clobber $MAKEFLAGS in the
environment if we're outside of CI, in case the user has e.g. "jN" or
other flags to "make" that they'd prefer configured already.

Using "ci/lib.sh" as a stand-alone script is much more useful if it
doesn't hardcode NPROC=10, let's provide a poor shellscript
replacement for the online_cpus() we have in thread-utils.c to cover
the most common OS's.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib-ci-type.sh         |  3 --
 ci/lib-online_cpus.sh     | 26 +++++++++++++
 ci/lib.sh                 | 80 ++++++++++++++++++++++++++++++++++-----
 ci/print-test-failures.sh |  4 --
 4 files changed, 96 insertions(+), 17 deletions(-)
 create mode 100644 ci/lib-online_cpus.sh

diff --git a/ci/lib-ci-type.sh b/ci/lib-ci-type.sh
index 6f01fd9e5d9..09acab7aaec 100644
--- a/ci/lib-ci-type.sh
+++ b/ci/lib-ci-type.sh
@@ -3,7 +3,4 @@
 if test "$GITHUB_ACTIONS" = "true"
 then
 	CI_TYPE=github-actions
-else
-	echo "Could not identify CI type" >&2
-	exit 1
 fi
diff --git a/ci/lib-online_cpus.sh b/ci/lib-online_cpus.sh
new file mode 100644
index 00000000000..7cf0cd042fa
--- /dev/null
+++ b/ci/lib-online_cpus.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+# TODO: Ideally we'd compile t/helper/test-online-cpus.c early, but
+# that currently presents a chicken & egg problem. We need this before
+# we build (much of) anything.
+online_cpus() {
+	NPROC=
+
+	if command -v nproc >/dev/null
+	then
+		# GNU coreutils
+		NPROC=$(nproc)
+	elif command -v sysctl >/dev/null
+	then
+		# BSD & Mac OS X
+		NPROC=$(sysctl -n hw.ncpu)
+	elif test -n "$NUMBER_OF_PROCESSORS"
+	then
+		# Windows
+		NPROC="$NUMBER_OF_PROCESSORS"
+	else
+		NPROC=1
+	fi
+
+	echo $NPROC
+}
diff --git a/ci/lib.sh b/ci/lib.sh
index 9e38c893890..80e89f89b7f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,16 +1,55 @@
 #!/bin/sh
 set -e
 
+# Usage
+CI_TYPE_HELP_COMMANDS='
+	# run "make all test" like the "linux-leaks" job
+	(eval $(jobname=linux-leaks ci/lib.sh --all) && make test)
+
+	# run "make all test" like the "linux-musl" job
+	(eval $(jobname=linux-musl ci/lib.sh --all) && make test)
+
+	# run "make test" like the "linux-TEST-vars" job (uses various GIT_TEST_* modes)
+	make && (eval $(jobname=linux-TEST-vars ci/lib.sh --test) && make test)
+
+	# run "make test" like the "linux-sha256" job
+	make && (eval $(jobname=linux-sha256 ci/lib.sh --test) && make test)
+'
+
+CI_TYPE_HELP="
+Running $0 outside of CI? You can use ci/lib.sh to set up your
+environment like a given CI job. E.g.:
+$CI_TYPE_HELP_COMMANDS
+Note that some of these (e.g. the linux-musl one) may not work as
+expected due to the CI job configuring a platform that may not match
+yours."
+
+usage() {
+	echo "usage: jobname=<job-name> [runs_on_pool=<pool-name>] $0 (--build | --test)" >&2
+	if test -z "$CI_TYPE"
+	then
+		echo "$CI_TYPE_HELP" >&2
+	fi
+	exit 1
+}
+
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
 
 # Parse options
+mode_all=
 mode_build=
 mode_test=
 mode_debug=
 while test $# != 0
 do
 	case "$1" in
+	--all)
+		echo "MODE: $1" >&2
+		mode_all=t
+		mode_build=t
+		mode_test=t
+		;;
 	--build)
 		echo "MODE: $1" >&2
 		mode_build=t
@@ -25,11 +64,11 @@ do
 		;;
 	-*)
 		echo "error: invalid option: $1" >&2
-		exit 1
+		usage
 		;;
 	*)
 		echo "error: invalid argument: $1" >&2
-		exit 1
+		usage
 		;;
 	esac
 	shift
@@ -39,13 +78,13 @@ done
 if test -z "$jobname"
 then
 	echo "error: must set a CI jobname in the environment" >&2
-	exit 1
+	usage
 fi
 
-if test "$mode_test$mode_build" != "t"
+if test "$mode_test$mode_build" != "t" && test -z "$mode_all"
 then
 	echo "error: need one mode, e.g. --build or --test" >&2
-	exit 1
+	usage
 fi
 
 # Show our configuration
@@ -65,13 +104,13 @@ setenv () {
 	do
 		case "$1" in
 		--build)
-			if test -z "$mode_build"
+			if test -z "$mode_build$mode_all"
 			then
 				skip=t
 			fi
 			;;
 		--test)
-			if test -z "$mode_test"
+			if test -z "$mode_test$mode_all"
 			then
 				skip=t
 			fi
@@ -103,6 +142,10 @@ setenv () {
 	if test -n "$GITHUB_ENV"
 	then
 		echo "$key=$val" >>"$GITHUB_ENV"
+	elif test -z "$CI_TYPE"
+	then
+		echo "$key=\"$val\""
+		echo "export $key"
 	fi
 
 	echo "SET: '$key=$val'" >&2
@@ -113,10 +156,25 @@ CC=
 
 # How many jobs to run in parallel?
 NPROC=10
+case "$CI_TYPE" in
+'')
+	. ${0%/*}/lib-online_cpus.sh
+	NPROC=$(online_cpus)
+
+	if test -n "$MAKEFLAGS"
+	then
+		COMMON_MAKEFLAGS="$MAKEFLAGS"
+	else
+		COMMON_MAKEFLAGS=--jobs=$NPROC
+	fi
+	;;
+*)
+	# For "--test" we carry the MAKEFLAGS over from earlier steps, except
+	# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
+	COMMON_MAKEFLAGS=--jobs=$NPROC
+	;;
+esac
 
-# For "--test" we carry the MAKEFLAGS over from earlier steps, except
-# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
-COMMON_MAKEFLAGS=--jobs=$NPROC
 
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=$COMMON_MAKEFLAGS
@@ -136,6 +194,8 @@ github-actions)
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
 	;;
+'')
+	;;
 *)
 	echo "Unhandled CI type: $CI_TYPE" >&2
 	exit 1
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 29f8c332eca..ec395c79ccd 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -36,10 +36,6 @@ do
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			;;
-		*)
-			echo "Unhandled CI type: $CI_TYPE" >&2
-			exit 1
-			;;
 		esac
 	fi
 done
-- 
2.36.1.1045.gf356b5617dd

