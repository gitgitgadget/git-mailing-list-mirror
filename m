Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136FCC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78F364F39
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhBDS2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbhBDS0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:26:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F371C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 10:25:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z6so4670469wrq.10
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6LwhmrDAL72qP700NGQC8CPVsWsIFTwAGnmHjxH+6Sk=;
        b=bVrzrATnCxASuD1Weren3MN30VLh606lsd5QSZm5flBpkUSLdLKaXnyF85M4yx7sZ6
         XBxjBs2VF0ZKWQXM1B0dr3YvZZOP2GWAtoWFFWC71GHmExDf5j3GfPkcq5EFToSutxbj
         4aCm3xgvMxgH+wtM2oo8An7tNMUcACQKRODjG9YuYpEvU9jPnJpnH1E3xl9+sUUtSE8+
         KpigtceQ/MZhrzIRR5Pelbb6ElUSMGSChBY6y+en8R0w7MDbXc84Q+bBVSPzSPKOwTsx
         e9OrctlGYiERxAC7TdySwCi3TnAKdDT4kT4yFqnRTUagx7VG0j2U5KyR6DYkBYqilXpw
         OdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6LwhmrDAL72qP700NGQC8CPVsWsIFTwAGnmHjxH+6Sk=;
        b=ZVwW0jeE4Uc7Ih1y0JyRtOJisAv8J1Fh0coap608HxBEplCo3+AIdc3drCDwvi482o
         k28+3x0FffPsn2mfiTX8lb7V+eTQQOHIljKE09MVSqVNHNzHLUChEoN+BCdqpL+vndJH
         X8FSdX+Xu/QWreoVxU7YQn4FsLllLzhyxeAZazrhQpdlW/TrFJQyQ2TvrvSnH4TKAi28
         I4+JQzFr/wAIk1u5AL1AvNdJFZrmJa9/dbGeS1sj2md/57xx7q5oTE4dpPViMKAaq/Zv
         we3ifHQ4Eit+N/7XMTzFwpG8IUGmEwWWiHtvn+7yK08/VwMZqxeXsnZL4m2SajA9M2tf
         FYQw==
X-Gm-Message-State: AOAM533fCinFucwNAaK1saqFqobyauZjQN9W0iJkGTAXJoqNk88zugco
        cWQryAnmyXtn3dJrUV9a4BeAW8b+h9w=
X-Google-Smtp-Source: ABdhPJxJjC7P4+j/RJc9O8AkhBUjWOpcQ33yDdyyYFTmAO4vueOwl6ooOecKp92FTNRCxcIXMpKRnw==
X-Received: by 2002:a05:6000:10cd:: with SMTP id b13mr688692wrx.163.1612463138262;
        Thu, 04 Feb 2021 10:25:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm6763408wmi.24.2021.02.04.10.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:25:37 -0800 (PST)
Message-Id: <pull.867.git.1612463137244.gitgitgadget@gmail.com>
From:   "Taylor Jones via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 18:25:36 +0000
Subject: [PATCH] subtree : fix split output containing unrelated history
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Jones <tjones629@gmail.com>, tjones629 <tjones629@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: tjones629 <tjones629@gmail.com>

When a subtree is deleted and re-added at the same location with the
--squash arguement the history created by "git subtree split" will
contain commits that do not affect the files in the given prefix
resulting in an incorrect history for the subtree.

This commit fixes the issue by removing lines that create cache files for
commits that did not contain the given prefix after new parent commits have
been created. The history created by "git subtree split" with this change
no longer contains unrelated commits or commits that occured before the
subtree was removed and re-added.

Signed-off-by: Taylor Jones <tjones629@gmail.com>
---
    Bugfix for subtree split function
    
    This patch fixes a bug in the subtree split command. The bug can be
    reproduced by adding a squashed subtree to a repository then removing it
    and squash adding it again with the same prefix. This will result in the
    subtree split history containing every commit from the main repository
    instead of just the commits that affect the subtree.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-867%2Ftjones629%2Fbugfix-subtree_removal-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-867/tjones629/bugfix-subtree_removal-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/867

 contrib/subtree/git-subtree.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 868e18b9a1ab..f1b8a3b2e74c 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -667,10 +667,6 @@ process_split_commit () {
 	if test -z "$tree"
 	then
 		set_notree "$rev"
-		if test -n "$newparents"
-		then
-			cache_set "$rev" "$rev"
-		fi
 		return
 	fi
 

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
