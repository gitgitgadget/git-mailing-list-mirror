Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E8C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiGNTkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGNTj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:39:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D822A416
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r14so3936075wrg.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V91dvfWnHDATESKUq6V1HP5ZKYjWEgYrFH4URvLY1Vg=;
        b=fJr7ca+iSRdDoycX7UQna/GV2kfEP9uhTzoidpnqYB9rF6ZpHGsH/+l9zXYrYP8k1i
         rBJpMvuntVgoTKgDdmNn9kTzxRWKcVH8/GKO7RDrBGy5tW0M4EENPBBd5la87o1qigCe
         lwowUGbliBJHU0m+fRYTT6CGtGBev1QKKwooEDweoc8QlyN1r52xLBJbtqllWjrU+REj
         B2AkJ/L+1yKzTsS9O1lqG7O0hta+SbYpw98Gxit/yinGmG06g3kXS/PyP5Y6MS94W6oc
         8PQb6dpLHk5JuU58WJzN4qPSQ2NmXchbSoiIHDH61NvTosVM74NwEWt5bJ8Cz/rj1geD
         sH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V91dvfWnHDATESKUq6V1HP5ZKYjWEgYrFH4URvLY1Vg=;
        b=XEP5ZLvqS1bWLWJOFTGwEQ5O5dFsc79slMfOWutdsw9wBveTtWL/S6cCNp04Kxyixp
         YxWGMraBgZKOziwboMlk2VpWcDFIRT0FNUilzMw4ql6gyq8zLIYBFb3t/8erwIU0tlJ3
         0KQVXfdqargmQbjIk/ry+bHNGjLY7DqtI0JfqJdgamevKHbpZVVNxHsVOlbuAZugZvnE
         g4w2AOT7l08tkC7ScnNfmYOaR/PcON4h3fjrjPaR31ROXiowYYbHmIZzbaTMVsyXaPHc
         kUMGUWlkbvEMecEe6iz9wbTfLs3bjAY2VYxVhO3QOMrcwkl1Qxx57aHjV5cCk63bVFSj
         0jrQ==
X-Gm-Message-State: AJIora+9A6ZAAnZ41m+29G6sqOTFabbaRvgeuH3SYkO4kHZiPm9jWQXj
        FLXlVUdouIYiMT53WU5SNGLrLgOLElcUvg==
X-Google-Smtp-Source: AGRyM1uUA1gLgVKRqGB46PyoXN2Iomtx+XTYAdBVHbBhXotmm5OZlh42JaWorrvZrr02Syigt7LLlA==
X-Received: by 2002:a05:6000:68e:b0:21d:76e3:cc80 with SMTP id bo14-20020a056000068e00b0021d76e3cc80mr9629037wrb.327.1657827594272;
        Thu, 14 Jul 2022 12:39:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:39:53 -0700 (PDT)
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
Subject: [PATCH 02/10] CI: remove more dead Travis CI support
Date:   Thu, 14 Jul 2022 21:39:39 +0200
Message-Id: <patch-02.10-39ef9d2ab6e-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
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
index 4f12bcaabb9..f32c588f6ad 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -148,9 +148,6 @@ then
 	CI_COMMIT="$BUILD_SOURCEVERSION"
 	CI_JOB_ID="$BUILD_BUILDID"
 	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
-	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
-	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
-	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
 	CC="${CC:-gcc}"
 
 	# use a subdirectory of the cache dir (because the file share is shared
@@ -160,16 +157,13 @@ then
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
@@ -200,7 +194,7 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 10"
 	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
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
index 8ebff425967..9a5032e6a77 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,11 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
-esac
-
 run_tests=t
 
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
index a3c67956a8d..312a3ef73fe 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -5,11 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-case "$CI_OS_NAME" in
-windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
-*) ln -s "$cache_dir/.prove" t/.prove;;
-esac
-
 group "Run tests" make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')" ||
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
2.37.1.996.g651fc6e809f

