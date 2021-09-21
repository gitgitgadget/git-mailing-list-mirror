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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E029C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F187A60E54
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhIUKZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhIUKZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DA1C06175F
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so30576652wri.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l/Jg8R6yAzj1NDGUukkEEPk+umccBmF3EC0FZvsVKYg=;
        b=PuyzvOpluRFslMLMZs0wa3Al3rZEl+3gHlSltBLDFcM9z6oGGg8StSluJducD9wHTg
         DpI/MZDkv7mS4n+I6x4vAHR6ItlWTQHUoRPrZqjLW5HL3RD3HJZ8bWWQUwHJP/EPO8+1
         XKQkwA8s2kd3s3QzH8xmkN+8uC/9ehmHFOEg1LhQbXcPTh28TmfAd6+u9bMtftoaGx4z
         TAxP65D0gZb8/LB49NltZZG8sUXMpT3nd4urBS1nmZqfsdJ4VP30rOl182lCAf7T3tuB
         sBHiMrhvPZ1BEWxdCNK4Z/dVuEcJFcQ9CDBPVaqvfAN+Vgdbg5MSEoXWri/moTZrji5G
         Yvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l/Jg8R6yAzj1NDGUukkEEPk+umccBmF3EC0FZvsVKYg=;
        b=xMz9kg8MMkUbWFOzW+cJprXpRUCtW6QwsyVok81Da0scks9MiVGny6bzwgPOlLefkl
         R8/07FbLKNRA1xNRAE5yAyoJVorlbiOfDenjd+LFNtyNamxzTCD0DWXEV2IfSm/juWKx
         9MzuHaSncuKFeySg7Au4SJv6oJo/qkdTRV1rkfKccIbPRdofhudrMflqtZgdWDn9lLtY
         p/wsvrPIvti0wt0TSDGdNaSoF4C1EyDt4rzkdfBHrIstii6WtluLsqcNgeb5zP5CZrXn
         JFWgFWVNCdZ1hVrk8k/dGp1MoY/PjHly/wZ091/sZyx+UEfFmcb851Tlxta58KFgESJG
         D9aQ==
X-Gm-Message-State: AOAM530MImeAni5+Ea5MORCNHKBI3928jLK/QZEGs4dsH+QXB1mFYKdH
        3cbP8BF32BckgkevtQYqXbm8sO8iBng=
X-Google-Smtp-Source: ABdhPJzjMSLW4mU0K3eRsTNbLA7THgrl1Jjl7P/7xRyTYEQWYnTPQIc91nFtsV4PalkKQSIk3dvYzA==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr32487911wru.23.1632219854045;
        Tue, 21 Sep 2021 03:24:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm6550213wrn.77.2021.09.21.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:13 -0700 (PDT)
Message-Id: <fd55a3196b16a2746cdf8ba374c0bbe1bc78ecbc.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:04 +0000
Subject: [PATCH v3 07/10] t3407: rework rebase --quit tests
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

9512177b68 ("rebase: add --quit to cleanup rebase, leave everything
else untouched", 2016-11-12) seems to have copied the --abort tests
but added two separate tests for the two rebase backends rather than
adding a single test into the existing testrebase() function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index f8264449b6c..162112ba5ea 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -86,31 +86,21 @@ testrebase() {
 		test_must_fail git rebase --abort -v &&
 		git rebase --abort
 	'
+
+	test_expect_success "rebase$type --quit" '
+		test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type main &&
+		test_path_is_dir $state_dir &&
+		head_before=$(git rev-parse HEAD) &&
+		git rebase --quit &&
+		test_cmp_rev HEAD $head_before &&
+		test_path_is_missing .git/rebase-apply
+	'
 }
 
 testrebase " --apply" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
-test_expect_success 'rebase --apply --quit' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase &&
-	test_must_fail git rebase --apply main &&
-	test_path_is_dir .git/rebase-apply &&
-	head_before=$(git rev-parse HEAD) &&
-	git rebase --quit &&
-	test_cmp_rev HEAD $head_before &&
-	test_path_is_missing .git/rebase-apply
-'
-
-test_expect_success 'rebase --merge --quit' '
-	# Clean up the state from the previous one
-	git reset --hard pre-rebase &&
-	test_must_fail git rebase --merge main &&
-	test_path_is_dir .git/rebase-merge &&
-	head_before=$(git rev-parse HEAD) &&
-	git rebase --quit &&
-	test_cmp_rev HEAD $head_before &&
-	test_path_is_missing .git/rebase-merge
-'
-
 test_done
-- 
gitgitgadget

