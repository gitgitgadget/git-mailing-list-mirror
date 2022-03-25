Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E5C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiCYTk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiCYTjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC309150401
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4946641wmb.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lcfd+U9TlDSYDgR80iZE/9sLC2zccQ4SmRDeuLJfgC4=;
        b=nF2ugyfUp+dQ2bc/fa91IHDQ5cFs7sDmz0XWEilWWElI41WnvC/QHc1o7JS8B0XH5u
         rwRuvOu1ZdAW4BVds4+8Fbw/gm7K6ST8BFGGRVHmJGlgQq9LLbk516579XmmYdHYBA08
         CHoddvyYY7UGJjkV50TnBfnv4jurHybZaCBqOT/E7iRZkPwECUnMMeaok7Q0TJzThWM6
         9RjaxcwMkyH6OEeCw6HOoRvYRT+r8LLcmNo1Rhg8aFyU0ttkiBvDe2W2cxUM3I6c3bxm
         r77gLUwolbVfSQRnOlzl8dKYA3LLcKPNDZJ5h7jY1DodgMTLe0RLI/siIyxSn1yW44My
         Qr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lcfd+U9TlDSYDgR80iZE/9sLC2zccQ4SmRDeuLJfgC4=;
        b=BHiOx/QPBnq3AeQfbD/MlvydSVLddBlmBTp8o8rkBDiPeJK0Z2NrHZSPq1w6Jrmkrr
         iLwIq+3SfjkR8Dh5uA812TXOj3rTu4Jb1BhtsYDukNLK7gQuchFvlNn6ho/jFa3ZCbcF
         Um+9VrfhxahVmxRRzcOfHLU0++W11gAQEmPfGawr+y43AD8lQ2kpjy2C2lUDX/UmfkA0
         rd/lHz8DmNH7RjVPiu9XFWK+yyir34q3Fi8Srqf+T90cSDCevtCciEORQCYSMsXc2SIw
         gsVmldpmYi5md2v+q29g+YQSTNz43JAiDQS/fviex4Sp8tpZAtg37WV0VIfS1wbwEIlI
         Ybiw==
X-Gm-Message-State: AOAM530KlRrxRaIOCPG3liwbgAtT8rELkeHPlFDGmOLp1hV6+yMMmtBD
        ONB4bxQpSYmKRNTHhCnY1lW4Fpu63tOzZA==
X-Google-Smtp-Source: ABdhPJw0bGJjICWQ+PCttNRdpNuH7SA4RIx8EvvaHjFGefN+A7xP/Umbv1eHvwVrDipCBbi6H823mQ==
X-Received: by 2002:a7b:cc15:0:b0:38c:8af7:f47c with SMTP id f21-20020a7bcc15000000b0038c8af7f47cmr11344335wmh.177.1648233517718;
        Fri, 25 Mar 2022 11:38:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:37 -0700 (PDT)
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
Subject: [PATCH v2 20/25] CI: only invoke ci/lib.sh as "steps" in main.yml
Date:   Fri, 25 Mar 2022 19:38:11 +0100
Message-Id: <patch-v2-20.25-ef9daa6882f-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the scripts in ci/ to stop using ci/lib.sh as a library, now
that the only thing it did for them was to "set -ex" and possibly set
TERM=dumb.

Let's create a ci/lib-tput.sh for those that need to use "tput"
instead, and have these scripts invoke "set -ex" themselves.

This makes their invocation a lot less verbose, since they'll be
relying on an earlier step in the CI job to have set the variables in
$GITHUB_ENV, and won't be spewing their own trace output to set those
variables again.

Let's also create a ci/lib-ci-type.sh, and have ci/lib.sh and
ci/print-test-failures.sh share the logic to discover the CI type. We
could have set the CI_TYPE in the environment with "setenv", but let's
avoid that verbosity for this purely internal variable.

The "ci/lib.sh" is now no longer a "Library of functions shared by all
CI scripts", so let's remove that commentary, and the misleading
comment about "set -ex" being for "installing dependencies", we're now
no longer using it in "ci/install-dependencies.sh" (but it does its
own "set -ex").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-unignored-build-artifacts.sh |  4 +++-
 ci/install-dependencies.sh            |  2 +-
 ci/lib-ci-type.sh                     |  8 ++++++++
 ci/lib-tput.sh                        |  2 ++
 ci/lib.sh                             | 27 ++++++++++-----------------
 ci/print-test-failures.sh             |  6 +++---
 ci/select-test-slice.sh               |  2 +-
 ci/test-documentation.sh              |  2 +-
 8 files changed, 29 insertions(+), 24 deletions(-)
 create mode 100644 ci/lib-ci-type.sh
 create mode 100644 ci/lib-tput.sh

diff --git a/ci/check-unignored-build-artifacts.sh b/ci/check-unignored-build-artifacts.sh
index 0bc04f32804..c27d6a97f45 100755
--- a/ci/check-unignored-build-artifacts.sh
+++ b/ci/check-unignored-build-artifacts.sh
@@ -3,7 +3,9 @@
 # Check whether the build created anything not in our .gitignore
 #
 
-. ${0%/*}/lib.sh
+set -ex
+
+. ${0%/*}/lib-tput.sh
 
 check_unignored_build_artifacts ()
 {
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 9388289d0ed..ee9af62fc92 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -3,7 +3,7 @@
 # Install dependencies required to build and test Git on Linux and macOS
 #
 
-. ${0%/*}/lib.sh
+set -ex
 
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
diff --git a/ci/lib-ci-type.sh b/ci/lib-ci-type.sh
new file mode 100644
index 00000000000..bd6e093c8f4
--- /dev/null
+++ b/ci/lib-ci-type.sh
@@ -0,0 +1,8 @@
+if test "$GITHUB_ACTIONS" = "true"
+then
+	CI_TYPE=github-actions
+else
+	echo "Could not identify CI type" >&2
+	env >&2
+	exit 1
+fi
diff --git a/ci/lib-tput.sh b/ci/lib-tput.sh
new file mode 100644
index 00000000000..baed1892f69
--- /dev/null
+++ b/ci/lib-tput.sh
@@ -0,0 +1,2 @@
+# GitHub Action doesn't set TERM, which is required by tput
+export TERM=${TERM:-dumb}
diff --git a/ci/lib.sh b/ci/lib.sh
index b882849ed5d..5eadc96de29 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,13 +1,9 @@
 #!/bin/sh
-
-# Library of functions shared by all CI scripts
-
-# Set 'exit on error' for all CI scripts to let the caller know that
-# something went wrong.
-# Set tracing executed commands, primarily setting environment variables
-# and installing dependencies.
 set -ex
 
+# Helper libraries
+. ${0%/*}/lib-ci-type.sh
+
 # Starting assertions
 if test -z "$jobname"
 then
@@ -39,15 +35,11 @@ setenv () {
 	fi
 }
 
-# GitHub Action doesn't set TERM, which is required by tput
-setenv TERM ${TERM:-dumb}
-
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=
 
-if test "$GITHUB_ACTIONS" = "true"
-then
-	CI_TYPE=github-actions
+case "$CI_TYPE" in
+github-actions)
 	CC="${CC:-gcc}"
 
 	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
@@ -57,11 +49,12 @@ then
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
-else
-	echo "Could not identify CI type" >&2
-	env >&2
+	;;
+*)
+	echo "Unhandled CI type: $CI_TYPE" >&2
 	exit 1
-fi
+	;;
+esac
 
 setenv --build DEVELOPER 1
 setenv --test DEFAULT_TEST_TARGET prove
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 0c63b6f7962..452aff35d74 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -3,10 +3,10 @@
 # Print output of failing tests
 #
 
-. ${0%/*}/lib.sh
+set -e
 
-# Tracing executed commands would produce too much noise in the loop below.
-set +x
+. ${0%/*}/lib-ci-type.sh
+. ${0%/*}/lib-tput.sh
 
 cd t/
 
diff --git a/ci/select-test-slice.sh b/ci/select-test-slice.sh
index ec602f8a053..a0332095bb3 100755
--- a/ci/select-test-slice.sh
+++ b/ci/select-test-slice.sh
@@ -3,7 +3,7 @@
 # Select a portion of the tests for testing Git in parallel
 #
 
-. ${0%/*}/lib.sh
+set -ex
 
 tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
 	t[0-9]*.sh))
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index b8a6a6f664e..64ff212cdaa 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -3,7 +3,7 @@
 # Perform sanity checks on "make doc" output and built documentation
 #
 
-. ${0%/*}/lib.sh
+set -ex
 
 generator=$1
 
-- 
2.35.1.1517.g20a06c426a7

