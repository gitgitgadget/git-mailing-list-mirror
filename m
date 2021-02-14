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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71BC433E9
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273CF64E68
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBNIAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBNH7s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 02:59:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B5C061786
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a16so2822559wmm.0
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XuiYx4EO4YirUq4iYtjYiQAhDHbYcuAz1/sCPONw96E=;
        b=gTpxQUaxFt+uX88J3qD68M6ezDDzzLDqF+t5WclmJBw15v7Fei/kgjGYGjDrGKvESl
         OlKjbYqeG/TUQiAAAHfyhUpHMmPt8oCR+T+hhzKe3I5Zf7vSJ7D0bcXzwU+lcNwbAtLD
         sLLXIrahXMTB1qmCtFL1AyeLnP4KNF3zEr73MTqmatZcvrL8Ea2WTJ49lmGcphE2GD3g
         VS/2XiqCjffqCqh8jmOqZRduKsETwzsPOj4dfRGY7CTlhdd2O8RHaYfBZa2gRTifOIia
         pRCiwN6dsBYGDT/cjV5GjIPINdF28O3gRjQ6/rxvn1i4rXO31swQZY1NjUw957wAJjmL
         6/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XuiYx4EO4YirUq4iYtjYiQAhDHbYcuAz1/sCPONw96E=;
        b=PUJpGcUnKAphZfocPTfCWGuIAL0YnFyiVRxnQIdhQUoMYAXZgbb4sKteMWtNo2gmOQ
         OPMn1OnT9d210rQ6OF7pY+/SFHwNP2zu/lksqlda1vIE4O9v5BVqjoJZ/TSdvIFQtVWh
         AxkED5QgYw7nsAMhY6G3BczeyrJTZ+muYiHgux08ZVFfAQ3cvBnO0miHlk4pk62uC3VB
         6YNNy6vLVKkgEBLjisE8gVd/f9UsWNxNK/E2eTN1CGY8pFRQDAQlWq7n8ky6RfjQZEar
         ruSPB5/UwNne2S6/4QRXF9PzOCw5PsVXwqzQqE0BK0Fmd+iumBXuH0cfczITRh65XyIh
         9ZRg==
X-Gm-Message-State: AOAM530sC6eLP8as/LmjJPmzOj4gYaCridMc9LRXsDRY9f4DILbYRWIy
        6QH//Y7JLtQkTTZxPhHzGUVR4fgyUe0=
X-Google-Smtp-Source: ABdhPJxV7iub8lUnE22FbYomZ06kHkK6QjS9UbOrLqhbyX60rfrPL7o3l3jReYMgW94JhswEktK2UA==
X-Received: by 2002:a05:600c:4242:: with SMTP id r2mr9144918wmm.109.1613289546943;
        Sat, 13 Feb 2021 23:59:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm13479276wru.85.2021.02.13.23.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:06 -0800 (PST)
Message-Id: <93f98fc0b2644aab9e98b7a32e88561618c7d4c0.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:58:56 +0000
Subject: [PATCH 03/10] diffcore-rename: move dir_rename_counts into a
 dir_rename_info struct
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

This is a purely cosmetic change for now, but we will be adding
additional information to the struct and changing where and how it is
setup and used in subsequent patches.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 614a8d63012d..7759c9a3a2ed 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,6 +367,11 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
+struct dir_rename_info {
+	struct strmap *dir_rename_count;
+	unsigned setup;
+};
+
 static void dirname_munge(char *filename)
 {
 	char *slash = strrchr(filename, '/');
@@ -375,7 +380,7 @@ static void dirname_munge(char *filename)
 	*slash = '\0';
 }
 
-static void increment_count(struct strmap *dir_rename_count,
+static void increment_count(struct dir_rename_info *info,
 			    char *old_dir,
 			    char *new_dir)
 {
@@ -383,20 +388,20 @@ static void increment_count(struct strmap *dir_rename_count,
 	struct strmap_entry *e;
 
 	/* Get the {new_dirs -> counts} mapping using old_dir */
-	e = strmap_get_entry(dir_rename_count, old_dir);
+	e = strmap_get_entry(info->dir_rename_count, old_dir);
 	if (e) {
 		counts = e->value;
 	} else {
 		counts = xmalloc(sizeof(*counts));
 		strintmap_init_with_options(counts, 0, NULL, 1);
-		strmap_put(dir_rename_count, old_dir, counts);
+		strmap_put(info->dir_rename_count, old_dir, counts);
 	}
 
 	/* Increment the count for new_dir */
 	strintmap_incr(counts, new_dir, 1);
 }
 
-static void update_dir_rename_counts(struct strmap *dir_rename_count,
+static void update_dir_rename_counts(struct dir_rename_info *info,
 				     struct strset *dirs_removed,
 				     const char *oldname,
 				     const char *newname)
@@ -450,7 +455,7 @@ static void update_dir_rename_counts(struct strmap *dir_rename_count,
 		}
 
 		if (strset_contains(dirs_removed, old_dir))
-			increment_count(dir_rename_count, old_dir, new_dir);
+			increment_count(info, old_dir, new_dir);
 		else
 			break;
 
@@ -466,12 +471,15 @@ static void update_dir_rename_counts(struct strmap *dir_rename_count,
 	free(new_dir);
 }
 
-static void compute_dir_rename_counts(struct strmap *dir_rename_count,
-				      struct strset *dirs_removed)
+static void compute_dir_rename_counts(struct dir_rename_info *info,
+				      struct strset *dirs_removed,
+				      struct strmap *dir_rename_count)
 {
 	int i;
 
-	/* Set up dir_rename_count */
+	info->setup = 1;
+	info->dir_rename_count = dir_rename_count;
+
 	for (i = 0; i < rename_dst_nr; ++i) {
 		/*
 		 * Make dir_rename_count contain a map of a map:
@@ -480,7 +488,7 @@ static void compute_dir_rename_counts(struct strmap *dir_rename_count,
 		 * the old filename and the new filename and count how many
 		 * times that pairing occurs.
 		 */
-		update_dir_rename_counts(dir_rename_count, dirs_removed,
+		update_dir_rename_counts(info, dirs_removed,
 					 rename_dst[i].p->one->path,
 					 rename_dst[i].p->two->path);
 	}
@@ -499,10 +507,13 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
 }
 
 MAYBE_UNUSED
-static void clear_dir_rename_count(struct strmap *dir_rename_count)
+static void cleanup_dir_rename_info(struct dir_rename_info *info)
 {
-	partial_clear_dir_rename_count(dir_rename_count);
-	strmap_clear(dir_rename_count, 1);
+	if (!info->setup)
+		return;
+
+	partial_clear_dir_rename_count(info->dir_rename_count);
+	strmap_clear(info->dir_rename_count, 1);
 }
 
 static const char *get_basename(const char *filename)
@@ -791,8 +802,10 @@ void diffcore_rename_extended(struct diff_options *options,
 	int num_destinations, dst_cnt;
 	int num_sources, want_copies;
 	struct progress *progress = NULL;
+	struct dir_rename_info info;
 
 	trace2_region_enter("diff", "setup", options->repo);
+	info.setup = 0;
 	assert(!dir_rename_count || strmap_empty(dir_rename_count));
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (!minimum_score)
@@ -985,7 +998,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	/*
 	 * Now that renames have been computed, compute dir_rename_count */
 	if (dirs_removed && dir_rename_count)
-		compute_dir_rename_counts(dir_rename_count, dirs_removed);
+		compute_dir_rename_counts(&info, dirs_removed, dir_rename_count);
 
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
-- 
gitgitgadget

