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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D5C43381
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B82C21D93
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbhADDKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbhADDKE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E2C061795
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 3so17991585wmg.4
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Beof6wirizOKpfsWwTbU2ekekdWsETRnVpYiQCmgFkc=;
        b=RjH250PQWH+JZWOOt5HoDYfpGjC9dZAEEt5f/F7JtGwCetTCBlikRZdJ4sl+cIrbYZ
         XWCLGHl1dSJ5Vj+tvyM6ITjq/UR+OPpA02KCABAGOwyZisLpu2jTpIkFlBQ/fJDytmDc
         xnyCeTeM8U+bNkBZWL2epyYchTasgLx3ZAO7MpmAC3HPleWxzH/2XCjNMfQfB/zzxTtt
         wC0xhiYjDb7Gy8VZbNdBPCRA1DhUXyO72s4qbemwUeIv4iFUl9U0YclHwEGivCDJc/YA
         tl0YKE1YmfFq8EfU1I9u0RP1JJBr/dNa4ME5S/H03XVLT0c6D7yW86fFT4zuZ1vtGG1f
         KPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Beof6wirizOKpfsWwTbU2ekekdWsETRnVpYiQCmgFkc=;
        b=dICndZ9uMsGIP8M42kfjsRgQEO9iebjyf300oW8Md4OPPSo0FA6UrFSEpTsINd0/2H
         j5tCj6p5MMw95LKgVffMroPv8U1Sq0ra6vbDRF81nM812feaB7zkbddXbss6HKYEAW6z
         ybf6DTBwHm9M2OS9KAq8k++i0zcddnUySdRiAQ+TxEBvdt3SHq5Bvfyf3tFvj8uBU+wP
         eXnGM3jD0yuaXUhemCxsB5a0srRRLiQ+hMRVe6U5vf1C/E6ScvbOvV/StgTEnL6IIhd2
         7ISyIj3RNnE/Os32tVBMSXw3ZruiH9axbzvUSO9tg5WawOehna40OOuTKqfh6bOdsw+0
         wj0Q==
X-Gm-Message-State: AOAM532QEcZXGS2ioyX3HguHBl9FfZaHtnYXRxLf36OL3Lt0pU6ttMZo
        g0cxfglsyDrD4iQkXh3jHUy8to6wDSA=
X-Google-Smtp-Source: ABdhPJzmcjLYzd9FbTlh7KcpniDZXAltch9w0LHREaIsVC0hycxHqACCbD+oNVBxCDXDa43TiBS19g==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr25503995wmk.14.1609729762828;
        Sun, 03 Jan 2021 19:09:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm79826887wru.33.2021.01.03.19.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:22 -0800 (PST)
Message-Id: <8959d57abddd620f4b597e4c43c5d2545c666e97.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:12 +0000
Subject: [PATCH v2 3/9] cache-tree: use trace2 in cache_tree_update()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This matches a trace_performance_enter()/trace_performance_leave() pair
added by 0d1ed59 (unpack-trees: add performance tracing, 2018-08-18).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index a537a806c16..9efb6748662 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -442,7 +442,9 @@ int cache_tree_update(struct index_state *istate, int flags)
 	if (i)
 		return i;
 	trace_performance_enter();
+	trace2_region_enter("cache_tree", "update", the_repository);
 	i = update_one(it, cache, entries, "", 0, &skip, flags);
+	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
 		return i;
-- 
gitgitgadget

