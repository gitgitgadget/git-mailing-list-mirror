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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BBC433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF21233F6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbhAGQc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbhAGQc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:32:58 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB68C0612F8
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 190so5712131wmz.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Beof6wirizOKpfsWwTbU2ekekdWsETRnVpYiQCmgFkc=;
        b=SFHm909zzvxfwO1WbegXeHndk/NjIHzlIKWHLVpPoVZgoyWHL6tlVMugICa1hL0pe5
         N5kerfhO2QdtqRYyLN2txF95Vxha99tLRn+sVq1y11VSEaPgb9o6pLMiwTAEOszCxem4
         8R4OHUM9G7UP2s+Lyj7/ZjdSQI9aAySm/8pirc8qx36lSXL7+hbFizH3CPXJlC26P5MK
         A89tQQm3igm9/tKYdQzNy/8Y8kLt0cuBNG0TuI6Eef05oPKF8PytPzkkjJyzEPGt9UM0
         hvfrRAKYpz/pO7BCgL4DObTu7UewW+2KOkDWuuS624kiIZ9qhwSuOKAYLmZaLvMu/Uvu
         mg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Beof6wirizOKpfsWwTbU2ekekdWsETRnVpYiQCmgFkc=;
        b=q2EXk1i1ee8Nn1j959uDEtt75U74COaw9XCSA24Ks9sjGyK2X6l1hGGZ/9WX6WCvRD
         5/5Sa5N8RLnVpcFbvdm0QPNeoGCMWNH1IKA1AgDTaeST1ncqeDCXxTK4tKSgL++e1xJn
         ZR1qkm8h/0IVBe97L2PyIlX8aowmp9H4t+iKFVmeYMnUimhPQYaz546hY/20m8uAIwkE
         syMBXry+2z4XQPKUh9PW0SzbBZEFI8przGP65N/WXVBQmhyjt1rhAZkEI2wTTgbtrs3d
         dl54KSiGWFSsW5SAF3uN6TEMlsIq6JhgtwER9JqmbgZd5G+inrMqNs7BOSfRJh4QbWiW
         GiWA==
X-Gm-Message-State: AOAM532Fi6j8oMm6/SRFSW1w6xAJf47oIUmf88xpCYiSVHtLvVIMw2o5
        cEJVEDit+PMp/tuMRVjDiXMAmOxCPns=
X-Google-Smtp-Source: ABdhPJy2CO1FDuFpfl66EKAUtkoT5kK1HLVzzSg1E6lHHP5Vm8t2TacUVfsmY4q1AsFJtp+se1MD0A==
X-Received: by 2002:a1c:17:: with SMTP id 23mr8499459wma.35.1610037136130;
        Thu, 07 Jan 2021 08:32:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm9846209wro.27.2021.01.07.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:15 -0800 (PST)
Message-Id: <8959d57abddd620f4b597e4c43c5d2545c666e97.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:04 +0000
Subject: [PATCH v3 03/10] cache-tree: use trace2 in cache_tree_update()
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

