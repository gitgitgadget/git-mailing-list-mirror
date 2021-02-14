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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D6AC433E0
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8609564E23
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBNIBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhBNIAa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 03:00:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF4FC06178C
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:10 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r5so262946wmp.1
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l2ofDQi8CbOpEuxER5ApmN4GoQTgWbuAVaO6UqD+chc=;
        b=XXQ0EkQkUiN71Fv6R7C02/BqL7s9Kq+SEIM16Ai1yGsYTFXdhjnWYWeppmFNRSny8L
         de4gq22fZdjcxPrPTqOFmnWAbmHtfJj1Kc4d4T5uQDzEFA/mX9DjW6Qj8it4CEwG58zL
         MWVA8yJO08DqxagynnDSN+NP2F3+anRLozJMF1u2wPnBFRYaiQDOm6uo2xk+FLd/ld92
         HuMyzV3u7SFkzN4n3ZwIbopfUB/7bmL36C/kV7pLr5zRk+yJrGYO/LRgbssBwiEC7UgS
         oSMpOZxB4gS9fXahNQkLnrwoVt+ethdCd/GofiivEXoZrsT2lXHGvwnvxErif4oQ3RDJ
         PxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l2ofDQi8CbOpEuxER5ApmN4GoQTgWbuAVaO6UqD+chc=;
        b=Kk0WlQAsSN4vaJEa8YpetAHwuH4qJVrT5nizqjfghd9lW983dECmsX9gFbvu46x97x
         Sol7QVQJc3+0+S8wzAewPnDtSmCoA97lXRG9buG0hy83cG5dDz/bT84QnSm6SlyLS8Kn
         xBMLFFZRx+JDPB/mn7XdeT3JsJT7kZSMYK8/MwNQCMK/Rogpg511EBxNQ9JuoLNmDeSA
         Z1FmoLeShMG2u4ILhxja4qK6r6/TdQ2YI6H2/+gjDpjHxHls6R3OwQzvBNaae8WSux5h
         Q4P2z1Kxy3M6k3A08vYNnf5B9y8RNi3qnqWy4t63UMQC/GL1KCva/d+gw+qooscnKdXF
         HQzw==
X-Gm-Message-State: AOAM530CaAXglU3+4EgeDGnfOvqklQ9WYJxhCLsmE4dWYsfe4jX5Cick
        Iq7aiCnWaD5+O26AwWz0yE2RzRn0c+U=
X-Google-Smtp-Source: ABdhPJyDV1kMvF4FrtGhMoJah1ajC0lJq3dBOFMprwDHq602Z9tXcsNjrwxdthsN3z2rvN6j2+2s+w==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr9399293wmf.82.1613289549201;
        Sat, 13 Feb 2021 23:59:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m205sm19934190wmf.40.2021.02.13.23.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:08 -0800 (PST)
Message-Id: <4983a1c2f908f02bc8a47f883c31652723ffde51.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:59:00 +0000
Subject: [PATCH 07/10] diffcore-rename: add a dir_rename_guess field to
 dir_rename_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

dir_rename_counts has a mapping of a mapping, in particular, it has
   old_dir => { new_dir => count }
We want a simple mapping of
   old_dir => new_dir
based on which new_dir had the highest count for a given old_dir.
Introduce dir_rename_guess for this purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index db569e4a0b0a..d24f104aa81c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -369,6 +369,7 @@ static int find_exact_renames(struct diff_options *options)
 
 struct dir_rename_info {
 	struct strintmap idx_map;
+	struct strmap dir_rename_guess;
 	struct strmap *dir_rename_count;
 	unsigned setup;
 };
@@ -381,6 +382,24 @@ static void dirname_munge(char *filename)
 	*slash = '\0';
 }
 
+static const char *get_highest_rename_path(struct strintmap *counts)
+{
+	int highest_count = 0;
+	const char *highest_destination_dir = NULL;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strintmap_for_each_entry(counts, &iter, entry) {
+		const char *destination_dir = entry->key;
+		intptr_t count = (intptr_t)entry->value;
+		if (count > highest_count) {
+			highest_count = count;
+			highest_destination_dir = destination_dir;
+		}
+	}
+	return highest_destination_dir;
+}
+
 static void increment_count(struct dir_rename_info *info,
 			    char *old_dir,
 			    char *new_dir)
@@ -498,6 +517,8 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 				       struct strset *dirs_removed,
 				       struct strmap *dir_rename_count)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
 	int i;
 
 	info->setup = 0;
@@ -511,6 +532,7 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 		strmap_init(info->dir_rename_count);
 	}
 	strintmap_init_with_options(&info->idx_map, -1, NULL, 0);
+	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
 
 	/*
 	 * Loop setting up both info->idx_map, and doing setup of
@@ -539,6 +561,23 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 					 rename_dst[i].p->one->path,
 					 rename_dst[i].p->two->path);
 	}
+
+	/*
+	 * Now we collapse
+	 *    dir_rename_count: old_directory -> {new_directory -> count}
+	 * down to
+	 *    dir_rename_guess: old_directory -> best_new_directory
+	 * where best_new_directory is the one with the highest count.
+	 */
+	strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
+		/* entry->key is source_dir */
+		struct strintmap *counts = entry->value;
+		char *best_newdir;
+
+		best_newdir = xstrdup(get_highest_rename_path(counts));
+		strmap_put(&info->dir_rename_guess, entry->key,
+			   best_newdir);
+	}
 }
 
 void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
@@ -566,6 +605,9 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	/* idx_map */
 	strintmap_clear(&info->idx_map);
 
+	/* dir_rename_guess */
+	strmap_clear(&info->dir_rename_guess, 1);
+
 	if (!keep_dir_rename_count) {
 		partial_clear_dir_rename_count(info->dir_rename_count);
 		strmap_clear(info->dir_rename_count, 1);
-- 
gitgitgadget

