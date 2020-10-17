Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21456C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3024207BB
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU6SJGw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439453AbgJQVEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439450AbgJQVEk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 17:04:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5BC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b127so8973941wmb.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=i1nIsUlsq85JzkWIjic8J4SiPwSM4KOitfnu5zM8bVw=;
        b=LU6SJGw5w7JaitRwh4sQguQQFHrn5B+ZS1ezOIeHa+4KrWpNZnyeliRw+5KMtI3U4J
         Nmy+wpwFiSgRCqmoBDKeIyI36/b/xKvKWod8iVa8ji2DL5IDksSmynwzfFtvRtOYVkGW
         Ch29J5crBP85q+mh38IJMLAbelgIQZwQltKf/3MO8D+pY43QJ5qSjtHu5lVAqHuHfG9s
         bSTE8njKAv+8L8wPchJ0MYOED8zYXySylOYPgGW2QjbLUCyMG/huOGoGf7MEgoA8uych
         T8p6el3ACuRj9UQBHEEIc+IM+my3BpUyzOXHXNfeZDY+FCkjzNwdfcz0BsvV1a1PXyBA
         eapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i1nIsUlsq85JzkWIjic8J4SiPwSM4KOitfnu5zM8bVw=;
        b=MOC1NbRlAER5mYGr85Ko+c/RoUTrjuWsc89fclJX4lRKk43Sl70POhlmfS/5Ih1xkl
         s5pHgivJM4Sj4ZWTXagMm+IOONQS7WvMI6R45+O2tag5RhxXKPiaaOUEOdqibklzJfPO
         d9y4c2ICL7/qh8Cc77Hic+Re4haR8Ayemrxmfrud8bbMtGXTfa/VgNQrTDq1YhX87bxZ
         Vsjml3jSBVXQAa4I5fqhrFBDl3g+viCzfvocPr1uPolP6I3aJ8J4i3fZTxGDS4uWuveV
         ImdyKojS1Ob5/BShMWzzimKiGsBr42VUUJ+jCsfrvovPdr780YfGfQe70Dqmw5TrkAF1
         AzJw==
X-Gm-Message-State: AOAM532W0pG0YUr+Huuhgre+u647duLJeYhZ9SGfY+5QBCN9sn2Wt+0Y
        fLR+5LXjp3t8l1MvOzMRwC9KR3rCyn4=
X-Google-Smtp-Source: ABdhPJzvIjF8KyocMpRFOX4QkK03FD6D7+1ywQfFsJkQFs0uVyv5hSlHlfdN4Gd9ChP7daqPt8l+2w==
X-Received: by 2002:a7b:cb8d:: with SMTP id m13mr9791517wmi.59.1602968678569;
        Sat, 17 Oct 2020 14:04:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a199sm9443719wmd.8.2020.10.17.14.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:04:37 -0700 (PDT)
Message-Id: <pull.756.git.1602968677.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 21:04:32 +0000
Subject: [PATCH 0/4] use fsmonitor data in git diff eliminating O(num_files) calls to lstat
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
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
repo (~ 400k files)

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

I encoded this into a perf test with results as follow:

On master (2.29)

Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         2.52(1.59+1.56)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.18(0.12+0.06)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.36(0.73+0.62)
7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)           0.85(0.30+0.54)
7519.7: status (fsmonitor=)                                      0.69(0.52+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.28+0.81)
7519.9: status -uall (fsmonitor=)                                1.53(0.93+1.32)
7519.10: diff (fsmonitor=)                                       0.34(0.26+0.81)

With this patch

Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         2.84(1.70+1.76)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.18(0.13+0.05)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.35(0.81+0.53)
7519.5: diff (fsmonitor=.git/hooks/fsmonitor-watchman)           0.15(0.11+0.05)
7519.7: status (fsmonitor=)                                      0.71(0.54+0.90)
7519.8: status -uno (fsmonitor=)                                 0.38(0.30+0.81)
7519.9: status -uall (fsmonitor=)                                1.55(0.93+1.34)
7519.10: diff (fsmonitor=)                                       0.35(0.32+0.76)

Alex Vandiver (1):
  fsmonitor: use fsmonitor data in `git diff`

Nipunn Koorapati (3):
  t/perf/README: elaborate on output format
  t/perf/p7519-fsmonitor.sh: warm cache on first git status
  t/perf: add fsmonitor perf test for git diff

 diff-lib.c                | 17 +++++++++++++++--
 t/perf/README             |  2 ++
 t/perf/p7519-fsmonitor.sh | 19 ++++++++++++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-756%2Fnipunn1313%2Fdiff_fsmon-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-756/nipunn1313/diff_fsmon-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/756
-- 
gitgitgadget
