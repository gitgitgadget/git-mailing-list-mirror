Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A610EC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AF761158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhDZQTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhDZQTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:19:33 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F9C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:52 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y14-20020a056830208eb02902a1c9fa4c64so16119269otq.9
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOJKPqOeFx/TQGntZS7ZLedzJIeaulaJ9v77KNbJ0xs=;
        b=W0EPiQft+O1OWgk3Wu/Gui9yxpp9ukgJqCIHLqMzBPURVf1M8tEz6rXE04eACNlyPs
         pIP6M4p9kkNDRbn23vc6yYH/UKnSQd00mMZxPwKW/jqApzROaPsV/8ODUBj04W7Hz/de
         PqxOVX3MO8b+IiCgEO+nHr7MqD3SxS5SqzwxgitpXaOudEOyLmpXiP9/rYXdaublcWzg
         5S09oZk9gHquOSpSnUZSIyeF7ppTn2tOeEtVYD0iQwZoIaUiMG4uQjjmVu/sbAqabfyh
         r+VonSyC9LB9VdbjX2san2eDSiqFYy8Nli/u/OTQzEDMoVDPShQU2/3cL8beq+2+nz+n
         MA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOJKPqOeFx/TQGntZS7ZLedzJIeaulaJ9v77KNbJ0xs=;
        b=Hd8wJSUbtrp0A0tIROYFOtyyFxMzfhv0z78candIOCNCVnbNa2aLfcA4B8U7QEElVW
         evNUFIC9W7j2Z9pAae+pbEsqt1z8g+t59YId5IjoUvsrIHnt6lm6mAa4VJGeGk5k4jDQ
         PGD2H/R0K3d8xugOFKSF9vqz1Eo0jkmWpIkNG3JOSMYQMU1OpCXoenoMndwIz9kpMlAo
         im1VYa9M1gZAuJxedIOB6gNdgINKUXZYGNbUpBTJNnCwexiU6frZtmF+feFXQkvSseW0
         uk70Te/a+PUgJwRBWQS3HPOUk9s+Lw6QfgXc4nHqHd3HfSKnlz06WwRX3tJtfVi/Ax7G
         /APQ==
X-Gm-Message-State: AOAM5312/f4LRvoZr8aaIcppfQqCLNQjLqklFxNtWkG2LAH0/+BTV48S
        3cz+GWFr8urO8NCanJ2adtQKvBXwD3lM/A==
X-Google-Smtp-Source: ABdhPJzJIHTxUJwH8yj8EsrZ+8yDJa7mMdnizTiDUVNir9bizBcTF0hqTgaYRHI5njerEc1Fexno9Q==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr15651735ots.245.1619453931272;
        Mon, 26 Apr 2021 09:18:51 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e30sm67208oow.11.2021.04.26.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:18:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 27/43] test: completion: add missing test
Date:   Mon, 26 Apr 2021 11:14:42 -0500
Message-Id: <20210426161458.49860-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once the correct suffix in __git_complete_config_variable_name() is set,
we can add the test again.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3528463047..bbea339a45 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2315,6 +2315,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
-- 
2.31.0

