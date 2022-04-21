Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13017C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391419AbiDUSjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344399AbiDUSja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3188369EA
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y21so3734407wmi.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xv/6fkJHjrd5H2YiudQbZ1QRy/W6YCJwc5Bbw5QvGmA=;
        b=dfNAjs9vJ0uAW9+TpqjhnWc6RPEWFzVRZv07+adsSyH5y3djjmmvsuY7N+1vgtfd/w
         nONE3xaOqUKMbk2ZXRBtWtYj506XJDFp2FOqCCMwjp9L4NTVX+zFHf9ZU9mGr/TrdoBF
         OWWYvHxP11VKuBmKUzd/iTJ8dpmuq4YgRM7QTNdbbv08GTumDjPRZizPb9CSAMFsDIrj
         6od0GYuI+dA4CDlAGLFk918Hyz5Z6lvYGCyaz2tXTN+8VfM4cEFfJ4bP6U7OtzQd6ADO
         fXQd7QM4ZUQiyNkgEb1gceHQHTjRSqWyZqTtXfO/a+bfBdqxQWd1iNzw8OeD9KPuCA/h
         qlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xv/6fkJHjrd5H2YiudQbZ1QRy/W6YCJwc5Bbw5QvGmA=;
        b=kUxpiGR/vBpXcNAZEh2hx+giKaHwxpCjJF77/0Kz3KPOcQVIQdnkpcL5wHarFJ5WKt
         Y+6KKJCYF+wez8Dl1Lz25P6jE2q4rkcAjo1YsI4zbSrouzguY2MJpJNNYEEb2Cv2iGam
         rn1Y5h/MT7eRDRmHIYTTEUJScJAj69wX39qiNg66nYEvQHG98h2ynLqluJkN7M7awLs1
         P6DQLttxW2fxoxeI2DbaHLn7nG+zmqQReYceOlWcwBLu84tmonEoT5XywYK3pzNpYeLC
         NZLetxrIDg7H3iMk3aGFe/y830lXnnWuzUYvMYXoWFVmls02HL7f5uahwp2U3lt0ISdk
         eExA==
X-Gm-Message-State: AOAM530gFZwWTNVtAmXnhIQuBY6Seew+Npfzn7IZEv70OM5rTfRpYgxF
        S40sYKEiryrJljRJOW24f6y5IpM/3+vutQ==
X-Google-Smtp-Source: ABdhPJwZ5HpORuepAI1Kh847rl0LiZHTkd0PYSNBeYk5huN3gLcUXx/qvwI9njSNko1i9ZYnWvsUSQ==
X-Received: by 2002:a05:600c:1c29:b0:392:926e:4255 with SMTP id j41-20020a05600c1c2900b00392926e4255mr674014wms.2.1650566198003;
        Thu, 21 Apr 2022 11:36:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:37 -0700 (PDT)
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
Subject: [RFC PATCH v5 00/10] CI: js/ci-github-workflow-markup rebased on "use $GITHUB_ENV"
Date:   Thu, 21 Apr 2022 20:36:24 +0200
Message-Id: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the "v3" for the "real" cover-letter:
https://lore.kernel.org/git/RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com/

I submitted a re-roll of the parent series at
https://lore.kernel.org/git/cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com
which required a conflict resolution for this one.

This version also has outstanding changes I had for using
ci/print-test-failures.sh with a parameter instead of the previous
copy/pasted and adjusted ci/print-test-failures-github.sh:
https://lore.kernel.org/git/RFC-patch-v4-1.6-cc137c69ee1-20220413T195514Z-avarab@gmail.com/

There's some discussion about these two serieses in general, and
Johannes intends to re-roll this:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2204211454500.355@tvgsbejvaqbjf.bet/

So whatever Junio ends up (re-)picking up (and I'll reply in some of
those threads) hopefully having this version for comparison helps.

Johannes Schindelin (6):
  ci: make it easier to find failed tests' logs in the GitHub workflow
  tests: refactor --write-junit-xml code
  test(junit): avoid line feeds in XML attributes
  ci: optionally mark up output in the GitHub workflow
  ci: use `--github-workflow-markup` in the GitHub workflow
  ci: call `finalize_test_case_output` a little later

Ævar Arnfjörð Bjarmason (4):
  CI: don't "cd" in ci/print-test-failures.sh
  CI: add --exit-code to ci/print-test-failures.sh
  CI: don't include "test-results/" in ci/print-test-failures.sh output
  CI: stop setting FAILED_TEST_ARTIFACTS N times

 .github/workflows/main.yml           |  20 +---
 ci/lib.sh                            |   2 +-
 ci/print-test-failures.sh            |  89 ++++++++++++++----
 t/test-lib-functions.sh              |   4 +-
 t/test-lib-github-workflow-markup.sh |  50 ++++++++++
 t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
 t/test-lib.sh                        | 128 ++++----------------------
 7 files changed, 282 insertions(+), 143 deletions(-)
 create mode 100644 t/test-lib-github-workflow-markup.sh
 create mode 100644 t/test-lib-junit.sh

Range-diff against v4:
 -:  ----------- >  1:  56910df26e7 CI: don't "cd" in ci/print-test-failures.sh
 -:  ----------- >  2:  caec0b1089a CI: add --exit-code to ci/print-test-failures.sh
 -:  ----------- >  3:  577a5be34f4 CI: don't include "test-results/" in ci/print-test-failures.sh output
 -:  ----------- >  4:  1482f840f64 CI: stop setting FAILED_TEST_ARTIFACTS N times
 1:  cc137c69ee1 !  5:  4291892fbd3 ci: make it easier to find failed tests' logs in the GitHub workflow
    @@ .github/workflows/main.yml: jobs:
     -      if: failure()
     -      shell: bash
     -      run: ci/print-test-failures.sh
    -+      run: . /etc/profile && make -C t -e || ci/print-test-failures-github.sh
    ++      run: . /etc/profile && make -C t -e || ci/print-test-failures.sh
          - name: Upload failed tests' directories
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v2
    @@ .github/workflows/main.yml: jobs:
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v2
     @@ .github/workflows/main.yml: jobs:
    -     - run: ci/lib.sh --build
          - run: make
          - run: ci/lib.sh --test
    +       if: success() && matrix.vector.skip-tests != 'yes'
     -    - run: make test
     +    - run: make test || ci/print-test-failures-github.sh
    -       if: success() && matrix.vector.skip-tests != 'no'
    +       if: success() && matrix.vector.skip-tests != 'yes'
     -    - run: ci/print-test-failures.sh
    --      if: failure() && matrix.vector.skip-tests != 'no'
    +-      if: failure() && matrix.vector.skip-tests != 'yes'
          - name: Upload failed tests' directories
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v1
     
    - ## ci/print-test-failures-github.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+. ${0%/*}/lib-ci-type.sh
    -+
    -+set -e
    -+
    + ## ci/print-test-failures.sh ##
    +@@ ci/print-test-failures.sh: set -e
    + . ${0%/*}/lib-ci-type.sh
    + . ${0%/*}/lib-tput.sh
    + 
    +-exit_code=
     +case "$CI_TYPE" in
     +github-actions)
    -+	handle_failed_tests () {
    -+		mkdir -p t/failed-test-artifacts
    -+		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
    -+
    -+		for test_exit in t/test-results/*.exit
    -+		do
    -+			test 0 != "$(cat "$test_exit")" || continue
    -+
    -+			test_name="${test_exit%.exit}"
    -+			test_name="${test_name##*/}"
    -+			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
    -+			cat "t/test-results/$test_name.out"
    -+
    -+			trash_dir="t/trash directory.$test_name"
    -+			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
    -+			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
    -+		done
    -+		return 1
    -+	}
    ++	exit_code=t
    ++	github_workflow_markup=t
     +	;;
     +*)
    -+	echo "Unhandled CI type: $CI_TYPE" >&2
    -+	exit 1
    ++	exit_code=
    ++	github_workflow_markup=
     +	;;
     +esac
     +
    -+handle_failed_tests
    + while test $# != 0
    + do
    + 	case "$1" in
    + 	--exit-code)
    + 		exit_code=t
    + 		;;
    ++	--no-exit-code)
    ++		exit_code=
    ++		;;
    ++	--github-workflow-markup)
    ++		github_workflow_markup=t
    ++		;;
    ++	--no-github-workflow-markup)
    ++		github_workflow_markup=
    ++		;;
    + 	*)
    + 		echo "BUG: invalid $0 argument: $1" >&2
    + 		exit 1
    +@@ ci/print-test-failures.sh: do
    + 		TEST_OUT="${TEST_NAME}.out"
    + 		TEST_MARKUP="${TEST_NAME}.markup"
    + 
    +-		echo "------------------------------------------------------------------------"
    +-		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    +-		echo "------------------------------------------------------------------------"
    ++		if test -n "$github_workflow_markup"
    ++		then
    ++			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
    ++		else
    ++			echo "------------------------------------------------------------------------"
    ++			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    ++			echo "------------------------------------------------------------------------"
    ++		fi
    + 		cat "t/test-results/${TEST_OUT}"
    + 
    + 		trash_dir="trash directory.$TEST_NAME"
 2:  91f96c4f210 =  6:  d9b7d5ddf5a tests: refactor --write-junit-xml code
 3:  84c722969d5 =  7:  2d233bbdc22 test(junit): avoid line feeds in XML attributes
 4:  8acaa800d3a =  8:  5dd43a1624b ci: optionally mark up output in the GitHub workflow
 5:  4499f743dd1 !  9:  877edff3b4d ci: use `--github-workflow-markup` in the GitHub workflow
    @@ ci/lib.sh: MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
      	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
     -	GIT_TEST_OPTS="--verbose-log -x"
     +	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    -+	MAKEFLAGS="$MAKEFLAGS --jobs=10"
      	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
      	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
     
    - ## ci/print-test-failures-github.sh ##
    -@@ ci/print-test-failures-github.sh: github-actions)
    - 			test_name="${test_exit%.exit}"
    - 			test_name="${test_name##*/}"
    - 			printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
    --			cat "t/test-results/$test_name.out"
    -+			cat "t/test-results/$test_name.markup"
    + ## ci/print-test-failures.sh ##
    +@@ ci/print-test-failures.sh: do
    + 		if test -n "$github_workflow_markup"
    + 		then
    + 			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
    ++			cat "t/test-results/$TEST_MARKUP"
    + 		else
    + 			echo "------------------------------------------------------------------------"
    + 			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    + 			echo "------------------------------------------------------------------------"
    ++			cat "t/test-results/${TEST_OUT}"
    + 		fi
    +-		cat "t/test-results/${TEST_OUT}"
      
    - 			trash_dir="t/trash directory.$test_name"
    - 			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
    + 		trash_dir="trash directory.$TEST_NAME"
    + 		case "$CI_TYPE" in
 6:  b291f64821c = 10:  6b278194f9a ci: call `finalize_test_case_output` a little later
-- 
2.36.0.879.g3659959fcca

