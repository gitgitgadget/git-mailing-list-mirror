Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDEEC388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CF8206F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 19:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2vZV6qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgJaTqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgJaTqK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 15:46:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF263C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:46:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d3so5823329wma.4
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9+JeKg8KCGC1nFbWiGvOgBcCPpUC/7LCbZeo9igdRqo=;
        b=S2vZV6qETTNhh3qjjtt+zBkNkpMhuOuBNPyyQeBCq5euBHlZm62Rlz4oK689pH/3/G
         vcUS9HiDlEXVEypCfcABlEHDuF8M1xgN/zWq22pnngGpXBpSsYK2Jydw8lNCZifCiCF1
         PIGe0khMwDGhrTvBtxxXf89IqG/27kVqJpB6Tdbjjm20jUAFNrhrg6qS2r5u1gqb3mcN
         6nuDqcUcOjRsYxGOWxn5YTr8mhT1WuX1o780s7xl08csItbO1SKzMDZVTgk16yhjD/Px
         KQp0yIK2qfSVHpNqxNF1gnV1KX533fmypmQorPUXQhGZMur9PZPkAAoCG1XXRYTGCtU4
         TJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9+JeKg8KCGC1nFbWiGvOgBcCPpUC/7LCbZeo9igdRqo=;
        b=P/w0p6LDP8Cxwsk+VhXfNDrqebNgs4j3aqFICWxI23Dr0VwJRQX27A+hF6i6f0RmOZ
         BbwYB+WzUak7XM4NZcQ1gYNFEOjdSgJ8UgorbWOKL0SVnmHFa4qdXhKwmq5VdQdi00lp
         xpBswxPZbfo8vWWktmh3XGPWDyVQNYC6dRvKA22T74p42y25tJ/xSXowSeeg8B2JeQIF
         Rz/sTI7pod9kwX+aym+SoeP6fiDM3DZ5im7giFnr3BOx1sf952knpLbz98pVv7bSGxqV
         xLZA5+odJlHTX4+iPCvH0CcyJ5n0yOvGWTsUSv8tDyEZ8dETxYDbq+Z80vwpH4aFeY6u
         xQbg==
X-Gm-Message-State: AOAM531k8PKCswmzHcU0HESFiEFz0lwntJ9X11FIPJ1+RnyjOPWA0iyx
        N8cDaRXfRNMEZkrtBmgIuxr8q/dNWiY=
X-Google-Smtp-Source: ABdhPJwY3PFeyw7rVo1X3ofzUq6N2WIqXBw4o6HaxREsqboJceXCmTXpX2uQpq7X2LGOwiE7mPCc1Q==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr2022135wmc.36.1604173568486;
        Sat, 31 Oct 2020 12:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm15015907wrw.36.2020.10.31.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 12:46:08 -0700 (PDT)
Message-Id: <6f1f1a926460a836aa6fa169e67a3545c1451d6f.1604173564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.v2.git.1604173563.gitgitgadget@gmail.com>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
        <pull.760.v2.git.1604173563.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Oct 2020 19:46:03 +0000
Subject: [PATCH v2 4/4] t5411: finish preparing for `main` being the default
 branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In addition to the trivial search-and-replace performed over the course
of the previous three commits, there is one test in t5411 that depends
on the length of the default branch name.

Adjust it and use `main` as the default branch name in this test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5411-proc-receive-hook.sh          | 7 +------
 t/t5411/once-0010-report-status-v1.sh | 6 +++---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 6da6f597a5..98b0e81208 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -5,16 +5,11 @@
 
 test_description='Test proc-receive hook'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
-	test_skip="In transit for the default branch name 'main'"
-	test_done
-}
-
 . "$TEST_DIRECTORY"/t5411/common-functions.sh
 
 setup_upstream_and_workbench () {
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index 6005ee0ecb..cb431a9c91 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -69,11 +69,11 @@ test_expect_success "proc-receive: report status v1" '
 	proc-receive> option forced-update
 	proc-receive> ng refs/for/next/topic target branch not exist
 	000eunpack ok
-	0019ok refs/heads/main
-	001eok refs/for/main/topic1
+	0017ok refs/heads/main
+	001cok refs/for/main/topic1
 	0016ok refs/heads/foo
 	0033ng refs/for/next/topic target branch not exist
-	001eok refs/for/main/topic2
+	001cok refs/for/main/topic2
 	0000# post-receive hook
 	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/main
 	post-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic1
-- 
gitgitgadget
