Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A9FC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B9E21D7F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/exi6OU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbgJSWrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbgJSWrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:47:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5BC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so32969wmj.5
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LRkYD5sphWN3B9dZpbq2no9I8RaCONyxEeYU0a8lXqk=;
        b=p/exi6OUafLB3NaxdCXT0PB0o32h7z9VoD1hcy6HYu7zOu/11B0VwCZ6LVYoOzcH+n
         cyK0oodlEGOSAPyrDvVFsdJqYeV9U0EAs275zJ1etPHdgLAYWhb4jN09qxGPvVY6KqO2
         4EAJVhOn6WhbuM/bYw5eUW5Nk4ibrbLUCNxGaK7gectRu74El15nLcXsN3Gvphrax5qU
         cEGF2+AqyDw1hN+spjRLi0VA+LS+VPE93DbQePlq3OkcDWPf29CMeU97tMH94A8kXXY+
         2vM7pa84+WehaqP/4756RYPi088hQRaPp1TM7xuJWgPW4wVzFTmuERqV5LdK3pv/jUTF
         l8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LRkYD5sphWN3B9dZpbq2no9I8RaCONyxEeYU0a8lXqk=;
        b=HZGjt6oVmawpyytvUy6DV0oWKEquTAyxIxagnnwzkUjs8xWNBlzJnaOxmCXMKKusFP
         J0J97q7S2YPE40SBXveQPI/IcMVxVM23rUaDN+9z6lx6XPxqAODr1DcvYlU24HBXWEof
         rdjVeBO20cbKc9KrwzXpQwZGm0OQIhKkJX5qOA5IZIhxSq6JF1btHbCEknLycbCpV4lI
         U+ZmX9qEc5oU2lG0iu3aFXcwwdUp1SscX7LZk/A1EyvTTUCgoplWj9y1Ewyli3BiwjfS
         r5ewV5rrwB/uITFeZMCM2AoyamvfoOrN7nvmNTIrzkFXSS6KJgEP1g3lAKK4tPCrRY0s
         sXmg==
X-Gm-Message-State: AOAM5305Uy2eP/cbbl36uPYE92lt+xiPgO5aM8V25G7Qo0lvGFpWzOpQ
        mZLerX68u4Ctn5tVnjiSeOCmZre/M2o=
X-Google-Smtp-Source: ABdhPJxBYgvDaf6zKoiL5HpEaOg2NvO7orPF1P8N8qLLEWqooG4I3juCIt7tm7t47pZ26Al8G5S95A==
X-Received: by 2002:a1c:4b0f:: with SMTP id y15mr56956wma.165.1603147658663;
        Mon, 19 Oct 2020 15:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a82sm31899wmc.44.2020.10.19.15.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:47:38 -0700 (PDT)
Message-Id: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 22:47:30 +0000
Subject: [PATCH v3 0/7] use fsmonitor data in git diff eliminating O(num_files) calls to lstat
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

Nipunn Koorapati (6):
  t/perf/README: elaborate on output format
  t/perf/p7519-fsmonitor.sh: warm cache on first git status
  t/perf: add fsmonitor perf test for git diff
  perf lint: check test-lint-shell-syntax in perf tests
  p7519-fsmonitor: refactor to avoid code duplication
  p7519-fsmonitor: add a git add benchmark

 diff-lib.c                | 15 +++++-
 t/Makefile                |  3 +-
 t/perf/README             |  2 +
 t/perf/p3400-rebase.sh    |  6 +--
 t/perf/p7519-fsmonitor.sh | 96 ++++++++++++++++++++++-----------------
 5 files changed, 75 insertions(+), 47 deletions(-)


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-756%2Fnipunn1313%2Fdiff_fsmon-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-756/nipunn1313/diff_fsmon-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/756

Range-diff vs v2:

 1:  cba03dd40b = 1:  cba03dd40b fsmonitor: use fsmonitor data in `git diff`
 2:  1c7876166f = 2:  1c7876166f t/perf/README: elaborate on output format
 3:  401f696c81 = 3:  401f696c81 t/perf/p7519-fsmonitor.sh: warm cache on first git status
 4:  f572e226bb ! 4:  b3ad8faac4 t/perf: add fsmonitor perf test for git diff
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup for fsmonitor" '
       	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
       	git update-index --fsmonitor &&
      +	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
     -+	for i in `seq 1 10`; do touch 10_files/$i; done &&
     -+	for i in `seq 1 100`; do touch 100_files/$i; done &&
     -+	for i in `seq 1 1000`; do touch 1000_files/$i; done &&
     -+	for i in `seq 1 10000`; do touch 10000_files/$i; done &&
     ++	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
     ++	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
     ++	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
     ++	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
      +	git add 1_file 10_files 100_files 1000_files 10000_files &&
      +	git commit -m "Add files" &&
       	git status  # Warm caches
 -:  ---------- > 5:  28c1e488bf perf lint: check test-lint-shell-syntax in perf tests
 -:  ---------- > 6:  b38f2984f9 p7519-fsmonitor: refactor to avoid code duplication
 -:  ---------- > 7:  d392a523f2 p7519-fsmonitor: add a git add benchmark

-- 
gitgitgadget
