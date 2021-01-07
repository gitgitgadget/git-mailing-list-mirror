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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A1C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F9123444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbhAGUCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbhAGUCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07ADC0612FF
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:38 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a12so6805112wrv.8
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IM9iUgvIbWyIXf1PCkOZI86FcaiMwFm5yW5FJzWa8Ao=;
        b=JRA7yteWnlVxyuDgI2O8qXhqt/APGkbbObax/5e0egnfokICAOBJudvyGV70c+BhO6
         6agFVq+m0e/dewsI4kIwK+O6kvyjhBWfAaluiX7e4RvuTvS7s8XT0yAbXPjsDqYKP4Xg
         2yr1TeY5Gsrvuk8brjtc/NWLs5geMFcuO3HtG1lku26Ysx/9iJRCV9WYj/pvZzZS1wV+
         FLwKkvQPxa8zU2321A3K5rWxZ/G1qu3Jv80QZTPkA+A5CRFWkKJIOGRHwJYEAi2SJG8n
         Eb0jQkQtmsAz3tIP6J3L+1LnCsC7XHDGH0oDBP8nSV2u7L9v0843xuae4O5kCOll9kBo
         k/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IM9iUgvIbWyIXf1PCkOZI86FcaiMwFm5yW5FJzWa8Ao=;
        b=nv0zZHo1Laapl2SOZClWWNTb1DC0fW5B0hq94uJs3rh9Nxee0luRTFmCwcfWzm98W3
         mY1fzrSop3Mna18U4AsTfgMtJpZ9l4lR1DNbPan8gMONDwTGHyEbMEnlqmAyDTtAu/d/
         uLttOll4YV9yuftTDx6Qk9ZZQYsPZZN2uC7UoR2S3cs+iZyu25jkFa2nXb5Ru3aTRHH+
         cb5hYk27JKMpbB7FpCoTO2TVtIeq/pj+zm6mF0FDkcRdLUTWWdrqTcxJiWgbnmMsh5Th
         +hO0LxUWhpWC8YIXXJG10dCAcczOuYvy0qzs4MayMnkhFQ/P3+ND/2ilTgb76cQ26uTC
         wFTA==
X-Gm-Message-State: AOAM5324vJp92xJnHwDqiU1wEttd0QOh9HY39e+nJ8Guow7CLSgy5Gf+
        8yjkhMkVDvQdkdR7jAiQ/i6pFi0wSds=
X-Google-Smtp-Source: ABdhPJwD1OCVKT1roLbHFzj0Uxr9BeEDwOsbHK0PDl00kSQH5HE2bIuPtqzK/El8Cgzk6aKU0of+lg==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr252000wru.219.1610049697548;
        Thu, 07 Jan 2021 12:01:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm10610777wrn.59.2021.01.07.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:37 -0800 (PST)
Message-Id: <bdd9d6cd70274477050e87a3f0a0aa18496f3a22.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:18 +0000
Subject: [PATCH 09/18] merge-ort: modify collect_renames() for directory
 rename handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

collect_renames() is similar to merge-recursive.c's get_renames(), but
lacks the directory rename handling found in the latter.  Port that code
structure over to merge-ort.  This introduces three new
die-not-yet-implemented functions that will be defined in future
commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index feeb838231a..f7ecd76c479 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,6 +721,11 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
+struct collision_info {
+	struct string_list source_files;
+	unsigned reported_already:1;
+};
+
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -960,6 +965,31 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 	string_list_clear(&duplicated, 0);
 }
 
+static void compute_collisions(struct strmap *collisions,
+			       struct strmap *dir_renames,
+			       struct diff_queue_struct *pairs)
+{
+	die("Not yet implemented.");
+}
+
+static char *check_for_directory_rename(struct merge_options *opt,
+					const char *path,
+					unsigned side_index,
+					struct strmap *dir_renames,
+					struct strmap *dir_rename_exclusions,
+					struct strmap *collisions,
+					int *clean_merge)
+{
+	die("Not yet implemented.");
+}
+
+static void apply_directory_rename_modifications(struct merge_options *opt,
+						 struct diff_filepair *pair,
+						 char *new_path)
+{
+	die("Not yet implemented.");
+}
+
 /*** Function Grouping: functions related to regular rename detection ***/
 
 static int process_renames(struct merge_options *opt,
@@ -1285,22 +1315,44 @@ static void detect_regular_renames(struct merge_options *opt,
  */
 static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
-			   unsigned side_index)
+			   unsigned side_index,
+			   struct strmap *dir_renames_for_side,
+			   struct strmap *rename_exclusions)
 {
 	int i, clean = 1;
+	struct strmap collisions;
 	struct diff_queue_struct *side_pairs;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
 	struct rename_info *renames = &opt->priv->renames;
 
 	side_pairs = &renames->pairs[side_index];
+	compute_collisions(&collisions, dir_renames_for_side, side_pairs);
 
 	for (i = 0; i < side_pairs->nr; ++i) {
 		struct diff_filepair *p = side_pairs->queue[i];
+		char *new_path; /* non-NULL only with directory renames */
 
-		if (p->status != 'R') {
+		if (p->status != 'A' && p->status != 'R') {
 			diff_free_filepair(p);
 			continue;
 		}
 
+		new_path = check_for_directory_rename(opt, p->two->path,
+						      side_index,
+						      dir_renames_for_side,
+						      rename_exclusions,
+						      &collisions,
+						      &clean);
+
+		if (p->status != 'R' && !new_path) {
+			diff_free_filepair(p);
+			continue;
+		}
+
+		if (new_path)
+			apply_directory_rename_modifications(opt, p, new_path);
+
 		/*
 		 * p->score comes back from diffcore_rename_extended() with
 		 * the similarity of the renamed file.  The similarity is
@@ -1315,6 +1367,20 @@ static int collect_renames(struct merge_options *opt,
 		result->queue[result->nr++] = p;
 	}
 
+	/* Free each value in the collisions map */
+	strmap_for_each_entry(&collisions, &iter, entry) {
+		struct collision_info *info = entry->value;
+		string_list_clear(&info->source_files, 0);
+	}
+	/*
+	 * In compute_collisions(), we set collisions.strdup_strings to 0
+	 * so that we wouldn't have to make another copy of the new_path
+	 * allocated by apply_dir_rename().  But now that we've used them
+	 * and have no other references to these strings, it is time to
+	 * deallocate them.
+	 */
+	free_strmap_strings(&collisions);
+	strmap_clear(&collisions, 1);
 	return clean;
 }
 
@@ -1346,8 +1412,12 @@ static int detect_and_process_renames(struct merge_options *opt,
 	ALLOC_GROW(combined.queue,
 		   renames->pairs[1].nr + renames->pairs[2].nr,
 		   combined.alloc);
-	clean &= collect_renames(opt, &combined, MERGE_SIDE1);
-	clean &= collect_renames(opt, &combined, MERGE_SIDE2);
+	clean &= collect_renames(opt, &combined, MERGE_SIDE1,
+				 &renames->dir_renames[2],
+				 &renames->dir_renames[1]);
+	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
+				 &renames->dir_renames[1],
+				 &renames->dir_renames[2]);
 	QSORT(combined.queue, combined.nr, compare_pairs);
 
 	clean &= process_renames(opt, &combined);
-- 
gitgitgadget

