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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A2C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B2461038
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhIUKZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhIUKZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B32C061575
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t18so37633186wrb.0
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V98N4KFFTGnu5SYXwIpcKyAHtNwzXMX0/pNnBaCO1p8=;
        b=mxivRz8W1CVrv32O6Oe11vhYaepclKSEjIP7HA0/HE8pwFRQgVgWP7eX0Mec6+RiE6
         JVHWMW9cZckP57M63R3ZLuE93bSluUjJQEiFgs66lDgR8Sejkf7CNv15smNU6dfFNGur
         ztTduX9zE2Fxy6zZzgsF5NozJ0Ryc91x6QyUn+TkbY56Hb2Ux0y+MkR0trnlpMhQli2U
         0zdXEIriYT4ms8zPoUPlffkyv+uyKWrKHiFCbLy9Jn7xW/shrA3vjB3mXUSwN621q0Gl
         0TUSKnE0vgK66IHOeAEgp2NAwynjLse94+FOgA1wT4ug6Zr0Wz1nli2LROe+DhR8K7CL
         9DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V98N4KFFTGnu5SYXwIpcKyAHtNwzXMX0/pNnBaCO1p8=;
        b=Fi7zIezXKmsohmAHrN1d7tsf5oBYnJa5zBKMiDDb6+uXSRSY9Fdxer3ElxwfQWdJEq
         UjWd+XVG4ppTWLHBIeV964AkngrzyieeY5xQFNOWjrUoY5zbPe6urpMOdXOX+4ptYLqd
         2qMCqtcPK7R7vxfU8SmtCe34BEGMDgJuJdgWz7F2TduY+5Dplk6wYCWlQcFNNC/ILJKG
         q87zPu97fBjFyotkNp4oqnexe8Yg7BFraDdQSMOQdvJTDaD0ixgiu9GfsGMSCBrGsB27
         mEtQHDPti98tjojM9Trrg17ycQLUk0RyT9Rf3kEHFbVcKVWz9wv3161Yxz5codTMnfpG
         itgQ==
X-Gm-Message-State: AOAM53343i2eA4QXqVMUC21XC7y2MlcVHrzvswuqFudmcZERAHiiRmSf
        NMGxtGGgjzKgFBjEypEnw0z7QzNUNDo=
X-Google-Smtp-Source: ABdhPJzGnDk5Ltqmkg5/l+6KrsoLi6rmwa75HSJrIK0ZQ9Z/f+bP1Sl7tDMyh5CugRQT9219qNPv5w==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr3669245wmh.193.1632219852067;
        Tue, 21 Sep 2021 03:24:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm18854449wrz.39.2021.09.21.03.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:11 -0700 (PDT)
Message-Id: <38eee11baf580adbef406cd776551dda012c8b4b.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:01 +0000
Subject: [PATCH v3 04/10] t3407: rename a variable
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

$dotest holds the name of the rebase state directory and was named
after the state directory used at the time the test was added. As we
no longer use that name rename the variable to reflect its purpose.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 39076ac9462..2c70230a4eb 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -21,35 +21,35 @@ test_expect_success setup '
 
 testrebase() {
 	type=$1
-	dotest=$2
+	state_dir=$2
 
 	test_expect_success "rebase$type --abort" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		test_must_fail git rebase --skip &&
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
 		test_must_fail git rebase$type main &&
-		test_path_is_dir "$dotest" &&
+		test_path_is_dir "$state_dir" &&
 		echo c > a &&
 		echo d >> a &&
 		git add a &&
@@ -57,7 +57,7 @@ testrebase() {
 		test_cmp_rev ! HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$dotest"
+		test ! -d "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort does not update reflog" '
-- 
gitgitgadget

