Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B44C43381
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBD82255F
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhADXvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhADXvU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:20 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F8FC0617A2
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:39 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 9so6688018ooy.7
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2NDkgdwIZLhIA+8d2WTIMJr3YqBZJibNdEHzP4jnCck=;
        b=upg2qBTTQOPDsF1YuYk8+94EbFNC/fZxxRN/2r1XzmcbOeo5N/SlUNpeL8KILFUK82
         /aAUvVPDxO9ioCoQXaQ9tv+mupFko47WGzg9g9Xz3Z9qXpu+VX1DzE2tnZO737k+w3Pm
         5v8aTk58MVxrlJXWfLweNwbbGeLn2O1XrZWsPLPKm8MGh19ru5QQ+q5sr/g5WASv27vD
         ZSBfsTZlOkmW806Yt872SIEgvmi2NeCRi7iMeu3R40iJPfun6EofKcT49Ph2Rs1s+B4e
         6s6Uq5zZ6e6fBSLMcZiDjleNJeI9nbyDdU12UJ2WEmAIvG5hwQMvQPox3m+5wupdJzNZ
         bnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NDkgdwIZLhIA+8d2WTIMJr3YqBZJibNdEHzP4jnCck=;
        b=eGnXQde6lSNoFpbxU8okZ0nVg5qNSXbhDrCShK9f0Ez2gNrmajkjTJK7u1qRwl2vbY
         zdBp2K8q8mIy1ZnDdyeeQKqBQFF74njR+TJSnqB3xw8sP2bMrPeUBAlvedJ/kM+ISP5Y
         dwiIFWqv2d3L3OIdOLNev9b2Tpwm5FHRbf3N6KgjeMlJ82mfQEaI8r2RUgvZGrRy7IWd
         S8xRPYkI3y6SiRbvIjnsTP+xMUXXCyKBV2l8Hm1V3MuIBlUAH0He/A2FJhhjNjPJeTBx
         yyMyuHPAqho2ZCO/mehysQ3Ch2Ngkqs7sJiIo+hNU/RyqOXDAGP9VmDOzGWX9KMUi+Bi
         /rZg==
X-Gm-Message-State: AOAM532pZCP10/ePFxUpr9cjjmGkcC6HNCyCwBvkHm1I+huPKEMBfQpu
        gkMFPQZgd0gJm+hUiCIauk0TIIWCroU=
X-Google-Smtp-Source: ABdhPJz0qh4J1MBxy9ZiH81as6CynhDKkX47jKMfzYU8wqnIipXBOd0ZuJO1TKZcogCnv4Bnyg1EaA==
X-Received: by 2002:a4a:901a:: with SMTP id i26mr50894069oog.42.1609804238698;
        Mon, 04 Jan 2021 15:50:38 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:38 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 09/17] merge-ort: modify collect_renames() for directory rename handling
Date:   Mon,  4 Jan 2021 15:49:58 -0800
Message-Id: <20210104235006.2867404-10-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index c4f437d4c0..a52905c4ee 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1139,6 +1139,11 @@ static int handle_content_merge(struct merge_options *opt,
 
 /*** Function Grouping: functions related to directory rename detection ***/
 
+struct collision_info {
+	struct string_list source_files;
+	unsigned reported_already:1;
+};
+
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -1378,6 +1383,31 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
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
@@ -1703,22 +1733,44 @@ static void detect_regular_renames(struct merge_options *opt,
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
@@ -1733,6 +1785,20 @@ static int collect_renames(struct merge_options *opt,
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
 
@@ -1764,8 +1830,12 @@ static int detect_and_process_renames(struct merge_options *opt,
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
2.29.1.106.g3ff750dc32.dirty

