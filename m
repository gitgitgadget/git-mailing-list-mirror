Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8161C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 04:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356876AbiFVEVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356866AbiFVEVs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 00:21:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A13534BB2
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:21:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so21596026wra.4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dzbgH2fkEQLvQv/d+UVZR3HXjYpl1DPaz4Io7ofjcbk=;
        b=LzODQxh9SZkIegNK91r7pov/STZZWCnwWunISwrU0r3vKUUlpXEcwxxMTrRgrX4cSa
         hjapH5Y9OiD0rrGDG3BfhumsFbYyFRHm8QsuJvgYhG5U2O35zUFXQRsDv59Brzu798o+
         saK/I7b8y+pn2Q2A1gifo9sJraM9206FRKJtfDJsBe2SdkAgK2aCFx9d6KmiRGugou7n
         mSoK7peUoZ1MRcwcp5stPM1/rHAWpgwKUEx8hyfuMnKdTXztyzi/vICgF+XzBordsgml
         gZELUBgKbOnjvj3TO4bkh8paP7WrcMsKXPT0cbQi7iqt8/h5AEkdhMqL1x/hO/e6nKNq
         eDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dzbgH2fkEQLvQv/d+UVZR3HXjYpl1DPaz4Io7ofjcbk=;
        b=neKCClP4nwtjJsGN9da4kWVrXl5k8xjtsbvkP96Q/3DuTHBl6wM1ew7NsILLq+rjZ8
         n10VLElcD0TE3MxT5okg9ve69qrp60eWDN37B1PkFURZOvIq66mBMesJ/FS2DDr1tgHr
         By5neegJhx11b4QzRyqH+mtGiQhgJi2a0XxnVCH8VTofEGIbl+HpHj81EpDsW6DDDyDL
         Jd1loxOoWIFruMj5igk4paH3m1TYVn+xHIo+MJntkzwA4n3szefe/e1QnkFLsDacDX3A
         x30BEKVl+rdGOOdVaIzD16E7H1DTzoOo+yEICVgo3St/WV1SDw+W1qEO7nHRWn+vK6+Y
         hGqg==
X-Gm-Message-State: AJIora9D1vgGvlzauvCbAK6T5Njn4/gUkhTlGUUXJFDBUU0C3caajatu
        Tyo8ntyccJz6v3x9nRH1dHr6NTJkjJIx1g==
X-Google-Smtp-Source: AGRyM1v11G35MaLqf0qwvRcg6JE8blt76sydIyd2rD7KuIPMaWiBGripwK+uHIl10ApecBEbCEntQw==
X-Received: by 2002:a5d:64e9:0:b0:218:3fdb:bfd2 with SMTP id g9-20020a5d64e9000000b002183fdbbfd2mr1198364wri.717.1655871705507;
        Tue, 21 Jun 2022 21:21:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d6a89000000b0021b98d73a4esm3205627wru.114.2022.06.21.21.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:21:36 -0700 (PDT)
Message-Id: <d8c13e56209ebb6d1d3c521b6522a1bc64909108.1655871652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 04:20:50 +0000
Subject: [PATCH 2/3] merge-ort: shuffle the computation and cleanup of
 potential collisions
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

Run compute_collisions() for renames on both sides of history before
any calls to collect_renames(), and do not free the computed collisions
until after both calls to collect_renames().  This is just a code
reorganization at this point that doesn't make sense on its own, but
will permit us to use the computed collision info from both sides
within each call to collect_renames() in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 56 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8545354dafd..fa6667de18c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2259,6 +2259,27 @@ static void compute_collisions(struct strmap *collisions,
 	}
 }
 
+static void free_collisions(struct strmap *collisions)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/* Free each value in the collisions map */
+	strmap_for_each_entry(collisions, &iter, entry) {
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
+	free_strmap_strings(collisions);
+	strmap_clear(collisions, 1);
+}
+
 static char *check_for_directory_rename(struct merge_options *opt,
 					const char *path,
 					unsigned side_index,
@@ -2314,7 +2335,8 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	}
 
 	new_path = handle_path_level_conflicts(opt, path, side_index,
-					       rename_info, collisions);
+					       rename_info,
+					       &collisions[side_index]);
 	*clean_merge &= (new_path != NULL);
 
 	return new_path;
@@ -3023,18 +3045,15 @@ static int detect_regular_renames(struct merge_options *opt,
 static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
 			   unsigned side_index,
+			   struct strmap *collisions,
 			   struct strmap *dir_renames_for_side,
 			   struct strmap *rename_exclusions)
 {
 	int i, clean = 1;
-	struct strmap collisions;
 	struct diff_queue_struct *side_pairs;
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
 	struct rename_info *renames = &opt->priv->renames;
 
 	side_pairs = &renames->pairs[side_index];
-	compute_collisions(&collisions, dir_renames_for_side, side_pairs);
 
 	for (i = 0; i < side_pairs->nr; ++i) {
 		struct diff_filepair *p = side_pairs->queue[i];
@@ -3050,7 +3069,7 @@ static int collect_renames(struct merge_options *opt,
 						      side_index,
 						      dir_renames_for_side,
 						      rename_exclusions,
-						      &collisions,
+						      collisions,
 						      &clean);
 
 		possibly_cache_new_pair(renames, p, side_index, new_path);
@@ -3076,20 +3095,6 @@ static int collect_renames(struct merge_options *opt,
 		result->queue[result->nr++] = p;
 	}
 
-	/* Free each value in the collisions map */
-	strmap_for_each_entry(&collisions, &iter, entry) {
-		struct collision_info *info = entry->value;
-		string_list_clear(&info->source_files, 0);
-	}
-	/*
-	 * In compute_collisions(), we set collisions.strdup_strings to 0
-	 * so that we wouldn't have to make another copy of the new_path
-	 * allocated by apply_dir_rename().  But now that we've used them
-	 * and have no other references to these strings, it is time to
-	 * deallocate them.
-	 */
-	free_strmap_strings(&collisions);
-	strmap_clear(&collisions, 1);
 	return clean;
 }
 
@@ -3100,6 +3105,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 {
 	struct diff_queue_struct combined = { 0 };
 	struct rename_info *renames = &opt->priv->renames;
+	struct strmap collisions[3];
 	int need_dir_renames, s, i, clean = 1;
 	unsigned detection_run = 0;
 
@@ -3149,12 +3155,22 @@ static int detect_and_process_renames(struct merge_options *opt,
 	ALLOC_GROW(combined.queue,
 		   renames->pairs[1].nr + renames->pairs[2].nr,
 		   combined.alloc);
+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
+		int other_side = 3 - i;
+		compute_collisions(&collisions[i],
+				   &renames->dir_renames[other_side],
+				   &renames->pairs[i]);
+	}
 	clean &= collect_renames(opt, &combined, MERGE_SIDE1,
+				 collisions,
 				 &renames->dir_renames[2],
 				 &renames->dir_renames[1]);
 	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
+				 collisions,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
+		free_collisions(&collisions[i]);
 	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
 	trace2_region_leave("merge", "directory renames", opt->repo);
 
-- 
gitgitgadget

