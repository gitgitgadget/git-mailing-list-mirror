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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52168C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 00:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048C964EC3
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 00:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhBXAAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 19:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhBWXrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:47:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F70C0617A7
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u125so268569wmg.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l2ofDQi8CbOpEuxER5ApmN4GoQTgWbuAVaO6UqD+chc=;
        b=TkqlqSXbBJ6n48K+uAxasaDkRmVfwsNFO+pioGixShctGtTCKfDNAxdzxo11nkEHh4
         G8ObHMuPmS3jDzGv7Vh8VacVqTOwlTDV9b0uFuz54FWV+Ma3r6okeOBJCPhsrVKu8j32
         V3dKLsOPa1G1lLXzg3qT8mF4TW4+ovkJW5CDNk5DVDLf3Qk5Yl+CuloG7adI70v6Qhvt
         bq05xCIAaw677C5SQ/XHb5aM5aCTg0z93+b2o6FWnYXcnyRNae/Nueo5EmCOO3jZHeNK
         ArG2Ti6u5cM0CQO6JoaHr7WYvGmAdWkFBGNNeN4Ol/7xnS+z17bwB3H/WP8yJUPUeFWd
         oN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l2ofDQi8CbOpEuxER5ApmN4GoQTgWbuAVaO6UqD+chc=;
        b=sjlZDsmyB4lHZvziFaPKgfBDsSmQxYeoewDL2DR95U8jdpTABzBbGaSizObfIAT5SA
         CgNnZCFOVvlxtgEHuaGKFCex4a/e+DYlIdYCuHbGV89A9LP7WCfGAuVXtmrPnP5AGOs2
         LKo8PMoMmf65a/hXdPHn4frlrkvHLxu4jXOMdcsXScl718IJy64J1UzF2bMVSF605LGt
         mUlTNtzBhmdn2HZI+v1FF6oHcXDmmSq99TEHPEI5gHzH3xjD5CruMIymMt3hW9aUtvyf
         2DBTV6h9MfSx9vrUoZleOtl5vqoITkLrFUd69f5oopDsLtf5V55ILLeMub/Y00WmVQtM
         tYOQ==
X-Gm-Message-State: AOAM5303NM6c9Xob3ZBekJlMMK0okPU9q+IKb1nQleUVxB7J2wJ5cTpC
        w9KHTleLbGdJBRPmtK07S7OCvyHwv6g=
X-Google-Smtp-Source: ABdhPJyyzwmyqxHApSnTqOxW1oJKY/Jaqa3M+DFLklKdQ27Dn93I9RgQ01CFEUBHJavulwaWwxpctw==
X-Received: by 2002:a1c:e384:: with SMTP id a126mr1060114wmh.42.1614123853437;
        Tue, 23 Feb 2021 15:44:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm353567wrj.52.2021.02.23.15.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:13 -0800 (PST)
Message-Id: <4983a1c2f908f02bc8a47f883c31652723ffde51.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:44:04 +0000
Subject: [PATCH v2 07/10] diffcore-rename: add a dir_rename_guess field to
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

