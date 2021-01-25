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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF56C433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C67422583
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbhAYRzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731310AbhAYRzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D27C061353
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so13808444wrx.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vpAX72lNJ35KIs0L6NecQ5GsW2/fj8OPGN09bLouxHo=;
        b=Rb0ohfbbhQZAUtknHUVfO5eJmrGbru3ec1iIhdhJlOGPCs6TPiBjfp16GQT2MGlWSA
         wDfcZpGMIwWeKDNU3/3O9FV8a/rUTADEYeYLWc82PQZ/L+aKgAAqYppjAzXlxpJ9GbEL
         0zloGJwm99VifRXyIMiTL6lxl4UxQSNgowni0iMMKl2xArg/J5l7SAedQ2tPqdrY2+oj
         xXLmaNAXOhxqfQC+6iBepBK0i8oGgzdJ7ybTbQ4NpIHMmUPmwt4Hjw7gIK5f4YmQfe96
         ZirTe7k3Cep+0ToXcNa5F+CJAAf5ZA/h81JTARid3MXR/zzpyKdmYBtmI+nIgbjESrUe
         vg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vpAX72lNJ35KIs0L6NecQ5GsW2/fj8OPGN09bLouxHo=;
        b=fMoD5+H1q3S/6tbVjyAZMwQYVYgfCOhNqwQKP1ZnrhPvQDeVM2+f3ZE3ILcUFStNHq
         B7wZ0eZeF32orKuYBOfVuIgZj1mjhpQaOEr/1nNi0PW+NUqQi5YTVbPGx17yzxG0xlN0
         L5t+6U4ET2JYwWApZe6htiaBo7QjKxec6wMMkQIoiqRkRS6Dvo0LDUL0j06pnHdUgKmE
         Uf0EDwldSbyTGkuZjKt741eBXw064rECb4NDHW5RdsskNE65QEhBzerHHxn8IxCJLKjH
         elMZAKj5vk6+G5zbXW6yY6urc+aVbf5/Ad+PB3xTDVrVNndRePfqrnfU115hUDnyDNop
         Piuw==
X-Gm-Message-State: AOAM532GjaVNhlyziezaJTOu8zbFT/ouohIndFFDUayRpqdCoG2PHJjH
        4yRuqu17Pp2TXVVD31yzdYKgyW2PtlI=
X-Google-Smtp-Source: ABdhPJwxlgfXJcXdIliDxUAqppOsUE5/7bUEbBXRt7Yi7B4+lVgfxEL5Ege0ruTZppgI0jCG7vUrEQ==
X-Received: by 2002:adf:fb52:: with SMTP id c18mr2223302wrs.186.1611596543256;
        Mon, 25 Jan 2021 09:42:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm42848wmc.12.2021.01.25.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:22 -0800 (PST)
Message-Id: <80aac5b8b71da96d6287f19e30f4ee8f786ca07b.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:41:54 +0000
Subject: [PATCH 08/27] sparse-checkout: hold pattern list in index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
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
index 2306a9ad98e..e00b82af727 100644
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
index 884046ca5b8..b05341cc687 100644
--- a/cache.h
+++ b/cache.h
@@ -311,6 +311,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 struct split_index;
 struct untracked_cache;
 struct progress;
+struct pattern_list;
 
 struct index_state {
 	struct cache_entry **cache;
@@ -336,6 +337,7 @@ struct index_state {
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
 	struct repository *repo;
+	struct pattern_list *sparse_checkout_patterns;
 };
 
 /* Name hashing */
-- 
gitgitgadget

