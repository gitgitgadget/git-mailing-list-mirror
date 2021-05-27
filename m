Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D5C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1B061028
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhE0Ezd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 00:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhE0Ezd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 00:55:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3BC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 21:54:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 16so1899245wmj.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 21:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=u6XGzUx9hOGvHesZPNWVM0j4F4gzcBBLrhH5uoIxoQw=;
        b=GOGr79v8IA/9cS+49KworXYWTmXiggO7tKl5F2+hf8psM90gK1JlKr2WtwmLPe7oWB
         CQvV+M5jvGGmqTYiw4ENwUeuG5dDSPSXpFbRm0ZjUGpcpMADjxvehVRpwVLdm0D75kbr
         RBxDS7qh+nIP0SkeK6F6psEbqE7+ZfXVzG8+2qlfArrIwfP6DA9nYaTTVVx8NAj21RiV
         PH6MvgW9Znhp1prMYqL79bsLgk3A4vgjhrk+cd4qmnQermubm/MbT6KQSlzZ4/PySa3k
         KnwmsAI9rpUqMtnU63ryKXcO5J2hQouA9153OAdaal7qhefkl6Drn/2fKsxkmTkkB3yB
         Cegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u6XGzUx9hOGvHesZPNWVM0j4F4gzcBBLrhH5uoIxoQw=;
        b=C5bU6zTzass8wZmiH6hFpkRi6NTY0/IUumjjZqwuacPIgZEQM9LuB2tVf+cAxNJa/z
         ++Au+sn/Tej/VaYAymXvUNR4lwCHsYV1862op4zxUCMgDSRMwRVtHbvxH8BXmxq1dxPN
         a3xKOaKhmTBnl1oOrhJDLR7KdlAo5Knkou0JRJyCPEXW6XNbw9v7KQeYeBACXxQfX1wU
         dJXWI2KgqBehC3atQL19DRf7V/9rCjLLItnvQuh42Ey4d+RmWb1M1y1qeoWTFkbL5uL1
         utZDpwxihTbf5sQTHZK4Vht7i1J6DVA0y0lSfGy8y8cqN9oJKnaMKnlOUw+/bhhzQfTb
         wAww==
X-Gm-Message-State: AOAM530IATyyHcYxyZQZVN6k+e7J+1XJ21t4J8ODj/JgHuMfW5DpXsJu
        CiNubxKKH4t4rIhMIMKws5NXqr1Eybo=
X-Google-Smtp-Source: ABdhPJyDmMBYdANHpgLyPEX3zMCCOkv2j+rz66MSZil9Gg7pFZa23jjjVtm8imwetXEYAB1qjbdh6g==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr6399214wmq.137.1622091238839;
        Wed, 26 May 2021 21:53:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm1297465wmg.10.2021.05.26.21.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 21:53:58 -0700 (PDT)
Message-Id: <pull.961.git.1622091237.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 04:53:54 +0000
Subject: [PATCH 0/2] Directory traversal fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of the final two patches of my series, as per
https://lore.kernel.org/git/xmqqfsyht49j.fsf@gitster.g/. It will not merge
cleanly unless the last two patches of en/dir-traversal-fixes are first
reverted, as Junio suggested he'd be doing.

(Corrected Reviewed-by -> Signed-off-by in the first patch, minor stylistic
fix for the second.)

Derrick Stolee (1):
  dir: update stale description of treat_directory()

Elijah Newren (1):
  dir: introduce readdir_skip_dot_and_dotdot() helper

 builtin/clean.c    |  4 +---
 builtin/worktree.c |  4 +---
 diff-no-index.c    |  5 ++---
 dir.c              | 38 ++++++++++++++++++++++----------------
 dir.h              |  2 ++
 entry.c            |  5 +----
 notes-merge.c      |  5 +----
 object-file.c      |  4 +---
 packfile.c         |  5 +----
 rerere.c           |  4 +---
 worktree.c         | 12 +++---------
 11 files changed, 36 insertions(+), 52 deletions(-)


base-commit: dd55fc0df15c338a8dbec6dec6ca6b58edc8acef
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-961%2Fnewren%2Fdirectory-traversal-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-961/newren/directory-traversal-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/961
-- 
gitgitgadget
