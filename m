Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2EFC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbiCGVvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiCGVvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C977562E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l10so6182203wmb.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q8+BEG3NwnoERyq+lPMXDfKtOelfHmetpKek56q/MYw=;
        b=WPgCgHbgPDyUDIBcPhSXaO54xhliVPXvUfx0JQSS8dvMEMUyb7GMzvNuoto3az5zoX
         urLLk28sIRvXCfmVigGNrbYktpVBPtjzzB9eOqoxOiw52VcyayQGUnX1XqQPkUYFR+Bp
         omNEgupvL+0j83X1zUW/scTezpCEJ4FBGLLZ+7AN71rockVllldE8HhaJejUkiTDqbPB
         BEJ1vma5L3zogEiWM1Cn02C8F6tGcbywkXV3mwVwrPxpJ91Fcyo6sPZaqVuSs0dgOukR
         0w79n1/1HVfn3k7GeRxy64HI33e8NF/xrukpVtsnI2+w5aGJqOnom0Il/O0KdlfHp0yg
         SCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q8+BEG3NwnoERyq+lPMXDfKtOelfHmetpKek56q/MYw=;
        b=b1QMRf51naw/j8FjznZsz8n8gDfewkrUngT/UKgIuGduy3YDtAyPnkKM3Xwv8kxq05
         4YsnvdsB/B/YoPCpcSF/YKOjVy2Mr+nJxArS8yFXNAjVpBEpivC8VPFMzF2HM199CHZX
         EhUj8Wg44OhGrKEruWM0RZLykSljpm7K8tmh3YHtkSmrOyUB4ex1L5MKFX0VSoe04Gbm
         oL4ub/EOl7Qa+ql/2PMAe1rk+eOCmeKuc62RW3Hs0oYfr4oM31UyYfZKAyLv6wCwitLM
         WEF/LdWurCRxObAGJSUzPccBzOeSErI8jKTURYuUM8pzjVRtKP0dqtbmSF/E60xouZjc
         qeQg==
X-Gm-Message-State: AOAM5311CmEIyMPn1BSzlHo8RGejyAfNHFyGB8ecuSO8khc5ovp2jRsm
        0FEUrtyv1QLDioZN3+h3/i/kOKyk6Fw=
X-Google-Smtp-Source: ABdhPJxqcXQ0kd+q6VMja2vz68rcsUxUv+Jzye775GzVFek6wMc6CK2JGXx+P19s0cU93DIrgmTCTQ==
X-Received: by 2002:a05:600c:ac5:b0:389:a170:c34 with SMTP id c5-20020a05600c0ac500b00389a1700c34mr846002wmr.100.1646689845853;
        Mon, 07 Mar 2022 13:50:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0037bd5fabd10sm497867wmq.48.2022.03.07.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:45 -0800 (PST)
Message-Id: <888774f6f28b291c928041a32c3df360cee13d10.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:32 +0000
Subject: [PATCH v2 04/12] pack-bitmap: drop filter in prepare_bitmap_walk()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Now that all consumers of prepare_bitmap_walk() have populated the
'filter' member of 'struct rev_info', we can drop that extra parameter
from the method and access it directly from the 'struct rev_info'.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  8 +++-----
 pack-bitmap.c          | 20 +++++++++-----------
 pack-bitmap.h          |  2 --
 reachable.c            |  2 +-
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 256d9b1798f..57f2cf49696 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 6f2b91d304e..556e78aebb9 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -434,8 +434,7 @@ static int try_bitmap_count(struct rev_info *revs,
 	 */
 	max_count = revs->max_count;
 
-	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
-					 filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -463,8 +462,7 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (revs->max_count >= 0)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
-					 filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
@@ -481,7 +479,7 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	if (!show_disk_usage)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, revs->filter, filter_provided_objects);
+	bitmap_git = prepare_bitmap_walk(revs, filter_provided_objects);
 	if (!bitmap_git)
 		return -1;
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9c666cdb8bd..613f2797cdf 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -739,8 +739,7 @@ static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
-				   struct bitmap *seen,
-				   struct list_objects_filter_options *filter)
+				   struct bitmap *seen)
 {
 	struct bitmap *base = NULL;
 	int needs_walk = 0;
@@ -823,7 +822,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		show_data.bitmap_git = bitmap_git;
 		show_data.base = base;
 
-		traverse_commit_list_filtered(filter, revs,
+		traverse_commit_list_filtered(revs->filter, revs,
 					      show_commit, show_object,
 					      &show_data, NULL);
 
@@ -1219,7 +1218,6 @@ static int can_filter_bitmap(struct list_objects_filter_options *filter)
 }
 
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter,
 					 int filter_provided_objects)
 {
 	unsigned int i;
@@ -1240,7 +1238,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (revs->prune)
 		return NULL;
 
-	if (!can_filter_bitmap(filter))
+	if (!can_filter_bitmap(revs->filter))
 		return NULL;
 
 	/* try to open a bitmapped pack, but don't parse it yet
@@ -1297,8 +1295,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 
 	if (haves) {
 		revs->ignore_missing_links = 1;
-		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL,
-					    filter);
+		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
 		reset_revision_walk();
 		revs->ignore_missing_links = 0;
 
@@ -1306,8 +1303,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			BUG("failed to perform bitmap walk");
 	}
 
-	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
-				    filter);
+	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
 
 	if (!wants_bitmap)
 		BUG("failed to perform bitmap walk");
@@ -1315,8 +1311,10 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
 
-	filter_bitmap(bitmap_git, (filter && filter_provided_objects) ? NULL : wants,
-		      wants_bitmap, filter);
+	filter_bitmap(bitmap_git,
+		      (revs->filter && filter_provided_objects) ? NULL : wants,
+		      wants_bitmap,
+		      revs->filter);
 
 	bitmap_git->result = wants_bitmap;
 	bitmap_git->haves = haves_bitmap;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19a63fa1abc..3d3ddd77345 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -10,7 +10,6 @@
 struct commit;
 struct repository;
 struct rev_info;
-struct list_objects_filter_options;
 
 static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
 
@@ -54,7 +53,6 @@ void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
 int test_bitmap_hashes(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
-					 struct list_objects_filter_options *filter,
 					 int filter_provided_objects);
 uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
diff --git a/reachable.c b/reachable.c
index 84e3d0d75ed..b9f4ad886ef 100644
--- a/reachable.c
+++ b/reachable.c
@@ -205,7 +205,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	cp.progress = progress;
 	cp.count = 0;
 
-	bitmap_git = prepare_bitmap_walk(revs, NULL, 0);
+	bitmap_git = prepare_bitmap_walk(revs, 0);
 	if (bitmap_git) {
 		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
 		free_bitmap_index(bitmap_git);
-- 
gitgitgadget

