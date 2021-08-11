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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F85C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E37B60551
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhHKHqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbhHKHqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:46:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC6C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa17so2095860pjb.1
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pp9B2HLr49m2x+SoTuL6BGrpE/gcpuY8BLOB0EfFKcA=;
        b=Y/mEmH2bWCZF3KZvyjddm652ytRoM4GzjwkBsVjMqGFR/Rr7NeilINLuzm7ShYArHg
         lx3lWrj11GvZ7uB8eWu8ogk3AXZEac7sA2zo4DQ/bJExuN1XGgDjPnSckPWvg3epHy4M
         sRhwO73o4kRJaas0NIpyHfGqShpayiq6poFV1Xnd6AXGcTWucn13+WOzTavQTJTBS54h
         3iw5vcULeJQbDssHrzyNgIRTMymbN9NkAD0ny1na9M9t8UbQ7YK6+Pch14Eb8cIrN3EY
         TqeHILwHcjxZfBau4N6x1iIbtzfzG5LSWYYfo9gM18glr/PfDfX36Yy32NALpVqSx4bk
         mrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pp9B2HLr49m2x+SoTuL6BGrpE/gcpuY8BLOB0EfFKcA=;
        b=CbGiSOgnUTY6uXPcLxsu8krVxXgD4BqGNmA+zcecJbzDR0HUepx9sGOSmvE7LxderP
         YmNB+jbONtmj2aWJh0XB+oCbUGK0+Rk+BQTNLOBZCzjsTlo1ZD1BHUHbsP+aSQMIWIJ1
         yBnUL4L8NtR3hrF1rjSnEvL8Yudi/kekooVBAmgKs8BdamS8qDnss/8jdKxlUBPN3kaB
         Hp8mewMf18htwbtS+5/B3PqArUoChNjvHxqJ3Jb625+xQICRSOdDkOkaOlmrD7iOcB6r
         degJTagZbXPIJtYzTD0RToQ4wPpzn4C3nlf2gtf+SlHOL1m1Ie3FLgIWYrZIv+baYlgJ
         TBQw==
X-Gm-Message-State: AOAM530hffQ98GENSLg1Wa8aNwnaJbJtmxtVoBermvL0YKZEzwh8mYk5
        Gqzw5ZwU8kpB7pnOizRdGvE=
X-Google-Smtp-Source: ABdhPJwVrEfwpDXMa0LT5B3nZ8KfIKbj7CVQpaMnu8ufz735RSwlIfceZaZPTRGOQujivCy9BGY79Q==
X-Received: by 2002:a17:90b:118f:: with SMTP id gk15mr9381927pjb.146.1628667983006;
        Wed, 11 Aug 2021 00:46:23 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id u13sm26179672pfi.51.2021.08.11.00.46.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 00:46:22 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v4 2/7] Add new parameter "carry_data" for "show_object" function
Date:   Wed, 11 Aug 2021 15:45:49 +0800
Message-Id: <bc8fea97e34b3ccb4b62bb4d48dac6e1c009236c.1628666093.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <cover.1628666093.git.dyroneteng@gmail.com>
References: <cover.1628666093.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the pack-objects process, "show_object" function will be called
to find the object and show the process("show_object_fn" in
"list-object.h"), the function definition contains three parameters:

	1. struct object *obj(contains object type, flags, and oid).
	2. const char *name(the object name).
	3. void *show_data(function to show progress info).

This commit adds a new parameter: "void *carry_data", the reason is
mainly based on scalability and performance considerations when showing
an object, space for time, avoid costly temporary calculations in the
"show" phase. For example, carry the ownership relationship between
blob or tree object and the referred commit to avoid redundant and
expensive calculations.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/describe.c     |  4 ++--
 builtin/pack-objects.c | 15 ++++++++-------
 builtin/rev-list.c     |  2 +-
 list-objects.c         |  8 ++++----
 list-objects.h         |  2 +-
 pack-bitmap.c          |  8 ++++----
 reachable.c            |  8 ++++----
 7 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 40482d8e9f..045da79b5c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -485,9 +485,9 @@ static void process_commit(struct commit *commit, void *data)
 	pcd->current_commit = commit->object.oid;
 }
 
-static void process_object(struct object *obj, const char *path, void *data)
+static void process_object(struct object *obj, const char *path, void *show_data, void *carry_data)
 {
-	struct process_commit_data *pcd = data;
+	struct process_commit_data *pcd = show_data;
 
 	if (oideq(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
 		reset_revision_walk();
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 31556e7396..5f9ec3566f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3068,7 +3068,7 @@ static void show_commit_pack_hint(struct commit *commit, void *_data)
 }
 
 static void show_object_pack_hint(struct object *object, const char *name,
-				  void *_data)
+				  void *show_data, void *carry_dataa)
 {
 	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
 	if (!oe)
@@ -3252,7 +3252,7 @@ static void show_commit(struct commit *commit, void *data)
 		propagate_island_marks(commit);
 }
 
-static void show_object(struct object *obj, const char *name, void *data)
+static void show_object(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
@@ -3274,7 +3274,7 @@ static void show_object(struct object *obj, const char *name, void *data)
 	}
 }
 
-static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
+static void show_object__ma_allow_any(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
 	assert(arg_missing_action == MA_ALLOW_ANY);
 
@@ -3285,10 +3285,10 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
 	if (!has_object(the_repository, &obj->oid, 0))
 		return;
 
-	show_object(obj, name, data);
+	show_object(obj, name, show_data, carry_data);
 }
 
-static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *data)
+static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
 	assert(arg_missing_action == MA_ALLOW_PROMISOR);
 
@@ -3299,7 +3299,7 @@ static void show_object__ma_allow_promisor(struct object *obj, const char *name,
 	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
 		return;
 
-	show_object(obj, name, data);
+	show_object(obj, name, show_data, carry_data);
 }
 
 static int option_parse_missing_action(const struct option *opt,
@@ -3547,7 +3547,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 
 static void record_recent_object(struct object *obj,
 				 const char *name,
-				 void *data)
+				 void *show_data,
+				 void *carry_data)
 {
 	oid_array_append(&recent_objects, &obj->oid);
 }
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index b4d8ea0a35..1cad33d9e8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -266,7 +266,7 @@ static int finish_object(struct object *obj, const char *name, void *cb_data)
 	return 0;
 }
 
-static void show_object(struct object *obj, const char *name, void *cb_data)
+static void show_object(struct object *obj, const char *name, void *cb_data, void *carry_data)
 {
 	struct rev_list_info *info = cb_data;
 	struct rev_info *revs = info->revs;
diff --git a/list-objects.c b/list-objects.c
index e19589baa0..427228a3ba 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -60,7 +60,7 @@ static void process_blob(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, path->buf, ctx->show_data);
+		ctx->show_object(obj, path->buf, ctx->show_data, NULL);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -191,7 +191,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		ctx->show_object(obj, base->buf, ctx->show_data, NULL);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -207,7 +207,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		ctx->show_object(obj, base->buf, ctx->show_data, NULL);
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
@@ -335,7 +335,7 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 			continue;
 		if (obj->type == OBJ_TAG) {
 			obj->flags |= SEEN;
-			ctx->show_object(obj, name, ctx->show_data);
+			ctx->show_object(obj, name, ctx->show_data, NULL);
 			continue;
 		}
 		if (!path)
diff --git a/list-objects.h b/list-objects.h
index a952680e46..ab946d34db 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -6,7 +6,7 @@ struct object;
 struct rev_info;
 
 typedef void (*show_commit_fn)(struct commit *, void *);
-typedef void (*show_object_fn)(struct object *, const char *, void *);
+typedef void (*show_object_fn)(struct object *, const char *, void *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3ed15431cd..516eb235da 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -459,9 +459,9 @@ struct bitmap_show_data {
 	struct bitmap *base;
 };
 
-static void show_object(struct object *object, const char *name, void *data_)
+static void show_object(struct object *object, const char *name, void *show_data, void *carry_data)
 {
-	struct bitmap_show_data *data = data_;
+	struct bitmap_show_data *data = show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(data->bitmap_git, &object->oid);
@@ -1268,9 +1268,9 @@ struct bitmap_test_data {
 };
 
 static void test_show_object(struct object *object, const char *name,
-			     void *data)
+			     void *show_data, void *carry_data)
 {
-	struct bitmap_test_data *tdata = data;
+	struct bitmap_test_data *tdata = show_data;
 	int bitmap_pos;
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
diff --git a/reachable.c b/reachable.c
index 77a60c70a5..521b39edef 100644
--- a/reachable.c
+++ b/reachable.c
@@ -47,14 +47,14 @@ static int add_one_ref(const char *path, const struct object_id *oid,
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
  */
-static void mark_object(struct object *obj, const char *name, void *data)
+static void mark_object(struct object *obj, const char *name, void *show_data, void *carry_data)
 {
-	update_progress(data);
+	update_progress(show_data);
 }
 
-static void mark_commit(struct commit *c, void *data)
+static void mark_commit(struct commit *c, void *show_data)
 {
-	mark_object(&c->object, NULL, data);
+	mark_object(&c->object, NULL, show_data, NULL);
 }
 
 struct recent_data {
-- 
2.31.1.449.gb2aa5456a8.dirty

