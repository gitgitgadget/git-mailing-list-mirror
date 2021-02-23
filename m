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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F173C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050DC64E6F
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhBWXtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbhBWXoz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:44:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74383C06178C
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m1so299672wml.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XuiYx4EO4YirUq4iYtjYiQAhDHbYcuAz1/sCPONw96E=;
        b=eo/uM8SRqcdPu2HSwtyRGTC2OXLc0LVF4/KM8mlgRhPm6OT+dAtPlA+F5hVXdrIL0n
         vT3f0x/Hj4DGMike529SIutn4SCYG1zj+y/QKEYTCb9Lc8DUO6p66DPF6RHNfvOUe9Pf
         PqAqYtL7FMXP2IVvowXYOP3bvw99VaMqGVC0DZ+1orEK6nnDmUHWwmS7vhQ4PJ28hSHM
         ZXfoJ1D8ar/NVQIZewB9ETqmDRgA5efsT4gRQqi06qDaqr5qHXMGsnC06wsUjc8DVnxJ
         IwcHZWB03znBvhyrcBrGRE5cRp8xLBu57GIWsCjZw+EO6AsAkBM0q+EQ9FsthcvUN7KH
         LUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XuiYx4EO4YirUq4iYtjYiQAhDHbYcuAz1/sCPONw96E=;
        b=KIDym1nSkm7qMWQ4UjMSL5bQFPukPUQALxuXdLkEb/l/+yDATk5zzv5RVZI3uLeK5e
         pWHXeSInc0kHx5vjqZ16xkyjRiCREh2viHeymCUdaFr9HnCPZHMSdUEmw3Oa7RjHhuP9
         xhcAweT1/KxDZ4tfrYmRiB2ORtgDthow+3hW88zVtTx+rNm/h3cB++fJRlUxZ/v3SKXf
         i+46BTZwNgmT9WIUcfuLsLW/kf95QSq/oWcElu5/cGH0CeFo1smTFD1I6qwPagWJNyBB
         IRFal7viJzxQ2NyQAh8h3Ae6UYwSyBJfHQUMB9UQsitvKjYfSQVW7tGh5+b27+W6hFBV
         iadA==
X-Gm-Message-State: AOAM532rw/HK2YBXuoWfN3uCZqwC2kHdXlAzs4JHGykNu/GTiqrA7LXf
        oE1ywytiPgVs6J3Q+N5KCmXNRGvDVYY=
X-Google-Smtp-Source: ABdhPJwBd71ATwkRPqedf3h9P0xdH+oCb83V2rEcnE1npIiF3qkIQBjzLxXlOKBtIHVzRDFx6HmgDQ==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr1052175wmz.84.1614123851252;
        Tue, 23 Feb 2021 15:44:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm184925wmh.17.2021.02.23.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:44:11 -0800 (PST)
Message-Id: <93f98fc0b2644aab9e98b7a32e88561618c7d4c0.1614123848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
        <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 23:44:00 +0000
Subject: [PATCH v2 03/10] diffcore-rename: move dir_rename_counts into a
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

