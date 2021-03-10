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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F35EC43333
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC8D64FDC
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhCJTbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhCJTbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:15 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7308C061762
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so24640332wrx.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zTzPdzknucQx81xJWRuZF717S/E2tCr/L+NZEBArTdk=;
        b=jS2YlEXBAVLNFvl5jex/Ro/xmCKVujyBd4BpMHiOPsI/e02B9UZQvl2ceSeX7zcmJP
         NY0sj5qQOvArxnT3MO0goBsGtqiK6/HrjQWO6h9F0Skr8m91IcdcV1Iat3bwW+uq0Y8A
         5w5R9VoThKlBc45a7OcY92+06RXCu1Dl9M7BzkFDQQJXbCdQaL5HAvXIfsQr2ONPGGaX
         tqhOGVGnjSDdC1DG5hd+/eZps/nHuxf9eNuawMu/PFv1fJpoKwGXGN9KlnaiQG1sgkgq
         qGYrnnYYnYoFLx9Y8Bo99oFxmJ+MyVpr77m0DCWrlE0IwcW2+q7myuAF6kvsFWdU3Ccu
         qcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zTzPdzknucQx81xJWRuZF717S/E2tCr/L+NZEBArTdk=;
        b=cP+ncPQVHLCTJBIXnJGrboIYFBWyewoK9LXxXvhkYOppGTLHdmiAM3osHI4zS8dE+M
         froWx9XA0y2upJwpSaiC0JSSCVyt077KMYNXjF4yxlF7Y1aD3oXJ7eWK8CRiT9uVRyBL
         bIWf/cNUAimrBveCY8QUUzg+/9quIrL6uFv+wohK9gE9pMeopa2VrhUNsPovYFm3L3Zf
         TRikZyVmO2RC8FKhClJZIxEw0O3880KVn7s4jS/Xhmyu/y0xDCEOBMlluL9ogiMqpA/5
         MY0pV5qUD4hCSDajlGuVD/iQKngS0PmYOsJL4/oDRAIXHNxKBBxuJadxZIwxf2ENzwzB
         pkpg==
X-Gm-Message-State: AOAM5307VMAz9Bw/8VOtAkvsAMjVEuXpFibaaYV6CJlXgBlzBf2JBAqK
        sZfJqPeXbueg4A7cOp9UitiZ15bTORU=
X-Google-Smtp-Source: ABdhPJwbEvjyyBM55Et7BKrK/ZnZUlS/PoP0GtTCNFhF0Q6d3oL9ZpFdvi4Xo3PsM+TBbKWhCiMIvQ==
X-Received: by 2002:a5d:698d:: with SMTP id g13mr5232086wru.2.1615404673520;
        Wed, 10 Mar 2021 11:31:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s20sm392610wmj.36.2021.03.10.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:13 -0800 (PST)
Message-Id: <83aac8b7a1ec18d018205117dc2e98a5bb99d4c6.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:30:53 +0000
Subject: [PATCH v2 10/20] sparse-checkout: hold pattern list in index
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
index 1f0b42264606..303411726e10 100644
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

