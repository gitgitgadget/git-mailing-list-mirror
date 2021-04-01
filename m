Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52486C4363F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF42610CB
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhDABun (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhDABuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B032C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so84256wmj.2
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gXHTyk/0rr+wbe8rzhDt1uZ1A0ElBNbmaZcI4hkvDxk=;
        b=SVviZ/TDvWySctTT/qISNXo45/+Drbc20zla6Zl/lEC8NK2gudLs6MxVjxqrQdDQD7
         UGDocQ7cVn59tGh+gQZB5TnKEYg27GX41ZyQa8nykW0RRZLkn9E0fUEuYpBLrNkAEwc5
         FeqgrKxeWhQWBu5gp0gw81iesPDo1aDJvoAfnC/sYdKWcYp/Ijfd6u5Ea/6GsFEq4YAI
         TEEfenhOqMVospcraDoEXqppagVYlHoCUcL2MySgdGuR2DGOFiD+Wfx9y+jY6TBicmZM
         /+D5r+KekuNA/L1Agqq4RV4g7nccqrTHr5L4VX4kkaSdQa07Mtjq0td0KHL4LJe24IE9
         9Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gXHTyk/0rr+wbe8rzhDt1uZ1A0ElBNbmaZcI4hkvDxk=;
        b=uhlQsVbsU6gpLBGsxkS6ciuA0LMGgPb2X1BBpv0UPXazVcIV+F9e2LpHRgoD9m5VBm
         mPdw51OIDb7nnZEhHlNVwzCbf/VKaNTAiLTG/vMRoX8ylYVch0if/Kukj1CX8H1g9TI9
         2CIFNwofYKc5gR13QkOMQS+2hyv9FExwuOIHJPXMi1eOygrwJ88RqmxTKrTrZ3tKNdhG
         y9qO8cIFOn1j2gP5p1r27R56yRldrrHo4N2PDJioF9WcTgQPkllncRSGfnvjHBC27mwi
         B4+SaXNs2D220n/gWR25BdPv+KEZ+NavOCf7T8RMcG5H4IK0qTnPIL+erPL4GQEuc+RY
         ipyQ==
X-Gm-Message-State: AOAM533+DEmH+zDtOzcL9yjQH294WLGEqMSvZvXbrzOommZM0n2sN764
        HL9kkcZ/lQL6F2nJ/5NrgzKMKxdAakc=
X-Google-Smtp-Source: ABdhPJzkgSo8XuUgsubdBFn+0mJxvIOCs8qdCa1IWXufqWP+4eJhsWcFEabCq+4brBMoob/eOU3jIw==
X-Received: by 2002:a05:600c:3647:: with SMTP id y7mr5604917wmq.17.1617241816130;
        Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x14sm7046382wrw.13.2021.03.31.18.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
Message-Id: <ebfffdbdd6ad7fcefc47a3581a335df96f930539.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:58 +0000
Subject: [PATCH v2 21/25] read-cache: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 3698bc7bf77d..a9dcf0ab4f78 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1577,6 +1577,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
@@ -2498,6 +2500,8 @@ int repo_index_has_changes(struct repository *repo,
 		diff_flush(&opt);
 		return opt.flags.has_changes != 0;
 	} else {
+		/* TODO: audit for interaction with sparse-index. */
+		ensure_full_index(istate);
 		for (i = 0; sb && i < istate->cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
-- 
gitgitgadget

