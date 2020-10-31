Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDCFC388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4019D206E3
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYks+SwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgJaTqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgJaTqH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 15:46:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9567C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:46:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w14so10056998wrs.9
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AIZ8smIXpUNCwJijdcrUOVigbyvefhQyDLek7Bkg8QQ=;
        b=hYks+SwFvK5VVOVuMSXis7sPnSzzLnAfwlEfqb2Vp0yAdnTDQBwEP8T4YhnfPa9rgG
         9umN/Nzg99df8ijH1Wrwjd3GRUa3RYfvr7n4444WUce/nFQ4uXTYuSdaZrqDYt2aqjMh
         w0aB+fm4Kdf9hJrP1S7bfoJ/glAeMge5AHYXRgfeFstxrTUwXAzCCNn5C44CoV35tZPp
         pYUHVDMFsnyFMi6qKLtOLXmfi5Q+5LP+Js98Dgmi07gj3Ln2A7jv7WCGdqdOMUMNUicO
         kSIcO7IKEy8gfyZWGj5ZsH834YDfCcHEd2ZsXsB6OMIH6kmTAgCwH4ei837H0ZLN2KDE
         qbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AIZ8smIXpUNCwJijdcrUOVigbyvefhQyDLek7Bkg8QQ=;
        b=CpYpxTl1e8c5xYL9U9odPRORPfVN2SzlsqS+bCvUOtuEC+QRmAYa3VrZDJ/Aopdv16
         G3lRVGA7VXmAROsoFYQIK+mBL1FHjNN/N6lnobfjvFGonSTLIG9soQoQRV7LPHubaiFA
         7Mo58K1JLiCT8lcuerQESo+3flLb4mHh01KufjPLNR8QRi9xaSH+r2emTgr4tptfwX2H
         TO2YjW1lCD7TksulZ7RwYdHIm1aVVQAQ9FJFl+m23XXzbovuWfgUp2Jrjz/kO3mtnL0Q
         2lIj7jjdS2oGu3D8HSdgfjuxOIQ6YcwAgkn7uy3hIRvLOurlVXcR64Mqx0E1YaDWIiA8
         yfEg==
X-Gm-Message-State: AOAM533cwcbxd26W6w0dsg4sdxcUhPMC96wDeBq13sGUzOmatzPNdIUD
        edWVl5cc1D63GvZtxrSVXof6zbInHI0=
X-Google-Smtp-Source: ABdhPJxgpxuSat9MvtteGYQB9nY0oZS73TNQx2L4vhURmo5FKUUUel3A5p3+M7sJh3thg1aO06tq2A==
X-Received: by 2002:a05:6000:1109:: with SMTP id z9mr10042298wrw.388.1604173565057;
        Sat, 31 Oct 2020 12:46:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm15476770wrp.74.2020.10.31.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 12:46:04 -0700 (PDT)
Message-Id: <pull.760.v2.git.1604173563.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.1603839487.gitgitgadget@gmail.com>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Oct 2020 19:45:59 +0000
Subject: [PATCH v2 0/4] Adjust t5411 for the upcoming change of the default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test script t5411-proc-receive-hook.sh is an interesting case: it not
only requires tons of mostly straight-forward changes that amount to an
automated search-and-replace, but it also requires a few adjustments due to
the change of the default branch name's length.

This patch series is part of the over-all effort tracked in 
https://github.com/gitgitgadget/git/pull/655.

Changes since v1:

 * We now set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME explicitly to master in
   patch 1/4, effectively disabling the test due to the use of the 
   PREPARE_FOR_MAIN_BRANCH prereq until we switch it over to setting the
   initial branch name to main with patch 4/4.

Johannes Schindelin (4):
  t5411: start using the default branch name "main"
  t5411: start adjusting the support files for init.defaultBranch=main
  t5411: adjust the remaining support files for init.defaultBranch=main
  t5411: finish preparing for `main` being the default branch name

 t/t5411-proc-receive-hook.sh                  |  17 ++-
 t/t5411/common-functions.sh                   |   2 +-
 t/t5411/once-0010-report-status-v1.sh         |  50 ++++----
 t/t5411/test-0000-standard-git-push.sh        |  72 +++++------
 .../test-0001-standard-git-push--porcelain.sh |  72 +++++------
 t/t5411/test-0002-pre-receive-declined.sh     |  12 +-
 ...st-0003-pre-receive-declined--porcelain.sh |  12 +-
 t/t5411/test-0011-no-hook-error.sh            |  38 +++---
 t/t5411/test-0012-no-hook-error--porcelain.sh |  38 +++---
 t/t5411/test-0013-bad-protocol.sh             |  96 +++++++-------
 t/t5411/test-0014-bad-protocol--porcelain.sh  |  70 +++++-----
 t/t5411/test-0020-report-ng.sh                |  40 +++---
 t/t5411/test-0021-report-ng--porcelain.sh     |  40 +++---
 t/t5411/test-0022-report-unexpect-ref.sh      |  36 +++---
 ...est-0023-report-unexpect-ref--porcelain.sh |  36 +++---
 t/t5411/test-0024-report-unknown-ref.sh       |  12 +-
 ...test-0025-report-unknown-ref--porcelain.sh |  12 +-
 t/t5411/test-0026-push-options.sh             |  36 +++---
 t/t5411/test-0027-push-options--porcelain.sh  |  36 +++---
 t/t5411/test-0030-report-ok.sh                |  22 ++--
 t/t5411/test-0031-report-ok--porcelain.sh     |  22 ++--
 t/t5411/test-0032-report-with-options.sh      | 120 +++++++++---------
 ...est-0033-report-with-options--porcelain.sh | 120 +++++++++---------
 t/t5411/test-0034-report-ft.sh                |  30 ++---
 t/t5411/test-0035-report-ft--porcelain.sh     |  30 ++---
 ...t-0036-report-multi-rewrite-for-one-ref.sh |  90 ++++++-------
 ...rt-multi-rewrite-for-one-ref--porcelain.sh |  82 ++++++------
 t/t5411/test-0038-report-mixed-refs.sh        |  40 +++---
 .../test-0039-report-mixed-refs--porcelain.sh |  40 +++---
 t/t5411/test-0040-process-all-refs.sh         |  42 +++---
 .../test-0041-process-all-refs--porcelain.sh  |  42 +++---
 ...t-0050-proc-receive-refs-with-modifiers.sh |  42 +++---
 32 files changed, 726 insertions(+), 723 deletions(-)


base-commit: 3224b0f0bb7bc90c0156e73c58f1d2e770f0ad7c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-760%2Fdscho%2Fprepare-for-main-branch-t5411-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-760/dscho/prepare-for-main-branch-t5411-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/760

Range-diff vs v1:

 1:  f997166db4 ! 1:  9b1c7eb0b4 t5411: start using the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5411-proc-receive-hook.sh ##
     -@@ t/t5411-proc-receive-hook.sh: test_description='Test proc-receive hook'
     +@@
       
     + test_description='Test proc-receive hook'
     + 
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     ++
       . ./test-lib.sh
       
      +test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
 2:  b9fcc47eb7 = 2:  0667f18244 t5411: start adjusting the support files for init.defaultBranch=main
 3:  ca914fbc4b = 3:  cf2a378793 t5411: adjust the remaining support files for init.defaultBranch=main
 4:  ac2173cce7 ! 4:  6f1f1a9264 t5411: finish preparing for `main` being the default branch name
     @@ t/t5411-proc-receive-hook.sh
       
       test_description='Test proc-receive hook'
       
     --. ./test-lib.sh
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
      +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
       
      -test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
      -	test_skip="In transit for the default branch name 'main'"
      -	test_done
      -}
     -+. ./test-lib.sh
     - 
     +-
       . "$TEST_DIRECTORY"/t5411/common-functions.sh
       
     + setup_upstream_and_workbench () {
      
       ## t/t5411/once-0010-report-status-v1.sh ##
      @@ t/t5411/once-0010-report-status-v1.sh: test_expect_success "proc-receive: report status v1" '

-- 
gitgitgadget
