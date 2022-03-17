Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E19C433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiCQKOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCQKOo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77675972B4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r7so2816663wmq.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jro1Gj7jpw8nW/c/eYViVxakfQ6lduzdyQ4Pm4eTT9M=;
        b=Wmh8jRyCrRUyaQtlPWBdRy1sCBCiTfu6cm2cd9ynxj4r1ai7efCVpZPJhQbI/PvYAE
         jJ/Zp01F7DS8w2ppPlYoumP7i51lanoK06Zm45ObOREhI4pn4VajMRyx2qb9hBGctvgl
         aeE7ysOxatxE1p5xhCGzlNvBaQ7Fsb4IADkIJqzWCUFMS7svpftRyMTZkAW51HhkvY//
         Sz3URGkemuA43T3rIL1LXoFdqOoq5bvF9K7Hf7qXS2ZO2aKN+DNo0Nef8zltYfus3+m4
         0oe0NGjxYN/o2VoBerx7PHSB0MZdlVuXk3sy4xuqglfiOOX1QE22H0JsvBvTxRD4mD3b
         kiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jro1Gj7jpw8nW/c/eYViVxakfQ6lduzdyQ4Pm4eTT9M=;
        b=yCfqmwAy2yWtgWGRappMlZvLVPbVXOkBP5eE0RbKgMMjdH5D3gwakQWaczOZ7F0KiV
         HbgDdHwiyHXkfhsy6l4tJ6JM1rVfnpx6mEb1zcnyxuebIKXyChoTj/2b6wagRkMcBXdZ
         XUY14J6qA47kUQo1FJAvPJhJT5kbWLjQgesPaxdcq3X5k/cvxUYGXAKWkirJS7AzWxYo
         NW1VVxn/IQ+68nqBLrP72srmnz/Zv7fYQzUD27m8lXnlRQuZDuTJiYoG1POFML4U23yj
         LT5mdH8CNhP3VDh3Mv+oyk0RmiStgozeCn3eA19V3/vWObtTQmhvRpJXFWTslQ9+AyUL
         Mz/A==
X-Gm-Message-State: AOAM532fr0GgySCcDUpdSW7BhqMby97z3k3n3JWcKsS7iTJj/wDRr3VI
        c6UOoi6Nsok25Cz+hXgSUdnEiTINGAo=
X-Google-Smtp-Source: ABdhPJw1eCeEl0Dk7enkUrldjl6gu0l58yugeIVmGfSySaNhFmm5JqDNTFb7aLMJV2P0CQ1wT3+S+Q==
X-Received: by 2002:a05:600c:3203:b0:381:b544:7970 with SMTP id r3-20020a05600c320300b00381b5447970mr3150531wmp.144.1647512003065;
        Thu, 17 Mar 2022 03:13:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/13] tests: add and use a "test_hook" wrapper + hook fixes
Date:   Thu, 17 Mar 2022 11:13:05 +0100
Message-Id: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a test-only improvement series split up and adapted
from a previous series of mine to add a "git init --no-template":
https://lore.kernel.org/git/cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com/;
For v1 and v2 see:
https://lore.kernel.org/git/cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com/
and
https://lore.kernel.org/git/cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com/

Changes since v2:

 * A large rewrite to hopefully make Junio happy. I.e. I rewrote &
   rebased the churn of changing certain tests in several
   commit. Before it was first indentation changes, then getting rid
   of sub-shells etc.

   Now the first commit introduces the test_hook wrapper, and all
   subsequent commits use it directly.

 * I added new commits to convert the test of the test suite, e.g. the
   proc-receive tests.

   Before (v2):  32 files changed, 325 insertions(+), 347 deletions(-)
   After  (v3): 67 files changed, 572 insertions(+), 600 deletions(-)

Ævar Arnfjörð Bjarmason (13):
  test-lib-functions: add and use a "test_hook" wrapper
  hook tests: turn exit code assertions into a loop
  http tests: don't rely on "hook/post-update.sample"
  tests: assume the hooks are disabled by default
  bugreport tests: tighten up "git bugreport -s hooks" test
  fetch+push tests: use "test_hook" and "test_when_finished" pattern
  gc + p4 tests: use "test_hook", remove sub-shells
  tests: change "cat && chmod +x" to use "test_hook"
  tests: change "mkdir -p && write_script" to use "test_hook"
  tests: use "test_hook" for misc "mkdir -p" and "chmod" cases
  tests: extend "test_hook" for "rm" and "chmod -x", convert "$HOOK"
  proc-receive hook tests: use "test_hook" instead of "write_script"
  http tests: use "test_hook" for "smart" and "dumb" http tests

 t/t0029-core-unsetenvvars.sh                  |   3 +-
 t/t0091-bugreport.sh                          |  26 ++-
 t/t1350-config-hooks-path.sh                  |   4 +-
 t/t1416-ref-transaction-hooks.sh              |  27 ++-
 t/t1800-hook.sh                               |  45 ++--
 t/t2400-worktree-add.sh                       |   5 +-
 t/t3404-rebase-interactive.sh                 |  10 +-
 t/t3412-rebase-root.sh                        |  18 +-
 t/t3413-rebase-hook.sh                        |  18 +-
 t/t3430-rebase-merges.sh                      |   6 +-
 t/t4150-am.sh                                 |  24 +--
 t/t5401-update-hooks.sh                       |  64 +++---
 t/t5402-post-merge-hook.sh                    |  16 +-
 t/t5403-post-checkout-hook.sh                 |   3 +-
 t/t5406-remote-rejects.sh                     |   2 +-
 t/t5407-post-rewrite-hook.sh                  |  14 +-
 t/t5409-colorize-remote-messages.sh           |   2 +-
 t/t5411-proc-receive-hook.sh                  |   4 +-
 t/t5411/once-0010-report-status-v1.sh         |   2 +-
 t/t5411/test-0002-pre-receive-declined.sh     |   4 +-
 ...st-0003-pre-receive-declined--porcelain.sh |   2 +-
 t/t5411/test-0013-bad-protocol.sh             |  20 +-
 t/t5411/test-0014-bad-protocol--porcelain.sh  |  18 +-
 t/t5411/test-0020-report-ng.sh                |   4 +-
 t/t5411/test-0021-report-ng--porcelain.sh     |   4 +-
 t/t5411/test-0022-report-unexpect-ref.sh      |   2 +-
 ...est-0023-report-unexpect-ref--porcelain.sh |   2 +-
 t/t5411/test-0024-report-unknown-ref.sh       |   2 +-
 ...test-0025-report-unknown-ref--porcelain.sh |   2 +-
 t/t5411/test-0026-push-options.sh             |   6 +-
 t/t5411/test-0027-push-options--porcelain.sh  |   6 +-
 t/t5411/test-0030-report-ok.sh                |   2 +-
 t/t5411/test-0031-report-ok--porcelain.sh     |   2 +-
 t/t5411/test-0032-report-with-options.sh      |  14 +-
 ...est-0033-report-with-options--porcelain.sh |  14 +-
 t/t5411/test-0034-report-ft.sh                |   2 +-
 t/t5411/test-0035-report-ft--porcelain.sh     |   2 +-
 ...t-0036-report-multi-rewrite-for-one-ref.sh |   6 +-
 ...rt-multi-rewrite-for-one-ref--porcelain.sh |   6 +-
 t/t5411/test-0038-report-mixed-refs.sh        |   2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |   2 +-
 t/t5411/test-0040-process-all-refs.sh         |   2 +-
 .../test-0041-process-all-refs--porcelain.sh  |   2 +-
 ...t-0050-proc-receive-refs-with-modifiers.sh |   4 +-
 t/t5503-tagfollow.sh                          |   4 +-
 t/t5510-fetch.sh                              |   8 +-
 t/t5516-fetch-push.sh                         | 192 ++++++++----------
 t/t5521-pull-options.sh                       |   4 +-
 t/t5534-push-signed.sh                        |  26 +--
 t/t5540-http-push-webdav.sh                   |   4 +-
 t/t5541-http-push-smart.sh                    |  32 ++-
 t/t5543-atomic-push.sh                        |   5 +-
 t/t5547-push-quarantine.sh                    |   4 +-
 t/t5548-push-porcelain.sh                     |   2 +-
 t/t5550-http-fetch-dumb.sh                    |  25 +--
 t/t5571-pre-push-hook.sh                      |  38 ++--
 t/t5601-clone.sh                              |   4 +-
 t/t6500-gc.sh                                 |  22 +-
 t/t7113-post-index-change-hook.sh             |   7 +-
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 150 +++++++-------
 t/t7504-commit-msg-hook.sh                    |  43 ++--
 t/t7505-prepare-commit-msg-hook.sh            |  43 ++--
 t/t7519-status-fsmonitor.sh                   |  20 +-
 t/t7520-ignored-hook-warning.sh               |  11 +-
 t/t9001-send-email.sh                         |   4 +-
 t/t9800-git-p4-basic.sh                       |  23 ++-
 t/test-lib-functions.sh                       |  76 +++++++
 67 files changed, 572 insertions(+), 600 deletions(-)

Range-diff against v2:
 8:  1fce2d8855a !  1:  7761d777e9c test-lib-functions: add and use a "test_hook" wrapper
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t0091-bugreport.sh ##
    -@@ t/t0091-bugreport.sh: test_expect_success 'can create leading directories outside of a git dir' '
    - test_expect_success 'indicates populated hooks' '
    - 	test_when_finished rm git-bugreport-hooks.txt &&
    - 
    --	write_script .git/hooks/applypatch-msg <<-\EOF &&
    -+	test_hook applypatch-msg <<-\EOF &&
    - 	true
    - 	EOF
    --	write_script .git/hooks/unknown-hook <<-\EOF &&
    -+	test_hook unknown-hook <<-\EOF &&
    - 	true
    - 	EOF
    - 	git bugreport -s hooks &&
    -
      ## t/t1416-ref-transaction-hooks.sh ##
     @@ t/t1416-ref-transaction-hooks.sh: test_expect_success setup '
      '
    @@ t/t1800-hook.sh: test_expect_success 'git hook run: basic' '
      	echo >&1 Will end up on stderr
      	echo >&2 Will end up on stderr
      	EOF
    -@@ t/t1800-hook.sh: test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
    - for code in 1 2 128 129
    - do
    - 	test_expect_success "git hook run: exit code $code is passed along" '
    --		write_script .git/hooks/test-hook <<-EOF &&
    -+		test_hook test-hook <<-EOF &&
    - 		exit $code
    - 		EOF
    - 
     @@ t/t1800-hook.sh: test_expect_success 'git hook run arg u ments without -- is not allowed' '
      '
      
    @@ t/t1800-hook.sh: test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
      	# t1350-config-hooks-path.sh
      	>actual &&
     
    + ## t/t5401-update-hooks.sh ##
    +@@ t/t5401-update-hooks.sh: test_expect_success 'send-pack stderr contains hook messages' '
    + '
    + 
    + test_expect_success 'pre-receive hook that forgets to read its input' '
    +-	write_script victim.git/hooks/pre-receive <<-\EOF &&
    ++	test_hook --clobber -C victim.git pre-receive <<-\EOF &&
    + 	exit 0
    + 	EOF
    + 	rm -f victim.git/hooks/update victim.git/hooks/post-update &&
    +
      ## t/t5406-remote-rejects.sh ##
     @@ t/t5406-remote-rejects.sh: test_description='remote push rejects are reported by client'
      . ./test-lib.sh
    @@ t/t5411-proc-receive-hook.sh: setup_upstream_and_workbench () {
      		echo "# post-receive hook"
      		while read old new ref
     
    + ## t/t5503-tagfollow.sh ##
    +@@ t/t5503-tagfollow.sh: test_expect_success 'atomic fetch with failing backfill' '
    + 	# one of both fails to update correctly.
    + 	#
    + 	# To trigger failure we simply abort when backfilling a tag.
    +-	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
    ++	test_hook -C clone3 reference-transaction <<-\EOF &&
    + 		while read oldrev newrev reference
    + 		do
    + 			if test "$reference" = refs/tags/tag1
    +@@ t/t5503-tagfollow.sh: test_expect_success 'atomic fetch with backfill should use single transaction' '
    + 		$ZERO_OID $T refs/tags/tag1
    + 	EOF
    + 
    +-	write_script clone4/.git/hooks/reference-transaction <<-\EOF &&
    ++	test_hook -C clone4 reference-transaction <<-\EOF &&
    + 		( echo "$*" && cat ) >>actual
    + 	EOF
    + 
    +
      ## t/t5510-fetch.sh ##
     @@ t/t5510-fetch.sh: test_expect_success 'fetch --atomic executes a single reference transaction only
      	EOF
    @@ t/t5510-fetch.sh: test_expect_success 'fetch --atomic --append appends to FETCH_
      		exit 1
      	EOF
      
    -
    - ## t/t5516-fetch-push.sh ##
    -@@ t/t5516-fetch-push.sh: test_expect_success 'updateInstead with push-to-checkout hook' '
    - 	git -C testrepo reset --hard HEAD^^ &&
    - 	git -C testrepo tag initial &&
    - 	git -C testrepo config receive.denyCurrentBranch updateInstead &&
    --	write_script testrepo/.git/hooks/push-to-checkout <<-\EOF &&
    -+	test_hook -C testrepo push-to-checkout <<-\EOF &&
    - 	echo >&2 updating from $(git rev-parse HEAD)
    - 	echo >&2 updating to "$1"
    - 
    -@@ t/t5516-fetch-push.sh: test_expect_success 'updateInstead with push-to-checkout hook' '
    - 	test_when_finished "rm -rf void" &&
    - 	git init void &&
    - 	git -C void config receive.denyCurrentBranch updateInstead &&
    --	write_script void/.git/hooks/push-to-checkout <<-\EOF &&
    -+	test_hook -C void push-to-checkout <<-\EOF &&
    - 	if git rev-parse --quiet --verify HEAD
    - 	then
    - 		has_head=yes
    +@@ t/t5510-fetch.sh: test_expect_success 'fetch --atomic --prune executes a single reference transact
    + 		$ZERO_OID $head_oid refs/remotes/origin/new-branch
    + 	EOF
    + 
    +-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
    ++	test_hook -C atomic reference-transaction <<-\EOF &&
    + 		( echo "$*" && cat ) >>actual
    + 	EOF
    + 
     
      ## t/t5521-pull-options.sh ##
     @@ t/t5521-pull-options.sh: test_expect_success 'git pull --no-verify flag passed to merge' '
    @@ t/t5521-pull-options.sh: test_expect_success 'git pull --no-verify --verify pass
      	EOF
      	test_commit -C src two &&
     
    - ## t/t5540-http-push-webdav.sh ##
    -@@ t/t5540-http-push-webdav.sh: test_expect_success 'setup remote repository' '
    - 	git clone --bare test_repo test_repo.git &&
    - 	cd test_repo.git &&
    - 	git --bare update-server-info &&
    --	write_script hooks/post-update <<-\EOF &&
    -+	test_hook --setup post-update <<-\EOF &&
    - 	exec git update-server-info
    - 	EOF
    - 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
    -
      ## t/t5547-push-quarantine.sh ##
     @@ t/t5547-push-quarantine.sh: test_description='check quarantine of objects during push'
      
    @@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
      		EOF
      	'
     
    - ## t/t6500-gc.sh ##
    -@@ t/t6500-gc.sh: test_expect_success 'pre-auto-gc hook can stop auto gc' '
    - 	EOF
    - 
    - 	git init pre-auto-gc-hook &&
    --	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
    -+	test_hook -C pre-auto-gc-hook pre-auto-gc <<-\EOF &&
    - 	echo >&2 no gc for you &&
    - 	exit 1
    - 	EOF
    -@@ t/t6500-gc.sh: test_expect_success 'pre-auto-gc hook can stop auto gc' '
    - 	See "git help gc" for manual housekeeping.
    - 	EOF
    - 
    --	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
    -+	test_hook -C pre-auto-gc-hook --clobber pre-auto-gc <<-\EOF &&
    - 	echo >&2 will gc for you &&
    - 	exit 0
    - 	EOF
    -
      ## t/t7519-status-fsmonitor.sh ##
     @@ t/t7519-status-fsmonitor.sh: dirty_repo () {
      }
 1:  706460d10b9 !  2:  aa4ee4da289 hook tests: turn exit code assertions into a loop
    @@ t/t1800-hook.sh: test_expect_success 'git hook run: stdout and stderr both write
     +for code in 1 2 128 129
     +do
     +	test_expect_success "git hook run: exit code $code is passed along" '
    -+		write_script .git/hooks/test-hook <<-EOF &&
    ++		test_hook test-hook <<-EOF &&
     +		exit $code
     +		EOF
     +
 2:  4bee939a894 !  3:  8451c31911d t5540: don't rely on "hook/post-update.sample"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    t5540: don't rely on "hook/post-update.sample"
    +    http tests: don't rely on "hook/post-update.sample"
     
         Change code added in a87679339c0 (test: rename http fetch and push
         test files, 2014-02-06) to stop relying on the "exec git
    @@ t/t5540-http-push-webdav.sh: test_expect_success 'setup remote repository' '
      	cd test_repo.git &&
      	git --bare update-server-info &&
     -	mv hooks/post-update.sample hooks/post-update &&
    -+	write_script hooks/post-update <<-\EOF &&
    ++	test_hook --setup post-update <<-\EOF &&
     +	exec git update-server-info
     +	EOF
      	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 3:  fc1a9d4d55b !  4:  3a3289afd80 tests: assume the hooks are disabled by default
    @@ t/t7519-status-fsmonitor.sh: test_expect_success UNTRACKED_CACHE 'ignore .git ch
      		cd dot-git &&
     -		mkdir -p .git/hooks &&
      		: >tracked &&
    + 		test-tool chmtime =-60 tracked &&
      		: >modified &&
    - 		mkdir dir1 &&
 4:  8dd7b40e510 !  5:  c21e3e43a55 bugreport tests: tighten up "git bugreport -s hooks" test
    @@ t/t0091-bugreport.sh: test_expect_success 'can create leading directories outsid
     -		EOF
     -	done &&
     +
    -+	write_script .git/hooks/applypatch-msg <<-\EOF &&
    ++	test_hook applypatch-msg <<-\EOF &&
     +	true
     +	EOF
    -+	write_script .git/hooks/unknown-hook <<-\EOF &&
    ++	test_hook unknown-hook <<-\EOF &&
     +	true
     +	EOF
      	git bugreport -s hooks &&
 7:  0ac75ed062f !  6:  0cf152dfca7 fetch+push tests: have tests clean up their own mess
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fetch+push tests: have tests clean up their own mess
    +    fetch+push tests: use "test_hook" and "test_when_finished" pattern
     
    -    Change the "t5516-fetch-push.sh" test code to make use of
    -    "test_when_finished" to remove data instead of having tests clean up
    -    leftover data from earlier tests, which may or may not be
    -    there (e.g. depending on the --run=* option).
    +    Change the "t5516-fetch-push.sh" test code to make use of the new
    +    "test_hook" helper, and to use "test_when_finished" to have tests
    +    clean up their own state, instead of relying on subsequent tests to
    +    clean the trash directory.
     
         Before this each test would have been responsible for cleaning up
         after a preceding test (which may or may not have run, e.g. if --run
         or "GIT_SKIP_TESTS" was used), now each test will instead clean up
         after itself.
     
    -    When doing this split up the "push with negotiation" test, now the
    +    In order to use both "test_hook" and "test_when_finished" we need to
    +    move them out of sub-shells, which requires some refactoring.
    +
    +    While we're at it split up the "push with negotiation" test, now the
         middle of the test doesn't need to "rm event", and since it delimited
         two halves that were testing two different things the end-state is
         easier to read and reason about.
    @@ t/t5516-fetch-push.sh: D=$(pwd)
      mk_empty () {
      	repo_name="$1"
     -	rm -fr "$repo_name" &&
    +-	mkdir "$repo_name" &&
    +-	(
    +-		cd "$repo_name" &&
    +-		git init &&
    +-		git config receive.denyCurrentBranch warn
    +-	)
     +	test_when_finished "rm -rf \"$repo_name\"" &&
     +	test_path_is_missing "$repo_name" &&
    - 	git init "$repo_name" &&
    - 	git -C "$repo_name" config receive.denyCurrentBranch warn
    ++	git init "$repo_name" &&
    ++	git -C "$repo_name" config receive.denyCurrentBranch warn
      }
    -@@ t/t5516-fetch-push.sh: mk_test_with_hooks() {
    + 
    + mk_test () {
    +@@ t/t5516-fetch-push.sh: mk_test () {
    + mk_test_with_hooks() {
    + 	repo_name=$1
    + 	mk_test "$@" &&
    +-	(
    +-		cd "$repo_name" &&
    +-		mkdir .git/hooks &&
    +-		cd .git/hooks &&
    +-
    +-		cat >pre-receive <<-'EOF' &&
    +-		#!/bin/sh
    +-		cat - >>pre-receive.actual
    +-		EOF
    +-
    +-		cat >update <<-'EOF' &&
    +-		#!/bin/sh
    +-		printf "%s %s %s\n" "$@" >>update.actual
    +-		EOF
    +-
    +-		cat >post-receive <<-'EOF' &&
    +-		#!/bin/sh
    +-		cat - >>post-receive.actual
    +-		EOF
    +-
    +-		cat >post-update <<-'EOF' &&
    +-		#!/bin/sh
    +-		for ref in "$@"
    +-		do
    +-			printf "%s\n" "$ref" >>post-update.actual
    +-		done
    +-		EOF
    +-
    +-		chmod +x pre-receive update post-receive post-update
    +-	)
    ++	test_hook -C "$repo_name" pre-receive <<-'EOF' &&
    ++	cat - >>pre-receive.actual
    ++	EOF
    ++
    ++	test_hook -C "$repo_name" update <<-'EOF' &&
    ++	printf "%s %s %s\n" "$@" >>update.actual
    ++	EOF
    ++
    ++	test_hook -C "$repo_name" post-receive <<-'EOF' &&
    ++	cat - >>post-receive.actual
    ++	EOF
    ++
    ++	test_hook -C "$repo_name" post-update <<-'EOF'
    ++	for ref in "$@"
    ++	do
    ++		printf "%s\n" "$ref" >>post-update.actual
    ++	done
    ++	EOF
      }
      
      mk_child() {
    @@ t/t5516-fetch-push.sh: grep_wrote () {
      	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
      		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
      	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
    +@@ t/t5516-fetch-push.sh: test_expect_success 'push does not update local refs on failure' '
    + 
    + 	mk_test testrepo heads/main &&
    + 	mk_child testrepo child &&
    +-	mkdir testrepo/.git/hooks &&
    + 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
    + 	chmod +x testrepo/.git/hooks/pre-receive &&
    + 	(
     @@ t/t5516-fetch-push.sh: done
      
      test_expect_success 'fetch follows tags by default' '
    @@ t/t5516-fetch-push.sh: test_expect_success 'receive.denyCurrentBranch = updateIn
     -	rm -fr testrepo &&
     +	test_when_finished "rm -rf testrepo" &&
      	git init testrepo &&
    - 	git -C testrepo pull .. main &&
    - 	git -C testrepo reset --hard HEAD^^ &&
    +-	(
    +-		cd testrepo &&
    +-		git pull .. main &&
    +-		git reset --hard HEAD^^ &&
    +-		git tag initial &&
    +-		git config receive.denyCurrentBranch updateInstead &&
    +-		write_script .git/hooks/push-to-checkout <<-\EOF
    +-		echo >&2 updating from $(git rev-parse HEAD)
    +-		echo >&2 updating to "$1"
    +-
    +-		git update-index -q --refresh &&
    +-		git read-tree -u -m HEAD "$1" || {
    +-			status=$?
    +-			echo >&2 read-tree failed
    +-			exit $status
    +-		}
    +-		EOF
    +-	) &&
    ++	git -C testrepo pull .. main &&
    ++	git -C testrepo reset --hard HEAD^^ &&
    ++	git -C testrepo tag initial &&
    ++	git -C testrepo config receive.denyCurrentBranch updateInstead &&
    ++	test_hook -C testrepo push-to-checkout <<-\EOF &&
    ++	echo >&2 updating from $(git rev-parse HEAD)
    ++	echo >&2 updating to "$1"
    ++
    ++	git update-index -q --refresh &&
    ++	git read-tree -u -m HEAD "$1" || {
    ++		status=$?
    ++		echo >&2 read-tree failed
    ++		exit $status
    ++	}
    ++	EOF
    + 
    + 	# Try pushing into a pristine
    + 	git push testrepo main &&
     @@ t/t5516-fetch-push.sh: test_expect_success 'updateInstead with push-to-checkout hook' '
      	) &&
      
    @@ t/t5516-fetch-push.sh: test_expect_success 'updateInstead with push-to-checkout
     -	rm -fr void &&
     +	test_when_finished "rm -rf void" &&
      	git init void &&
    - 	git -C void config receive.denyCurrentBranch updateInstead &&
    - 	write_script void/.git/hooks/push-to-checkout <<-\EOF &&
    +-	(
    +-		cd void &&
    +-		git config receive.denyCurrentBranch updateInstead &&
    +-		write_script .git/hooks/push-to-checkout <<-\EOF
    +-		if git rev-parse --quiet --verify HEAD
    +-		then
    +-			has_head=yes
    +-			echo >&2 updating from $(git rev-parse HEAD)
    +-		else
    +-			has_head=no
    +-			echo >&2 pushing into void
    +-		fi
    +-		echo >&2 updating to "$1"
    +-
    +-		git update-index -q --refresh &&
    +-		case "$has_head" in
    +-		yes)
    +-			git read-tree -u -m HEAD "$1" ;;
    +-		no)
    +-			git read-tree -u -m "$1" ;;
    +-		esac || {
    +-			status=$?
    +-			echo >&2 read-tree failed
    +-			exit $status
    +-		}
    +-		EOF
    +-	) &&
    ++	git -C void config receive.denyCurrentBranch updateInstead &&
    ++	test_hook -C void push-to-checkout <<-\EOF &&
    ++	if git rev-parse --quiet --verify HEAD
    ++	then
    ++		has_head=yes
    ++		echo >&2 updating from $(git rev-parse HEAD)
    ++	else
    ++		has_head=no
    ++		echo >&2 pushing into void
    ++	fi
    ++	echo >&2 updating to "$1"
    ++
    ++	git update-index -q --refresh &&
    ++	case "$has_head" in
    ++	yes)
    ++		git read-tree -u -m HEAD "$1" ;;
    ++	no)
    ++		git read-tree -u -m "$1" ;;
    ++	esac || {
    ++		status=$?
    ++		echo >&2 read-tree failed
    ++		exit $status
    ++	}
    ++	EOF
    + 
    + 	git push void main &&
    + 	(
 6:  08bd1629d65 !  7:  bb57b298598 hook tests: get rid of unnecessary sub-shells
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    hook tests: get rid of unnecessary sub-shells
    +    gc + p4 tests: use "test_hook", remove sub-shells
     
         Refactor the repository setup code for tests that test hooks the use
    -    of sub-shells when setting up the test repository and hooks.
    -
    -    A subsequent commit will change the hook setup to use a helper that
    -    makes use of "test_when_finished", which cannot be used in
    -    sub-shells. Let's change that setup code, and the adjacent and similar
    -    "mk_empty" code.
    +    of sub-shells when setting up the test repository and hooks, and use
    +    the "test_hook" wrapper instead of "write_scripts".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t5516-fetch-push.sh ##
    -@@ t/t5516-fetch-push.sh: D=$(pwd)
    - mk_empty () {
    - 	repo_name="$1"
    - 	rm -fr "$repo_name" &&
    --	mkdir "$repo_name" &&
    --	(
    --		cd "$repo_name" &&
    --		git init &&
    --		git config receive.denyCurrentBranch warn
    --	)
    -+	git init "$repo_name" &&
    -+	git -C "$repo_name" config receive.denyCurrentBranch warn
    - }
    - 
    - mk_test () {
    -@@ t/t5516-fetch-push.sh: mk_test () {
    - mk_test_with_hooks() {
    - 	repo_name=$1
    - 	mk_test "$@" &&
    --	(
    --		cd "$repo_name" &&
    --		mkdir .git/hooks &&
    --		cd .git/hooks &&
    --
    --		cat >pre-receive <<-'EOF' &&
    --		#!/bin/sh
    --		cat - >>pre-receive.actual
    --		EOF
    - 
    --		cat >update <<-'EOF' &&
    --		#!/bin/sh
    --		printf "%s %s %s\n" "$@" >>update.actual
    --		EOF
    --
    --		cat >post-receive <<-'EOF' &&
    --		#!/bin/sh
    --		cat - >>post-receive.actual
    --		EOF
    --
    --		cat >post-update <<-'EOF' &&
    --		#!/bin/sh
    --		for ref in "$@"
    --		do
    --			printf "%s\n" "$ref" >>post-update.actual
    --		done
    --		EOF
    --
    --		chmod +x pre-receive update post-receive post-update
    --	)
    -+	cat >"$repo_name"/.git/hooks/pre-receive <<-'EOF' &&
    -+	#!/bin/sh
    -+	cat - >>pre-receive.actual
    -+	EOF
    -+
    -+	cat >"$repo_name"/.git/hooks/update <<-'EOF' &&
    -+	#!/bin/sh
    -+	printf "%s %s %s\n" "$@" >>update.actual
    -+	EOF
    -+
    -+	cat >"$repo_name"/.git/hooks/post-receive <<-'EOF' &&
    -+	#!/bin/sh
    -+	cat - >>post-receive.actual
    -+	EOF
    -+
    -+	cat >"$repo_name"/.git/hooks/post-update <<-'EOF' &&
    -+	#!/bin/sh
    -+	for ref in "$@"
    -+	do
    -+		printf "%s\n" "$ref" >>post-update.actual
    -+	done
    -+	EOF
    -+
    -+	chmod +x \
    -+	      "$repo_name"/.git/hooks/pre-receive \
    -+	      "$repo_name"/.git/hooks/update \
    -+	      "$repo_name"/.git/hooks/post-receive \
    -+	      "$repo_name"/.git/hooks/post-update
    - }
    - 
    - mk_child() {
    -@@ t/t5516-fetch-push.sh: test_expect_success 'push does not update local refs on failure' '
    - 
    - 	mk_test testrepo heads/main &&
    - 	mk_child testrepo child &&
    --	mkdir testrepo/.git/hooks &&
    - 	echo "#!/no/frobnication/today" >testrepo/.git/hooks/pre-receive &&
    - 	chmod +x testrepo/.git/hooks/pre-receive &&
    - 	(
    -@@ t/t5516-fetch-push.sh: test_expect_success 'receive.denyCurrentBranch = updateInstead' '
    - test_expect_success 'updateInstead with push-to-checkout hook' '
    - 	rm -fr testrepo &&
    - 	git init testrepo &&
    --	(
    --		cd testrepo &&
    --		git pull .. main &&
    --		git reset --hard HEAD^^ &&
    --		git tag initial &&
    --		git config receive.denyCurrentBranch updateInstead &&
    --		write_script .git/hooks/push-to-checkout <<-\EOF
    --		echo >&2 updating from $(git rev-parse HEAD)
    --		echo >&2 updating to "$1"
    --
    --		git update-index -q --refresh &&
    --		git read-tree -u -m HEAD "$1" || {
    --			status=$?
    --			echo >&2 read-tree failed
    --			exit $status
    --		}
    --		EOF
    --	) &&
    -+	git -C testrepo pull .. main &&
    -+	git -C testrepo reset --hard HEAD^^ &&
    -+	git -C testrepo tag initial &&
    -+	git -C testrepo config receive.denyCurrentBranch updateInstead &&
    -+	write_script testrepo/.git/hooks/push-to-checkout <<-\EOF &&
    -+	echo >&2 updating from $(git rev-parse HEAD)
    -+	echo >&2 updating to "$1"
    -+
    -+	git update-index -q --refresh &&
    -+	git read-tree -u -m HEAD "$1" || {
    -+		status=$?
    -+		echo >&2 read-tree failed
    -+		exit $status
    -+	}
    -+	EOF
    - 
    - 	# Try pushing into a pristine
    - 	git push testrepo main &&
    -@@ t/t5516-fetch-push.sh: test_expect_success 'updateInstead with push-to-checkout hook' '
    - 	# push into void
    - 	rm -fr void &&
    - 	git init void &&
    --	(
    --		cd void &&
    --		git config receive.denyCurrentBranch updateInstead &&
    --		write_script .git/hooks/push-to-checkout <<-\EOF
    --		if git rev-parse --quiet --verify HEAD
    --		then
    --			has_head=yes
    --			echo >&2 updating from $(git rev-parse HEAD)
    --		else
    --			has_head=no
    --			echo >&2 pushing into void
    --		fi
    --		echo >&2 updating to "$1"
    --
    --		git update-index -q --refresh &&
    --		case "$has_head" in
    --		yes)
    --			git read-tree -u -m HEAD "$1" ;;
    --		no)
    --			git read-tree -u -m "$1" ;;
    --		esac || {
    --			status=$?
    --			echo >&2 read-tree failed
    --			exit $status
    --		}
    --		EOF
    --	) &&
    -+	git -C void config receive.denyCurrentBranch updateInstead &&
    -+	write_script void/.git/hooks/push-to-checkout <<-\EOF &&
    -+	if git rev-parse --quiet --verify HEAD
    -+	then
    -+		has_head=yes
    -+		echo >&2 updating from $(git rev-parse HEAD)
    -+	else
    -+		has_head=no
    -+		echo >&2 pushing into void
    -+	fi
    -+	echo >&2 updating to "$1"
    -+
    -+	git update-index -q --refresh &&
    -+	case "$has_head" in
    -+	yes)
    -+		git read-tree -u -m HEAD "$1" ;;
    -+	no)
    -+		git read-tree -u -m "$1" ;;
    -+	esac || {
    -+		status=$?
    -+		echo >&2 read-tree failed
    -+		exit $status
    -+	}
    -+	EOF
    - 
    - 	git push void main &&
    - 	(
    -
      ## t/t6500-gc.sh ##
     @@ t/t6500-gc.sh: test_expect_success 'pre-auto-gc hook can stop auto gc' '
      	EOF
      
      	git init pre-auto-gc-hook &&
    -+	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
    ++	test_hook -C pre-auto-gc-hook pre-auto-gc <<-\EOF &&
     +	echo >&2 no gc for you &&
     +	exit 1
     +	EOF
    @@ t/t6500-gc.sh: test_expect_success 'pre-auto-gc hook can stop auto gc' '
      	See "git help gc" for manual housekeeping.
      	EOF
      
    -+	write_script "pre-auto-gc-hook/.git/hooks/pre-auto-gc" <<-\EOF &&
    -+	echo >&2 will gc for you &&
    -+	exit 0
    -+	EOF
    -+
    - 	(
    - 		cd pre-auto-gc-hook &&
    +-	(
    +-		cd pre-auto-gc-hook &&
     -		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
     -		echo >&2 will gc for you &&
     -		exit 0
     -		EOF
    +-		git gc --auto >../out.actual 2>../err.actual
    +-	) &&
    ++	test_hook -C pre-auto-gc-hook --clobber pre-auto-gc <<-\EOF &&
    ++	echo >&2 will gc for you &&
    ++	exit 0
    ++	EOF
     +
    - 		git gc --auto >../out.actual 2>../err.actual
    - 	) &&
    ++	git -C pre-auto-gc-hook gc --auto >out.actual 2>err.actual &&
      
    + 	test_must_be_empty out.actual &&
    + 	test_cmp err.expect err.actual
     
      ## t/t9800-git-p4-basic.sh ##
     @@ t/t9800-git-p4-basic.sh: test_expect_success 'run hook p4-pre-submit before submit' '
    @@ t/t9800-git-p4-basic.sh: test_expect_success 'run hook p4-pre-submit before subm
     -		EOF
     +		grep "Would apply" out
     +	) &&
    -+	mkdir -p "$git"/.git/hooks &&
    -+	write_script "$git"/.git/hooks/p4-pre-submit <<-\EOF &&
    ++	test_hook -C "$git" p4-pre-submit <<-\EOF &&
     +	exit 0
     +	EOF
     +	(
    @@ t/t9800-git-p4-basic.sh: test_expect_success 'run hook p4-pre-submit before subm
     -		EOF
     +		grep "Would apply" out
     +	) &&
    -+	write_script "$git"/.git/hooks/p4-pre-submit <<-\EOF &&
    ++	test_hook -C "$git" --clobber p4-pre-submit <<-\EOF &&
     +	exit 1
     +	EOF
     +	(
10:  db27fa32bbd !  8:  bb25560d432 tests: change "cat && chmod +x" to use "test_hook"
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t3412-rebase-root.sh ##
    -@@ t/t3412-rebase-root.sh: test_expect_success 'rebase --root fails with too many args' '
    - '
    - 
    - test_expect_success 'setup pre-rebase hook' '
    --	mkdir -p .git/hooks &&
    --	cat >.git/hooks/pre-rebase <<-EOF &&
    --	#!$SHELL_PATH
    --	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
    -+	test_hook --setup pre-rebase <<-\EOF
    -+	echo "$1,$2" >.git/PRE-REBASE-INPUT
    - 	EOF
    --	chmod +x .git/hooks/pre-rebase
    - '
    - cat > expect <<EOF
    - 4
    -@@ t/t3412-rebase-root.sh: commit work7~5
    - EOF
    - 
    - test_expect_success 'setup pre-rebase hook that fails' '
    --	mkdir -p .git/hooks &&
    --	cat >.git/hooks/pre-rebase <<-EOF &&
    --	#!$SHELL_PATH
    -+	test_hook --setup --clobber pre-rebase <<-\EOF
    - 	false
    - 	EOF
    --	chmod +x .git/hooks/pre-rebase
    - '
    - 
    - test_expect_success 'pre-rebase hook stops rebase' '
    -
    - ## t/t3413-rebase-hook.sh ##
    -@@ t/t3413-rebase-hook.sh: test_expect_success 'rebase -i' '
    - '
    - 
    - test_expect_success 'setup pre-rebase hook' '
    --	mkdir -p .git/hooks &&
    --	cat >.git/hooks/pre-rebase <<-EOF &&
    --	#!$SHELL_PATH
    --	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
    -+	test_hook --setup pre-rebase <<-\EOF
    -+	echo "$1,$2" >.git/PRE-REBASE-INPUT
    - 	EOF
    --	chmod +x .git/hooks/pre-rebase
    - '
    - 
    - test_expect_success 'pre-rebase hook gets correct input (1)' '
    -@@ t/t3413-rebase-hook.sh: test_expect_success 'pre-rebase hook gets correct input (6)' '
    - '
    - 
    - test_expect_success 'setup pre-rebase hook that fails' '
    --	mkdir -p .git/hooks &&
    --	cat >.git/hooks/pre-rebase <<-EOF &&
    --	#!$SHELL_PATH
    -+	test_hook --setup --clobber pre-rebase <<-\EOF
    - 	false
    - 	EOF
    --	chmod +x .git/hooks/pre-rebase
    - '
    - 
    - test_expect_success 'pre-rebase hook stops rebase (1)' '
    -
    - ## t/t5401-update-hooks.sh ##
    -@@ t/t5401-update-hooks.sh: test_expect_success setup '
    - 	git update-ref refs/heads/main $commit1 &&
    - 	git update-ref refs/heads/tofail $commit0 &&
    - 
    --	cat >victim.git/hooks/pre-receive <<-\EOF &&
    --	#!/bin/sh
    -+	test_hook --setup -C victim.git pre-receive <<-\EOF &&
    - 	printf %s "$@" >>$GIT_DIR/pre-receive.args
    - 	cat - >$GIT_DIR/pre-receive.stdin
    - 	echo STDOUT pre-receive
    - 	echo STDERR pre-receive >&2
    - 	EOF
    --	chmod u+x victim.git/hooks/pre-receive &&
    - 
    --	cat >victim.git/hooks/update <<-\EOF &&
    --	#!/bin/sh
    -+	test_hook --setup -C victim.git update <<-\EOF &&
    - 	echo "$@" >>$GIT_DIR/update.args
    - 	read x; printf %s "$x" >$GIT_DIR/update.stdin
    - 	echo STDOUT update $1
    - 	echo STDERR update $1 >&2
    - 	test "$1" = refs/heads/main || exit
    - 	EOF
    --	chmod u+x victim.git/hooks/update &&
    - 
    --	cat >victim.git/hooks/post-receive <<-\EOF &&
    --	#!/bin/sh
    -+	test_hook --setup -C victim.git post-receive <<-\EOF &&
    - 	printf %s "$@" >>$GIT_DIR/post-receive.args
    - 	cat - >$GIT_DIR/post-receive.stdin
    - 	echo STDOUT post-receive
    - 	echo STDERR post-receive >&2
    - 	EOF
    --	chmod u+x victim.git/hooks/post-receive &&
    - 
    --	cat >victim.git/hooks/post-update <<-\EOF &&
    --	#!/bin/sh
    -+	test_hook --setup -C victim.git post-update <<-\EOF
    - 	echo "$@" >>$GIT_DIR/post-update.args
    - 	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
    - 	echo STDOUT post-update
    - 	echo STDERR post-update >&2
    - 	EOF
    --	chmod u+x victim.git/hooks/post-update
    - '
    - 
    - test_expect_success push '
    -
      ## t/t5402-post-merge-hook.sh ##
     @@ t/t5402-post-merge-hook.sh: test_expect_success setup '
      	GIT_DIR=clone2/.git git update-index --add a
    @@ t/t5402-post-merge-hook.sh: test_expect_success setup '
      test_expect_success 'post-merge does not run for up-to-date ' '
      	GIT_DIR=clone1/.git git merge $commit0 &&
     
    - ## t/t5407-post-rewrite-hook.sh ##
    -@@ t/t5407-post-rewrite-hook.sh: test_expect_success 'setup' '
    - 	test_commit F foo F &&
    - 	git checkout main &&
    - 
    --	cat >.git/hooks/post-rewrite <<-EOF &&
    --	#!/bin/sh
    -+	test_hook --setup post-rewrite <<-EOF
    - 	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
    - 	cat > "$TRASH_DIRECTORY"/post-rewrite.data
    - 	EOF
    --	chmod u+x .git/hooks/post-rewrite
    - '
    - 
    - clear_hook_input () {
    -
    - ## t/t5516-fetch-push.sh ##
    -@@ t/t5516-fetch-push.sh: mk_test () {
    - mk_test_with_hooks() {
    - 	repo_name=$1
    - 	mk_test "$@" &&
    --
    --	cat >"$repo_name"/.git/hooks/pre-receive <<-'EOF' &&
    --	#!/bin/sh
    -+	test_hook -C "$repo_name" pre-receive <<-'EOF' &&
    - 	cat - >>pre-receive.actual
    - 	EOF
    - 
    --	cat >"$repo_name"/.git/hooks/update <<-'EOF' &&
    --	#!/bin/sh
    -+	test_hook -C "$repo_name" update <<-'EOF' &&
    - 	printf "%s %s %s\n" "$@" >>update.actual
    - 	EOF
    - 
    --	cat >"$repo_name"/.git/hooks/post-receive <<-'EOF' &&
    --	#!/bin/sh
    -+	test_hook -C "$repo_name" post-receive <<-'EOF' &&
    - 	cat - >>post-receive.actual
    - 	EOF
    - 
    --	cat >"$repo_name"/.git/hooks/post-update <<-'EOF' &&
    --	#!/bin/sh
    -+	test_hook -C "$repo_name" post-update <<-'EOF'
    - 	for ref in "$@"
    - 	do
    - 		printf "%s\n" "$ref" >>post-update.actual
    - 	done
    - 	EOF
    --
    --	chmod +x \
    --	      "$repo_name"/.git/hooks/pre-receive \
    --	      "$repo_name"/.git/hooks/update \
    --	      "$repo_name"/.git/hooks/post-receive \
    --	      "$repo_name"/.git/hooks/post-update
    - }
    - 
    - mk_child() {
    -
    - ## t/t5541-http-push-smart.sh ##
    -@@ t/t5541-http-push-smart.sh: test_expect_success 'create and delete remote branch' '
    - '
    - 
    - test_expect_success 'setup rejected update hook' '
    --	cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-EOF &&
    --	#!/bin/sh
    -+	test_hook --setup -C "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" update <<-\EOF &&
    - 	exit 1
    - 	EOF
    --	chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" &&
    - 
    - 	cat >exp <<-EOF
    - 	remote: error: hook declined to update refs/heads/dev2
    -
      ## t/t5601-clone.sh ##
     @@ t/t5601-clone.sh: test_expect_success 'clone from hooks' '
      	cd .. &&
 9:  121ca23db37 !  9:  f908e27da82 tests: change "mkdir -p && write_script" to use "test_hook"
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ 'cmdline in-reply-to used wit
      	# test that we have the correct environment variable, pwd, and
      	# argument
      	case "$GIT_DIR" in
    -
    - ## t/t9800-git-p4-basic.sh ##
    -@@ t/t9800-git-p4-basic.sh: test_expect_success 'run hook p4-pre-submit before submit' '
    - 		git p4 submit --dry-run >out &&
    - 		grep "Would apply" out
    - 	) &&
    --	mkdir -p "$git"/.git/hooks &&
    --	write_script "$git"/.git/hooks/p4-pre-submit <<-\EOF &&
    -+	test_hook -C "$git" p4-pre-submit <<-\EOF &&
    - 	exit 0
    - 	EOF
    - 	(
    -@@ t/t9800-git-p4-basic.sh: test_expect_success 'run hook p4-pre-submit before submit' '
    - 		git p4 submit --dry-run >out &&
    - 		grep "Would apply" out
    - 	) &&
    --	write_script "$git"/.git/hooks/p4-pre-submit <<-\EOF &&
    -+	test_hook -C "$git" --clobber p4-pre-submit <<-\EOF &&
    - 	exit 1
    - 	EOF
    - 	(
 5:  19db5b2d7c2 ! 10:  dab99b8359d tests: indent and add hook setup to "test_expect_success"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tests: indent and add hook setup to "test_expect_success"
    +    tests: use "test_hook" for misc "mkdir -p" and "chmod" cases
     
    -    Indent various hook setup code in the test suite that's using a manual
    -    "cat && chmod" pattern.
    -
    -    These should also consistently use "#!$SHELL_PATH" instead of
    -    "#!/bin/sh", i.e. "test_script". Let's fix that in a subsequent
    -    commit, which will be easier to review after this smaller change.
    +    Make use of "test_hook" in various cases that didn't fit neatly into
    +    preceding commits. Here we need to indent blocks in addition to
    +    changing the test code, or to make other small cosmetic changes.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t3412-rebase-root.sh ##
     @@ t/t3412-rebase-root.sh: test_expect_success 'rebase --root fails with too many args' '
    + '
      
      test_expect_success 'setup pre-rebase hook' '
    - 	mkdir -p .git/hooks &&
    +-	mkdir -p .git/hooks &&
     -	cat >.git/hooks/pre-rebase <<EOF &&
     -#!$SHELL_PATH
     -echo "\$1,\$2" >.git/PRE-REBASE-INPUT
     -EOF
    -+	cat >.git/hooks/pre-rebase <<-EOF &&
    -+	#!$SHELL_PATH
    -+	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
    +-	chmod +x .git/hooks/pre-rebase
    ++	test_hook --setup pre-rebase <<-\EOF
    ++	echo "$1,$2" >.git/PRE-REBASE-INPUT
     +	EOF
    - 	chmod +x .git/hooks/pre-rebase
      '
      cat > expect <<EOF
    -@@ t/t3412-rebase-root.sh: EOF
    + 4
    +@@ t/t3412-rebase-root.sh: commit work7~5
    + EOF
      
      test_expect_success 'setup pre-rebase hook that fails' '
    - 	mkdir -p .git/hooks &&
    +-	mkdir -p .git/hooks &&
     -	cat >.git/hooks/pre-rebase <<EOF &&
     -#!$SHELL_PATH
     -false
     -EOF
    -+	cat >.git/hooks/pre-rebase <<-EOF &&
    -+	#!$SHELL_PATH
    +-	chmod +x .git/hooks/pre-rebase
    ++	test_hook --setup --clobber pre-rebase <<-\EOF
     +	false
     +	EOF
    - 	chmod +x .git/hooks/pre-rebase
      '
      
    + test_expect_success 'pre-rebase hook stops rebase' '
     
      ## t/t3413-rebase-hook.sh ##
     @@ t/t3413-rebase-hook.sh: test_expect_success 'rebase -i' '
    + '
      
      test_expect_success 'setup pre-rebase hook' '
    - 	mkdir -p .git/hooks &&
    +-	mkdir -p .git/hooks &&
     -	cat >.git/hooks/pre-rebase <<EOF &&
     -#!$SHELL_PATH
     -echo "\$1,\$2" >.git/PRE-REBASE-INPUT
     -EOF
    -+	cat >.git/hooks/pre-rebase <<-EOF &&
    -+	#!$SHELL_PATH
    -+	echo "\$1,\$2" >.git/PRE-REBASE-INPUT
    +-	chmod +x .git/hooks/pre-rebase
    ++	test_hook --setup pre-rebase <<-\EOF
    ++	echo "$1,$2" >.git/PRE-REBASE-INPUT
     +	EOF
    - 	chmod +x .git/hooks/pre-rebase
      '
      
    + test_expect_success 'pre-rebase hook gets correct input (1)' '
     @@ t/t3413-rebase-hook.sh: test_expect_success 'pre-rebase hook gets correct input (6)' '
    + '
      
      test_expect_success 'setup pre-rebase hook that fails' '
    - 	mkdir -p .git/hooks &&
    +-	mkdir -p .git/hooks &&
     -	cat >.git/hooks/pre-rebase <<EOF &&
     -#!$SHELL_PATH
     -false
     -EOF
    -+	cat >.git/hooks/pre-rebase <<-EOF &&
    -+	#!$SHELL_PATH
    +-	chmod +x .git/hooks/pre-rebase
    ++	test_hook --setup --clobber pre-rebase <<-\EOF
     +	false
     +	EOF
    - 	chmod +x .git/hooks/pre-rebase
      '
      
    + test_expect_success 'pre-rebase hook stops rebase (1)' '
     
      ## t/t5401-update-hooks.sh ##
     @@ t/t5401-update-hooks.sh: test_expect_success setup '
    @@ t/t5401-update-hooks.sh: test_expect_success setup '
      	GIT_DIR=victim.git git update-ref refs/heads/tofail $commit1 &&
      	git update-ref refs/heads/main $commit1 &&
     -	git update-ref refs/heads/tofail $commit0
    +-'
     +	git update-ref refs/heads/tofail $commit0 &&
    -+
    -+	cat >victim.git/hooks/pre-receive <<-\EOF &&
    -+	#!/bin/sh
    -+	printf %s "$@" >>$GIT_DIR/pre-receive.args
    -+	cat - >$GIT_DIR/pre-receive.stdin
    -+	echo STDOUT pre-receive
    -+	echo STDERR pre-receive >&2
    -+	EOF
    -+	chmod u+x victim.git/hooks/pre-receive &&
    -+
    -+	cat >victim.git/hooks/update <<-\EOF &&
    -+	#!/bin/sh
    -+	echo "$@" >>$GIT_DIR/update.args
    -+	read x; printf %s "$x" >$GIT_DIR/update.stdin
    -+	echo STDOUT update $1
    -+	echo STDERR update $1 >&2
    -+	test "$1" = refs/heads/main || exit
    -+	EOF
    -+	chmod u+x victim.git/hooks/update &&
    -+
    -+	cat >victim.git/hooks/post-receive <<-\EOF &&
    -+	#!/bin/sh
    -+	printf %s "$@" >>$GIT_DIR/post-receive.args
    -+	cat - >$GIT_DIR/post-receive.stdin
    -+	echo STDOUT post-receive
    -+	echo STDERR post-receive >&2
    -+	EOF
    -+	chmod u+x victim.git/hooks/post-receive &&
    -+
    -+	cat >victim.git/hooks/post-update <<-\EOF &&
    -+	#!/bin/sh
    -+	echo "$@" >>$GIT_DIR/post-update.args
    -+	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
    -+	echo STDOUT post-update
    -+	echo STDERR post-update >&2
    -+	EOF
    -+	chmod u+x victim.git/hooks/post-update
    - '
      
     -cat >victim.git/hooks/pre-receive <<'EOF'
     -#!/bin/sh
    @@ t/t5401-update-hooks.sh: test_expect_success setup '
     -echo STDERR pre-receive >&2
     -EOF
     -chmod u+x victim.git/hooks/pre-receive
    --
    ++	test_hook --setup -C victim.git pre-receive <<-\EOF &&
    ++	printf %s "$@" >>$GIT_DIR/pre-receive.args
    ++	cat - >$GIT_DIR/pre-receive.stdin
    ++	echo STDOUT pre-receive
    ++	echo STDERR pre-receive >&2
    ++	EOF
    + 
     -cat >victim.git/hooks/update <<'EOF'
     -#!/bin/sh
     -echo "$@" >>$GIT_DIR/update.args
    @@ t/t5401-update-hooks.sh: test_expect_success setup '
     -test "$1" = refs/heads/main || exit
     -EOF
     -chmod u+x victim.git/hooks/update
    --
    ++	test_hook --setup -C victim.git update <<-\EOF &&
    ++	echo "$@" >>$GIT_DIR/update.args
    ++	read x; printf %s "$x" >$GIT_DIR/update.stdin
    ++	echo STDOUT update $1
    ++	echo STDERR update $1 >&2
    ++	test "$1" = refs/heads/main || exit
    ++	EOF
    + 
     -cat >victim.git/hooks/post-receive <<'EOF'
     -#!/bin/sh
     -printf %s "$@" >>$GIT_DIR/post-receive.args
    @@ t/t5401-update-hooks.sh: test_expect_success setup '
     -echo STDERR post-receive >&2
     -EOF
     -chmod u+x victim.git/hooks/post-receive
    --
    ++	test_hook --setup -C victim.git post-receive <<-\EOF &&
    ++	printf %s "$@" >>$GIT_DIR/post-receive.args
    ++	cat - >$GIT_DIR/post-receive.stdin
    ++	echo STDOUT post-receive
    ++	echo STDERR post-receive >&2
    ++	EOF
    + 
     -cat >victim.git/hooks/post-update <<'EOF'
     -#!/bin/sh
     -echo "$@" >>$GIT_DIR/post-update.args
    @@ t/t5401-update-hooks.sh: test_expect_success setup '
     -echo STDERR post-update >&2
     -EOF
     -chmod u+x victim.git/hooks/post-update
    --
    ++	test_hook --setup -C victim.git post-update <<-\EOF
    ++	echo "$@" >>$GIT_DIR/post-update.args
    ++	read x; printf %s "$x" >$GIT_DIR/post-update.stdin
    ++	echo STDOUT post-update
    ++	echo STDERR post-update >&2
    ++	EOF
    ++'
    + 
      test_expect_success push '
      	test_must_fail git send-pack --force ./victim.git \
    - 		main tofail >send.out 2>send.err
     
      ## t/t5407-post-rewrite-hook.sh ##
     @@ t/t5407-post-rewrite-hook.sh: test_expect_success 'setup' '
    @@ t/t5407-post-rewrite-hook.sh: test_expect_success 'setup' '
     -cat > "$TRASH_DIRECTORY"/post-rewrite.data
     -EOF
     -chmod u+x .git/hooks/post-rewrite
    -+	cat >.git/hooks/post-rewrite <<-EOF &&
    -+	#!/bin/sh
    ++	test_hook --setup post-rewrite <<-EOF
     +	echo \$@ > "$TRASH_DIRECTORY"/post-rewrite.args
     +	cat > "$TRASH_DIRECTORY"/post-rewrite.data
     +	EOF
    -+	chmod u+x .git/hooks/post-rewrite
     +'
      
      clear_hook_input () {
    @@ t/t5541-http-push-smart.sh: test_expect_success 'create and delete remote branch
     -EOF
     -chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
     +test_expect_success 'setup rejected update hook' '
    -+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-EOF &&
    -+	#!/bin/sh
    ++	test_hook --setup -C "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git" update <<-\EOF &&
     +	exit 1
     +	EOF
    -+	chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" &&
      
     -cat >exp <<EOF
     -remote: error: hook declined to update refs/heads/dev2
 -:  ----------- > 11:  f541b0b2d70 tests: extend "test_hook" for "rm" and "chmod -x", convert "$HOOK"
 -:  ----------- > 12:  5b764ffc65a proc-receive hook tests: use "test_hook" instead of "write_script"
 -:  ----------- > 13:  2dffde32036 http tests: use "test_hook" for "smart" and "dumb" http tests
-- 
2.35.1.1384.g7d2906948a1

