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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC62DC433E9
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BD922242
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgL3T1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgL3T1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:27:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA564C06179B
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c5so18306136wrp.6
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Beof6wirizOKpfsWwTbU2ekekdWsETRnVpYiQCmgFkc=;
        b=dx5VnawPa40bkTwI0hHSR1eG+CDDbLolOvomy079v93b6qMSQwDkVCpzIOWb81oUIB
         qOwmeYftmr3RLqxmO92REzzJCEsH7rT3JLD/oTuv1C9hzsMFZJx86knOt/rbuMF4LAtJ
         FA3pceIO3eO1mx0YVBXlTaVHDMxMsw8VjNhNPLJakPVJ7kHbR458H0CwrNEma7OW0A8F
         sKVQAkbcT0UiWClVkU1IP2xHq565kqn1k1gT8qKeG6S7qMFFgUfLQ72Y3zPd55QQcEJb
         NUicAwFKJMxpbTd/dad6RAJEt03LWYXkUKfxVagLd1dUcF2V7JyF6vv1ldSeordSGtMZ
         jtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Beof6wirizOKpfsWwTbU2ekekdWsETRnVpYiQCmgFkc=;
        b=Y1op2blK0hXqEPxsz6C3yK9ZTScuugqrDEHI3SUXYl99/PcFoG8mczH1rjE0Th5DnS
         wT0YWi64HxVLp6NdVSMMeF/UqzNAuq20HAuWpWvdo0OXnmcViKm3zmsJfEPLlXSg80FK
         4EDlrEX6KDdMncGCGb6u/4a+DkqwiGKG9X2RHdgLxxxktMjcSKoP8FkzAh3304hmQltr
         rHZGnW9B91l9mM2ryz1jZS5cPvrFa2XDEJY1Ps1a3yf/hZlX5i46Y+To9w0c0nq7OiM0
         NRJLfVPGwja0V4jiu/evEdOy9k8Sl/ra00iQikZFDO58ADii5ZeaoV813RccXb75SYxM
         7AKg==
X-Gm-Message-State: AOAM531spnGtqZS1gc3XDTQt4bsZaX9hS/gimR0+VpQGQgBMvs8HXxNp
        VaSxlrXRECTr5aEADT8VLZ+BHqhflIA=
X-Google-Smtp-Source: ABdhPJyveQqxoxxvqF6J+5IsC6eDEDh2t15dd/PVbJuQhn0hH0xgr/7c8elFlKmf/dPoYgT/U084sg==
X-Received: by 2002:adf:db43:: with SMTP id f3mr63663598wrj.70.1609356417360;
        Wed, 30 Dec 2020 11:26:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm69476329wrb.92.2020.12.30.11.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:26:56 -0800 (PST)
Message-Id: <802718084a7266429ddf0f5b836bd3fecd55400c.1609356413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:48 +0000
Subject: [PATCH 3/8] cache-tree: use trace2 in cache_tree_update()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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

