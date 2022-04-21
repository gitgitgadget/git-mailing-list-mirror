Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82727C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391384AbiDUS2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391319AbiDUS1c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21494BB95
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e2so1563879wrh.7
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oz0mdEw13vDLO+FgHBYEq0ULOnS9kZiQpvR8Lco819s=;
        b=UA6s/c0Gixgd2/jmc1v4FTpNHzWSG1RuiWRs5ia9jV7JEoOQ7u4Vv5i5/J5flHi0my
         6Za376qaBvlOIREfeVtMT6TFEh9F+F7NSwbyu06c+zSwde7kQpDBVd7sB3BNzeWkH6Ux
         lJkVqWygSTR+i5Jvxhh4sM87vprmzotb4/wnuOxYaHUvOdIEhgJuWeFwywzeu0X6ofsQ
         /O1ND0aIN3mIhs0BnTSpsjTw0qEl72LvtneXjy58+p7219/cDXJ4Ese6ZeJ0qinx3wza
         T9Tg90gI53UGf5jvfzf0DxqqzKFkou3IjwGmeNYvDbHGa28D9F5faPwCsMG3gp74xOHt
         yEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oz0mdEw13vDLO+FgHBYEq0ULOnS9kZiQpvR8Lco819s=;
        b=z6BCTu1ZKiVYVOaA7M4cJVKr9IuYSI6PDla+jo0a3T6EBNWvFpWR8Zax85Rs8J457H
         UbL9vBFb0FxNOSgwbYTUzAFsH5qrjYhsWd84Y2UvjgP0893kotnTsRliqlQft089wwcO
         2AyIhQEqiMezQ0KpsspCgTL3f/6bjXL6pUTWbLfUojsijvUO+K5HRyIuNcZ7iDUIehGu
         ugTcPlACx7oTZk2nmxP5ZNVJuf9EcZTRHGcDW6ylvDw9zHHodmTZYmDI8C0AHiwhC2+6
         6luxjNvdnKnKeyMCCMcytFWCH/XKrlIyfhnUGNvnQnFDKH5XMBCDpENTNNhol/RbMmp2
         4ANg==
X-Gm-Message-State: AOAM530KcGbUbpIICHD0PtOiHYcSSeGubfQ+ubBXmrNlrTGVFHxs8lkb
        URcJUIFQwjfj3L0f4B/NjqIaULyMEyv8ZQ==
X-Google-Smtp-Source: ABdhPJx5mfhOP0EzFDt/1TiQFgqewhVZCgOncJVlDrQ1Qtf7L8/YL/lmWXUx97ktJECiQIrnaBx5wA==
X-Received: by 2002:a5d:64c4:0:b0:20a:8f02:1fe6 with SMTP id f4-20020a5d64c4000000b0020a8f021fe6mr750195wri.15.1650565443279;
        Thu, 21 Apr 2022 11:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:24:02 -0700 (PDT)
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
Subject: [PATCH v5 29/29] CI: make it easy to use ci/*.sh outside of CI
Date:   Thu, 21 Apr 2022 20:23:24 +0200
Message-Id: <patch-v5-29.29-13d8c6997c3-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
2.36.0.879.g3659959fcca

