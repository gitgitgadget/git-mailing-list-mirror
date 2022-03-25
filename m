Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6EC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiCYTfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiCYTfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:35:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F7280C0A
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m30so12159565wrb.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVgyWnnEvM1Um3kUJrg2Z83f+uS7CwHHxyYiQx56tBw=;
        b=ZQCh+4rY10W8AtOd7Zj/cyLgt1DWXAvLT8zqgxqxJkC+1+Z2BqGnlzXmPvbEE0kES/
         GV+tU4Bc+RqBSP4YVLI9NZxESxhVi5zvm5oOZ6pf/hP1XC8MSoevdtwwNtXIpMEk9vt4
         LRS7ASARtdlytTBnRkg2vNBijnBXKbXmjVnMrOLu9GK27r6DU6IRGXze0q76/K+XqHEz
         KkdIl2tr9SX5+J1v6O8mNX4s/GsRtao28dw62eyEER3smhGNelVQ+IL0YDV8kEJL0AcI
         1QG8BkcWTL0dOCBSoaNWYH3CKg6ZfYFLCt81LghD4OqcJ5ebUSFBCazgpD1U5nEXuOIs
         /UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVgyWnnEvM1Um3kUJrg2Z83f+uS7CwHHxyYiQx56tBw=;
        b=SLHyTpLW2R6rhBOMuNR76Ho4it6cvZ12ZYuxzvgLVvEJA3W89ajBjGw0lyBkHRDDQO
         jHNb4vwzFi4s6Y6sj7aqWIycW07MJGJsJwZuysnOaP5wmMaa9hq4cDezQHZcDPmrLF2q
         /Af8jNMmZF3t7r/UbW5vx/i/wGf0KsIh/g0/UKRdD5b++rMeuLIXTA+ryZsDuuRAO1G7
         NQWZhatAvTMxxbr4Jaz0vQNAzpSux0YY3XhGp2va7JieLfS4X6yQxguwsNWSRbjk50k7
         McXitov8IplWxKbTygcV8YsqaKZt6Pz5WvWEmoicaHJ306L0kaMBCub4QzwDP+KQYFee
         D/GQ==
X-Gm-Message-State: AOAM530zKcALnbRlawDb8fKehuFLpuLu5KZd4sAz+NkiCRExOvJMquff
        h4gWkU1OsY1IRPhyJzxO8rnLzjzFT4C/RQ==
X-Google-Smtp-Source: ABdhPJzPexbMcVX/MuDhhD0Ig3x0U4aVJQkqQKaVipKPYOzcRWphiWXYWZwop5W3YPvrkCz/zGU2Cg==
X-Received: by 2002:a5d:660e:0:b0:203:eda6:e983 with SMTP id n14-20020a5d660e000000b00203eda6e983mr10471903wru.544.1648236258220;
        Fri, 25 Mar 2022 12:24:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b0038cbb21fb00sm4999704wmi.39.2022.03.25.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:24:17 -0700 (PDT)
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
Subject: [RFC PATCH v3 0/6] CI: js/ci-github-workflow-markup rebased on "use $GITHUB_ENV"
Date:   Fri, 25 Mar 2022 20:24:09 +0100
Message-Id: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a rebasing of v2 of js/ci-github-workflow-markup[1] on top of
my just-submitted v2 of my own CI changes[2] which make most of that
series's changes to ci/ unnecessary, as it'll get the split of "build"
and "test" output for free without the need for any special GitHub
workflow syntax.

That's because that series eliminates the monolithic:

    - ci/run-build-and-tests.sh

In favor of:

    - make
    - make test

So what it did with markup to delineate those two is now done
automatically by focusing on the relevant "step" within a job that
failed.

A demo of a failing run for this series (with an intentionally broken
patch on top) can be seen at
https://github.com/avar/git/actions/runs/2041259003

As it shows the GitHub workflow syntax for test failures is retained,
e.g.:
https://github.com/avar/git/runs/5695803104?check_suite_focus=true

But for build failures the GitHub workflow syntax isn't needed
anymore, e.g. this job where we focus on the failing "make":
https://github.com/avar/git/runs/5695557199?check_suite_focus=true

Note that the UI of the latter is also better because we can see in
the "skipped" portion that we didn't run the "make test", since we're
now piggy-backing on the CI flow to show that, as opposed to in
js/ci-github-workflow-markup:
https://github.com/git-for-windows/git/runs/4822802185?check_suite_focus=true

The 5/6 change here (as seen in the range diff) the gets rid of a
limitation that js/ci-github-workflow-markup commented on being
unfortunate, i.e. we can now do more with the GitHub workflow syntax
as a result of not usign it for the "top-level" of "make" and "make
test".

1. https://lore.kernel.org/git/pull.1117.v2.git.1646130289.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com

Johannes Schindelin (6):
  ci: make it easier to find failed tests' logs in the GitHub workflow
  tests: refactor --write-junit-xml code
  test(junit): avoid line feeds in XML attributes
  ci: optionally mark up output in the GitHub workflow
  ci: use `--github-workflow-markup` in the GitHub workflow
  ci: call `finalize_test_case_output` a little later

 .github/workflows/main.yml           |  20 +---
 ci/lib.sh                            |   2 +-
 ci/print-test-failures-github.sh     |  35 +++++++
 t/test-lib-functions.sh              |   4 +-
 t/test-lib-github-workflow-markup.sh |  50 ++++++++++
 t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
 t/test-lib.sh                        | 128 ++++----------------------
 7 files changed, 244 insertions(+), 127 deletions(-)
 create mode 100755 ci/print-test-failures-github.sh
 create mode 100644 t/test-lib-github-workflow-markup.sh
 create mode 100644 t/test-lib-junit.sh

Range-diff against v2:
 1:  db08b07c37a <  -:  ----------- ci: fix code style
 2:  42ff3e170bf <  -:  ----------- ci/run-build-and-tests: take a more high-level view
 3:  bbbe1623257 !  1:  d88749c60c9 ci: make it easier to find failed tests' logs in the GitHub workflow
    @@ Commit message
         nested groupings in GitHub workflows' output).
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    +       shell: bash
          - name: test
            shell: bash
    -       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
    +-      run: . /etc/profile && make -C t -e
     -    - name: ci/print-test-failures.sh
     -      if: failure()
     -      shell: bash
     -      run: ci/print-test-failures.sh
    ++      run: . /etc/profile && make -C t -e || ci/print-test-failures-github.sh
          - name: Upload failed tests' directories
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v2
     @@ .github/workflows/main.yml: jobs:
    -       env:
    -         NO_SVN_TESTS: 1
    -       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
    +       shell: bash
    +     - name: test
    +       shell: bash
    +-      run: . /etc/profile && make -C t -e
     -    - name: ci/print-test-failures.sh
     -      if: failure()
     -      shell: bash
     -      run: ci/print-test-failures.sh
    ++      run: . /etc/profile && make -C t -e || ci/print-test-failures-github.sh
          - name: Upload failed tests' directories
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v2
     @@ .github/workflows/main.yml: jobs:
    -     - uses: actions/checkout@v2
    -     - run: ci/install-dependencies.sh
    -     - run: ci/run-build-and-tests.sh
    +     - run: ci/lib.sh --build
    +     - run: make
    +     - run: ci/lib.sh --test
    +-    - run: make test
    ++    - run: make test || ci/print-test-failures-github.sh
    +       if: success()
     -    - run: ci/print-test-failures.sh
     -      if: failure()
          - name: Upload failed tests' directories
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v2
     @@ .github/workflows/main.yml: jobs:
    -     - uses: actions/checkout@v1
    -     - run: ci/install-docker-dependencies.sh
    -     - run: ci/run-build-and-tests.sh
    +     - run: ci/lib.sh --build
    +     - run: make
    +     - run: ci/lib.sh --test
    +-    - run: make test
    ++    - run: make test || ci/print-test-failures-github.sh
    +       if: success() && matrix.vector.skip-tests != 'no'
     -    - run: ci/print-test-failures.sh
    --      if: failure()
    +-      if: failure() && matrix.vector.skip-tests != 'no'
          - name: Upload failed tests' directories
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v1
     
    - ## ci/lib.sh ##
    -@@ ci/lib.sh: check_unignored_build_artifacts () {
    - 	}
    - }
    - 
    -+handle_failed_tests () {
    -+	return 1
    -+}
    + ## ci/print-test-failures-github.sh (new) ##
    +@@
    ++#!/bin/sh
     +
    - # GitHub Action doesn't set TERM, which is required by tput
    - export TERM=${TERM:-dumb}
    - 
    -@@ ci/lib.sh: then
    - 	CI_JOB_ID="$GITHUB_RUN_ID"
    - 	CC="${CC:-gcc}"
    - 	DONT_SKIP_TAGS=t
    ++. ${0%/*}/lib-ci-type.sh
    ++
    ++set -e
    ++
    ++case "$CI_TYPE" in
    ++github-actions)
     +	handle_failed_tests () {
     +		mkdir -p t/failed-test-artifacts
     +		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
    @@ ci/lib.sh: then
     +		done
     +		return 1
     +	}
    - 
    - 	cache_dir="$HOME/none"
    - 
    -
    - ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: esac
    - make
    - if test -n "$run_tests"
    - then
    --	make test
    -+	make test ||
    -+	handle_failed_tests
    - fi
    - check_unignored_build_artifacts
    - 
    -
    - ## ci/run-test-slice.sh ##
    -@@ ci/run-test-slice.sh: esac
    - 
    - make --quiet -C t T="$(cd t &&
    - 	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
    --	tr '\n' ' ')"
    -+	tr '\n' ' ')" ||
    ++	;;
    ++*)
    ++	echo "Unhandled CI type: $CI_TYPE" >&2
    ++	exit 1
    ++	;;
    ++esac
    ++
     +handle_failed_tests
    - 
    - check_unignored_build_artifacts
 4:  f72254a9ac6 <  -:  ----------- ci/run-build-and-tests: add some structure to the GitHub workflow output
 5:  9eda6574313 !  2:  ad1e1465a81 tests: refactor --write-junit-xml code
    @@ Commit message
         --color-moved-ws=allow-indentation-change <commit>`.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/test-lib-junit.sh (new) ##
     @@
 6:  c8b240af749 !  3:  fc96e5b7296 test(junit): avoid line feeds in XML attributes
    @@ Commit message
         incorrect, so let's fix it.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/test-lib-junit.sh ##
     @@ t/test-lib-junit.sh: finalize_test_case_output () {
 7:  15f199e810e !  4:  429c256ac62 ci: optionally mark up output in the GitHub workflow
    @@ Commit message
         to test cases that were expected to fail but didn't.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_verify_prereq () {
 8:  91ea54f36c5 !  5:  72058db67b0 ci: use `--github-workflow-markup` in the GitHub workflow
    @@ Metadata
      ## Commit message ##
         ci: use `--github-workflow-markup` in the GitHub workflow
     
    -    This makes the output easier to digest.
    +    [Ævar: due to re-structuring on top of my series the {begin,end}_group
    +    in CI isn't needed at all to get "group" output for the test
    +    suite. This commit includes the now-squashed "ci/run-build-and-tests:
    +    add some structure to the GitHub workflow output":]
     
    -    Note: since workflow output currently cannot contain any nested groups
    -    (see https://github.com/actions/runner/issues/802 for details), we need
    -    to remove the explicit grouping that would span the entirety of each
    -    failed test script.
    +    The current output of Git's GitHub workflow can be quite confusing,
    +    especially for contributors new to the project.
    +
    +    To make it more helpful, let's introduce some collapsible grouping.
    +    Initially, readers will see the high-level view of what actually
    +    happened (did the build fail, or the test suite?). To drill down, the
    +    respective group can be expanded.
    +
    +    Note: sadly, workflow output currently cannot contain any nested groups
    +    (see https://github.com/actions/runner/issues/802 for details),
    +    therefore we take pains to ensure to end any previous group before
    +    starting a new one.
    +
    +    [Ævar: The above comment isn't true anymore, as that limitation has
    +    been removed by basing this on my patches to run "make" and "make
    +    test" directly from the top-level of main.yml.
    +
    +    Those are now effectively their own "group", effectively giving this
    +    stage another group "level" to use. This means that the equivalent of
    +    "make test" won't be on the same level as an individual test failure.
    +
    +    We no longer take any pains to ensure balanced group output as a
    +    result (which was a caveat the previous ci/lib.sh implementation had
    +    to deal with., We just need to "cat" the generated *.markup]
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: then
    +@@ ci/lib.sh: MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
    + case "$CI_TYPE" in
    + github-actions)
    + 	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
    +-	GIT_TEST_OPTS="--verbose-log -x"
    ++	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    + 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
    + 	test Windows != "$RUNNER_OS" ||
    + 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    +
    + ## ci/print-test-failures-github.sh ##
    +@@ ci/print-test-failures-github.sh: github-actions)
      			test_name="${test_exit%.exit}"
      			test_name="${test_name##*/}"
      			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
    --			group "Failed test: $test_name" cat "t/test-results/$test_name.out"
    +-			cat "t/test-results/$test_name.out"
     +			cat "t/test-results/$test_name.markup"
      
      			trash_dir="t/trash directory.$test_name"
      			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
    -@@ ci/lib.sh: then
    - 	cache_dir="$HOME/none"
    - 
    - 	export GIT_PROVE_OPTS="--timer --jobs 10"
    --	export GIT_TEST_OPTS="--verbose-log -x"
    -+	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    - 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
    - 	test windows != "$CI_OS_NAME" ||
    - 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 9:  be2a83f5da3 !  6:  1d2b94436fc ci: call `finalize_test_case_output` a little later
    @@ Commit message
         test case.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
-- 
2.35.1.1517.g20a06c426a7

