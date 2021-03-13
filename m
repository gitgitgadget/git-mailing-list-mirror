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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455FC4332D
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7624D64EC9
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 22:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhCMWWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 17:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhCMWWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 17:22:14 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3CC061764
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g8so5898044wmd.4
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=728ZRLS/UuSnaBi3rp5Djtg/3cDb908K+cFCy0fteD0=;
        b=rBZfyjiY4WQlNMChiaa33DAra0K8giaedqcNH+GyVzK/QOvizWaCQE8ZtCP4MkyBZ4
         yz7kOvVYpOyGnKLwsbFyI4m7JSlXUgUYt2lGfT3VBvyeRfYjckKQiRwiAjuVAeVnhUL2
         oRyFyic20Lo4NyuKIQArXD8ZiMz/blfJm6f1tomz9O7z7eK8B4IYRKy/txHv4JAs46b/
         67rsEL4xS5rU/ppkofAhLuNTW0P9c1OeZ1iRqdHr8l8yPFtM9dfCeW6hVaLEd8bak/qj
         3J3kXZ0pjkgWspv/SVleAoIGK1Bgte+96rqUeghknIC+CPFFILmPVl1oBQvz8tg7iyXD
         t/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=728ZRLS/UuSnaBi3rp5Djtg/3cDb908K+cFCy0fteD0=;
        b=pteyvXz4BJIeCKULwlbQCW3qIeZdqea9Vg/fVq4s28L/jDz/S031iawm7jfCFRCybj
         AMhvBYRG0nF0s1r4ivGlN9FoQ1QRuzwPIFSKqvXiAXeBur5jbpBmLJ18Nz1avt+NIOIs
         /acuyscZQMCFYhvAFVWQkIPNEg+0/t/YU1tZUJKUWN8AaJmYCaj+cvKlllthEZJ2bI+1
         0BLB4YpVd79aqLV0FqM4jFlCnKYDjaRADjTgfvjq8BShq/oKWXr3Mr8EJtKdkLZscjug
         14Q8WzEwaqNk/d3dbSFhjhc55QleCFg4oeoSCR4is/FbkJUWK7hRKy1DcPneJhTVhQJv
         23ZQ==
X-Gm-Message-State: AOAM530kz2fbg4s9ppprusKBiqXv9bmh0i5JTh1VpoE/n6S66qh75q6l
        KUYCXC7wh7INA7DDwvqD2kidQu58Zcc=
X-Google-Smtp-Source: ABdhPJz0m8klXVN/Erh7cbMy5endjF1OxXOLiS1ayUYgD+wW/4AdqqYElN2OdwHp6vuourvTO45bVA==
X-Received: by 2002:a05:600c:2254:: with SMTP id a20mr20211007wmm.115.1615674131571;
        Sat, 13 Mar 2021 14:22:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n186sm7509887wmn.22.2021.03.13.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 14:22:11 -0800 (PST)
Message-Id: <05850cb49823ea9c6d6c7cfd3b4adbbc1c47abc6.1615674128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.853.git.1615674128.gitgitgadget@gmail.com>
References: <pull.853.git.1615674128.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Mar 2021 22:22:03 +0000
Subject: [PATCH 3/8] merge-ort: record the reason that we want a rename for a
 directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When one side of history renames a directory, and the other side of
history added files to the old directory, directory rename detection is
used to warn about the location of the added files so the user can
move them to the old directory or keep them with the new one.

This sets up three different types of directories:
  * directories that had new files added to them
  * directories underneath a directory that had new files added to them
  * directories where no new files were added to it or any leading path

Save this information in dirs_removed; the next several commits will
make use of this information.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c |  2 +-
 diffcore.h        |  7 +++++++
 merge-ort.c       | 41 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6487825317ff..fafec66b29e9 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -667,7 +667,7 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 		const char *source_dir = entry->key;
 		struct strintmap *counts = entry->value;
 
-		if (!strintmap_contains(dirs_removed, source_dir)) {
+		if (!strintmap_get(dirs_removed, source_dir)) {
 			string_list_append(&to_remove, source_dir);
 			strintmap_clear(counts);
 			continue;
diff --git a/diffcore.h b/diffcore.h
index 4f168b385fde..d5a497b7a162 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -161,6 +161,13 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *,
 				 struct diff_filespec *);
 void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
+/* dir_rename_relevance: the reason we want rename information for a dir */
+enum dir_rename_relevance {
+	NOT_RELEVANT = 0,
+	RELEVANT_FOR_ANCESTOR = 1,
+	RELEVANT_FOR_SELF = 2
+};
+
 void partial_clear_dir_rename_count(struct strmap *dir_rename_count);
 
 void diffcore_break(struct repository *, int);
diff --git a/merge-ort.c b/merge-ort.c
index 6fa670396ce4..e2606c73ad88 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -73,6 +73,10 @@ struct rename_info {
 
 	/*
 	 * dirs_removed: directories removed on a given side of history.
+	 *
+	 * The keys of dirs_removed[side] are the directories that were removed
+	 * on the given side of history.  The value of the strintmap for each
+	 * directory is a value from enum dir_rename_relevance.
 	 */
 	struct strintmap dirs_removed[3];
 
@@ -729,10 +733,41 @@ static void collect_rename_info(struct merge_options *opt,
 	if (dirmask == 1 || dirmask == 3 || dirmask == 5) {
 		/* absent_mask = 0x07 - dirmask; sides = absent_mask/2 */
 		unsigned sides = (0x07 - dirmask)/2;
+		unsigned relevance = (renames->dir_rename_mask == 0x07) ?
+					RELEVANT_FOR_ANCESTOR : NOT_RELEVANT;
+		/*
+		 * Record relevance of this directory.  However, note that
+		 * when collect_merge_info_callback() recurses into this
+		 * directory and calls collect_rename_info() on paths
+		 * within that directory, if we find a path that was added
+		 * to this directory on the other side of history, we will
+		 * upgrade this value to RELEVANT_FOR_SELF; see below.
+		 */
 		if (sides & 1)
-			strintmap_set(&renames->dirs_removed[1], fullname, 1);
+			strintmap_set(&renames->dirs_removed[1], fullname,
+				      relevance);
 		if (sides & 2)
-			strintmap_set(&renames->dirs_removed[2], fullname, 1);
+			strintmap_set(&renames->dirs_removed[2], fullname,
+				      relevance);
+	}
+
+	/*
+	 * Here's the block that potentially upgrades to RELEVANT_FOR_SELF.
+	 * When we run across a file added to a directory.  In such a case,
+	 * find the directory of the file and upgrade its relevance.
+	 */
+	if (renames->dir_rename_mask == 0x07 &&
+	    (filemask == 2 || filemask == 4)) {
+		/*
+		 * Need directory rename for parent directory on other side
+		 * of history from added file.  Thus
+		 *    side = (~filemask & 0x06) >> 1
+		 * or
+		 *    side = 3 - (filemask/2).
+		 */
+		unsigned side = 3 - (filemask >> 1);
+		strintmap_set(&renames->dirs_removed[side], dirname,
+			      RELEVANT_FOR_SELF);
 	}
 
 	if (filemask == 0 || filemask == 7)
@@ -3446,7 +3481,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	renames = &opt->priv->renames;
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		strintmap_init_with_options(&renames->dirs_removed[i],
-					    0, NULL, 0);
+					    NOT_RELEVANT, NULL, 0);
 		strmap_init_with_options(&renames->dir_rename_count[i],
 					 NULL, 1);
 		strmap_init_with_options(&renames->dir_renames[i],
-- 
gitgitgadget

