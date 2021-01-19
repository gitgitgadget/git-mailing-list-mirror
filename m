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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB07C433E9
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97E823104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbhAST74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392089AbhASTzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6137EC061793
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id s24so2164012wmj.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N10pSBx6/l8A1GlErUbjDT3w29kUzj8xpttyDUnNgqM=;
        b=obJP8HwTlY4LVqa2qipHao6zHb/AUXxZ9IFnmpkbhrt5IhhKOqNHhTKzBLfMV5nYhw
         8xG83PHxYxNYlEOPwpvgzK5TdJBOzwtjyXrZuo/dBXFcgq60ACStnbr4IJ2sILvLA+Lr
         TKGfFy0UsFZrmnUoMtvvuLjYRw/rolXPwvKO0M32jcEoyeRabMXhtsla2rel+Ljq3L3H
         C0oQFxaLSorgvmZ/VPfn4g1uCt1KTessEymc+GskG0Qc+AauKOTbNWOag2BdQvLVtBHw
         vfid9XuUrWzwK79gYf/IfkJqP6N8+Z40XHWmE9fV0TY2Svycaw/fl6M5vzkZRnuW+/s7
         X3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N10pSBx6/l8A1GlErUbjDT3w29kUzj8xpttyDUnNgqM=;
        b=l0jEB3A4Q8tGH2B/BOO8L0NzIawYtNW3/z0auPR0IdKL/vb8tcPS+14iizEYoHRGN6
         E/K7+jUu30Rn/19z9Tce+EdMIJxvzHgqfiVUnMRAiPeDSiNZvbXn8c5cxsaG5O6fdllm
         WVvS1GO3wqeWt9FSBivZESGH9Kj5LPc4Wltf9qiaav3n2yMoJ5HQP7v5J6fcY6Y4kmqq
         EZoMBfkdQPAaNw7bk1UMwm/cHUv3R7fvaTIjl7UkAHgbx8CjP+0W7HZAPH97Ykf0vvWF
         /BBsfZdEVitIiv/aGdMpovp/4lPE/g2SC9I7f5yA9Y4yYaE13dgOGcjhPtiFFaeobn79
         U9bA==
X-Gm-Message-State: AOAM530gZbVuAKvy4A7f+9q4tZXZlXun+/r6sX2oVQyqqq5kG+Wh40PO
        JncFypnLEaPVEkpyN315h8keCRLq3UA=
X-Google-Smtp-Source: ABdhPJwYPxs81/kawg7BBXWsnPdE5z80Qu511RC+jlprvY0woRLMIK0cf8tZpi8gDZnQgGp9P/MggA==
X-Received: by 2002:a1c:1f86:: with SMTP id f128mr1115548wmf.174.1611086042927;
        Tue, 19 Jan 2021 11:54:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm4702574wmc.12.2021.01.19.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:02 -0800 (PST)
Message-Id: <e9e621a0b7043f0e5b2660ef9eac152d63570bcc.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:45 +0000
Subject: [PATCH v3 09/17] merge-ort: modify collect_renames() for directory
 rename handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
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
index 6dea4206dc6..c86ed85b097 100644
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
@@ -959,6 +964,31 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
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
@@ -1284,22 +1314,44 @@ static void detect_regular_renames(struct merge_options *opt,
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
@@ -1314,6 +1366,20 @@ static int collect_renames(struct merge_options *opt,
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
 
@@ -1345,8 +1411,12 @@ static int detect_and_process_renames(struct merge_options *opt,
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

