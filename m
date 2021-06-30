Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED74C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA69A6147D
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhF3Rce (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhF3Rcc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:32:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A9C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p8so4655228wrr.1
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F2XEH9D106024tJoiOKsG7Mwa4Z9oAW33kNiKFCWxvE=;
        b=vQDDUVNxfDPZLbX8n65UCWRdOsXnvnxgoj4dBhFxHQTg4geGgd1WoWKtD1uF3ivWpy
         BsflY0I86CY75tdPhMZfz248iHXtVaXMHKd1uQAawcpv88XSJQy2QQAjWDQgiPcVwszZ
         +FZyxlTUiSkFj3VRbq9hohs42w6N5yAseo9yVcnck8Jxom7AJzFbEC09OsiPuG0Im0af
         YnWD5P9B0FSmGLEatxyNi/zqb6u9VtxEkaPM/nv5timjV7gMHOkYBVOBxKR7pYpSJokp
         e70kGvsowPbczD3eFpSIP3/tzc6998OzbLZTD8CeVmLZCu51o5CkX3sxGGF7IwbFaWeA
         J8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F2XEH9D106024tJoiOKsG7Mwa4Z9oAW33kNiKFCWxvE=;
        b=BewXSrLMS2LuuiL69yW88x/uiJYrPDy3v2ZGPJUIi+7usAmFxNL3J0zndvHr66RFTr
         0DFhcMfoRHSMpUAyjNfqTsU9R1t4meS9YQpUTO42EK+Df4dnKy7pF+BC1W56VM/5UqS/
         B3it5DtM03mS0gSM38w70FZxCr2ktkGjxIxvjNmHysecFWPjQ7f5n8Wovew++8xcc7AB
         27P3DUAvnZ8ViPAsiLuRdDiGULZR4SH0FTGI0ZCAIBgOouCnU2WvdvTzj3i19686GY+k
         4gXmPvqk5wDVFNki9IEJAmtR3Vbw3lBrkeOvtaBi1hCeOE2kt8AFRGSIke374nE2JDR2
         Qcnw==
X-Gm-Message-State: AOAM533aEAYn4tVE3BgzDKKR1b41paGtMBCuFITW5Yw1SkNlq/E0L/RA
        z9CWtcSDqmUzm1wqyYDXehECoDLuppQ=
X-Google-Smtp-Source: ABdhPJxxp3QqO2S+CUNGLltnbBavSEPYERmB+2LFUF7EcmttuqC6msixYlkUB3FxL5j5jYBtmGFSDw==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr36634060wri.10.1625074201811;
        Wed, 30 Jun 2021 10:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm7230182wmq.0.2021.06.30.10.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:30:01 -0700 (PDT)
Message-Id: <pull.1039.v2.git.git.1625074200.gitgitgadget@gmail.com>
In-Reply-To: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Jun 2021 17:29:57 +0000
Subject: [PATCH v2 0/3] Fix bugs from interesting renaming pairs: one side renames A/file -> B/file,
 the other B/ -> A/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg recently reported a few issues in an interesting rename
case[1]. I was able to duplicate and find multiple bugs from it; two in
merge-recursive, and one in merge-ort. This series has some fixes.

Changes since v1:

 * Added a third testcase

[1]
https://lore.kernel.org/git/CABPp-BGDfucqae=HNES_QmmsjpDbdHrR6CG=H3gtiDygHzquVg@mail.gmail.com/

Elijah Newren (3):
  t6423: test directory renames causing rename-to-self
  merge-ort: ensure we consult df_conflict and path_conflicts
  merge-recursive: handle rename-to-self case

 merge-ort.c                         |   6 +-
 merge-recursive.c                   |  19 ++-
 t/t6423-merge-rename-directories.sh | 175 ++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+), 7 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1039%2Fnewren%2Frename-plus-dir-rename-cancel-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1039/newren/rename-plus-dir-rename-cancel-v2
Pull-Request: https://github.com/git/git/pull/1039

Range-diff vs v1:

 1:  d3572e8bc85 ! 1:  86b2eaea75e t6423: test directory renames causing rename-to-self
     @@ t/t6423-merge-rename-directories.sh: test_expect_failure '12h: renaming a file w
      +		test_cmp expect actual
      +	)
      +'
     ++
     ++# Testcase 12k, Directory rename with sibling causes rename-to-self
     ++#   Commit O: dirB/foo, dirA/{bar, baz_1}
     ++#   Commit A: dirA/{foo, bar, baz_1}
     ++#   Commit B: dirB/{foo, bar}, dirA/baz_2
     ++#   Expected: dirA/{foo, bar, baz_2}, with conflicts on dirA/bar vs. dirB/bar
     ++
     ++test_setup_12k () {
     ++	test_create_repo 12k &&
     ++	(
     ++		cd 12k &&
     ++
     ++		mkdir dirA dirB &&
     ++		echo foo >dirB/foo &&
     ++		echo bar >dirA/bar &&
     ++		echo baz >dirA/baz &&
     ++		git add . &&
     ++		git commit -m orig &&
     ++
     ++		git branch O &&
     ++		git branch A &&
     ++		git branch B &&
     ++
     ++		git switch A &&
     ++		git mv dirB/* dirA/ &&
     ++		git commit -m A &&
     ++
     ++		git switch B &&
     ++		git mv dirA/bar dirB/bar &&
     ++		echo more baz >>dirA/baz &&
     ++		git commit -m B
     ++	)
     ++}
     ++
     ++test_expect_merge_algorithm failure failure '12k: Directory rename with sibling causes rename-to-self' '
     ++	test_setup_12k &&
     ++	(
     ++		cd 12k &&
     ++
     ++		git checkout A^0 &&
     ++
     ++		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
     ++
     ++		test_path_is_missing dirB &&
     ++		test_path_is_file dirA/bar &&
     ++		test_path_is_file dirA/baz &&
     ++
     ++		git ls-files | uniq >tracked &&
     ++		test_line_count = 3 tracked &&
     ++
     ++		git status --porcelain -uno >actual &&
     ++		cat >expect <<-\EOF &&
     ++		UU dirA/bar
     ++		 M dirA/baz
     ++		EOF
     ++		test_cmp expect actual
     ++	)
     ++'
      +
       ###########################################################################
       # SECTION 13: Checking informational and conflict messages
 2:  052f40c3c1a ! 2:  6e7ef18bf53 merge-ort: ensure we consult df_conflict and path_conflicts
     @@ t/t6423-merge-rename-directories.sh: test_setup_12j () {
       	test_setup_12j &&
       	(
       		cd 12j &&
     +@@ t/t6423-merge-rename-directories.sh: test_setup_12k () {
     + 	)
     + }
     + 
     +-test_expect_merge_algorithm failure failure '12k: Directory rename with sibling causes rename-to-self' '
     ++test_expect_merge_algorithm failure success '12k: Directory rename with sibling causes rename-to-self' '
     + 	test_setup_12k &&
     + 	(
     + 		cd 12k &&
 3:  dea97c25e52 ! 3:  7c96d6c7a0a merge-recursive: handle rename-to-self case
     @@ t/t6423-merge-rename-directories.sh: test_setup_12j () {
       	test_setup_12j &&
       	(
       		cd 12j &&
     +@@ t/t6423-merge-rename-directories.sh: test_setup_12k () {
     + 	)
     + }
     + 
     +-test_expect_merge_algorithm failure success '12k: Directory rename with sibling causes rename-to-self' '
     ++test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
     + 	test_setup_12k &&
     + 	(
     + 		cd 12k &&

-- 
gitgitgadget
