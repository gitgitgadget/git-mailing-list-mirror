Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C20C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7142A21D7B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL6kHd74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437310AbgJUJJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387803AbgJUJJH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 05:09:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1BCC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 02:09:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n6so2058454wrm.13
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dPh9dK7wZ5qCOQeG9RxzIyb9j0OngXdOddpT56CtRp8=;
        b=bL6kHd74//T9FDHY61B1Xt0t+I9eV+ivE8xt3PRe65CrpRuip3WjfB5uGp7s+r9kRC
         XQOMWmkULfTM3YGT9hVNLjS1nkcyXnLPuzKPXCUvUDTsh4e7ED7un9/x8ju24aFAU1xc
         E64U8NLIa592UaY7SVK8U+xJf/+Pm4UUztwuu7kIeSV1Vec2r8FB22HlstQQNTYU5edq
         AUs6SHiIYxgvmc5TsGYTpuz3hBS5fRfegd9GL0xGP5D+3YOfEzqrZn2urYHEnptI63jF
         SH/niRNmG0JwXb9bNerNW2KB2/mt9OWkrWU/W+VH/9FLXd/A1CEc+9B6LV7Y1OIU0MJm
         cYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dPh9dK7wZ5qCOQeG9RxzIyb9j0OngXdOddpT56CtRp8=;
        b=ADn1P7ZO7kbFetaMUJwZjy3+7w+MAFRkp70fCmGc9C5d1Ib9IGtxxJ7VoHYMgPoZtG
         FVDBXCcb7Q5Cfw1wxhb7SvmJiMsQ7sdEepA9t5Eeb5VVQmJzeXA8Tb9Cm+t9zdOUlyL+
         6Rn15wPXBzXc04geh1y5dD323B89XlUS9W+BxPJvCz55FPtjoHAGRaykirJI4BNn2oG9
         kRDGPpt76NXPiwGZmF9CAVHrlIvPTEghajZdt/0XIIR941fvQVo2uaKA7sWjaIZskYq0
         XuYKGYn0pin1juVvTytp+nS6mzi0yDWBNw4ulj++Yo3+mGqOpsnY+FGIguPRkeYOiiUU
         2YoQ==
X-Gm-Message-State: AOAM533o2rU1TWGmLT3+EwqITKLpSqLCeYntz2Ev8T9pq9EnMqaZPm2A
        whfZOf/+ipx5O6FLkh70XvJ03GdrYvI=
X-Google-Smtp-Source: ABdhPJx4J5cWUKRvHDPaYc16vq8AjNRcwr6TgG1l8EPWJET9EziytFP3O4g1dXNFFY+VuSsksJWmbA==
X-Received: by 2002:adf:e443:: with SMTP id t3mr3492292wrm.14.1603271345538;
        Wed, 21 Oct 2020 02:09:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm2944894wra.38.2020.10.21.02.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 02:09:05 -0700 (PDT)
Message-Id: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
From:   "Sangeeta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 09:09:04 +0000
Subject: [PATCH] bisect: allow `git bisect` to run from subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sangeeta <sangunb09@gmail.com>,
        Sangeeta Jain <sangunb09@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sangeeta Jain <sangunb09@gmail.com>

As `git rebase` was never prevented to run from subdirectory we shouldn't
prevent `git bisect` to run from subdirectories. This commit removes the
restriction on git bisect to run only from top level directory thereby
allowing it to run from any subdirectory.

Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
---
    [Outreachy] bisect: allow git bisect to run from subdirectory
    
    As git rebase was never prevented to run from subdirectory we shouldn't
    prevent git bisect to run from subdirectories. This commit removes the
    restriction on git bisect to run only from top level directory thereby
    allowing it to run from any subdirectory.
    
    Signed-off-by: Sangeeta Jain sangunb09@gmail.com [sangunb09@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-765%2Fsangu09%2Fbisect_fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-765/sangu09/bisect_fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/765

 git-bisect.sh               | 1 +
 t/t6030-bisect-porcelain.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index ea7e684ebb..9cd0fa0483 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -32,6 +32,7 @@ git bisect run <cmd>...
 Please use "git help bisect" to get the full man page.'
 
 OPTIONS_SPEC=
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index aa226381be..6b68cc01d0 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -49,6 +49,13 @@ test_expect_success 'bisect starts with only one bad' '
 	git bisect next
 '
 
+test_expect_success 'bisect runs in a subdirectory' '
+    mkdir -p subdir &&
+    git -C subdir bisect start &&
+    git -C subdir bisect good &&
+    git -C subdir bisect reset
+'
+
 test_expect_success 'bisect does not start with only one good' '
 	git bisect reset &&
 	git bisect start &&

base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
-- 
gitgitgadget
