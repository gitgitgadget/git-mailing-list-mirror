Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E15DC2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1C3206E5
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/6aYLLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKBUoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgKBUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:13 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8381C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:13 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id j7so16006883oie.12
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFCb51uRTTPCO8hIEsQWsOIa2UB9F539kDz6RVguH8Y=;
        b=Y/6aYLLoXypoj01S1ayNSZG74C8rTFWsZn4rJcvkghGe8jItfk1N9Ks/4w8pImeP7W
         HeLsR5+HIkOo9YA9tCLVlMa3jHNkchsuATZmkfeF8MTOO8UsRs7Ktu4QznIguNVZQ+6m
         xMW5qx9hdEcPE/cLBFOkEIiHdQ//ep/B9zg/ktHE7xs+8tJvPINSHfBqfDg3nuwP8cXU
         jcpTXzkgC2ZAehbwmepROkR4dnRJRsDD0bv9SIyxm8QPa8e0ad5KfnDVPiIqqAyj5kwe
         sfXu2auiSwPk6PdNQK1bCocy7cJ1Jq99F2LcXF8zeeCwy1EP/uDwtXQXjKz+rhbQb6B3
         U19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFCb51uRTTPCO8hIEsQWsOIa2UB9F539kDz6RVguH8Y=;
        b=opZMkrNpk5FcaHyuwYirABqJ7mVdXNdR803DJqs84z08hTGqmOS/WDme74q8O2cDDq
         FaB8mTAkP9Gdg2rUXlTFffwvZSrNAL7Wi9YFwrwR2GMPrkUlfqlp2CwhQWt89PMJqLZy
         wehB0tghP4Aq50QgsSrtybxifvGmmq5q+wSlx9W58cjU6DQBo3pWFdIorfNK/7LbrVth
         4izpe919AC3VEjhMOXh5UDf/IMkHmI0f6axe3EKsjwEBt6ucu7LzR715PJLyDrISkQrE
         66CacPSwHYq/Fbg48OvpcZ+CnWQGhWBgkTqUnItkvR4BSAmb0w9G7R8Nt+60Wct0D6AL
         csHg==
X-Gm-Message-State: AOAM532a40umotB8OS68LJRM1q3gDGzTg6BVKJmvR/yAbhDzxxamhSyg
        9ZEuicBp6AveU/R2aRjtHrU20Pw8xAYJug==
X-Google-Smtp-Source: ABdhPJzGmcLfYVM12EZcxJrvIjEQUVOOPtx4vP/unnDYenfT2wir90FTnxTD5kvnl6SJZkW9e6aajQ==
X-Received: by 2002:a05:6808:696:: with SMTP id k22mr11611462oig.107.1604349853071;
        Mon, 02 Nov 2020 12:44:13 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:12 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 18/20] tree: enable cmp_cache_name_compare() to be used elsewhere
Date:   Mon,  2 Nov 2020 12:43:42 -0800
Message-Id: <20201102204344.342633-19-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree.c | 2 +-
 tree.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tree.c b/tree.c
index e76517f6b1..a52479812c 100644
--- a/tree.c
+++ b/tree.c
@@ -144,7 +144,7 @@ int read_tree_recursive(struct repository *r,
 	return ret;
 }
 
-static int cmp_cache_name_compare(const void *a_, const void *b_)
+int cmp_cache_name_compare(const void *a_, const void *b_)
 {
 	const struct cache_entry *ce1, *ce2;
 
diff --git a/tree.h b/tree.h
index 9383745073..3eb0484cbf 100644
--- a/tree.h
+++ b/tree.h
@@ -28,6 +28,8 @@ void free_tree_buffer(struct tree *tree);
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const struct object_id *oid);
 
+int cmp_cache_name_compare(const void *a_, const void *b_);
+
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
 
-- 
2.29.0.471.ga4f56089c0

