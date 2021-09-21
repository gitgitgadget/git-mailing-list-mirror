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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F2C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB746109E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhIUKZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhIUKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4631C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so30576203wri.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9NpwjDFGHvgVsT0BcjST5Xoig7LqC/kMtL9l2s32FLU=;
        b=FakvKT5FzFvT7rRrtE06mSRaT9mSnbNXPEIvs/plA6GqtINAGieQ6aivgkXQ4hKkN3
         +VBcIoL7RGuJpvGejQetDqrDUR12dk2rYWG62OHtrSfN0Pt730BZ01oV0X9s+q5czjEV
         ChE3OC9cuPSw3DTUbqE4U5Unp73BkS+A6RvaA3U0l1ApQ/nwLjqnXTOiT2GJLg9W3UIv
         H1UnnOEL1TcfiSg4yBegqMpX05nqOnp1i5BJ+G/wU3GQ07Xd59zeEdLDYEmjkwohz3Y0
         ikKnqi72jHd8/baD52khI/KTePLfvJvAg7pwQ+rchoRxE2KYZNLH4U806uUGKEhNrKGD
         ZkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9NpwjDFGHvgVsT0BcjST5Xoig7LqC/kMtL9l2s32FLU=;
        b=bDruhTfMtl6KOqW8NKl1gS+SomOGs+n3aduvuy0f/tgVcV/hWhnYDlMOaouM9jrbcG
         /ggu0FO/OORBfW+/5A4eqIX+0NuBy3cdEIPG1Ec5D1U9ffjK21RohA/NZRXVIeCVIpK5
         EGO755kDBj/r1W/vIf5cnHqQKjoUEvgPvEoaL/EfDUPVdF5igfq3dt7ty8vJGeYF+U3W
         ihNr0pkX6NyreLzZtQBk8lVz4poKpXlZEqIHh5YXZpV1Q2dAsLozNJimfexmQ0jI9og8
         R1xQ/GPILQmaXD3TumbPfhW/4F2NFize8HZcC8M5Eyf9dUi1e/FncULLI8SvDtwhXltf
         WsQA==
X-Gm-Message-State: AOAM531PCuTI/Jqz4noTFe143oenlts1N2Lz+X3ZC/uBtw98dDB5xYc9
        dJ+sBzHYPbMteK2ntRGJmzGhy18xBZ4=
X-Google-Smtp-Source: ABdhPJxHGdgHV+A2IDZGCTI3rhYNMNmozIHVXOgufikRdKfk1pjLZ1gWYAP7wTiHXcr3MZW7grfWfQ==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr34624930wru.76.1632219851286;
        Tue, 21 Sep 2021 03:24:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o26sm2385612wmc.17.2021.09.21.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:10 -0700 (PDT)
Message-Id: <7755ce17fef90729275334a735d31a348a0ddbc0.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:00 +0000
Subject: [PATCH v3 03/10] t3407: use test_cmp_rev
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
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

