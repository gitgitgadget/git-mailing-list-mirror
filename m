Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B3C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbiEYKE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKEt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95C6D4EB
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j25so4963101wrb.6
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTbXPYe3qbqrW7WI2UBxMMiaKkciTrVHG3FWOwYYZZk=;
        b=Lby6w/nNw2djxpTcoa9JSosY2ghgxPyjBjckH4Kxej1+uHjjXAbqyyvI9JB6UKbB7/
         fIJESl6icw5U4npWaJYLsG4RBt7NOudheYj8Fph3oK46LZ9bmiaRiLJSqU629a3YRdrp
         2AgdTsPXGfqBm8owKl3RDQyVPO25vmljMEldfHu0dg9/VCH/UFQcx7DiqdbAxCOtNh2Z
         ejRUvVWaU5wJFPatwGpZfUwFScfQftUYSxp+mk2tBjog2Dsc3DAUKIG+57A/QaYUpdco
         dZJbIIZn/jPiJn0FCDvgUp7KjwBE/Tntu0APfwW67LkTET/ReciOWUZM7qHTZvufFoAc
         JOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTbXPYe3qbqrW7WI2UBxMMiaKkciTrVHG3FWOwYYZZk=;
        b=piVYN/cs2sp1ciQvy+y5vks9YM2Ne3N1Ssttzb0I8HaWt5GLb8PpKA1nLokBibPLGV
         Dl4JF4IPesEtzEdUXc2aqz7KL6frZokkHXD0T+Z7Zzmxosr/zugTsFq1ZnmwpUP3/KQh
         4yQzkjdaGGHbCbUd+ymWIZ5+arnzSp65nQp+yRQILuLCM7nK2/dLnTLcgYbUPq3oXhcW
         u5SmdWPw+APzWg6wU3rhVMpnRDLk7BMC3/eVcd8nmcQyWxjcwLdjfvV/12SAIP/wGoP7
         qPhtN5viP0lLqtktmWlTuoa4M9aEKWhsOTELlmXxsCIiwn+Zw2zG3FcSP4eO7HRmzUI0
         32sw==
X-Gm-Message-State: AOAM533NXGOrjnzEnXBE0DVjgoBxCkewtVrCeUu+sn+OrpgdbrQKkcBC
        K9BogcgZpE+UVzyUPv88CtdKkCQSGJB16A==
X-Google-Smtp-Source: ABdhPJz9ke2eJLLX3/I192PDcAHm5EajCfm7gt40JjzK8hZBVwUdwmZXpmxjSMvBw/sUKCA4xkV8Ug==
X-Received: by 2002:a5d:4e08:0:b0:210:297:7d4b with SMTP id p8-20020a5d4e08000000b0021002977d4bmr892723wrt.112.1653473084852;
        Wed, 25 May 2022 03:04:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:44 -0700 (PDT)
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
Subject: [PATCH v6 03/29] CI: remove more dead Travis CI support
Date:   Wed, 25 May 2022 12:03:42 +0200
Message-Id: <patch-v6-03.29-234e248e831-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code that I missed in 4a6e4b96026 (CI: remove Travis CI
support, 2021-11-23). This code was only called from or used by the
now-removed .travis.yml, or needed by the Travis CI environment.

For the symlinking in ci/run-build-and-tests.sh: Back when
3c93b829205 (travis-ci: build Git during the 'script' phase,
2018-01-08) and 4b060a4d973 (ci: use a junction on Windows instead of
a symlink, 2019-01-27) adjusted this "ln" command, the Windows build
would use ci/run-build-and-tests.sh.

As seen in 889cacb6897 (ci: configure GitHub Actions for CI/PR,
2020-04-11) the current windows build uses a different entry point
under the GitHub CI, which doesn't use this .prove caching. Namely
"ci/run-test-slice.sh".

We can be certain that it's never used in "ci/run-test-slice.sh"
because to have a ".prove" file we'd need to use "--state=save", which
we only do in the dead Azure codepath in ci/lib.sh. If it were used it
would do the wrong thing, because the different test slices would each
try to clobber the same "t/.prove" file.

If a subsequent run then used the "--state=failed,slow,save" it would
defeat the purpose of "ci/run-test-slice.sh", since all slices would
then run all tests. I.e. behavior of prove's "--state" options is to
select tests to run from the provided "--state" file, in addition to
those specified on the command-line.

For ci/run-docker{,-build}.sh: It was likewise last referenced in the
.travis.yml removed in my 4a6e4b96026. The current "dockerized" run in
".github/workflows/main.yml" calls the same entry points as the main
"regular" job.

For "ci/print-test-failures.sh" the creation of the tarball added in
aea8879a6ac (travis-ci: include the trash directories of failed tests
in the trace log, 2018-08-01) has been dead since my 4a6e4b96026,
which removed the fall-through case from the "case/esac" statement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh                     | 10 ++----
 ci/print-test-failures.sh     | 39 ---------------------
 ci/run-build-and-tests.sh     |  5 ---
 ci/run-docker-build.sh        | 66 -----------------------------------
 ci/run-docker.sh              | 47 -------------------------
 ci/run-test-slice.sh          |  5 ---
 ci/util/extract-trash-dirs.sh | 50 --------------------------
 7 files changed, 2 insertions(+), 220 deletions(-)
 delete mode 100755 ci/run-docker-build.sh
 delete mode 100755 ci/run-docker.sh
 delete mode 100755 ci/util/extract-trash-dirs.sh

diff --git a/ci/lib.sh b/ci/lib.sh
index 3061de96d8f..2e60c0a71b5 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -106,9 +106,6 @@ then
 	CI_COMMIT="$BUILD_SOURCEVERSION"
 	CI_JOB_ID="$BUILD_BUILDID"
 	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
-	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
-	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
-	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
 	CC="${CC:-gcc}"
 
 	# use a subdirectory of the cache dir (because the file share is shared
@@ -118,16 +115,13 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
-	test windows_nt != "$CI_OS_NAME" ||
+	test Windows_NT != "$AGENT_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 elif test true = "$GITHUB_ACTIONS"
 then
 	CI_TYPE=github-actions
 	CI_BRANCH="$GITHUB_REF"
 	CI_COMMIT="$GITHUB_SHA"
-	CI_OS_NAME="$(echo "$RUNNER_OS" | tr A-Z a-z)"
-	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
-	CI_REPO_SLUG="$GITHUB_REPOSITORY"
 	CI_JOB_ID="$GITHUB_RUN_ID"
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=t
@@ -137,7 +131,7 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 10"
 	export GIT_TEST_OPTS="--verbose-log -x"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
-	test windows != "$CI_OS_NAME" ||
+	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
 	echo "Could not identify CI type" >&2
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 57277eefcd0..740ebb7c529 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -16,15 +16,6 @@ then
 	exit
 fi
 
-case "$jobname" in
-osx-clang|osx-gcc)
-	# base64 in OSX doesn't wrap its output at 76 columns by
-	# default, but prints a single, very long line.
-	base64_opts="-b 76"
-	;;
-esac
-
-combined_trash_size=0
 for TEST_EXIT in test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
@@ -42,47 +33,17 @@ do
 		azure-pipelines)
 			mkdir -p failed-test-artifacts
 			mv "$trash_dir" failed-test-artifacts
-			continue
 			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
-			continue
 			;;
 		*)
 			echo "Unhandled CI type: $CI_TYPE" >&2
 			exit 1
 			;;
 		esac
-		trash_tgz_b64="trash.$test_name.base64"
-		if [ -d "$trash_dir" ]
-		then
-			tar czp "$trash_dir" |base64 $base64_opts >"$trash_tgz_b64"
-
-			trash_size=$(wc -c <"$trash_tgz_b64")
-			if [ $trash_size -gt 1048576 ]
-			then
-				# larger than 1MB
-				echo "$(tput setaf 1)Didn't include the trash directory of '$test_name' in the trace log, it's too big$(tput sgr0)"
-				continue
-			fi
-
-			new_combined_trash_size=$(($combined_trash_size + $trash_size))
-			if [ $new_combined_trash_size -gt 1048576 ]
-			then
-				echo "$(tput setaf 1)Didn't include the trash directory of '$test_name' in the trace log, there is plenty of trash in there already.$(tput sgr0)"
-				continue
-			fi
-			combined_trash_size=$new_combined_trash_size
-
-			# DO NOT modify these two 'echo'-ed strings below
-			# without updating 'ci/util/extract-trash-dirs.sh'
-			# as well.
-			echo "$(tput setaf 1)Start of trash directory of '$test_name':$(tput sgr0)"
-			cat "$trash_tgz_b64"
-			echo "$(tput setaf 1)End of trash directory of '$test_name'$(tput sgr0)"
-		fi
 	fi
 done
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 280dda7d285..0a1ec8c2bae 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,11 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
-esac
-
 export MAKE_TARGETS="all test"
 
 case "$jobname" in
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
deleted file mode 100755
index 6cd832efb9c..00000000000
--- a/ci/run-docker-build.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-#
-# Build and test Git inside container
-#
-# Usage:
-#   run-docker-build.sh <host-user-id>
-#
-
-set -ex
-
-if test $# -ne 1 || test -z "$1"
-then
-	echo >&2 "usage: run-docker-build.sh <host-user-id>"
-	exit 1
-fi
-
-case "$jobname" in
-linux32)
-	switch_cmd="linux32 --32bit i386"
-	;;
-linux-musl)
-	switch_cmd=
-	useradd () { adduser -D "$@"; }
-	;;
-*)
-	exit 1
-	;;
-esac
-
-"${0%/*}/install-docker-dependencies.sh"
-
-# If this script runs inside a docker container, then all commands are
-# usually executed as root. Consequently, the host user might not be
-# able to access the test output files.
-# If a non 0 host user id is given, then create a user "ci" with that
-# user id to make everything accessible to the host user.
-HOST_UID=$1
-if test $HOST_UID -eq 0
-then
-	# Just in case someone does want to run the test suite as root.
-	CI_USER=root
-else
-	CI_USER=ci
-	if test "$(id -u $CI_USER 2>/dev/null)" = $HOST_UID
-	then
-		echo "user '$CI_USER' already exists with the requested ID $HOST_UID"
-	else
-		useradd -u $HOST_UID $CI_USER
-	fi
-fi
-
-# Build and test
-command $switch_cmd su -m -l $CI_USER -c "
-	set -ex
-	export DEVELOPER='$DEVELOPER'
-	export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET'
-	export GIT_PROVE_OPTS='$GIT_PROVE_OPTS'
-	export GIT_TEST_OPTS='$GIT_TEST_OPTS'
-	export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB'
-	export MAKEFLAGS='$MAKEFLAGS'
-	export cache_dir='$cache_dir'
-	cd /usr/src/git
-	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
-	make
-	make test
-"
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
deleted file mode 100755
index af89d1624a4..00000000000
--- a/ci/run-docker.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/sh
-#
-# Download and run Docker image to build and test Git
-#
-
-. ${0%/*}/lib.sh
-
-case "$jobname" in
-linux32)
-	CI_CONTAINER="daald/ubuntu32:xenial"
-	;;
-linux-musl)
-	CI_CONTAINER=alpine
-	;;
-*)
-	exit 1
-	;;
-esac
-
-docker pull "$CI_CONTAINER"
-
-# Use the following command to debug the docker build locally:
-# <host-user-id> must be 0 if podman is used as drop-in replacement for docker
-# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/sh "$CI_CONTAINER"
-# root@container:/# export jobname=<jobname>
-# root@container:/# /usr/src/git/ci/run-docker-build.sh <host-user-id>
-
-container_cache_dir=/tmp/container-cache
-
-docker run \
-	--interactive \
-	--env DEVELOPER \
-	--env DEFAULT_TEST_TARGET \
-	--env GIT_PROVE_OPTS \
-	--env GIT_TEST_OPTS \
-	--env GIT_TEST_CLONE_2GB \
-	--env MAKEFLAGS \
-	--env jobname \
-	--env cache_dir="$container_cache_dir" \
-	--volume "${PWD}:/usr/src/git" \
-	--volume "$cache_dir:$container_cache_dir" \
-	"$CI_CONTAINER" \
-	/usr/src/git/ci/run-docker-build.sh $(id -u $USER)
-
-check_unignored_build_artifacts
-
-save_good_tree
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index f8c2c3106a2..b9a682b4bcd 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,11 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
-esac
-
 make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')"
diff --git a/ci/util/extract-trash-dirs.sh b/ci/util/extract-trash-dirs.sh
deleted file mode 100755
index 8e67bec21a2..00000000000
--- a/ci/util/extract-trash-dirs.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-
-error () {
-	echo >&2 "error: $@"
-	exit 1
-}
-
-find_embedded_trash () {
-	while read -r line
-	do
-		case "$line" in
-		*Start\ of\ trash\ directory\ of\ \'t[0-9][0-9][0-9][0-9]-*\':*)
-			test_name="${line#*\'}"
-			test_name="${test_name%\'*}"
-
-			return 0
-		esac
-	done
-
-	return 1
-}
-
-extract_embedded_trash () {
-	while read -r line
-	do
-		case "$line" in
-		*End\ of\ trash\ directory\ of\ \'$test_name\'*)
-			return
-			;;
-		*)
-			printf '%s\n' "$line"
-			;;
-		esac
-	done
-
-	error "unexpected end of input"
-}
-
-# Raw logs from Linux build jobs have CRLF line endings, while OSX
-# build jobs mostly have CRCRLF, except an odd line every now and
-# then that has CRCRCRLF.  'base64 -d' from 'coreutils' doesn't like
-# CRs and complains about "invalid input", so remove all CRs at the
-# end of lines.
-sed -e 's/\r*$//' | \
-while find_embedded_trash
-do
-	echo "Extracting trash directory of '$test_name'"
-
-	extract_embedded_trash |base64 -d |tar xzp
-done
-- 
2.36.1.1045.gf356b5617dd

