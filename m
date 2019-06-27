Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A571F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF0Wy2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:28 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33674 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfF0Wy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:28 -0400
Received: by mail-pl1-f202.google.com with SMTP id f2so2261067plr.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JGksyiK5RmZkf+ytgjSy6zPynu37En4vDcWXMUpqvYY=;
        b=OIGA3NE7o9TwPaeKNetEBCNYON/cb5IGjjXKMjtPP61QI3ugbmCAaASqCiiArvuYce
         kNepY6T4HGbGhBy2c5olXSckHATPACf1DRZ5IjMeze0F6e1slzqyFUAiX64bwU4xtA4m
         oUA1CMqGqT44T0a8S9lRO0/KBOEWnQVmQnJpwlHdcXaevEmrsEcE/J1UHosU/+Ck+OUX
         KmUyC61A10SG1M5RE3dN0Z3UpkQ3TiiAhG1C4lsMz09KcQSPf5Yqdv54ihy4E+A67cgq
         3kUyEVIMjby6coYdIYaM5SECqGHSXNN0S1p+T74NfjaBSxIsUwPq6CasieCxDK1Uz/G6
         wlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JGksyiK5RmZkf+ytgjSy6zPynu37En4vDcWXMUpqvYY=;
        b=AICSIosxYuPZ0wOE4KS7CAVRDU7TG2ZJ8tM0jB5kzU3vLHdgHYzdIbtt4dTt2WUneZ
         usWpZqmh0aM4R/pvEJ+A8tles7fk3e6UvSJXdfqpAMsEdc/sDgkyyjl+XuZST6mjjvhm
         8X3IvvHU7U/apQLmM9ZEMtU9rInHkDuWe7GDkwwPwkE8WOHn/6gZOngax5NuL7YkPBJO
         WP7Y5bH5IY61mc0eq0p0RUWlVf1Wp5JcStblN4kHbAXgEjcayUrlIjwSjaHMbXqPnwWL
         p0Bl2vou/nUBIANn9kEW7qhBkTXEnzorodcQsLd45Rvb9W4VlWTA0k0ETXNQ+blKBay3
         buqg==
X-Gm-Message-State: APjAAAUi34AxyF1SUIDxsjdZqOFBysQ+TCIEFq57mm/tLgMVsnmX3u22
        zQaT/WrFyAQpoxu8I6ZX+eETpf+F9IeUqsBqB8jFhGzySkbcPkJp0dD79i7Mf+X0glyhOhNmjcR
        XWTBdaK+8SSacUrTviJqYW4iDD3UcfaQYWP7V6gfrsRNh5qMLdhXSlYouPFA=
X-Google-Smtp-Source: APXvYqydLjykAZ6GWMSLkek9aBKRDo8QraIOX5Ywz3fe3BrZDSreAmQiOCGYbxITHFXaekkCWTPqJleUbf+S
X-Received: by 2002:a63:f14:: with SMTP id e20mr6127919pgl.227.1561676067244;
 Thu, 27 Jun 2019 15:54:27 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:06 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <62441a2214528b114341796673c6f8fda14d24b8.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 02/10] list-objects-filter: put omits set in filter struct
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The oidset *omits pointer must be accessed by the combine filter in a
type-agnostic way once the graph traversal is over. Store that pointer
in the general `filter` struct. This will be used in a follow-up patch
to implement the combine filter.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 68 +++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index e06b82def0..3b4b6764ca 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -26,88 +26,76 @@
  */
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
 
 struct filter {
 	enum list_objects_filter_result (*filter_object_fn)(
 		struct repository *r,
 		enum list_objects_filter_situation filter_situation,
 		struct object *obj,
 		const char *pathname,
 		const char *filename,
+		struct oidset *omits,
 		void *filter_data);
 
 	void (*free_fn)(void *filter_data);
 
 	void *filter_data;
-};
 
-/*
- * A filter for list-objects to omit ALL blobs from the traversal.
- * And to OPTIONALLY collect a list of the omitted OIDs.
- */
-struct filter_blobs_none_data {
+	/* If non-NULL, the filter collects a list of the omitted OIDs here. */
 	struct oidset *omits;
 };
 
 static enum list_objects_filter_result filter_blobs_none(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct oidset *omits,
 	void *filter_data_)
 {
-	struct filter_blobs_none_data *filter_data = filter_data_;
-
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
 		/* always include all tree objects */
 		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
 		return LOFR_ZERO;
 
 	case LOFS_BLOB:
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		if (filter_data->omits)
-			oidset_insert(filter_data->omits, &obj->oid);
+		if (omits)
+			oidset_insert(omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 }
 
 static void filter_blobs_none__init(
-	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
-	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
-
-	filter->filter_data = d;
 	filter->filter_object_fn = filter_blobs_none;
 	filter->free_fn = free;
 }
 
 /*
  * A filter for list-objects to omit ALL trees and blobs from the traversal.
  * Can OPTIONALLY collect a list of the omitted OIDs.
  */
 struct filter_trees_depth_data {
-	struct oidset *omits;
-
 	/*
 	 * Maps trees to the minimum depth at which they were seen. It is not
 	 * necessary to re-traverse a tree at deeper or equal depths than it has
 	 * already been traversed.
 	 *
 	 * We can't use LOFR_MARK_SEEN for tree objects since this will prevent
 	 * it from being traversed at shallower depths.
 	 */
 	struct oidmap seen_at_depth;
 
@@ -116,38 +104,39 @@ struct filter_trees_depth_data {
 };
 
 struct seen_map_entry {
 	struct oidmap_entry base;
 	size_t depth;
 };
 
 /* Returns 1 if the oid was in the omits set before it was invoked. */
 static int filter_trees_update_omits(
 	struct object *obj,
-	struct filter_trees_depth_data *filter_data,
+	struct oidset *omits,
 	int include_it)
 {
-	if (!filter_data->omits)
+	if (!omits)
 		return 0;
 
 	if (include_it)
-		return oidset_remove(filter_data->omits, &obj->oid);
+		return oidset_remove(omits, &obj->oid);
 	else
-		return oidset_insert(filter_data->omits, &obj->oid);
+		return oidset_insert(omits, &obj->oid);
 }
 
 static enum list_objects_filter_result filter_trees_depth(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct oidset *omits,
 	void *filter_data_)
 {
 	struct filter_trees_depth_data *filter_data = filter_data_;
 	struct seen_map_entry *seen_info;
 	int include_it = filter_data->current_depth <
 		filter_data->exclude_depth;
 	int filter_res;
 	int already_seen;
 
 	/*
@@ -158,47 +147,47 @@ static enum list_objects_filter_result filter_trees_depth(
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
 		filter_data->current_depth--;
 		return LOFR_ZERO;
 
 	case LOFS_BLOB:
-		filter_trees_update_omits(obj, filter_data, include_it);
+		filter_trees_update_omits(obj, omits, include_it);
 		return include_it ? LOFR_MARK_SEEN | LOFR_DO_SHOW : LOFR_ZERO;
 
 	case LOFS_BEGIN_TREE:
 		seen_info = oidmap_get(
 			&filter_data->seen_at_depth, &obj->oid);
 		if (!seen_info) {
 			seen_info = xcalloc(1, sizeof(*seen_info));
 			oidcpy(&seen_info->base.oid, &obj->oid);
 			seen_info->depth = filter_data->current_depth;
 			oidmap_put(&filter_data->seen_at_depth, seen_info);
 			already_seen = 0;
 		} else {
 			already_seen =
 				filter_data->current_depth >= seen_info->depth;
 		}
 
 		if (already_seen) {
 			filter_res = LOFR_SKIP_TREE;
 		} else {
 			int been_omitted = filter_trees_update_omits(
-				obj, filter_data, include_it);
+				obj, omits, include_it);
 			seen_info->depth = filter_data->current_depth;
 
 			if (include_it)
 				filter_res = LOFR_DO_SHOW;
-			else if (filter_data->omits && !been_omitted)
+			else if (omits && !been_omitted)
 				/*
 				 * Must update omit information of children
 				 * recursively; they have not been omitted yet.
 				 */
 				filter_res = LOFR_ZERO;
 			else
 				filter_res = LOFR_SKIP_TREE;
 		}
 
 		filter_data->current_depth++;
@@ -208,50 +197,48 @@ static enum list_objects_filter_result filter_trees_depth(
 
 static void filter_trees_free(void *filter_data) {
 	struct filter_trees_depth_data *d = filter_data;
 	if (!d)
 		return;
 	oidmap_free(&d->seen_at_depth, 1);
 	free(d);
 }
 
 static void filter_trees_depth__init(
-	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
 	struct filter_trees_depth_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	oidmap_init(&d->seen_at_depth, 0);
 	d->exclude_depth = filter_options->tree_exclude_depth;
 	d->current_depth = 0;
 
 	filter->filter_data = d;
 	filter->filter_object_fn = filter_trees_depth;
 	filter->free_fn = filter_trees_free;
 }
 
 /*
  * A filter for list-objects to omit large blobs.
  * And to OPTIONALLY collect a list of the omitted OIDs.
  */
 struct filter_blobs_limit_data {
-	struct oidset *omits;
 	unsigned long max_bytes;
 };
 
 static enum list_objects_filter_result filter_blobs_limit(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct oidset *omits,
 	void *filter_data_)
 {
 	struct filter_blobs_limit_data *filter_data = filter_data_;
 	unsigned long object_length;
 	enum object_type t;
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
@@ -275,38 +262,36 @@ static enum list_objects_filter_result filter_blobs_limit(
 			 * apply the size filter criteria.  Be conservative
 			 * and force show it (and let the caller deal with
 			 * the ambiguity).
 			 */
 			goto include_it;
 		}
 
 		if (object_length < filter_data->max_bytes)
 			goto include_it;
 
-		if (filter_data->omits)
-			oidset_insert(filter_data->omits, &obj->oid);
+		if (omits)
+			oidset_insert(omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 
 include_it:
-	if (filter_data->omits)
-		oidset_remove(filter_data->omits, &obj->oid);
+	if (omits)
+		oidset_remove(omits, &obj->oid);
 	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
 
 static void filter_blobs_limit__init(
-	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
 	struct filter_blobs_limit_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	d->max_bytes = filter_options->blob_limit_value;
 
 	filter->filter_data = d;
 	filter->filter_object_fn = filter_blobs_limit;
 	filter->free_fn = free;
 }
 
 /*
  * A filter driven by a sparse-checkout specification to only
  * include blobs that a sparse checkout would populate.
@@ -330,33 +315,33 @@ struct frame {
 	 * omitted objects.
 	 *
 	 * 0 if everything (recursively) contained in this directory
 	 * has been explicitly included (SHOWN) in the result and
 	 * the directory may be short-cut later in the traversal.
 	 */
 	unsigned child_prov_omit : 1;
 };
 
 struct filter_sparse_data {
-	struct oidset *omits;
 	struct exclude_list el;
 
 	size_t nr, alloc;
 	struct frame *array_frame;
 };
 
 static enum list_objects_filter_result filter_sparse(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
+	struct oidset *omits,
 	void *filter_data_)
 {
 	struct filter_sparse_data *filter_data = filter_data_;
 	int val, dtype;
 	struct frame *frame;
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
@@ -424,79 +409,76 @@ static enum list_objects_filter_result filter_sparse(
 
 		frame = &filter_data->array_frame[filter_data->nr - 1];
 
 		dtype = DT_REG;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
 					    r->index);
 		if (val < 0)
 			val = frame->defval;
 		if (val > 0) {
-			if (filter_data->omits)
-				oidset_remove(filter_data->omits, &obj->oid);
+			if (omits)
+				oidset_remove(omits, &obj->oid);
 			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 		}
 
 		/*
 		 * Provisionally omit it.  We've already established that
 		 * this pathname is not in the sparse-checkout specification
 		 * with the CURRENT pathname, so we *WANT* to omit this blob.
 		 *
 		 * However, a pathname elsewhere in the tree may also
 		 * reference this same blob, so we cannot reject it yet.
 		 * Leave the LOFR_ bits unset so that if the blob appears
 		 * again in the traversal, we will be asked again.
 		 */
-		if (filter_data->omits)
-			oidset_insert(filter_data->omits, &obj->oid);
+		if (omits)
+			oidset_insert(omits, &obj->oid);
 
 		/*
 		 * Remember that at least 1 blob in this tree was
 		 * provisionally omitted.  This prevents us from short
 		 * cutting the tree in future iterations.
 		 */
 		frame->child_prov_omit = 1;
 		return LOFR_ZERO;
 	}
 }
 
 
 static void filter_sparse_free(void *filter_data)
 {
 	struct filter_sparse_data *d = filter_data;
 	free(d->array_frame);
 	free(d);
 }
 
 static void filter_sparse_oid__init(
-	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
 					   NULL, 0, &d->el) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 	d->nr++;
 
 	filter->filter_data = d;
 	filter->filter_object_fn = filter_sparse;
 	filter->free_fn = filter_sparse_free;
 }
 
 typedef void (*filter_init_fn)(
-	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter);
 
 /*
  * Must match "enum list_objects_filter_choice".
  */
 static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
@@ -515,35 +497,37 @@ struct filter *list_objects_filter__init(
 
 	if (filter_options->choice >= LOFC__COUNT)
 		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
 	init_fn = s_filters[filter_options->choice];
 	if (!init_fn)
 		return NULL;
 
 	filter = xcalloc(1, sizeof(*filter));
-	init_fn(omitted, filter_options, filter);
+	filter->omits = omitted;
+	init_fn(filter_options, filter);
 	return filter;
 }
 
 enum list_objects_filter_result list_objects_filter__filter_object(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
 	struct filter *filter)
 {
 	if (filter && (obj->flags & NOT_USER_GIVEN))
 		return filter->filter_object_fn(r, filter_situation, obj,
 						pathname, filename,
+						filter->omits,
 						filter->filter_data);
 	/*
 	 * No filter is active or user gave object explicitly. In this case,
 	 * always show the object (except when LOFS_END_TREE, since this tree
 	 * had already been shown when LOFS_BEGIN_TREE).
 	 */
 	if (filter_situation == LOFS_END_TREE)
 		return 0;
 	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
-- 
2.21.0

