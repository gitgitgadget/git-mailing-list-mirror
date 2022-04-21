Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7564FC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391400AbiDUS2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391351AbiDUS1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2F4B1E2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q20so3714935wmq.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPxt9c67GJ21FrfGuSr0O8Wq7lwQtm3f1W/ThUDAe/g=;
        b=PjhUa2YV7vGVntIMgnDB07Xd6KoEVaq5glpHRIR+jbl+aH+zTiAU0jPMLWvq3TQnuJ
         d4fgdf0qrQmPDmT5+6jwvSZhlOIQrJRvc6xhkGE4EpRgfUoH1DlAifb26szp3MdXymyq
         R7iyTYLnqgdCz6ySIZ55FhRDlR5/zkG2gkLXb1IzKd76cjg8LrSs7d+bh2fGD0hLOL5k
         HOPv6jWAKnHkeM/ZemwM2trcOm+U62a25OdcxawpIUQG+xoOZ1UuMoTV+bsQqvxJb2Ld
         zOsk+Sbsd6m3+klVi9+mJEBsY+ekbEG48vdnu21lHYwgC7EQ6QeW34MBOPw6IT29xPwm
         WdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPxt9c67GJ21FrfGuSr0O8Wq7lwQtm3f1W/ThUDAe/g=;
        b=LEfZEWR1DhI3YP1YxeVNr7wyZkyz56S0HhvYap16zEUF1iomXtoTRABIjOl/uiA4Lt
         rnqPN9oZRJYi9QgrMcFquSlnJUbscOLjKK43KhgEHZf/GGeiqUNMifAbnQZ/f5u7tpoY
         wLI1iau8LI+ZD5JgIIe/7kMvpZINin/q0pSt+RGx2PlK1IbrFvGPUCIU8DpIpFVS4+AS
         TuHGv4C90FsFEV2E0t1dSQ4tfjrKDtzq/ntu9UF18da5Gz34RgVIjVMT1XiTARDNWPVp
         zJ4yFGdCTzw89xkzkWa/UCFMM8Cu5QtYN9o3rz+KThwm0xLytYK1JtFTbny7dJMMIwmG
         nWlQ==
X-Gm-Message-State: AOAM530Nb3KFE14lO6objhwsr6APugjGcd+lgOMI+cNkqQEvmeuFmk4p
        3d0KSoLhN15s1zDsic1cfE8Fp3qSJKs1aQ==
X-Google-Smtp-Source: ABdhPJyZo4JaVCjHH68FM1zSC9P1VaGmQ1f6N5J/t/d0SwALJsdpOYGsxNgdSCs4rgo5L+TNAGeSOQ==
X-Received: by 2002:a05:600c:4f91:b0:38f:fba2:3ccb with SMTP id n17-20020a05600c4f9100b0038ffba23ccbmr567783wmq.125.1650565436423;
        Thu, 21 Apr 2022 11:23:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:55 -0700 (PDT)
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
Subject: [PATCH v5 22/29] CI: only invoke ci/lib.sh as "steps" in main.yml
Date:   Thu, 21 Apr 2022 20:23:17 +0200
Message-Id: <patch-v5-22.29-1b077665352-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
 ci/lib-ci-type.sh                     |  9 +++++++++
 ci/lib-tput.sh                        |  5 +++++
 ci/lib.sh                             | 27 ++++++++++-----------------
 ci/print-test-failures.sh             |  6 +++---
 ci/select-test-slice.sh               |  2 +-
 ci/test-documentation.sh              |  2 +-
 8 files changed, 33 insertions(+), 24 deletions(-)
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
index adece989491..4b4cdbe26e0 100755
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
index 00000000000..6f01fd9e5d9
--- /dev/null
+++ b/ci/lib-ci-type.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+if test "$GITHUB_ACTIONS" = "true"
+then
+	CI_TYPE=github-actions
+else
+	echo "Could not identify CI type" >&2
+	exit 1
+fi
diff --git a/ci/lib-tput.sh b/ci/lib-tput.sh
new file mode 100644
index 00000000000..b62ef13c44c
--- /dev/null
+++ b/ci/lib-tput.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+# GitHub Action doesn't set TERM, which is required by tput
+TERM=${TERM:-dumb}
+export TERM
diff --git a/ci/lib.sh b/ci/lib.sh
index cae324e2fd7..fea45a1a8d3 100755
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
@@ -47,18 +43,14 @@ setenv () {
 	fi
 }
 
-# GitHub Action doesn't set TERM, which is required by tput
-setenv TERM ${TERM:-dumb}
-
 # How many jobs to run in parallel?
 NPROC=10
 
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=--jobs=$NPROC
 
-if test "$GITHUB_ACTIONS" = "true"
-then
-	CI_TYPE=github-actions
+case "$CI_TYPE" in
+github-actions)
 	CC="${CC:-gcc}"
 
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
@@ -66,11 +58,12 @@ then
 	test Windows != "$RUNNER_OS" ||
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
index 47e2ea1ad10..29f8c332eca 100755
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
index f59d8cadda5..eccf9a48104 100755
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
2.36.0.879.g3659959fcca

