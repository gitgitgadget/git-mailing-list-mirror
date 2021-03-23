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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C8C433E6
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0061619C3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhCWNpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhCWNom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541D2C0613DE
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p19so11089833wmq.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AkJvT4gY7lKLChaTErd6DbcmGyVraiVliS0HbBhNfCE=;
        b=hmsbLSsNu2AJ/dXSUVQ6sgRDsjG2Yxtl1OUCUWZY/RQMw1BTRe4dMiy00CEd/d3aHv
         P+/19o4bNglSPR+ZVzt35uPXk83C0jFW7RCeLXuux97CN9bs11btFuSFWhlUTIIfdJDW
         0kzSJuN8aBEoUaoHGu7neWZsSmEc9WMav8bc7icDg7ntmN0uCJDFM3Mzrogot57jrfHt
         dX2jZbf6j7mC43coaWDufJpjsIe2TUCdHpRd7APGJZt8hv1RwssIIJ8EyCEuLaC8b1JA
         G7Qhhj64VLsP0hPJmddxt79Dvf6SpbxJmc1DezVHFUu5+kn1bLrADnCgFQqSedwx0B6o
         AdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AkJvT4gY7lKLChaTErd6DbcmGyVraiVliS0HbBhNfCE=;
        b=YOrx51vHFDL7Wx2PjwBOrp91KFyUgSf6PjK5akLAjOa4M/u9t8cH6BPZ1XJzO+9pZE
         jCXfRiEmHtn9siyEcEffBMdDDZYRnjvSd6++L8xO8HHY2O7Pbf6w0AysiXeu1j2GlJ98
         RhBWT7OIgU/W44iNLy9M8ZpwyAZjgKGdkZ2vyP6in3AN9FhtaUvvtCMH8ESFi40I51gr
         NtHFROfcKbaZRnT4gyDnAg7eLrTVJN0a8IUg2BdRBzNFO5BcO8Hxr2l12yP82Vudbj+G
         Uad+Qq4IqpWI+pHeBiSyYORi0qECREeslGljVclu6Nt3SCa+kvlhjVmr0MIOecKttlaB
         Ra/Q==
X-Gm-Message-State: AOAM530lfeIAjX7W6bb2AKqnrhyM108Y5bHW2DR1E5AeUQ/ARwBSYZyU
        rnJ2WmpQbWTkx0q2eeNhAUeRAp6tEIw=
X-Google-Smtp-Source: ABdhPJyBFrGeELZldiBqcSNQkdyeeUPtreRZYN0rYl2npSaZMxiITzjoPl8MUKPqgdmdJwSG7+ZtYA==
X-Received: by 2002:a05:600c:9:: with SMTP id g9mr3568929wmc.134.1616507079083;
        Tue, 23 Mar 2021 06:44:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm2573865wmq.29.2021.03.23.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:38 -0700 (PDT)
Message-Id: <7308c87697f179c06a6dc1abd85b64230060bc25.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:18 +0000
Subject: [PATCH v4 10/20] sparse-checkout: hold pattern list in index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we modify the sparse-checkout definition, we perform index operations
on a pattern_list that only exists in-memory. This allows easy backing
out in case the index update fails.

However, if the index write itself cares about the sparse-checkout
pattern set, we need access to that in-memory copy. Place a pointer to
a 'struct pattern_list' in the index so we can access this on-demand.
This will be used in the next change which uses the sparse-checkout
definition to filter out directories that are outside the sparse cone.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c | 17 ++++++++++-------
 cache.h                   |  2 ++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2306a9ad98e0..e00b82af727b 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -110,6 +110,8 @@ static int update_working_directory(struct pattern_list *pl)
 	if (is_index_unborn(r->index))
 		return UPDATE_SPARSITY_SUCCESS;
 
+	r->index->sparse_checkout_patterns = pl;
+
 	memset(&o, 0, sizeof(o));
 	o.verbose_update = isatty(2);
 	o.update = 1;
@@ -138,6 +140,7 @@ static int update_working_directory(struct pattern_list *pl)
 	else
 		rollback_lock_file(&lock_file);
 
+	r->index->sparse_checkout_patterns = NULL;
 	return result;
 }
 
@@ -517,19 +520,18 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 {
 	int result;
 	int changed_config = 0;
-	struct pattern_list pl;
-	memset(&pl, 0, sizeof(pl));
+	struct pattern_list *pl = xcalloc(1, sizeof(*pl));
 
 	switch (m) {
 	case ADD:
 		if (core_sparse_checkout_cone)
-			add_patterns_cone_mode(argc, argv, &pl);
+			add_patterns_cone_mode(argc, argv, pl);
 		else
-			add_patterns_literal(argc, argv, &pl);
+			add_patterns_literal(argc, argv, pl);
 		break;
 
 	case REPLACE:
-		add_patterns_from_input(&pl, argc, argv);
+		add_patterns_from_input(pl, argc, argv);
 		break;
 	}
 
@@ -539,12 +541,13 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 		changed_config = 1;
 	}
 
-	result = write_patterns_and_update(&pl);
+	result = write_patterns_and_update(pl);
 
 	if (result && changed_config)
 		set_config(MODE_NO_PATTERNS);
 
-	clear_pattern_list(&pl);
+	clear_pattern_list(pl);
+	free(pl);
 	return result;
 }
 
diff --git a/cache.h b/cache.h
index 136dd496c95d..8c4464420d0a 100644
--- a/cache.h
+++ b/cache.h
@@ -307,6 +307,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 struct split_index;
 struct untracked_cache;
 struct progress;
+struct pattern_list;
 
 struct index_state {
 	struct cache_entry **cache;
@@ -338,6 +339,7 @@ struct index_state {
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
 	struct repository *repo;
+	struct pattern_list *sparse_checkout_patterns;
 };
 
 /* Name hashing */
-- 
gitgitgadget

