Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE6BC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiEYL1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiEYL1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:27:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8CC9CF79
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso913327wmh.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fg5f0SRI+7opSXD2XRvHLm5MYpmkGxWD/+c9r71wBhE=;
        b=AeqQKSNRSKkohqaYGdPivzrMCrQ0pXbEs4eP9EzWFxqaJzA5STJt02XN9KF3bcTwLN
         1k0aQJLw0nXMLaUVDeFPqfNTOqzK2mxiAmipCLctS6GGqyj/b5znqXy0sNWK04K0oww4
         k2XOB3Mo6FDmma9GLBcP7ICF9YSQbe2FPBo+nqUYUgkMLEl7qobo5vB3udumt31tJh1B
         ck8lHO0PWNk0U84rZ9fhtvB5w4Tz0rvBhIIWwi6wTnjn4HRhNydcQZoVEo1vafeDEBMz
         qo6U5hf/3snMmeBkPnv2oA2R5yTJ7gTM/AxeNsCoSgBiHInJeA2LasAQUcf2+hw9KbwS
         u09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fg5f0SRI+7opSXD2XRvHLm5MYpmkGxWD/+c9r71wBhE=;
        b=j9lXu8mHBRRgB+swPla2axPC6KCppY8+jL3QGKOiWszTvoYAQqrxGb7WpXAB7QGFh3
         wZQwezf+P5oY7NEgbRJnAVFbtRVak32sukcNdeUPd5Jl5/8Aijn1kg2nQRimrwYAcae1
         4tTg/B/dlduYoiwqqQBRSliiCJMdcCfn27UZDtXpC82pitlyjMIUwAxti+O/N3W3MMcF
         jbfbPm9H4yoSvx844DmXfXx7SrfqUdMvuS3SHecUp45cvfQhqcRlqFXovXMfuhRVHNlD
         iSWl3BOGBRWp6rNg7jgCpgbGeCmMPisQNgqGrLx6r0IOVqFEpv2NPymh+WgUKzx6+xh2
         0sGQ==
X-Gm-Message-State: AOAM531clb4kMLy8OpvV/UEq3sx3hACzxyQoUPcBG3RhOUjLUmjguBlm
        CE6VYFnD3TaVH0iSY/aMPDQo8iy66Zr0qA==
X-Google-Smtp-Source: ABdhPJyk2N9OXvJuUMDAe9FhFQ3iVVI0g3z3qPsO42yLB0KK/Dr8tM6mAHVMlAvWK+3dhsmO+Nc8pQ==
X-Received: by 2002:a05:600c:3b2a:b0:397:3e63:3db8 with SMTP id m42-20020a05600c3b2a00b003973e633db8mr7651896wms.40.1653477992909;
        Wed, 25 May 2022 04:26:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:32 -0700 (PDT)
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
Subject: [PATCH v6 13/14] CI: make --github-workflow-markup ci-config, off by default
Date:   Wed, 25 May 2022 13:26:02 +0200
Message-Id: <patch-v6-13.14-fbe0d99c6b3-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the --github-workflow-markup output was made the
default under GitHub CI.

There's a few outstanding issues with that new output target however:

A. As noted in [1] it's much slower in some common cases, i.e. the
   page rendering time (under Firefox & Chrome debugging) goes from ~20s
   to on the order of 60-80s (less pronounced when not debugging, but
   still in that ballpark). See also [2] for tests on an earlier iteration
   of the series.

B. Preceding commits in this series to omit non-failing test output
   may have mitigated that somewhat, i.e. skipping "ok" and "skip" tests
   in the *.markup files (although [1] is a benchmark with that "ok"
   change).

   Per [3] there are some CI users that prefer to see only the full
   verbose output, i.e. we can't in the general case assume that we
   can emit only the trace output for the failing test, and that's
   going to give us the information we need to debug the test. It
   might be failing because of earlier setup, or from trace output
   outside of any test (i.e. in the main body of the file).

   Users such as [3] could still just consult the *.out output, but
   then we'd make them download the archive instead of viewing the
   output in the web UX.

C. Per B above and [3] an earlier change in this series modified
   the *.out output to change the *.out output inadvertently while trying
   to modify the *.markup output. See the commit message of "ci(github):
   avoid printing test case preamble twice" earlier in this series.

It thus make sense for now to make the "ci/print-test-failures.sh"
output be the "raw" one. I.e. the *.out output we'd get before
--github-workflow-markup was implemented.

To make it use ci/print-test-failures.sh we can create a
"ci/config/print-test-failures-output-type" script on the "ci-config"
branch that does e.g.:

	#!/bin/sh
	echo github

That script will (like the existing "check-ref") get the ref as an
argument, so we can in the future turn this on experimentally for
"seen", and flip the default in the future. The script can also emit
nothing to get whatever our idea is of the default (currently "raw").

Note the corresponding change to ci/print-test-failures.sh, i.e. we'll
do the right thing vis-a-vis what we "zoom in" to depending on the
setting. If it's "raw" we'd like a failed "make test" to "zoom in" to
that step, if it's "github" we'd like the to open the subsequent
"ci/print-test-failures.sh" step instead.

1. https://lore.kernel.org/git/220523.86ee0kzjix.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220222.86tucr6kz5.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/20210309175249.GE3590451@szeder.dev/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 ci/lib.sh                  | 14 +++++++++++++-
 ci/print-test-failures.sh  |  7 +++++--
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6835e942280..4195f37c1ba 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -8,6 +8,7 @@ jobs:
     runs-on: ubuntu-latest
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
+      print-test-failures-output-type: ${{ steps.print-test-failures-output-type.outputs.type }}
     steps:
       - name: try to clone ci-config branch
         run: |
@@ -22,6 +23,21 @@ jobs:
             config-repo &&
           cd config-repo &&
           git checkout HEAD -- ci/config || : ignore
+      - id: print-test-failures-output-type
+        name: check what output type ci/print-test-failures.sh uses
+        run: |
+          type_default=raw
+          type=$type_default
+
+          if test -x config-repo/ci/config/print-test-failures-output-type
+          then
+            type=$(config-repo/ci/config/print-test-failures-output-type '${{ github.ref }}')
+            if test -z "$type"
+            then
+              type=$type_default
+            fi
+          fi
+          echo "::set-output name=type::$type"
       - id: check-ref
         name: check whether CI is enabled for ref
         run: |
@@ -124,6 +140,8 @@ jobs:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - run: ci/lib.sh --test
       shell: bash
+      env:
+        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
     - name: select tests
       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
       shell: bash
@@ -213,6 +231,8 @@ jobs:
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - run: ci/lib.sh --test
       shell: bash
+      env:
+        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
     - name: select tests
       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
       shell: bash
@@ -265,6 +285,8 @@ jobs:
     - run: ci/lib.sh --build
     - run: make
     - run: ci/lib.sh --test
+      env:
+        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
     - run: make test
       if: success()
     - run: ci/print-test-failures.sh
@@ -302,6 +324,8 @@ jobs:
     - run: make
     - run: ci/lib.sh --test
       if: success() && matrix.vector.skip-tests != 'yes'
+      env:
+        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
     - run: make test
       if: success() && matrix.vector.skip-tests != 'yes'
     - run: ci/print-test-failures.sh
diff --git a/ci/lib.sh b/ci/lib.sh
index 422399b1305..b148d3f209f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -95,6 +95,7 @@ if test -n "$GITHUB_ENV"
 then
 	echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
 fi
+echo "CONFIG: GIT_CI_PTF_OUTPUT_TYPE=$GIT_CI_PTF_OUTPUT_TYPE" >&2
 echo >&2
 
 # Helper functions
@@ -189,7 +190,18 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 case "$CI_TYPE" in
 github-actions)
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
-	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
+	GIT_TEST_OPTS="--verbose-log -x"
+	if test -n "$GIT_CI_PTF_OUTPUT_TYPE"
+	then
+		# For later use in ci/print-test-failures.sh
+		setenv --test GIT_CI_PTF_OUTPUT_TYPE "$GIT_CI_PTF_OUTPUT_TYPE"
+
+		case "$GIT_CI_PTF_OUTPUT_TYPE" in
+		github)
+			GIT_TEST_OPTS="$GIT_TEST_OPTS --github-workflow-markup"
+			;;
+		esac
+	fi
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 72fae2b0cc4..1e0738e0058 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -9,10 +9,13 @@ set -e
 . ${0%/*}/lib-tput.sh
 
 github_workflow_markup=auto
-case "$CI_TYPE" in
-github-actions)
+case "$GIT_CI_PTF_OUTPUT_TYPE" in
+github)
 	github_workflow_markup=t
 	;;
+raw)
+	github_workflow_markup=
+	;;
 esac
 
 while test $# != 0
-- 
2.36.1.1045.gf356b5617dd

