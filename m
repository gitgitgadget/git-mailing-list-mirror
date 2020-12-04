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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28487C193FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF6022CF8
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgLDUtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbgLDUtl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:41 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750CFC094240
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:32 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so6568409wrv.6
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Vqos9ENXW+RP/6IqXk99famSFdcxfCZlVpwjy1vIpo=;
        b=NJ4cr+iaKASDPi2g///wm8WW+4B8WzFx3h+WqujPiLElaElqIm1YpswEJJrBcA7ceQ
         2mxmFcTpxITdwCzIWENI5TwqIiUptLRuyAqJr78wC0VNZEn1bPxka8n+Aza6eGrClmp7
         vezToD+UoKDUa/m3U2KM2g+NXX8FzbwpasIT6JRiKHSp4XQ74cTObul+dpOzhudChqwj
         NSEmDRFylyfysrtW71cDHgg3N0dSuEXquajunYK87kIPsw629aCWORBjI2hK0fGdTYMz
         HenrUiV3iGX4sAUzVHXLPigwhKO6kb6u2dnhTMLhblOB2Ik0FL3uqu2pGkkFCBRmDVqB
         y2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Vqos9ENXW+RP/6IqXk99famSFdcxfCZlVpwjy1vIpo=;
        b=QKP/xuzgbhADVwncOPsD4R1Bcjcl3XmHUdDJBdGGRFSg4COFf6zFXxWEevOwmUjPc3
         Zv6hGdYgPhNCmIrL9k2tvSbFOCa68s1wgnEkcVeSWcdq/qjRi7txP6H5k88LMEjYKBPz
         WNI2U3T0wCvyT3blKJvHPPnbxL3z2uJGs3ee6Hmb8IZfIn8UwksNO5HowPx91UXD66+X
         8D7PSxQgNnjoEa5vKbwIrXMCkd/x0IHP3AHT1wjlQAfEg1h6BRctlDjvvs8MSx43UEC3
         pUAtaaH+4JsHeMzv69sr0z2vqTkoucINAXSXdntDb7AoilrIWDfjT6x08V3hFaorvkVb
         lUOQ==
X-Gm-Message-State: AOAM5308qPxUhNEGXncAL1TLOV6R343M8bvLp2uL3vVc6VMWoc5eOROg
        LGLmaAPX6EIPqj41pBjXuulOzG9lRnU=
X-Google-Smtp-Source: ABdhPJyHi+NYXSfNdiAbT32NsN0gKRtOMuFZGNRLGTvVEcq5N4Zk1JmiD1szFXw/YTrYN/7TBbuZ9A==
X-Received: by 2002:adf:f085:: with SMTP id n5mr6709931wro.371.1607114911014;
        Fri, 04 Dec 2020 12:48:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q25sm5254726wmq.37.2020.12.04.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:30 -0800 (PST)
Message-Id: <f5a13a0b084bd40a2de6f519ab941a80fdc45dd0.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:08 +0000
Subject: [PATCH v2 18/20] tree: enable cmp_cache_name_compare() to be used
 elsewhere
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

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
gitgitgadget

