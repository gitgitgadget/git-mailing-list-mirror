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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCDCC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A0E64EFA
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBZB7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBZB7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EE4C06178B
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w7so6174210wmb.5
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eQoaYcKyzPcew4W23zmKB5BiPa6HfP+sUKPEs8GxRz0=;
        b=mm1i1MFqzhCEVYIupwltNR4N+O0PXLL3cmYi+EPj5/018P5zfDAfneTC2zljrifTjY
         y4aZFZqW6AgUOjvrDZRkm68i26UPmTbmOIKUZpj3Jq4BO/ZfowVovC+BqhkzPCW9KWIn
         aST4FgnjZLPS4KAnLNQwXmZ2s3IjO+N7yXQoIBa7hhSdllWjsDSVp/TXLEY3W1IgWNYZ
         1iZqwJL5+b0Y5RkG5BGCm0r3Ojv/qvP8gZjk+YA26IhUG/yNm0tpjk5UDdb8r0LnPw4J
         ObtnzYEAqK4+Wqx8q7TWM4R/LLdabqQUzyFt4LYu5pFuU268NF2G1tzfCMgY9XOYVRa6
         aLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eQoaYcKyzPcew4W23zmKB5BiPa6HfP+sUKPEs8GxRz0=;
        b=HgzsiO5+2Y3penBaUULR9NIuWZvERoOAdHMbZuKFwkFaPi5gAjpumsdm9I59RALrPw
         2qIOXY9zD+7YknS4XXovWpotTZg/8gHDAYPi1Y1fOO7/Ls9KuY56v/3+G1uAEE/FHuA/
         AlgLqQhEj1v9zu0syjx1KUrkUDy/Z+Y+3FBkZJwIgozE4Iv7DLXWDAZTga+/I4n6dAmG
         Sm6O1hyr6kAo0rQNPahkGwX6X1guB1AtJgIDUvU1Iiylpao8aY32iseX0BMIrN3+Tdyf
         Nvb/dnZt16pa0YRg/Ell872sYE1MSBklgeqakSWRPYj8+FTh0VK7CKl2ODTPfSmp7GnF
         1FAg==
X-Gm-Message-State: AOAM530RnpMTJk9DZKfA2dXM3vCRTeEOYXhLVF6JqTE+Jip/EZFPA0xq
        LbbY+ZdqOK5tWU1JUxFmOKsZiOd0cVY=
X-Google-Smtp-Source: ABdhPJzHYFvyYAGocSiLtn/d3xMOxVKoVt0u/01B0AQfjtTD8/YsS1bJn57pUVyNviXGiVWZ9CSijA==
X-Received: by 2002:a1c:2186:: with SMTP id h128mr413188wmh.178.1614304706489;
        Thu, 25 Feb 2021 17:58:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm11255924wrt.33.2021.02.25.17.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:26 -0800 (PST)
Message-Id: <ab353f2e75ebe4744cd3eb65f74f1242ba53e989.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:15 +0000
Subject: [PATCH v3 06/10] diffcore-rename: move dir_rename_counts into
 dir_rename_info struct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This continues the migration of the directory rename detection code into
diffcore-rename, now taking the simple step of combining it with the
dir_rename_info struct.  Future commits will then make dir_rename_counts
be computed in stages, and add computation of dir_rename_guess.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7dd475ff9a9f..a1ccf14001f5 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -388,7 +388,7 @@ static void dirname_munge(char *filename)
 	*slash = '\0';
 }
 
-static void increment_count(struct strmap *dir_rename_count,
+static void increment_count(struct dir_rename_info *info,
 			    char *old_dir,
 			    char *new_dir)
 {
@@ -396,20 +396,20 @@ static void increment_count(struct strmap *dir_rename_count,
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
@@ -463,7 +463,7 @@ static void update_dir_rename_counts(struct strmap *dir_rename_count,
 		}
 
 		if (strset_contains(dirs_removed, old_dir))
-			increment_count(dir_rename_count, old_dir, new_dir);
+			increment_count(info, old_dir, new_dir);
 		else
 			break;
 
@@ -479,12 +479,15 @@ static void update_dir_rename_counts(struct strmap *dir_rename_count,
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
 		/* File not part of directory rename counts if not a rename */
 		if (!rename_dst[i].is_rename)
@@ -497,7 +500,7 @@ static void compute_dir_rename_counts(struct strmap *dir_rename_count,
 		 * the old filename and the new filename and count how many
 		 * times that pairing occurs.
 		 */
-		update_dir_rename_counts(dir_rename_count, dirs_removed,
+		update_dir_rename_counts(info, dirs_removed,
 					 rename_dst[i].p->one->path,
 					 rename_dst[i].p->two->path);
 	}
@@ -551,7 +554,9 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info)
 	/* dir_rename_guess */
 	strmap_clear(&info->dir_rename_guess, 1);
 
-	/* Nothing to do for dir_rename_count, yet */
+	/* dir_rename_count */
+	partial_clear_dir_rename_count(info->dir_rename_count);
+	strmap_clear(info->dir_rename_count, 1);
 }
 
 static const char *get_basename(const char *filename)
@@ -1140,7 +1145,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	/*
 	 * Now that renames have been computed, compute dir_rename_count */
 	if (dirs_removed && dir_rename_count)
-		compute_dir_rename_counts(dir_rename_count, dirs_removed);
+		compute_dir_rename_counts(&info, dirs_removed, dir_rename_count);
 
 	/* At this point, we have found some renames and copies and they
 	 * are recorded in rename_dst.  The original list is still in *q.
-- 
gitgitgadget

