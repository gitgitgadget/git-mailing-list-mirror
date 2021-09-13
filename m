Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058BC433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC3C610A6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbhIMPq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A53C0A8892
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g16so15320896wrb.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9NpwjDFGHvgVsT0BcjST5Xoig7LqC/kMtL9l2s32FLU=;
        b=En48kPN+3urKpvRYggB0JAuqN9grqxwzWB7ztanFJ08sNH3DcBpg6gCD2zES0GdPXp
         ZilbEakFVjtVu2b+1hucwbtERjgpr5higS4klF+g0uDayNKms+hOXjRR09Q15RqRkAko
         lx+eaHgVAboHlIrlrYO+5UHmPW5fCpTXeigwtAsuXEfEjrH/y2Mw5A+r/b5OoLIUM3JX
         a/eMBKWpFxakTSIhF39MHWH2sEV/tpBISYCsdyTpFGQRTn6NlWYQ4Pin0llS4zPryDQQ
         gbfwFREhLbVZbYTTIXM5mLYCjCL3tPamnr0Jux1kogWU3AtWSgZKx908H1ygJ7uDsrd4
         37xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9NpwjDFGHvgVsT0BcjST5Xoig7LqC/kMtL9l2s32FLU=;
        b=K0eTnDittWVsmIaHQw7AVeuELqq31Cv+MSIveL1z9U/wTGugb70G2WyJtYo7rcV2nu
         f9/r7sgHjLFjAXoD7mp5l3LXyekB0bJUciwHc3iQstOUjHxJtyrQpQN6k5oob0FHvraX
         WXuMWqnbpO+7WPyIdEqik+E2pbTujllP8cLd1gNSgbtebjWBt00LKkN7KpHqvBx1PRCo
         LIYs2yFwYkCqfzkypgn52Un/uGrlzVk60ZggomSidiy4GKXQnt/jCKfY/LSCtxPmJvjb
         dyZIqJU4TSDBSZiLlHxSON17JHCmu1x2m+GjhXx6rT96dk8hCicfQjyPfVcNQQEe+RUN
         i3BA==
X-Gm-Message-State: AOAM531CaJx7zxWbboOBLjFpWgxW/Q2sRAhG5FeJ5tLmtdldMoc3VMjM
        861rWNwPHYtFVA2HetaWy000el68pr8=
X-Google-Smtp-Source: ABdhPJyFmdLidi1SXeioF4fR7oPYKbpFGG2WP7r/9F4pC1NZZtGdBuR6bon8eYqDYMCFIxKDK8+wnA==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr13360803wrm.235.1631546366059;
        Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm5655475wri.53.2021.09.13.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:25 -0700 (PDT)
Message-Id: <7755ce17fef90729275334a735d31a348a0ddbc0.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:14 +0000
Subject: [PATCH v2 03/11] t3407: use test_cmp_rev
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This provides better diagnostics if a test fails

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 0ad21966bc5..39076ac9462 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -29,7 +29,7 @@ testrebase() {
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$dotest" &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test_cmp_rev to-rebase pre-rebase &&
 		test ! -d "$dotest"
 	'
 
@@ -39,9 +39,9 @@ testrebase() {
 		test_must_fail git rebase$type main &&
 		test_path_is_dir "$dotest" &&
 		test_must_fail git rebase --skip &&
-		test $(git rev-parse HEAD) = $(git rev-parse main) &&
+		test_cmp_rev HEAD main &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test_cmp_rev to-rebase pre-rebase &&
 		test ! -d "$dotest"
 	'
 
@@ -54,9 +54,9 @@ testrebase() {
 		echo d >> a &&
 		git add a &&
 		test_must_fail git rebase --continue &&
-		test $(git rev-parse HEAD) != $(git rev-parse main) &&
+		test_cmp_rev ! HEAD main &&
 		git rebase --abort &&
-		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
+		test_cmp_rev to-rebase pre-rebase &&
 		test ! -d "$dotest"
 	'
 
@@ -91,7 +91,7 @@ test_expect_success 'rebase --apply --quit' '
 	test_path_is_dir .git/rebase-apply &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
-	test $(git rev-parse HEAD) = $head_before &&
+	test_cmp_rev HEAD $head_before &&
 	test ! -d .git/rebase-apply
 '
 
@@ -102,7 +102,7 @@ test_expect_success 'rebase --merge --quit' '
 	test_path_is_dir .git/rebase-merge &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
-	test $(git rev-parse HEAD) = $head_before &&
+	test_cmp_rev HEAD $head_before &&
 	test ! -d .git/rebase-merge
 '
 
-- 
gitgitgadget

