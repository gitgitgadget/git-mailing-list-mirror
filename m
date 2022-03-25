Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60DC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiCYTeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiCYTdP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:33:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7321DF04
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:07:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so3261999wms.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WF27/z9yPLrApnJgGryINuWUpeDmL/QMOgWhvKlOG8Y=;
        b=I5l5OOcRtU9m7/E2ftR99fcYpB3fe47dSCxG0Sn/0ilAc8P2Yo6kt7fHO7JNv9vp9q
         G3kc2uvhqYNp3onBEdjVywX3m5cOzYqXUN0zuBb536zwq9/J1WGE5WL7tkVljvI9ntWE
         myCnMqg3H/15ROIVv1iAw80wCJv5UO37ixaYYUYspSufBy3e23V/jSU8LeZwziec/M8H
         6lBP/pdXvUAj7OumV9K4failQcVR4bZkyJyuytO/CfcDq0jnxAlDNO0ccD7LeWKbw7zL
         gbNwtfe8mHNGYU8orsnOhxEcrGSRZlDRURpcOZmnYnQUSX3c6TqYdWYJt+1SYPXv4ckK
         /8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WF27/z9yPLrApnJgGryINuWUpeDmL/QMOgWhvKlOG8Y=;
        b=VI+xjz7ywOk0jgDM9f/0EOlFQc2OcUTYLl5kCeLZu8k7GLarYsOCcZe+ihS0ggZnOv
         f3E3N6QLmzw5qdSBqpj+pwLqhvmnv6avTcyGO4mDSRFagr/pLKtuaCnuXoFoPPpv5hkC
         9Ungj/2BVIdFQsqegtWzQmADmcmEbBUqTrr9G+l+FgZkMj/hxtiOl6ZehxNk9niHdaru
         XHdB0m7LWh779ykgk6Y6vrsMP4Ey+q9IKn+j8FnJp8+JUlNdy69I9gEKw5ROv53GBENI
         bM4+9wUAb5T6TpflzS6Y8HE9qfIb2I38iZKtdAXCCDL8n4M0BWgz90CofT8r50LdEJxa
         fqdQ==
X-Gm-Message-State: AOAM530HQhED2ezN9Y5EUOuXjMa31mCzHsV3ZC11lFDmpJY8vNqUb28P
        O0yKUriZ4zbKvATUP91vj80SJ4XPqbmASw==
X-Google-Smtp-Source: ABdhPJzg2KxZiVfLOjBne+cKsgSAd6//zXmKqU9ZJavNVOclKmN+tRy2rcbijpSPvVlWbRcn0k7CRw==
X-Received: by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id n65-20020a1c2744000000b00382a9b71c8amr11053864wmn.187.1648233510530;
        Fri, 25 Mar 2022 11:38:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:30 -0700 (PDT)
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
Subject: [PATCH v2 12/25] CI: remove "run-build-and-tests.sh", run "make [test]" directly
Date:   Fri, 25 Mar 2022 19:38:03 +0100
Message-Id: <patch-v2-12.25-86d5a48d59a-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the already thin "ci/run-build-and-tests.sh" wrapper and
instead make the CI run "make" or "make test" directly. By doing this
we'll be able to easily see at a glance whether our failure was in the
compilation or testing, whether that's via human eyes or improve
machine readability.

We also need to run our new "ci/check-unignored-build-artifacts.sh" on
success() in the CI now, just like we already had a step conditional
on failure() running ci/print-test-failures.sh.

The reason we used a "ci/run-build-and-tests.sh" wrapper in the first
place had to do with Travis CI-specific constraints that no longer
apply to us, as the Travis CI support has been removed.

Instead we can configure the CI in an earlier step by running
"ci/lib.sh", which under GitHub CI will write the environment
variables we need to the "$GITHUB_ENV" file.

We'll then have access to them in subsequent steps, and crucially
those variables will be prominently visible at the start of each step
via an expandable drop-down in the UI.drop-do.

I.e. this changes the CI run from a top-down flow like (pseudocode):

 - job:
   - step1:
     - use ci/lib.sh to set env vars
     - run a script like ci/run-build-and-tests.sh
   - step2:
     - if: failure()
     - use ci/lib.sh to set env vars
     - run ci/print-test-failures.sh

To:

 - job:
   - step1:
     - set variables in $GITHUB_ENV using ci/lib.sh
   - step2:
     - make
   - step3:
     - make test
   - step4:
     - if: failure()
     - run ci/print-test-failures.sh
   - step5:
     - if: success()
     - run ci/check-unignored-build-artifacts.sh

There is a proposal[2] to get some of the benefits of this approach by
not re-arranging our variable setup in this way, but to instead use
the GitHub CI grouping syntax to focus on the relevant parts of "make"
or "make test" when we have failures.

Doing it this way makes for better looking GitHub CI UI, and lays much
better ground work for our CI going forward. Because:

 * The CI logic will be more portable to a future CI system, since a
   common feature of them is to run various commands in sequence, but
   a future system won't necessarily support the GitHub-specifics
   syntax of "grouping" output within a "step".

   Even if those systems don't support a "$GITHUB_ENV" emulating will
   be much easier than to deal with some CI-specific grouping syntax.

 * At the start of every step the GitHub CI presents an expandable
   list of environment variables from "$GITHUB_ENV". We'll now see
   exactly what variables affected that step (although we currently
   overshoot that a bit, and always define all variables).

 * CI failures will be easier to reproduce locally, as this makes the
   relevant ci/* scripts something that sets up our environment, but
   leaves "make" and "make test" working as they do locally.

   To reproduce a run the user only needs to set the variables
   discussed in the drop-down above, either manually or by running
   "ci/lib.sh".

 * The output will be less verbose. The "ci/lib.sh" script uses "set
   -x", and before this e.g. "ci/static-analysis.sh" would start with
   40 lines of trace output, culminating in using "export" to export
   the relevant environment variables.

   Now that verbosity is in the earlier "ci/lib.sh" step, and not in
   any subsequent one. The "make" targets then start out with the
   relevant output non-trace output right away.

 * If we do want to use the grouping syntax within a "step" it'll now
   be easier to do so. It doesn't support nesting, so we'd have to
   make a choice between using it for e.g. "make" v.s. "make test", or
   individual test failures. See "sadly" in [3].

1. https://lore.kernel.org/git/211120.86k0h30zuw.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gmail.com/
3. https://lore.kernel.org/git/9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml            | 14 ++++++--
 ci/check-unignored-build-artifacts.sh |  8 +++++
 ci/install-dependencies.sh            |  4 +++
 ci/lib.sh                             | 40 ++++++++++++++++++++++-
 ci/make-test-artifacts.sh             |  2 --
 ci/run-build-and-tests.sh             | 47 ---------------------------
 ci/run-test-slice.sh                  |  2 --
 ci/test-documentation.sh              |  1 -
 8 files changed, 62 insertions(+), 56 deletions(-)
 create mode 100755 ci/check-unignored-build-artifacts.sh
 delete mode 100755 ci/run-build-and-tests.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ad752010102..c83f6a21ca3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -268,7 +268,10 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/run-build-and-tests.sh
+    - run: ci/lib.sh
+    - run: make
+    - run: make test
+      if: success()
     - run: ci/print-test-failures.sh
       if: failure()
     - name: Upload failed tests' directories
@@ -292,6 +295,7 @@ jobs:
           image: daald/ubuntu32:xenial
         - jobname: pedantic
           image: fedora
+          skip-tests: no
     env:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ubuntu-latest
@@ -299,9 +303,12 @@ jobs:
     steps:
     - uses: actions/checkout@v1
     - run: ci/install-docker-dependencies.sh
-    - run: ci/run-build-and-tests.sh
+    - run: ci/lib.sh
+    - run: make
+    - run: make test
+      if: success() && matrix.vector.skip-tests != 'no'
     - run: ci/print-test-failures.sh
-      if: failure()
+      if: failure() && matrix.vector.skip-tests != 'no'
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v1
@@ -317,6 +324,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
+    - run: ci/lib.sh
     - run: make ci-static-analysis
   sparse:
     needs: ci-config
diff --git a/ci/check-unignored-build-artifacts.sh b/ci/check-unignored-build-artifacts.sh
new file mode 100755
index 00000000000..56d04b0db9a
--- /dev/null
+++ b/ci/check-unignored-build-artifacts.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Check whether the build created anything not in our .gitignore
+#
+
+. ${0%/*}/lib.sh
+
+check_unignored_build_artifacts
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 34b4400f38b..01006379fd0 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -22,6 +22,10 @@ ubuntu-latest)
 	P4_PATH="$HOME/custom/p4"
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	if test -n "$GITHUB_PATH"
+	then
+		echo "$PATH" >>"$GITHUB_PATH"
+	fi
 
 	P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 	LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
diff --git a/ci/lib.sh b/ci/lib.sh
index 1a1fa0e4bb2..05f3dd15e27 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 # Library of functions shared by all CI scripts
 
 # Set 'exit on error' for all CI scripts to let the caller know that
@@ -27,7 +29,14 @@ setenv () {
 	val=$2
 	shift 2
 
-	eval "export $key=\"$val\""
+	if test -n "$GITHUB_ENV"
+	then
+		echo "$key=$val" >>"$GITHUB_ENV"
+	else
+		# For local debugging. Not used by the GitHub CI
+		# itself.
+		eval "export $key=\"$val\""
+	fi
 }
 
 check_unignored_build_artifacts ()
@@ -96,6 +105,35 @@ macos-latest)
 esac
 
 case "$jobname" in
+linux-gcc)
+	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
+	;;
+linux-TEST-vars)
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
+	;;
+linux-clang)
+	setenv --test GIT_TEST_DEFAULT_HASH sha1
+	;;
+linux-sha256)
+	setenv --test GIT_TEST_DEFAULT_HASH sha256
+	;;
+pedantic)
+	# Don't run the tests; we only care about whether Git can be
+	# built.
+	setenv --build DEVOPTS pedantic
+	;;
 linux32)
 	CC=gcc
 	;;
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 646967481f6..45298562982 100755
--- a/ci/make-test-artifacts.sh
+++ b/ci/make-test-artifacts.sh
@@ -8,5 +8,3 @@ mkdir -p "$1" # in case ci/lib.sh decides to quit early
 . ${0%/*}/lib.sh
 
 make artifacts-tar ARTIFACTS_DIRECTORY="$1"
-
-check_unignored_build_artifacts
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
deleted file mode 100755
index 35d45a9373e..00000000000
--- a/ci/run-build-and-tests.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/sh
-#
-# Build and test Git
-#
-
-. ${0%/*}/lib.sh
-
-export MAKE_TARGETS="all test"
-
-case "$jobname" in
-linux-gcc)
-	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
-	;;
-linux-TEST-vars)
-	setenv --test GIT_TEST_SPLIT_INDEX yes
-	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
-	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
-	setenv --test GIT_TEST_OE_SIZE 10
-	setenv --test GIT_TEST_OE_DELTA_SIZE 5
-	setenv --test GIT_TEST_COMMIT_GRAPH 1
-	setenv --test GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
-	setenv --test GIT_TEST_MULTI_PACK_INDEX 1
-	setenv --test GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP 1
-	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 1
-	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME master
-	setenv --test GIT_TEST_WRITE_REV_INDEX 1
-	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
-	;;
-linux-clang)
-	setenv --test GIT_TEST_DEFAULT_HASH sha1
-	;;
-linux-sha256)
-	setenv --test GIT_TEST_DEFAULT_HASH sha256
-	;;
-pedantic)
-	# Don't run the tests; we only care about whether Git can be
-	# built.
-	setenv --build DEVOPTS pedantic
-	export MAKE_TARGETS=all
-	;;
-esac
-
-# Any new "test" targets should not go after this "make", but should
-# adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
-# start running tests.
-make $MAKE_TARGETS
-check_unignored_build_artifacts
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index b9a682b4bcd..70326961454 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -8,5 +8,3 @@
 make --quiet -C t T="$(cd t &&
 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
 	tr '\n' ' ')"
-
-check_unignored_build_artifacts
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 41e2b126311..6b5cce03bd7 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -39,4 +39,3 @@ test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
 
 rm -f stdout.log stderr.log stderr.raw
-check_unignored_build_artifacts
-- 
2.35.1.1517.g20a06c426a7

