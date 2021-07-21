Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7BAC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D8561279
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGUWRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhGUWRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:17:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C4C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso175715wms.4
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yhh0QmZeoI+GieQN3CN+/4vlA+RIsUS1RxIbQzXqe3c=;
        b=O1xiOe0EFSWNpBJz5U2O3fGtyaypUC8Ufj0nTCsGpLM3hGV9V0Hef7PcGupMPFvol9
         2uPQH6vj4IfihLXAzHGG3vg10zccBY36E0xO63v91SoJMKRw4/Pk2mNQ9zrLrlTafBet
         eSaBljUXVcUEWCVCUIOw8E4hQK6tUWS3d5JOQeNC8GyUPw923kZDqaEdTQu6kr5IUX3k
         JO8OKjzoP24tuGP+46/0n9UZTh5obWQ72rwqzlWCLr+6Nn5YdQF0YKW31odWFwIlwS7C
         YWNH7pGjCTUrW3FMUoarLyBTI8+Zmdv6k7+/FzsA1tfKxYR/aUcjkqNVkPLShr3iK7mp
         Vdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yhh0QmZeoI+GieQN3CN+/4vlA+RIsUS1RxIbQzXqe3c=;
        b=OMS1Fa+mKTxbxsQRGyUK9OOrdYECebnPTiYQoAEemSSqevRqIhdT9OHIpwDPw/tVvc
         sAlQ4DQde2PbFfNbM+ArqOseU7oZvKmxB2PzPwAAPgregfARabKH8oOzIBSLVNjib1Ya
         zX+igI5v3p5Zj9sbkt+qYbpbAXOj3G3+/QlZqCr1dcpJaghJQ8g5Kp5SaeMMGG2Hhfc0
         FfD+nJyztQXaysEDrOIuDvJR5Xy+sxgLlI/cZC4x57eouna9/5B0PCLT7mxRmFJw6aGy
         B135wuJriu1bNYNnnA4t1uArfKN/qVTL+XEIhieqd39/iZZGjFW/0jinYciGXoc4E1Pw
         /XLg==
X-Gm-Message-State: AOAM530vTBmH/wFGLeJgieFNMIYN1FqK73NNGL0jHn0660UJZTSlF4AM
        8V+KUgjCtishtVSQLFipDOr3PNiOj/a3QQ==
X-Google-Smtp-Source: ABdhPJzNy+HaZduUXp8CPCcuyu9s2fX2O1OpJM24wqyl3zUmd9V4HU4PSfOP6gXUBolT52DXfziiIA==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr6070199wmp.70.1626908304312;
        Wed, 21 Jul 2021 15:58:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g18sm23129818wmk.37.2021.07.21.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 15:58:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] test-lib tests: split off subtest code in t0000 into lib-subtest.sh
Date:   Thu, 22 Jul 2021 00:57:39 +0200
Message-Id: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactors the testing of test-lib.sh itself in t0000 into a
lib-subtest.sh, fixing duplicate setup, bugs and various shell nits
along the way.

The v1[1] of this recently started conflicting with the cooking
jk/t0000-subtests-fix and ps/t0000-output-directory-fix, and got
ejected from "seen". This v2 is rebased on top of those two, so it
merges cleanly with "seen".

1. https://lore.kernel.org/git/cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  test-lib tests: move "run_sub_test" to a new lib-subtest.sh
  test-lib tests: split up "write and run" into two functions
  test-lib tests: stop using a subshell in write_sub_test_lib_test()
  test-lib tests: don't provide a description for the sub-tests
  test-lib tests: get rid of copy/pasted mock test code
  test-lib tests: avoid subshell for "test_cmp" for readability
  test-lib tests: refactor common part of check_sub_test_lib_test*()
  test-lib tests: assert 1 exit code, not non-zero

 t/lib-subtest.sh | 128 ++++++++++++++
 t/t0000-basic.sh | 448 +++++++++++++----------------------------------
 2 files changed, 246 insertions(+), 330 deletions(-)
 create mode 100644 t/lib-subtest.sh

Range-diff against v1:
1:  3c0a78530d2 ! 1:  7a06ea3a7b7 test-lib tests: move "run_sub_test" to a new lib-subtest.sh
    @@ t/lib-subtest.sh (new)
     +_run_sub_test_lib_test_common () {
     +	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
     +	shift 3
    ++
    ++	# intercept pseudo-options at the front of the argument list that we
    ++	# will not pass to child script
    ++	skip=
    ++	while test $# -gt 0
    ++	do
    ++		case "$1" in
    ++		--skip=*)
    ++			skip=${1#--*=}
    ++			shift
    ++			;;
    ++		*)
    ++			break
    ++			;;
    ++		esac
    ++	done
    ++
     +	mkdir "$name" &&
     +	(
     +		# Pretend we're not running under a test harness, whether we
    @@ t/lib-subtest.sh (new)
     +		EOF
     +		cat >>"$name.sh" &&
     +		export TEST_DIRECTORY &&
    -+		TEST_OUTPUT_DIRECTORY=$(pwd) &&
    -+		export TEST_OUTPUT_DIRECTORY &&
    ++		# The child test re-sources GIT-BUILD-OPTIONS and may thus
    ++		# override the test output directory. We thus pass it as an
    ++		# explicit override to the child.
    ++		TEST_OUTPUT_DIRECTORY_OVERRIDE=$(pwd) &&
    ++		export TEST_OUTPUT_DIRECTORY_OVERRIDE &&
    ++		GIT_SKIP_TESTS=$skip &&
    ++		export GIT_SKIP_TESTS &&
     +		sane_unset GIT_TEST_FAIL_PREREQS &&
     +		if test -z "$neg"
     +		then
    @@ t/t0000-basic.sh: test_expect_success 'success is reported like this' '
     -_run_sub_test_lib_test_common () {
     -	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
     -	shift 3
    +-
    +-	# intercept pseudo-options at the front of the argument list that we
    +-	# will not pass to child script
    +-	skip=
    +-	while test $# -gt 0
    +-	do
    +-		case "$1" in
    +-		--skip=*)
    +-			skip=${1#--*=}
    +-			shift
    +-			;;
    +-		*)
    +-			break
    +-			;;
    +-		esac
    +-	done
    +-
     -	mkdir "$name" &&
     -	(
     -		# Pretend we're not running under a test harness, whether we
    @@ t/t0000-basic.sh: test_expect_success 'success is reported like this' '
     -		EOF
     -		cat >>"$name.sh" &&
     -		export TEST_DIRECTORY &&
    --		TEST_OUTPUT_DIRECTORY=$(pwd) &&
    --		export TEST_OUTPUT_DIRECTORY &&
    +-		# The child test re-sources GIT-BUILD-OPTIONS and may thus
    +-		# override the test output directory. We thus pass it as an
    +-		# explicit override to the child.
    +-		TEST_OUTPUT_DIRECTORY_OVERRIDE=$(pwd) &&
    +-		export TEST_OUTPUT_DIRECTORY_OVERRIDE &&
    +-		GIT_SKIP_TESTS=$skip &&
    +-		export GIT_SKIP_TESTS &&
     -		sane_unset GIT_TEST_FAIL_PREREQS &&
     -		if test -z "$neg"
     -		then
2:  9e2715d2e20 ! 2:  28117b84abf test-lib tests: split up "write and run" into two functions
    @@ Commit message
     
      ## t/lib-subtest.sh ##
     @@
    --_run_sub_test_lib_test_common () {
    --	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
    --	shift 3
     +write_sub_test_lib_test () {
     +	name="$1" descr="$2" # stdin is the body of the test code
    - 	mkdir "$name" &&
    - 	(
    --		# Pretend we're not running under a test harness, whether we
    --		# are or not. The test-lib output depends on the setting of
    --		# this variable, so we need a stable setting under which to run
    --		# the sub-test.
    --		sane_unset HARNESS_ACTIVE &&
    - 		cd "$name" &&
    - 		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
    - 		test_description='$descr (run in sub test-lib)
    -@@ t/lib-subtest.sh: _run_sub_test_lib_test_common () {
    - 		# Point to the t/test-lib.sh, which isn't in ../ as usual
    - 		. "\$TEST_DIRECTORY"/test-lib.sh
    - 		EOF
    --		cat >>"$name.sh" &&
    ++	mkdir "$name" &&
    ++	(
    ++		cd "$name" &&
    ++		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
    ++		test_description='$descr (run in sub test-lib)
    ++
    ++		This is run in a sub test-lib so that we do not get incorrect
    ++		passing metrics
    ++		'
    ++
    ++		# Point to the t/test-lib.sh, which isn't in ../ as usual
    ++		. "\$TEST_DIRECTORY"/test-lib.sh
    ++		EOF
     +		cat >>"$name.sh"
     +	)
     +}
     +
    -+_run_sub_test_lib_test_common () {
    -+	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
    -+	shift 3
    -+	(
    + _run_sub_test_lib_test_common () {
    + 	neg="$1" name="$2" descr="$3" # stdin is the body of the test code
    + 	shift 3
    +@@ t/lib-subtest.sh: _run_sub_test_lib_test_common () {
    + 		esac
    + 	done
    + 
    +-	mkdir "$name" &&
    + 	(
     +		cd "$name" &&
     +
    -+		# Pretend we're not running under a test harness, whether we
    -+		# are or not. The test-lib output depends on the setting of
    -+		# this variable, so we need a stable setting under which to run
    -+		# the sub-test.
    -+		sane_unset HARNESS_ACTIVE &&
    -+
    + 		# Pretend we're not running under a test harness, whether we
    + 		# are or not. The test-lib output depends on the setting of
    + 		# this variable, so we need a stable setting under which to run
    + 		# the sub-test.
    + 		sane_unset HARNESS_ACTIVE &&
    +-		cd "$name" &&
    +-		write_script "$name.sh" "$TEST_SHELL_PATH" <<-EOF &&
    +-		test_description='$descr (run in sub test-lib)
    + 
    +-		This is run in a sub test-lib so that we do not get incorrect
    +-		passing metrics
    +-		'
    +-
    +-		# Point to the t/test-lib.sh, which isn't in ../ as usual
    +-		. "\$TEST_DIRECTORY"/test-lib.sh
    +-		EOF
    +-		cat >>"$name.sh" &&
      		export TEST_DIRECTORY &&
    - 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
    - 		export TEST_OUTPUT_DIRECTORY &&
    + 		# The child test re-sources GIT-BUILD-OPTIONS and may thus
    + 		# override the test output directory. We thus pass it as an
     @@ t/lib-subtest.sh: _run_sub_test_lib_test_common () {
      	)
      }
    @@ t/lib-subtest.sh: _run_sub_test_lib_test_common () {
      run_sub_test_lib_test () {
      	_run_sub_test_lib_test_common '' "$@"
      }
    +@@ t/lib-subtest.sh: check_sub_test_lib_test_err () {
    + 		test_cmp expect.err err
    + 	)
    + }
    ++
     
      ## t/t0000-basic.sh ##
     @@ t/t0000-basic.sh: test_expect_success 'success is reported like this' '
    @@ t/t0000-basic.sh: test_expect_success 'test --verbose' '
      		--verbose-only=2 <<-\EOF &&
      	test_expect_success "passing test" true
     @@ t/t0000-basic.sh: test_expect_success 'test --verbose-only' '
    + 
      test_expect_success 'GIT_SKIP_TESTS' '
      	(
    - 		GIT_SKIP_TESTS="git.2" && export GIT_SKIP_TESTS &&
     -		run_sub_test_lib_test git-skip-tests-basic \
     +		write_and_run_sub_test_lib_test git-skip-tests-basic \
    - 			"GIT_SKIP_TESTS" <<-\EOF &&
    + 			"GIT_SKIP_TESTS" \
    + 			--skip="git.2" <<-\EOF &&
      		for i in 1 2 3
    - 		do
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS' '
    + 
      test_expect_success 'GIT_SKIP_TESTS several tests' '
      	(
    - 		GIT_SKIP_TESTS="git.2 git.5" && export GIT_SKIP_TESTS &&
     -		run_sub_test_lib_test git-skip-tests-several \
     +		write_and_run_sub_test_lib_test git-skip-tests-several \
    - 			"GIT_SKIP_TESTS several tests" <<-\EOF &&
    + 			"GIT_SKIP_TESTS several tests" \
    + 			--skip="git.2 git.5" <<-\EOF &&
      		for i in 1 2 3 4 5 6
    - 		do
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS several tests' '
    + 
      test_expect_success 'GIT_SKIP_TESTS sh pattern' '
      	(
    - 		GIT_SKIP_TESTS="git.[2-5]" && export GIT_SKIP_TESTS &&
     -		run_sub_test_lib_test git-skip-tests-sh-pattern \
     +		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
    - 			"GIT_SKIP_TESTS sh pattern" <<-\EOF &&
    + 			"GIT_SKIP_TESTS sh pattern" \
    + 			--skip="git.[2-5]" <<-\EOF &&
      		for i in 1 2 3 4 5 6
    - 		do
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS sh pattern' '
    + 
      test_expect_success 'GIT_SKIP_TESTS entire suite' '
      	(
    - 		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
     -		run_sub_test_lib_test git-skip-tests-entire-suite \
     +		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
    - 			"GIT_SKIP_TESTS entire suite" <<-\EOF &&
    + 			"GIT_SKIP_TESTS entire suite" \
    + 			--skip="git" <<-\EOF &&
      		for i in 1 2 3
    - 		do
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS entire suite' '
    + 
      test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
      	(
    - 		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
     -		run_sub_test_lib_test git-skip-tests-unmatched-suite \
     +		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
    - 			"GIT_SKIP_TESTS does not skip unmatched suite" <<-\EOF &&
    + 			"GIT_SKIP_TESTS does not skip unmatched suite" \
    + 			--skip="notgit" <<-\EOF &&
      		for i in 1 2 3
    - 		do
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
      '
      
3:  cd6c740c912 = 3:  7d5ed335a36 test-lib tests: stop using a subshell in write_sub_test_lib_test()
4:  0578470d899 ! 4:  2a0dd64da90 test-lib tests: don't provide a description for the sub-tests
    @@ t/lib-subtest.sh: write_sub_test_lib_test () {
     -	shift 3
     +	neg="$1" name="$2" # stdin is the body of the test code
     +	shift 2
    - 	(
    - 		cd "$name" &&
      
    + 	# intercept pseudo-options at the front of the argument list that we
    + 	# will not pass to child script
     
      ## t/t0000-basic.sh ##
     @@ t/t0000-basic.sh: test_expect_success 'success is reported like this' '
    @@ t/t0000-basic.sh: test_expect_success 'test --verbose-only' '
     -test_expect_success 'GIT_SKIP_TESTS' '
     +test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
      	(
    - 		GIT_SKIP_TESTS="git.2" && export GIT_SKIP_TESTS &&
      		write_and_run_sub_test_lib_test git-skip-tests-basic \
    --			"GIT_SKIP_TESTS" <<-\EOF &&
    -+			<<-\EOF &&
    +-			"GIT_SKIP_TESTS" \
    + 			--skip="git.2" <<-\EOF &&
      		for i in 1 2 3
      		do
    - 			test_expect_success "passing test #$i" "true"
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS' '
      	)
      '
    @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS' '
     -test_expect_success 'GIT_SKIP_TESTS several tests' '
     +test_expect_success 'subtest: skip several with GIT_SKIP_TESTS' '
      	(
    - 		GIT_SKIP_TESTS="git.2 git.5" && export GIT_SKIP_TESTS &&
      		write_and_run_sub_test_lib_test git-skip-tests-several \
    --			"GIT_SKIP_TESTS several tests" <<-\EOF &&
    -+			<<-\EOF &&
    +-			"GIT_SKIP_TESTS several tests" \
    + 			--skip="git.2 git.5" <<-\EOF &&
      		for i in 1 2 3 4 5 6
      		do
    - 			test_expect_success "passing test #$i" "true"
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS several tests' '
      	)
      '
    @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS several tests' '
     -test_expect_success 'GIT_SKIP_TESTS sh pattern' '
     +test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
      	(
    - 		GIT_SKIP_TESTS="git.[2-5]" && export GIT_SKIP_TESTS &&
      		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
    --			"GIT_SKIP_TESTS sh pattern" <<-\EOF &&
    -+			<<-\EOF &&
    +-			"GIT_SKIP_TESTS sh pattern" \
    + 			--skip="git.[2-5]" <<-\EOF &&
      		for i in 1 2 3 4 5 6
      		do
    - 			test_expect_success "passing test #$i" "true"
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS sh pattern' '
      	)
      '
    @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS sh pattern' '
     -test_expect_success 'GIT_SKIP_TESTS entire suite' '
     +test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
      	(
    - 		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
      		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
    --			"GIT_SKIP_TESTS entire suite" <<-\EOF &&
    -+			<<-\EOF &&
    +-			"GIT_SKIP_TESTS entire suite" \
    + 			--skip="git" <<-\EOF &&
      		for i in 1 2 3
      		do
    - 			test_expect_success "passing test #$i" "true"
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS entire suite' '
      	)
      '
    @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS entire suite' '
     -test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
     +test_expect_success 'subtest: GIT_SKIP_TESTS does not skip unmatched suite' '
      	(
    - 		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
      		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
    --			"GIT_SKIP_TESTS does not skip unmatched suite" <<-\EOF &&
    -+			<<-\EOF &&
    +-			"GIT_SKIP_TESTS does not skip unmatched suite" \
    + 			--skip="notgit" <<-\EOF &&
      		for i in 1 2 3
      		do
    - 			test_expect_success "passing test #$i" "true"
     @@ t/t0000-basic.sh: test_expect_success 'GIT_SKIP_TESTS does not skip unmatched suite' '
      	)
      '
5:  1909616d9ca ! 5:  f60190dec6a test-lib tests: get rid of copy/pasted mock test code
    @@ t/t0000-basic.sh: test_expect_success 'subtest: --verbose-only option' '
      
      test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
      	(
    --		GIT_SKIP_TESTS="git.2" && export GIT_SKIP_TESTS &&
     -		write_and_run_sub_test_lib_test git-skip-tests-basic \
    --			<<-\EOF &&
    +-			--skip="git.2" <<-\EOF &&
     -		for i in 1 2 3
     -		do
     -			test_expect_success "passing test #$i" "true"
    @@ t/t0000-basic.sh: test_expect_success 'subtest: --verbose-only option' '
     -		test_done
     -		EOF
     -		check_sub_test_lib_test git-skip-tests-basic <<-\EOF
    -+		GIT_SKIP_TESTS="full.2" && export GIT_SKIP_TESTS &&
    -+		run_sub_test_lib_test full-pass &&
    ++		run_sub_test_lib_test full-pass \
    ++			--skip="full.2" &&
     +		check_sub_test_lib_test full-pass <<-\EOF
      		> ok 1 - passing test #1
      		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
      		> ok 3 - passing test #3
     @@ t/t0000-basic.sh: test_expect_success 'subtest: skip several with GIT_SKIP_TESTS' '
    + 
      test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
      	(
    - 		GIT_SKIP_TESTS="git.[2-5]" && export GIT_SKIP_TESTS &&
     -		write_and_run_sub_test_lib_test git-skip-tests-sh-pattern \
    --			<<-\EOF &&
    +-			--skip="git.[2-5]" <<-\EOF &&
     -		for i in 1 2 3 4 5 6
     -		do
     -			test_expect_success "passing test #$i" "true"
    @@ t/t0000-basic.sh: test_expect_success 'subtest: skip several with GIT_SKIP_TESTS
     -		test_done
     -		EOF
     -		check_sub_test_lib_test git-skip-tests-sh-pattern <<-\EOF
    -+		run_sub_test_lib_test git-skip-tests-several &&
    ++		run_sub_test_lib_test git-skip-tests-several \
    ++			--skip="git.[2-5]" &&
     +		check_sub_test_lib_test git-skip-tests-several <<-\EOF
      		> ok 1 - passing test #1
      		> ok 2 # skip passing test #2 (GIT_SKIP_TESTS)
      		> ok 3 # skip passing test #3 (GIT_SKIP_TESTS)
     @@ t/t0000-basic.sh: test_expect_success 'subtest: sh pattern skipping with GIT_SKIP_TESTS' '
    + 
      test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
      	(
    - 		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
     -		write_and_run_sub_test_lib_test git-skip-tests-entire-suite \
    --			<<-\EOF &&
    +-			--skip="git" <<-\EOF &&
     -		for i in 1 2 3
     -		do
     -			test_expect_success "passing test #$i" "true"
    @@ t/t0000-basic.sh: test_expect_success 'subtest: sh pattern skipping with GIT_SKI
     -		test_done
     -		EOF
     -		check_sub_test_lib_test git-skip-tests-entire-suite <<-\EOF
    -+		run_sub_test_lib_test git-skip-tests-several &&
    ++		GIT_SKIP_TESTS="git" && export GIT_SKIP_TESTS &&
    ++		run_sub_test_lib_test git-skip-tests-several \
    ++			--skip="git" &&
     +		check_sub_test_lib_test git-skip-tests-several <<-\EOF
      		> 1..0 # SKIP skip all tests in git
      		EOF
      	)
     @@ t/t0000-basic.sh: test_expect_success 'subtest: skip entire test suite with GIT_SKIP_TESTS' '
    + 
      test_expect_success 'subtest: GIT_SKIP_TESTS does not skip unmatched suite' '
      	(
    - 		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
     -		write_and_run_sub_test_lib_test git-skip-tests-unmatched-suite \
    --			<<-\EOF &&
    +-			--skip="notgit" <<-\EOF &&
     -		for i in 1 2 3
     -		do
     -			test_expect_success "passing test #$i" "true"
    @@ t/t0000-basic.sh: test_expect_success 'subtest: skip entire test suite with GIT_
     -		test_done
     -		EOF
     -		check_sub_test_lib_test git-skip-tests-unmatched-suite <<-\EOF
    -+		run_sub_test_lib_test full-pass &&
    ++		GIT_SKIP_TESTS="notgit" && export GIT_SKIP_TESTS &&
    ++		run_sub_test_lib_test full-pass \
    ++			--skip="notfull" &&
     +		check_sub_test_lib_test full-pass <<-\EOF
      		> ok 1 - passing test #1
      		> ok 2 - passing test #2
6:  2f717e437e6 ! 6:  022ddbabf63 test-lib tests: avoid subshell for "test_cmp" for readability
    @@ t/lib-subtest.sh: run_sub_test_lib_test_err () {
     +	sed -e 's/^> //' -e 's/Z$//' <&3 >"$name"/expect.err &&
     +	test_cmp "$name"/expect.err "$name"/err
      }
    + 
7:  1f32eb60411 = 7:  ae0226e164c test-lib tests: refactor common part of check_sub_test_lib_test*()
8:  ddbc8db2802 ! 8:  676547e001e test-lib tests: assert 1 exit code, not non-zero
    @@ t/lib-subtest.sh: write_sub_test_lib_test () {
     -	shift 2
     +	cmp_op="$1" want_code="$2" name="$3" # stdin is the body of the test code
     +	shift 3
    - 	(
    - 		cd "$name" &&
      
    + 	# intercept pseudo-options at the front of the argument list that we
    + 	# will not pass to child script
     @@ t/lib-subtest.sh: _run_sub_test_lib_test_common () {
    - 		TEST_OUTPUT_DIRECTORY=$(pwd) &&
    - 		export TEST_OUTPUT_DIRECTORY &&
    + 		GIT_SKIP_TESTS=$skip &&
    + 		export GIT_SKIP_TESTS &&
      		sane_unset GIT_TEST_FAIL_PREREQS &&
     -		if test -z "$neg"
     -		then
-- 
2.32.0.955.ge7c5360f7e7

