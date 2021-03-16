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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB7C4321A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AC865111
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhCPQoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbhCPQnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD54C06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so10799157wrx.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v9Eykv/Bcp1PY3+/HvFDzf+sslGlfcSnKU+nMpjHnlk=;
        b=u96eDHj9wH5DRbz5ZpOVz61UErKfVK7Tdivb+OARyqlNtO4YgF7dgJ9uZx19ntt5s/
         SXvI5q9PFJZbXnvq86laOl8VdHzFlwOu3Qkiae00nHXlMTWdF8WHrARTBFjmvbKc5sB+
         zB5PYFXB0OoKlzVqoWd0mLXFjCO42cB4w1rb0gvPvQpNxuRyLJLnPVx5LgDRuvcZVyU4
         qhwvx8zSmdRY+t9kAJD6mD/4pwkTEy5xizFLiVWih2Ug2HmeCsZKn+iaJBJO+1sxgXp7
         fgHjUNM71j0p56LJa+y2xFk+2nOCkXkOZOWY931tRfLLuxzqcgk1Amy1o39BYXXrDjsp
         7l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v9Eykv/Bcp1PY3+/HvFDzf+sslGlfcSnKU+nMpjHnlk=;
        b=jW+YSwaGT+Fp9qEWAAP30XLXqcdpkaVmTdVnuFiUpmB6eMRWHHoA9IXXuweZpbgcmM
         ONVCASkeecSIIX0eHdl58loEjxuO3uRXQGDLMoQe5JulLUHaUxU3hlB8sGMwdhBgUe/Y
         sPXjWGAuiUOyhRuo/oTyt3BVJWo3DjlYoq5hKj4cKlL0mB9Q020hLpoXBOay59cY2CIo
         b7mpWd0GF9+jfvMUC4b6lM9ZzAyjArcguWL5EZ6opdM4chWj977h2UqAootv+9VSu6e7
         PB3osTC82+p0uHUAWeNE25SY0LaJwvqfG8EE4sJnHJdljbe8qcGKSeLMomckAiAEGFg+
         iBmA==
X-Gm-Message-State: AOAM5334MbRCNk1jewmVAX6b02BDxtF1RXvuomO1Xdi8otBaZUbKQCyT
        PkUeYFss9CJCa3PagxOn4DiNG9sCRnY=
X-Google-Smtp-Source: ABdhPJwMvqVjpZ5vvrRSVOI4Mg8F7d9+XKa9IO2jfg//tpC6GHC6B6ASfhsoJziFypO2FnYzyIIajQ==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr6071608wrw.247.1615912992364;
        Tue, 16 Mar 2021 09:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm26824109wrm.0.2021.03.16.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:11 -0700 (PDT)
Message-Id: <33fdba2b8cfdf3b7d003989a0ba1264ae8f9bb99.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:42:53 +0000
Subject: [PATCH v3 10/20] sparse-checkout: hold pattern list in index
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
index abb00a068e5d..759ca92e2ecc 100644
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

