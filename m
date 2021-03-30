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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C0DC433F1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0DC619C8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhC3NLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhC3NLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00252C061762
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j9so14476998wrx.12
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AkJvT4gY7lKLChaTErd6DbcmGyVraiVliS0HbBhNfCE=;
        b=UbprqlNdSt0S4FKnFsL0jH6vnCFiI5MtJjoRbq27+yBk/CC3bQzPCAdgbzWn1rfu+g
         8puvKHIk9Kbk9GKLWzJ3EensbaqPcTGvLx/hjZMmsa18otA00taeZ8sD3MnoiMMhHw9O
         230ys6RBdKXY4cZTjztYeFFW2l1P2iQT0nUKXbsSs/MUtdbwePiqRAsaxsYcBJxJX4Jj
         GZKSdb6CsAqB5RMG+J6tmORwpPnKe8S7KHFSw/eW35NSbonKEAfuVpYJ3FQ0/fAiEkmB
         OiQygcQqKyPqjhysntgE22Fs2Gl1WE5GsEMPmqKB6GjyGNT4g5hv7s9ZcC04LfwteEti
         9aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AkJvT4gY7lKLChaTErd6DbcmGyVraiVliS0HbBhNfCE=;
        b=ClYjuct8W4KolGzuLZPJ0eUYBfaCSGeNjSr2I1vjWLuzq46ljC9pmdLsJxIIkJII7V
         sfiwmJef9b8K9JyKHo/TqQitHI1xswkyb22/CGAsFSDgsPRMlB1U/BCuTKDwlukPGrV2
         Cig5r+hT3n2/jGvkC0kcZmO2EhHE5nUmPZPos6TBMKcqEk5zr6KaH+P6N3u4aiiXQ9Jm
         ECnKYdieJSosMt0+QNCBgFyk5bn9UOoZZ+jJUoj8HV5hXSOstfiAbAwRxUO7hCFzkEZ/
         p46KIbnsB2nzGY9B2lG2Vc5gHpaeu2q3yZKRMvT2gOZ2XcC2GU/EIFUHxzecXPh9DVaz
         Id/A==
X-Gm-Message-State: AOAM531o4VVtX3K+KOQvPIZtfsNAYXZ49GjI4yJWWMdBpeTlkNgQbPrC
        VSuvodddTRSul/oL8IsuyShYFz0Lfkw=
X-Google-Smtp-Source: ABdhPJxf46Yapf3hk2mUJQZDkUyQx9qHXk0RUqVnrGsGiW7s+hkVVy78A/X0+WBBUSgchblWj2t2KQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr28941841wrc.317.1617109874778;
        Tue, 30 Mar 2021 06:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm38818960wra.65.2021.03.30.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:14 -0700 (PDT)
Message-Id: <c3651e26dc3ace4602eeb7c7bbe3ee15684de257.1617109864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:53 +0000
Subject: [PATCH v5 10/21] sparse-checkout: hold pattern list in index
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

