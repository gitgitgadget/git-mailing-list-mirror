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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899D8C001B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F55610A6
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhDABup (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhDABuS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3815C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so2062548wmc.0
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ujY+w6SXlDeI30iu//cxteaQB/3nSsRybSiz0GS0fM=;
        b=UnO8PiA2R1gz2JwafpCz7GzCwiOVmy5jVmN/2i59cCVuR6/GZFnWxgpv7hVdPh6a8U
         IfnBpfdp4RnzI79jy4jJghs7qVMnmF+EffKtg3xBL7SK6QItuH4oS6yQEH/JT+3KpU26
         kXZJ9IPdhbLEBHbNz73Ghi6/NMwkGELLTqqBjOpt7QaLcSDxwPja5gXX1pG3Jc5BR9Vo
         IBSokR1FJ/mPSU2r47oYZPbMQPNaMuWsUsYKXZdwVhtUaDB8dQC5Dxwd0I9XzXLCm5uz
         W46jRUGFCxFpzGHNUU7tNkb6C6WpqrUne1UirQTXUzxCIvw7YomNdKAYz1SUvk33iChk
         XZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ujY+w6SXlDeI30iu//cxteaQB/3nSsRybSiz0GS0fM=;
        b=PV7uYatHdPAy4TPO74/z6+uhpXM7eQ2ZeieAd8TDXTZM8lPCSivslrkXrgN/MOI8bZ
         kifBGfoBOcvwTLwbyZh8/de6GKuKkr1/BrlQ928fXemKUiVbnpL/aVu37Jwv19WjXj1K
         oBsTrcNipJ++LVulk1cLOSb+CZpbe6A6PuR6g1JQtmRipUxXKmwBoyXQzZBqZiLsXNNH
         V7TtR7t3oFVTVD4eqruaqcRY3d3JjFZO2eWrHZW5vUIOam+CWkUrWbioQJBYSrUSt9QB
         P5vrSETZJy4lrGSWV+A4Z3fO0Z7AMVUsD/dUmsxc/1bYaLAv3jDpTkqSzK07rBqucv4h
         PbSg==
X-Gm-Message-State: AOAM533N6iTvXPFIsQa3hDFGotm+mXJOyOK7T4aHzMdRqKU5AR5twzYQ
        7HjM3xTIzTFbl7ClfI0SwyNKfRKIEB0=
X-Google-Smtp-Source: ABdhPJy+7BYeVz1wBovKiDcgPqNuSt2kasMJu/USEBypdQMCvsK+8T/M+GfQ3rbxAPtJund1I3rVNg==
X-Received: by 2002:a1c:c1:: with SMTP id 184mr5596845wma.143.1617241816647;
        Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm6540344wmc.17.2021.03.31.18.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
Message-Id: <495b07a87973f32ad81e513b2be04a1b1b92bdc8.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:59 +0000
Subject: [PATCH v2 22/25] resolve-undo: ensure full index
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
 resolve-undo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/resolve-undo.c b/resolve-undo.c
index 236320f179cb..ee36ca58b135 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -172,6 +172,8 @@ void unmerge_marked_index(struct index_state *istate)
 	if (!istate->resolve_undo)
 		return;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (ce->ce_flags & CE_MATCHED)
@@ -186,6 +188,8 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 	if (!istate->resolve_undo)
 		return;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_path_match(istate, ce, pathspec, NULL))
-- 
gitgitgadget

