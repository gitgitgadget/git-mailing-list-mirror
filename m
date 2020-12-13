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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1019DC4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFE922D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbgLMIHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393756AbgLMIGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:06:08 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253AC0611CD
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r7so13253335wrc.5
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NJ9DfsR44CRQ6MBxmFGkdBFtUEn9AS/jGwKdtehq0pY=;
        b=HiEUia6Szm1kQjQnnMmejjOefu9uNN9sOaV/vnxtrOQBB9aDtWt3k0qm8zq+sfdioq
         OOx/kd0Vgqdvn3cSGY9+KziedbKZz51OoJY7UCzVjUAUNYFXW1GyFADZXvW3eZsNivki
         xJSNLCeg+Q5gW0bckBKI4omb4ghOCN1mzpCG9O2lKboD+m7BuZvhUnzvyS8aAk54P8aa
         HppTz7soGJe8hymvQA+nhEw+BGKTrPtO/RFT9f87wZgetIR1sInhtMAy1lHex8OuEEKR
         WwwMIGgJHxPOIheX0/T61C77GOsfDplpm1UiRRU4ESS2+mM74LZ2NOW7TdLuVF/3bCoj
         iIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NJ9DfsR44CRQ6MBxmFGkdBFtUEn9AS/jGwKdtehq0pY=;
        b=aMEaq04carVJTceztQRjE6lHUK3A3DpuWF+JEpu562O/NHjOg6TinD+790RO5SZVon
         5fqPcoXWQL8y4mZ55pGP0+dhC92XYb9SHE6n0Ot7dBdVY8yBUEl5JEt2esHt4d+WBsc2
         EQ3TWO3IrOv3ooZA5fGgOhmUpZvWmFWo1/UoScc8xwijJkoP+FbixXcVWqPBsYA/Ua/r
         cONmfCoGoWV3508o9jaYfCw5akbWNdOWaLGq7sTXskvsuPXF6KRw8rV8p5453A12VjL1
         u0A2rcoNAuVb1pTkiKL0D0KmjuQ27JApGzXNtDawWTueguYhGw87NUJ/rh+cdbJci8Uw
         Nu3Q==
X-Gm-Message-State: AOAM530d0D76rhwOU/tfvArBlZ1zme7N76vQ5nkMpPFafmmnQG8Ow36R
        s2CbVne15Ep3w1NGpKD70Zg3m3AO4JU=
X-Google-Smtp-Source: ABdhPJzdVX/782rA+Mrfjzq4EMSpO8fatc13gWCfN+QkZzCSGvGiyiFUvG29GqatOznIFo3Zlp6j0Q==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr22809232wrp.405.1607846685222;
        Sun, 13 Dec 2020 00:04:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm22565118wml.8.2020.12.13.00.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:44 -0800 (PST)
Message-Id: <b4c400051adb7fa0e2256c13ce8af84891470267.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:25 +0000
Subject: [PATCH v3 18/20] tree: enable cmp_cache_name_compare() to be used
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
index e76517f6b18..a52479812ce 100644
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
index 93837450739..3eb0484cbf2 100644
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

