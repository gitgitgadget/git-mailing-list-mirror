Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638E9C43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC362236F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlDsT1On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbgJSVfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733223AbgJSVfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:35:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D56C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y12so1338926wrp.6
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vraIWK80+IITzaf7/4MU74vkId5yLJf+6Sv7GhRpeQk=;
        b=SlDsT1Onz1Xwe2pun2QQaRtuwcKLznvGkMX0v8co/lI2bhn/6hEJMi/zm2ZHePliTs
         psA/63SAiCenvI97b+SNENHPq5xYMYR5Ph6Zli5OA+ny4Uj7TLMXWNCO2PEc75o1mE+j
         b5zej1K8lryeSENfAlGCfBaDziBn7YYNUnOpOCrZo2Ahf9hwnDmpZKEzh7WnPkG6L9xZ
         viLNl7AhzZoXrELFjhn+mgUumztXIgBzwDGvbsm7hCH8+ZmXsSAaLLA79dP0xL7JAmlO
         X8t2q9Xq/5xR5Qxw0F/nhunZw8NlmkXpvkIqEOiC1Kc/V6vG+hg4RLWHE47F3imTjBN+
         qLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vraIWK80+IITzaf7/4MU74vkId5yLJf+6Sv7GhRpeQk=;
        b=EADS5+jvpRJZriIhrz5yViGf16kXLP+7G6KZVH2v8FLnsrWdZYeUNZ0/R9d61/WdoA
         GOCBan1ggc9JkQvllrFI4/D/bfFuADepUhCGZW8/zvAykdU93udxnedppd2INkgRzJO5
         jD1YhATxWBG6pLsC5egdXVwmrctSV6l1oPeskOFnyv8C2dSH9Ct3+a2hSgnd+lpLFKuE
         EE0A0u1X/euccUmagXvuMMXTEE6hAwIQf20Tr6Gz18MgM3rQnjHYGTuDTSpBO47MRly/
         3kHK8m4xZBQj8MzdTaOyYSQw/P+3M6TH4Sf7/OfEaKKfeVcsbKH54zAPxiOlopAcHQQp
         /MUw==
X-Gm-Message-State: AOAM530fgc/TPF+eUh8i98Yv+Rqw3ZFAu8geNayHeu83WGXozm/+EyaV
        QHuBtOgKYDt8dB/3JMjkWEJj17YHb6c=
X-Google-Smtp-Source: ABdhPJyXkdk1FWsUb1XixRDsyCuyky1VHea6IW9NZxUMCWluV+8PL1TZzwgvRY/NSWS4BH9+V8EC5Q==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr1400535wrr.144.1603143317554;
        Mon, 19 Oct 2020 14:35:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm1349156wrf.67.2020.10.19.14.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:35:17 -0700 (PDT)
Message-Id: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.git.1602968677.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 21:35:11 +0000
Subject: [PATCH v2 0/4] use fsmonitor data in git diff eliminating O(num_files) calls to lstat
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Credit to alexmv who made this commit back in Dec, 2017 when he was at dbx.
I've rebased it and am submitting it now.

With fsmonitor enabled, git diff currently lstats every file in the repo
This makes use of the fsmonitor extension to skip lstat() calls on files
that fsmonitor judged as unmodified.

I was able to do some testing with/without this change in a large in-house
repo (~ 400k files).

-----------------------------------------
(1) With fsmonitor enabled - on master of git (2.29.0)
-----------------------------------------
../git/bin-wrappers/git checkout HEAD~200
strace -c ../git/bin-wrappers/git diff

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.64    4.358994          10    446257         3 lstat
  0.12    0.005353           7       764       360 open

(A subsequent call)
strace -c ../git/bin-wrappers/git diff

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.84    4.380955          10    444904         3 lstat
  0.06    0.002564         135        19           munmap
...

-----------------------------------------
(2) With fsmonitor enabled - with my patch
-----------------------------------------
../git/bin-wrappers/git checkout HEAD~200
strace -c ../git/bin-wrappers/git diff

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 50.72    0.003090         163        19           munmap
 19.63    0.001196         598         2           futex
...
  0.00    0.000000           0         4         3 lstat


-----------------------------------------
(3) With fsmonitor disabled entirely
-----------------------------------------

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 98.52    0.277085       92362         3           futex
  0.27    0.000752           4       191        63 open
...
  0.14    0.000397           3       158         3 lstat

I was able to encode this into a perf test in one of the commits.

Changes since Patch Series V1

 * Add git diff -- <pathspec> to perf tests
 * improve readability of bitwise ops

Alex Vandiver (1):
  fsmonitor: use fsmonitor data in `git diff`

Nipunn Koorapati (3):
  t/perf/README: elaborate on output format
  t/perf/p7519-fsmonitor.sh: warm cache on first git status
  t/perf: add fsmonitor perf test for git diff

 diff-lib.c                | 15 ++++++--
 t/perf/README             |  2 ++
 t/perf/p7519-fsmonitor.sh | 74 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 3 deletions(-)


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-756%2Fnipunn1313%2Fdiff_fsmon-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-756/nipunn1313/diff_fsmon-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/756

Range-diff vs v1:

 1:  13fd992a37 ! 1:  cba03dd40b fsmonitor: use fsmonitor data in `git diff`
     @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      -		/* If CE_VALID is set, don't look at workdir for file removal */
      -		if (ce->ce_flags & CE_VALID) {
      +		/*
     -+		 * If CE_VALID is set, the user has promised us that the workdir
     -+		 * hasn't changed compared to index, so don't stat workdir
     -+		 * for file removal
     -+		 *  eg - via git udpate-index --assume-unchanged
     -+		 *  eg - via core.ignorestat=true
     -+		 *
     -+		 * When using FSMONITOR:
     -+		 * If CE_FSMONITOR_VALID is set, then we know the metadata on disk
     -+		 * has not changed since the last refresh, and we can skip the
     -+		 * file-removal checks without doing the stat in check_removed.
     ++		 * When CE_VALID is set (via "update-index --assume-unchanged"
     ++		 * or via adding paths while core.ignorestat is set to true),
     ++		 * the user has promised that the working tree file for that
     ++		 * path will not be modified.  When CE_FSMONITOR_VALID is true,
     ++		 * the fsmonitor knows that the path hasn't been modified since
     ++		 * we refreshed the cached stat information.  In either case,
     ++		 * we do not have to stat to see if the path has been removed
     ++		 * or modified.
      +		 */
     -+		if (ce->ce_flags & CE_VALID || ce->ce_flags & CE_FSMONITOR_VALID) {
     ++		if (ce->ce_flags & (CE_VALID | CE_FSMONITOR_VALID)) {
       			changed = 0;
       			newmode = ce->ce_mode;
       		} else {
 2:  024cd07965 = 2:  1c7876166f t/perf/README: elaborate on output format
 3:  6482e372bc = 3:  401f696c81 t/perf/p7519-fsmonitor.sh: warm cache on first git status
 4:  0613b07676 ! 4:  f572e226bb t/perf: add fsmonitor perf test for git diff
     @@ Commit message
          significantly better with this patch series (80% faster on my
          workload)!
      
     -    On master (2.29)
     +    GIT_PERF_LARGE_REPO=~/src/server ./run v2.29.0-rc1 . -- p7519-fsmonitor.sh
      
     -    Test                                                             this tree
     -    --------------------------------------------------------------------------------
     -    7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.06)
     -    7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.13+0.05)
     -    7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.34(0.77+0.56)
     -    7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)           0.82(0.24+0.58)
     -    7519.7: status (fsmonitor=)                                      0.70(0.53+0.90)
     -    7519.8: status -uno (fsmonitor=)                                 0.37(0.32+0.78)
     -    7519.9: status -uall (fsmonitor=)                                1.55(1.01+1.25)
     -    7519.10: diff (fsmonitor=)                                       0.34(0.35+0.72)
     +    Test                                                                     v2.29.0-rc1       this tree
     +    -----------------------------------------------------------------------------------------------------------------
     +    7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)                 1.46(0.82+0.64)   1.47(0.83+0.62) +0.7%
     +    7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)            0.16(0.12+0.04)   0.17(0.12+0.05) +6.3%
     +    7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)           1.36(0.73+0.62)   1.37(0.76+0.60) +0.7%
     +    7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)                   0.85(0.22+0.63)   0.14(0.10+0.05) -83.5%
     +    7519.6: diff -- 0_files (fsmonitor=.git/hooks/fsmonitor-watchman)        0.12(0.08+0.05)   0.13(0.11+0.02) +8.3%
     +    7519.7: diff -- 10_files (fsmonitor=.git/hooks/fsmonitor-watchman)       0.12(0.08+0.04)   0.13(0.09+0.04) +8.3%
     +    7519.8: diff -- 100_files (fsmonitor=.git/hooks/fsmonitor-watchman)      0.12(0.07+0.05)   0.13(0.07+0.06) +8.3%
     +    7519.9: diff -- 1000_files (fsmonitor=.git/hooks/fsmonitor-watchman)     0.12(0.09+0.04)   0.13(0.08+0.05) +8.3%
     +    7519.10: diff -- 10000_files (fsmonitor=.git/hooks/fsmonitor-watchman)   0.14(0.09+0.05)   0.13(0.10+0.03) -7.1%
     +    7519.12: status (fsmonitor=)                                             1.67(0.93+1.49)   1.67(0.99+1.42) +0.0%
     +    7519.13: status -uno (fsmonitor=)                                        0.37(0.30+0.82)   0.37(0.33+0.79) +0.0%
     +    7519.14: status -uall (fsmonitor=)                                       1.58(0.97+1.35)   1.57(0.86+1.45) -0.6%
     +    7519.15: diff (fsmonitor=)                                               0.34(0.28+0.83)   0.34(0.27+0.83) +0.0%
     +    7519.16: diff -- 0_files (fsmonitor=)                                    0.09(0.06+0.04)   0.09(0.08+0.02) +0.0%
     +    7519.17: diff -- 10_files (fsmonitor=)                                   0.09(0.07+0.03)   0.09(0.06+0.05) +0.0%
     +    7519.18: diff -- 100_files (fsmonitor=)                                  0.09(0.06+0.04)   0.09(0.06+0.04) +0.0%
     +    7519.19: diff -- 1000_files (fsmonitor=)                                 0.09(0.06+0.04)   0.09(0.05+0.05) +0.0%
     +    7519.20: diff -- 10000_files (fsmonitor=)                                0.10(0.08+0.04)   0.10(0.06+0.05) +0.0%
      
     -    With this patch series
     +    I also added a benchmark for a tiny git diff workload w/ a pathspec.
     +    I see an approximately .02 second overhead added w/ and w/o fsmonitor
      
     -    Test                                                             this tree
     -    --------------------------------------------------------------------------------
     -    7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.07)
     -    7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.12+0.05)
     -    7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.35(0.73+0.61)
     -    7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)           0.14(0.10+0.05)
     -    7519.7: status (fsmonitor=)                                      0.70(0.56+0.87)
     -    7519.8: status -uno (fsmonitor=)                                 0.37(0.31+0.79)
     -    7519.9: status -uall (fsmonitor=)                                1.54(0.97+1.29)
     -    7519.10: diff (fsmonitor=)                                       0.34(0.28+0.79)
     +    From looking at these results, I suspected that refresh_fsmonitor
     +    is already happening during git diff - independent of this patch
     +    series' optimization. Confirmed that suspicion by breaking on
     +    refresh_fsmonitor.
     +
     +    (gdb) bt  [simplified]
     +    0  refresh_fsmonitor  at fsmonitor.c:176
     +    1  ie_match_stat  at read-cache.c:375
     +    2  match_stat_with_submodule at diff-lib.c:237
     +    4  builtin_diff_files  at builtin/diff.c:260
     +    5  cmd_diff  at builtin/diff.c:541
     +    6  run_builtin  at git.c:450
     +    7  handle_builtin  at git.c:700
     +    8  run_argv  at git.c:767
     +    9  cmd_main  at git.c:898
     +    10 main  at common-main.c:52
      
          Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
     +@@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup for fsmonitor" '
     + 
     + 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
     + 	git update-index --fsmonitor &&
     ++	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
     ++	for i in `seq 1 10`; do touch 10_files/$i; done &&
     ++	for i in `seq 1 100`; do touch 100_files/$i; done &&
     ++	for i in `seq 1 1000`; do touch 1000_files/$i; done &&
     ++	for i in `seq 1 10000`; do touch 10000_files/$i; done &&
     ++	git add 1_file 10_files 100_files 1000_files 10000_files &&
     ++	git commit -m "Add files" &&
     + 	git status  # Warm caches
     + '
     + 
      @@ t/perf/p7519-fsmonitor.sh: test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
       	git status -uall
       '
     @@ t/perf/p7519-fsmonitor.sh: test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIP
      +test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
      +	git diff
      +'
     ++
     ++if test -n "$GIT_PERF_7519_DROP_CACHE"; then
     ++	test-tool drop-caches
     ++fi
     ++
     ++test_perf "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 1_file
     ++'
     ++
     ++test_perf "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 10_files
     ++'
     ++
     ++test_perf "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 100_files
     ++'
     ++
     ++test_perf "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 1000_files
     ++'
     ++
     ++test_perf "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 10000_files
     ++'
      +
       test_expect_success "setup without fsmonitor" '
       	unset INTEGRATION_SCRIPT &&
     @@ t/perf/p7519-fsmonitor.sh: test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIP
      +test_perf "diff (fsmonitor=$INTEGRATION_SCRIPT)" '
      +	git diff
      +'
     ++
     ++if test -n "$GIT_PERF_7519_DROP_CACHE"; then
     ++	test-tool drop-caches
     ++fi
     ++
     ++test_perf "diff -- 0_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 1_file
     ++'
     ++
     ++test_perf "diff -- 10_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 10_files
     ++'
     ++
     ++test_perf "diff -- 100_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 100_files
     ++'
     ++
     ++test_perf "diff -- 1000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 1000_files
     ++'
     ++
     ++test_perf "diff -- 10000_files (fsmonitor=$INTEGRATION_SCRIPT)" '
     ++	git diff -- 10000_files
     ++'
      +
       if test_have_prereq WATCHMAN
       then

-- 
gitgitgadget
