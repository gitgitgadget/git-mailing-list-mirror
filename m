Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C890CC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA24F61139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351278AbhIHJuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348657AbhIHJug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58951C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so1066547wmq.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ee4k5bVEDCDcLzkDmF80K5D0JVWDg2Ihfroij4uub/Q=;
        b=e+4NmAB3Md1DHHoI4c/nOCPX5FRJJAzHr/kjdfsIdQm3XbBB8D8VUNbpQ9tYomIvzH
         OSZ91uvF4SXj9y8j00IA+N5x3mQS50Ew85tI3CxX6Pdv1z6f38yYTj4UC8WHJEzAALYm
         SZR6rVzhpE/8RckhZesM1HKssbdJO7TBnqop/PmA5g7twTWFvKbWSvR8R55fxFsBUirL
         c4uhfQaGGYROvCwno4mSkRKOPTP/6MAcnNAU2cXYsxX+UJ5ywKzMHkMfEjVVb5/Lap1r
         lsqFewl1ChyX2ciZqOkHfHMOtoZ+qDVRpCUtQaPz5he/Pl/BLATSGwiNwG47DK8N+5RM
         vZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ee4k5bVEDCDcLzkDmF80K5D0JVWDg2Ihfroij4uub/Q=;
        b=WUwjPgpbyQ1W8qTdp7JDDCYZwV2zaE8iwlNoi0dVLgKLvhHICto4N7DKrDaV1jFyzE
         BATeRD6FNDa1fIvxcmfx9xXo8RP5zigvsU4o+sPUGAkoKXI8LuIFoWx8fuHWu03VMFAi
         D8YVuAiDT9G9P7sggHLJXhbKvpKVwvZoRLQjthcJKEtF063pKJWi72mnoAFcKewDDnkW
         J/cOz2YARZgTwxrnwb63DRB4OC+nKBNVo24+wgYQanrnBDExavCC60+7IISSED/ABgxi
         CTv0V4zsAr98B63Pdwn/fn8tvV0ytatAF6Y2HJvlQIs14YCvEHv8sAc0qDTzDZtkcedP
         HuAg==
X-Gm-Message-State: AOAM533gjoQ26CGStX81yivxYJdQntCEL78RPdQxGOF4fuIx3HD4KiH6
        DssPomNnTYITC5LF3jEB0LcDIxO2UxA=
X-Google-Smtp-Source: ABdhPJweWqswm4IfJwPUMdy0RQXH719IMqIZOP6H/KcwAgzK33+y+IdmnnvZGXfDlMvhIAEr+/rdwg==
X-Received: by 2002:a1c:a713:: with SMTP id q19mr528468wme.42.1631094566942;
        Wed, 08 Sep 2021 02:49:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm1631391wrs.60.2021.09.08.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:26 -0700 (PDT)
Message-Id: <d9376fe08183af70eeb0ba0ebf6300af70cb51a8.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:16 +0000
Subject: [PATCH 05/11] t3407: use test_path_is_missing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index d36a3f2758b..624d2ee3fa4 100755
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
 		! test_cmp_rev HEAD main &&
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

