Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5698EC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378C16052B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhG3Lrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbhG3Lrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:47:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DCC0613C1
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b13so90278wrs.3
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yzkzbi/Slg3JVOXhChvUByogsyK3fYn9Uf+8FgTW9dE=;
        b=j8UAfSsklfN1HDw0VsnG3e2ULkKpHzJbLV4pg2Tp4D9TyScflqKNKU9gvg69Un/FL0
         YLhwf9pfTNcZ+QcFRR84jRZ/oJMk6UMi//IUkR6tLVwUV5n9JWZQSF0uMYmw7EjbgNEs
         F7jo/0nqNLFqAZ7IWj2AGr1x2eUKzilIRVdscFFujkpdT9MBHDJGqHIWM36NSUpxoXBl
         akvTkDlXtQV6ym45Pb5Whh+DiBGfxvc9CsnKWs6lPQiKRr1krqGnKig8m/C/aGqkfY1g
         h/9YgySFIO+bT9dyEmBM9AjS+6ee4E+m7lIorktYdS5nz7pZztZq4U/umk3Ot/HJ5Qqh
         bHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yzkzbi/Slg3JVOXhChvUByogsyK3fYn9Uf+8FgTW9dE=;
        b=aJ8L/tY8sMZ4cQAAcAqf8O49ZLKbfelyIXIhNRmn+quAiDjcWAHL9nJ/Ub3XVAKdqB
         YPTUeiCtIP00yv7ZVHkJf+YUO4nFhQKSweVgIohyK0EOxyqNg6Sjp4gp+Yr/Ufkj7IuJ
         21i3UHW0Jys79HWgfhdvLg9KJMrvBK2Hpqtj00uVYHOLl7TGxFDhp2MpodDzkzbWcvjg
         XQzs8+/zap0NJ70IIWFKKI9/9wRncAxoL2RjBoh5o59nHMjlj+7Nm/tczGiXRlcI0sU/
         JqBUrR9otwuP1aQFao9WIkDqfwNXGCJ1qlN3Pnmo7uQezqfpuA19Es11zPh/qGw3Gh+i
         gmTQ==
X-Gm-Message-State: AOAM530iWAxDslFUAZEZ6myE4CBYsx6VoyTT7PV8aI5fsYqTGoWQd5pt
        xt+D6kC/ReJ3+GJZp6jR7XmbJBu15y4=
X-Google-Smtp-Source: ABdhPJxVYVpvFAP6CGNCZ1sSbiJPa9FpJcrvZ7hRdNZPsC9R8P9aoMrliN7JIcA6lkif3jnJOQyhQQ==
X-Received: by 2002:a5d:4562:: with SMTP id a2mr2553891wrc.347.1627645667139;
        Fri, 30 Jul 2021 04:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k186sm1862406wme.45.2021.07.30.04.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:46 -0700 (PDT)
Message-Id: <e075d985f269cdbf1fc67c99584b85d07538d603.1627645664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:36 +0000
Subject: [PATCH v3 1/9] merge-ort: rename str{map,intmap,set}_func()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to make it clearer that these three variables holding a
function refer to functions that will clear the strmap/strintmap/strset,
rename them to str{map,intmap,set}_clear_func().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index e75b524153e..401a40247a3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -519,11 +519,11 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 {
 	struct rename_info *renames = &opti->renames;
 	int i;
-	void (*strmap_func)(struct strmap *, int) =
+	void (*strmap_clear_func)(struct strmap *, int) =
 		reinitialize ? strmap_partial_clear : strmap_clear;
-	void (*strintmap_func)(struct strintmap *) =
+	void (*strintmap_clear_func)(struct strintmap *) =
 		reinitialize ? strintmap_partial_clear : strintmap_clear;
-	void (*strset_func)(struct strset *) =
+	void (*strset_clear_func)(struct strset *) =
 		reinitialize ? strset_partial_clear : strset_clear;
 
 	/*
@@ -534,14 +534,14 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	 * to deallocate them.
 	 */
 	free_strmap_strings(&opti->paths);
-	strmap_func(&opti->paths, 1);
+	strmap_clear_func(&opti->paths, 1);
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
 	 * opti->paths.  We don't want to deallocate anything twice, so we
 	 * don't free the keys and we pass 0 for free_values.
 	 */
-	strmap_func(&opti->conflicted, 0);
+	strmap_clear_func(&opti->conflicted, 0);
 
 	/*
 	 * opti->paths_to_free is similar to opti->paths; we created it with
@@ -559,24 +559,24 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 
 	/* Free memory used by various renames maps */
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
-		strintmap_func(&renames->dirs_removed[i]);
-		strmap_func(&renames->dir_renames[i], 0);
-		strintmap_func(&renames->relevant_sources[i]);
+		strintmap_clear_func(&renames->dirs_removed[i]);
+		strmap_clear_func(&renames->dir_renames[i], 0);
+		strintmap_clear_func(&renames->relevant_sources[i]);
 		if (!reinitialize)
 			assert(renames->cached_pairs_valid_side == 0);
 		if (i != renames->cached_pairs_valid_side &&
 		    -1 != renames->cached_pairs_valid_side) {
-			strset_func(&renames->cached_target_names[i]);
-			strmap_func(&renames->cached_pairs[i], 1);
-			strset_func(&renames->cached_irrelevant[i]);
+			strset_clear_func(&renames->cached_target_names[i]);
+			strmap_clear_func(&renames->cached_pairs[i], 1);
+			strset_clear_func(&renames->cached_irrelevant[i]);
 			partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
 			if (!reinitialize)
 				strmap_clear(&renames->dir_rename_count[i], 1);
 		}
 	}
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
-		strintmap_func(&renames->deferred[i].possible_trivial_merges);
-		strset_func(&renames->deferred[i].target_dirs);
+		strintmap_clear_func(&renames->deferred[i].possible_trivial_merges);
+		strset_clear_func(&renames->deferred[i].target_dirs);
 		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
 	}
 	renames->cached_pairs_valid_side = 0;
-- 
gitgitgadget

