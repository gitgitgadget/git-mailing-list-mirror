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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F3C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505FC60E54
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhIUKZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhIUKZm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16158C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g16so37591434wrb.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5NiZ1dey39+kkiAnyp/BnURcm4AUhPyCNBo/a7YNbQM=;
        b=hVQ8W2hCEKcwGp8Wb+PDMOg9zLMU+hhjlcKHc7aEXn1lGe7XqjtLU79L8DNPNrfph1
         zcI8Ffj1t3nUWCOvJbSCiR1nBvZk2bjF4sYEy1aB+8gLO5aUUzs3ErTqsAn4lH1hYWRM
         HquEwmwK0TcpQkuOfHhzDJNAZrIMD0y+KEENQd/ouqzO27+J5POQJH2QRERVaeAW5uRf
         9tx1R61HQVGW9BcjUTgVOwpEhXgG/7AcsEeUiA+nme5cHOBsb7Snn4J6wRJnz/vYcGJH
         v82yy//v4yQ/LVsuvQWGJcKdsfNfnhplsmHNJvCkvhTKsjeoHhSkp1PDxdIcZ1Gk0Ici
         8b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5NiZ1dey39+kkiAnyp/BnURcm4AUhPyCNBo/a7YNbQM=;
        b=Z/tXfMJZlHxhBrMoaZkKSI9YdKRay9BuC7cfA4tHfVdW4rI9mCeV1QmhxCKmKkrgll
         b78eehC251bnDasixjQQywt2IiJumCnU6yorlkPB6MONePUUjLBz27cnYMqOhnyxJ/4a
         0SU4USgA1dvxZHFx8rN3wEY1+CysQZXx/9c8+Ii+wqvxRb5TvdgVU5rKT4GyxudFqj2d
         uU+1MX3HPmOQt0iBKr2h+dEEurmo9+oztVomhdyO/SjSYZBXwDkYXtibaC5Yx/f3Vdce
         d+PvY8n0IoJigrR4oRCwSJ523GbMlgHP0mSj5gkv+2WChr4r6MZtZH7lN6hEtmG/JCBk
         JVLA==
X-Gm-Message-State: AOAM530ihTK4RVMzR5fqpqNTlWp1riW5ksrBQqH51eB+gjYx3klvYl2w
        +PrME+CKEM9p9aPTr9YUWquFRnd3kS0=
X-Google-Smtp-Source: ABdhPJwDlXDXRmix4eJpk/7J5AMHO6XEHLexAsSTpC0Q71s3bf7GSnT4ZaIqnA2p0nJTI5zTIMw5qQ==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr3874620wmo.138.1632219852687;
        Tue, 21 Sep 2021 03:24:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm2405584wmf.11.2021.09.21.03.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:12 -0700 (PDT)
Message-Id: <61a37c89f1e97c00b28daf1ce7a0c4253ecec9fb.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:02 +0000
Subject: [PATCH v3 05/10] t3407: use test_path_is_missing
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

At the end of the test we expect the state directory to be missing,
but the tests only check it is not a directory.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 2c70230a4eb..7eba9ec1619 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -30,7 +30,7 @@ testrebase() {
 		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$state_dir"
+		test_path_is_missing "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
@@ -42,7 +42,7 @@ testrebase() {
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$state_dir"
+		test_path_is_missing "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
@@ -57,7 +57,7 @@ testrebase() {
 		test_cmp_rev ! HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$state_dir"
+		test_path_is_missing "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort does not update reflog" '
@@ -92,7 +92,7 @@ test_expect_success 'rebase --apply --quit' '
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
 	test_cmp_rev HEAD $head_before &&
-	test ! -d .git/rebase-apply
+	test_path_is_missing .git/rebase-apply
 '
 
 test_expect_success 'rebase --merge --quit' '
@@ -103,7 +103,7 @@ test_expect_success 'rebase --merge --quit' '
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
 	test_cmp_rev HEAD $head_before &&
-	test ! -d .git/rebase-merge
+	test_path_is_missing .git/rebase-merge
 '
 
 test_done
-- 
gitgitgadget

