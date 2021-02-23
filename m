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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21933C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D615164E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhBWUQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhBWUP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD3C0617A9
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l12so23848837wry.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L6MQp2JdcxhlOlaQrA0yBx5aKzvSmmUcSuoEJrSyQ8k=;
        b=clkAJmySLfTcoHQEnzh18mqwNq/K129dvih0nPdk7vNLHVNfmohjQXefcNq8GdpIVn
         ZE9kg9KGy8aBT1W5mzoS/x4MEDzOPYqfns7OWDLO/ROLIdhGTxtHpNHff/DScRPftRGl
         ogQ5Qua1E9w3MuWPbElKubJF0GPBAGMShJ87fhVZkSO0kG53eHIQ/QUHr7jX48l0iXou
         4XO67X9PSBSE8FDD0FvPy9wi+8Afy8UevTr+YjBi1Pih9htHY6Q4aCbPOJR2ZCXojtCO
         d2H10mrApTMuqB+wyr0TR+jTUBBEzs6jQ0Ylh9ZnXBkeposEhcjcuXFNiPCzglQJKFf9
         QuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L6MQp2JdcxhlOlaQrA0yBx5aKzvSmmUcSuoEJrSyQ8k=;
        b=a2whkQ+YPwM1nTr4S6FL0OJOIQA9DqAOBWKQz+vpLlSm7lIe8UZ9oKEi6qmF5n26pE
         8azG81wGHlvLgZVwi9znL1Oyad0vdFoofHUrGbwJT60tHeSplFMzfutxt2Pombi5kMA9
         L8nvI4eE43D6rCVsn0tB+dUBBTxvqsCDN+UWydhNPxAIk027ALyssg2aHuKPYxfCnC+y
         5gdc9arjZuNqEJjBWFAaAOXbpD1oYjZWIfplybRy7abxG88PqS0IBT515x/p3SkIzrI/
         /NYS3+/lJ5CVseQwL8buZRgRUvIfh7J+LITvKKmrNXEoTp4TCIu1CWKWREpuB49IwupK
         o8pg==
X-Gm-Message-State: AOAM530ZjC632zaaLsPk0AJ+nHqntawilugUfoOXENW2pbzIBXz5S8Nr
        7bYHbqH6ljbTCToSfeXEyqY+prgm29c=
X-Google-Smtp-Source: ABdhPJwioOdIv4WXP2K5x5wc3LCu2xS3rrlcRgiCksV9FnPj+uJT8ZY6xO0l27mAMYexi+we8YnM/A==
X-Received: by 2002:adf:fd85:: with SMTP id d5mr15777641wrr.423.1614111277132;
        Tue, 23 Feb 2021 12:14:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm34737882wre.25.2021.02.23.12.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:36 -0800 (PST)
Message-Id: <f86d3dc154d172912c23bdc157afb9d9cc545a85.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:19 +0000
Subject: [PATCH 10/20] sparse-checkout: hold pattern list in index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
definition to filter out directories that are outsie the sparse cone.

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
index 1336c8d7435e..d75b352f38d3 100644
--- a/cache.h
+++ b/cache.h
@@ -307,6 +307,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 struct split_index;
 struct untracked_cache;
 struct progress;
+struct pattern_list;
 
 struct index_state {
 	struct cache_entry **cache;
@@ -332,6 +333,7 @@ struct index_state {
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
 	struct repository *repo;
+	struct pattern_list *sparse_checkout_patterns;
 };
 
 /* Name hashing */
-- 
gitgitgadget

