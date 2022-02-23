Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EDBC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiBWRzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiBWRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96365EC
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso2044578wml.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q8+BEG3NwnoERyq+lPMXDfKtOelfHmetpKek56q/MYw=;
        b=gMri/RKKRgjqJBzDyo5vIsK0gxxPmBZUaWLiXJl1gawiCPbysh7aqmnerc1idrdzmZ
         EYVKwGeWz+pguvicrbh6o9QCo3/Dso/DS0ALIlE//SA1/jQHhSeWMVybUjMV5Tz1+Gtl
         As8cyRv1kElZvJJ+sEaV4VqD44agMv5YD0BHSmrngP0bbYlBBUvFho/972TnwZUaemcX
         k6Qyp81EKQ22RmdvJLCWM90L9ynqmI0yME8hvrefLB4mysxEOLEUGtIJ4grdQ9JYJBDh
         UE+gPk9r2adjVZGh1tb+SBii0ghKpENi/GdfkKZPEKwstT0rPpuvNu5vVYV/l5d+FiNd
         ucIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q8+BEG3NwnoERyq+lPMXDfKtOelfHmetpKek56q/MYw=;
        b=T915l5dAfwjUfGYja6Djg1c37LRg8wKIeytXeYoIWubp+iTExm5IOL01He/8B+Hzrn
         gh41+ioynqdBpYsPjAb7wDzVm5ygrfP1INqKDzCofdBN8QX7CXmAcJH+nVE/iM1maIYy
         rZJgSyklGGT/dpMpk3bQPehnKn/YwnWdpGtxDUvZFJYU28uX7rbdURS7AkiH/Q0A14JB
         rkpK+TACV0kb3+/5+FuT7AandCvs9Am+Zf/yLPaSTE8I9ZOBQYmKVZNZDT2JMfkoqny1
         BlRFwJbC87G7Mc6+O+bp9mcGBqZsExxRllW5Hpldura8Y9G2WM+sIGLcB1ckpTyzVhxP
         H4KA==
X-Gm-Message-State: AOAM531IVaDlEjQJJIQ7+1xlPeCYmcL9QmM3vT+okqFxdK1NXKyGk2Hx
        ig2klNG3BpBaeXG4YiMcRHRYpbjW12I=
X-Google-Smtp-Source: ABdhPJy1p44IByKm2u+whb+yBtxCn8vec+Ko2jGmy7Ph75upDOXg1ld8qrJ+tmnEDR8L2fUku2ADOw==
X-Received: by 2002:a05:600c:4b92:b0:380:e46c:c35 with SMTP id e18-20020a05600c4b9200b00380e46c0c35mr662536wmp.15.1645638917150;
        Wed, 23 Feb 2022 09:55:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm422040wms.24.2022.02.23.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:16 -0800 (PST)
Message-Id: <888774f6f28b291c928041a32c3df360cee13d10.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:04 +0000
Subject: [PATCH 04/11] pack-bitmap: drop filter in prepare_bitmap_walk()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
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

