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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E1BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A797E6109F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbhIHNm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbhIHNmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:42:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30BBC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:41:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso1208073wme.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=82mj4O3sQeL4xRrDph3+NBTpjhpDJqHGG56do4lmAug=;
        b=AVca6gXrdSzsVc0AvgiBZjOOJDbJb/yiYpnqbl60jYL9Oju8DcV3qHuqqUKmmQ37aR
         9eyWQy6DxiQ+yZE2h2CFBwZsA3tvNlihvP9jlkzv03H+49/cS6m1nR7USFKvoj0Wh13R
         t3wYH4O4rs0nzhAuAGvueiVinscMjKvO5NjI3uFHCUk3C480G0JTAFgRe51nUjtSZTr0
         c9FYgRNn1qLxOZzmtPOYtQbPLzXCNOX3QfClXy1+n4fCUh/S876EGcdMhvVkrJWXJgqY
         5wnaZ02aHX3Q7l64rIUGYzsrR3mjjI35C3PQquil5cwVWppVtCeq02KH7be2X5/dMixq
         u3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=82mj4O3sQeL4xRrDph3+NBTpjhpDJqHGG56do4lmAug=;
        b=0hsA36wo0HtIkAt8N2ZD4n+/41lhCQTDvpKS7ZkDkWKDKDLEPLPKSoHHHTd2zLtx7R
         qkVzx5leacuDPkSy/6tUB/vPecjQQgpjdYJcd085f4JTDaXKqSYwWG6o+kdGjSPmEFJH
         xS09EpiRSs7szbUulz/suGInKDPzFmGb3xMpfggH/siRaQZ+DLxvl/BcZjMT7q2SwxKs
         tfn9YWj2q0hF8b+ZNYVEABEonq8Q2GqhsiKLDGADN+hp2VSKf/G1iQFU3hy6QXTDz08Y
         wugCHLqw6mTIR3vC7RzrepE4h4wqkxUFl6Njp3V2QI9k2ePlvVf0p8UF7BGrfVEyVOaN
         F55A==
X-Gm-Message-State: AOAM530lMcQ+o9fepFhmxV5Ppx2E27UsaqcpdM7+xLanT5o13Fnax9E3
        xVeC821pfb4QguWLmRrG+nxGNNybBZE=
X-Google-Smtp-Source: ABdhPJxx70Bh+Sj0Nucb0NsvsdQtdVW+inSABp5NKkCne5mMLoLO0xRCL/dAIJe78EDpiOal/qpsgw==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr3615683wmi.87.1631108475590;
        Wed, 08 Sep 2021 06:41:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21sm2335559wra.92.2021.09.08.06.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:41:15 -0700 (PDT)
Message-Id: <614555fc10f336cc6f7681501247209aac879269.1631108472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 13:41:10 +0000
Subject: [PATCH 3/5] reset_head(): mark oid parameter as const
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

We do not write to oid so mark it as const in preparation for the next
commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 reset.c | 4 ++--
 reset.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/reset.c b/reset.c
index 4bea758053b..5b578d6bb68 100644
--- a/reset.c
+++ b/reset.c
@@ -8,8 +8,8 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
-	       const char *switch_to_branch, unsigned flags,
+int reset_head(struct repository *r, const struct object_id *oid,
+	       const char *action, const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action)
 {
diff --git a/reset.h b/reset.h
index 12f83c78e28..6d2be511b8c 100644
--- a/reset.h
+++ b/reset.h
@@ -12,8 +12,8 @@
 #define RESET_HEAD_REFS_ONLY (1<<3)
 #define RESET_ORIG_HEAD (1<<4)
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
-	       const char *switch_to_branch, unsigned flags,
+int reset_head(struct repository *r, const struct object_id *oid,
+	       const char *action, const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action);
 
-- 
gitgitgadget

