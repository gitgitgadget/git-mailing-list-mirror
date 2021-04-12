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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C8DC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42C460C3E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbhDLVJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbhDLVIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E26C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y204so6192355wmg.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P9rJd368hm+Jl6xbpIBIuWVC2ZyfP3m2Ah742l9tbUc=;
        b=iQICstAfDohYBFWyDNnd7BcmbtZEElz14OcFO9G5UvIjszV9IHsV8+vAnb1wPXVLlE
         U209cjHaJaHgZOfImXluy9dSho43w61QW3iUkMysdNCaImhRL+AOdjocksmTLFaP8uj9
         RG79o8DmDt5QdQawUTVZjMPNDny05JiopU4VIYHdQ/uuQfD24diObf9lmliy31fbh9E/
         qobULB+5Tco1bDor8RR/fdoTJ/5PdYsr4LciYIZZ526Xs34NySLTD12ks+Lr2c8UG7dd
         Ry3cPcAijc/RZcedTK6LrKEaG8o3G6EGZl0m4pVvDDd17R4TnP4scRmrNKA2Rc32lc5N
         zk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P9rJd368hm+Jl6xbpIBIuWVC2ZyfP3m2Ah742l9tbUc=;
        b=HZ+A6UgzuxNn1dzZ779hCjULNPioQULqT+hFexpCWfFbkjtvEprKxQz1SW7g9QYIHS
         JTf3YTR+bAN3hV/Pvpc5BVQYA23jOASvPzJIf2IMfP9RUx/FJWFXBWlkp1ElzojZSDh9
         ydsTnGGS/Hgi9c37Lu0vzpfil2MW9oCIExX2I4ojMXqln0bRCWM+DRr0xMdx/So67XZq
         NxXZonOg15X8i5JhZ6dQ90ABw03n70H0SSIMazc3BAA7bbeaOgWqcBxT1IC0LSzwJSKc
         e7+oCLHNWUrxDSWBhP13CFgV9+S4nCaziJowT9C9hUpG0oVbaB5et5IVCmPlezF7k6YW
         E/Hg==
X-Gm-Message-State: AOAM532j9rlaO/SDjHGzEB7C8sh+9Tg9zd0m2yqIZ/Ub+4sqXrxjm3IJ
        jVGZhNVwEuLjssLTTuriFJjxu7yol24=
X-Google-Smtp-Source: ABdhPJwWdKcrV0wfLVBAKSM6+ClDW4jNeOVEiEyeeB/RhchSKTPbnopspB8R5CI778aSRTxDxW11Sg==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr898164wme.54.1618261709506;
        Mon, 12 Apr 2021 14:08:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m26sm482280wmg.17.2021.04.12.14.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:29 -0700 (PDT)
Message-Id: <8c5336964d9b513825a9f7ac983ff06cc5757d2f.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:07 +0000
Subject: [PATCH v3 16/26] update-index: ensure full index
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
 builtin/update-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea4b..f1f16f2de526 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -745,6 +745,8 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++) {
 		const struct cache_entry *ce = active_cache[pos];
 		struct cache_entry *old = NULL;
-- 
gitgitgadget

