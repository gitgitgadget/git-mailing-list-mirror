Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED1C433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB28206D8
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEx2le+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgHHRBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgHHRB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FEEC061A27
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k20so4581890wmi.5
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v/YrnIQx0Qjh+uN3OIOcV92pi53pOcv0u9rwLWldDJs=;
        b=CEx2le+Bk1nms7ngUFjqkFWNe0eK4Ex+rIGtHAP7KPWlp3WqIjn+OnZDwpJRJjXi+j
         WKzYm39FFcJ703lUeemXsNpC6NGlnnlk/kl1h3zKLjODCFEabcODjl6Ls+T2H9iR4onO
         8j3QcHdxKPa0qUXfykaqYogjW2xN/yoaPo8o/0iWTZxoxKg1usUkL24OCxkpWuSz1z4O
         19xy89AtmficTlBzPfBnI+/J7+HQGcB3GSqmbaLIjVkv1nZ423vlrYjF9HAqFyXEydRI
         Ic/ArcbsYGFDUfl9hsH6JSfgosGUa/fB9tNjl6PpftcVueYWnmkFDJiAA73R5ktxiUs1
         N8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v/YrnIQx0Qjh+uN3OIOcV92pi53pOcv0u9rwLWldDJs=;
        b=AEd70Ya+wNrAiN9wvbzo8R967X0EbPzlElMY0mk1XNeRkr9Xu9OCqb8L4SB2sORbE8
         Rdhk9KTEhlJZpHYtG6QH51+b9nSqoGizue0YJVDJ3aDtBwtBQmWXSkCFZrwq0XpxpUsf
         NzOuwc8mIYpz6vSjfqHSD9/hu9FNOcUN+NjFWlFz6Mi5PErlls2f4a8IPaaLz3o3Coaq
         e1VDjSgRT0QzmNNSueK8dfeRp5PhioiUss+FZSc9yV9YvsQMKY6aznHTJTZ+yod50CPG
         Fg5G5GHOFoCL5g86rbiv8PIl4coUOpRutlqMfV306VKT33KEqSM8h5wy8+7mGiSKO+he
         meUA==
X-Gm-Message-State: AOAM530tNrkdn1XvmyVS6MCEO75bhsRDuMkkUbIR2cYehgntZhsaUrKg
        XnWClUdQGSc2cRgygglnLg7BD1xL
X-Google-Smtp-Source: ABdhPJyHB/tIaK6t1FNaYMVtACenRFdCbsDv838gEUwARiMU+Rx9+Dum3lTHW6JIyfGXmjBauBtfOg==
X-Received: by 2002:a05:600c:2d1:: with SMTP id 17mr17544935wmn.15.1596906087307;
        Sat, 08 Aug 2020 10:01:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm14352070wmb.11.2020.08.08.10.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:26 -0700 (PDT)
Message-Id: <382d65649dc1d8abdd1c3f0f4a4af67f42f43731.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:14 +0000
Subject: [PATCH v2 05/11] t6423: fix test setup for a couple tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit da1e295e00 ("t604[236]: do not run setup in separate tests",
2019-10-22) removed approximately half the tests (which were setup-only
tests) in t6043 by turning them into functions that the subsequent test
would call as their first step.  This ensured that any test from this
file could be run entirely independently of all the other tests in the
file.  Unfortunately, the call to the new setup function was missed in
two of the test_expect_failure cases.  Add them in.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 83792c5ef1..d227e15944 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -2880,6 +2880,7 @@ test_setup_9g () {
 }
 
 test_expect_failure '9g: Renamed directory that only contained immediate subdirs, immediate subdirs renamed' '
+	test_setup_9g &&
 	(
 		cd 9g &&
 
@@ -3362,6 +3363,7 @@ test_setup_10e () {
 }
 
 test_expect_failure '10e: Does git complain about untracked file that is not really in the way?' '
+	test_setup_10e &&
 	(
 		cd 10e &&
 
-- 
gitgitgadget

