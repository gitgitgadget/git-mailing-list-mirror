Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3101F462
	for <e@80x24.org>; Wed, 22 May 2019 00:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfEVAWT (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:22:19 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:47217 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVAWT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:22:19 -0400
Received: by mail-oi1-f202.google.com with SMTP id v3so308803oia.14
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fu+KxqorTXsSSSbU7rsIFkxijPGpB0m1O5O/e2ApYPA=;
        b=FPrbLs2txqvnb7IVnKUuUMTTuqjRaxVcLdK5gV2Et8+V8DwBAz+dwimNQRcPJjoA5n
         p/GS+9auqBZB/xw/1jHKNgnk46awGCL8WV2+fCCdKeo++GCAK9tTxTw+M92MDpINwwdj
         ugct2oYui0pQDsE1gGm72+wVp6+NSDL8vNmbOf95CiTfbHB4KvdnOH2VRlnbFLxSVl7H
         MSrjkHqR4iHXGGHt6kPmQasV1AAnktBs6dr7NXuhxA77yxe7TQimpDkL9zThYDJKqR6Y
         +FluU7ae/efyEfDOVgl/LwUKdeG5S2Tn4hZMJjN/bQAN80aw/xB+FVexnhe3bHOr2gQ8
         kipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fu+KxqorTXsSSSbU7rsIFkxijPGpB0m1O5O/e2ApYPA=;
        b=DykdcCSsO3DB4HQLgIZJUlcUGTYsiVewR3N/F2fDxyocUc/fc1Y3ifyxwBU/vyniXF
         L34Rtmtpzl17BeQ2d+95ozsVq/qObeBn0EK/DODEWwEQL+UDLiBUoNfRxlKolwByLpiX
         LUrxBSZVg07MQmn851HjUagmlQJQYbYu3/Bi4ivJ281ylk8gio/9WgzZTCzX/69ZrWWI
         fnAEIa8jBHa3U0HDr7sCx5qvnKsNhobWYHQMokIXzSNzoSeT4XEEsE6EweTIVcwXQWYS
         RXa50rFUzj76J0bt/Tf/HqaL+zol5EpY/r68vcGzzMdJIplXiJb2YOedp4yw3h1kkt57
         ytvQ==
X-Gm-Message-State: APjAAAVIP9KQTffRVC8qHtOfXXmGMsKM8HxpLSAgztJyXpIqTDvxscKp
        Gdn9Sd748ZgmWe4j6Xkw47LFian7P9I=
X-Google-Smtp-Source: APXvYqzsrw4OZ20nyWtkfrse8+F6CoSvUquACInFHA32cdupvF7ksNv1muYAh3xWYx14FowyDHk5ndFBf9dj
X-Received: by 2002:aca:240d:: with SMTP id n13mr2478071oic.145.1558484538236;
 Tue, 21 May 2019 17:22:18 -0700 (PDT)
Date:   Tue, 21 May 2019 17:21:50 -0700
In-Reply-To: <cover.1558484115.git.matvore@google.com>
Message-Id: <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1558484115.git.matvore@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v1 1/5] list-objects-filter: refactor into a context struct
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next patch will create and manage filters in a new way, which means
that this bundle of data will have to be managed at a new callsite. Make
this bundle of data more manageable by putting it in a struct and
making it part of the list-objects-filter module's API.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 156 +++++++++++++++---------------------------
 list-objects-filter.h |  31 ++++++---
 list-objects.c        |  45 ++++++------
 3 files changed, 96 insertions(+), 136 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index ee449de3f7..8e8616b9b8 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -19,82 +19,60 @@
  * FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects
  * that have been shown, but should be revisited if they appear
  * in the traversal (until we mark it SEEN).  This is a way to
  * let us silently de-dup calls to show() in the caller.  This
  * is subtly different from the "revision.h:SHOWN" and the
  * "sha1-name.c:ONELINE_SEEN" bits.  And also different from
  * the non-de-dup usage in pack-bitmap.c
  */
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
 
-/*
- * A filter for list-objects to omit ALL blobs from the traversal.
- * And to OPTIONALLY collect a list of the omitted OIDs.
- */
-struct filter_blobs_none_data {
-	struct oidset *omits;
-};
-
 static enum list_objects_filter_result filter_blobs_none(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	void *filter_data_)
+	struct filter_context *ctx)
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
+		if (ctx->omits)
+			oidset_insert(ctx->omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 }
 
-static void *filter_blobs_none__init(
-	struct oidset *omitted,
+static void filter_blobs_none__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_context *ctx)
 {
-	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
-
-	*filter_fn = filter_blobs_none;
-	*filter_free_fn = free;
-	return d;
+	ctx->filter_fn = filter_blobs_none;
 }
 
-/*
- * A filter for list-objects to omit ALL trees and blobs from the traversal.
- * Can OPTIONALLY collect a list of the omitted OIDs.
- */
+/* A filter for list-objects to omit ALL trees and blobs from the traversal. */
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
 
@@ -103,41 +81,41 @@ struct filter_trees_depth_data {
 };
 
 struct seen_map_entry {
 	struct oidmap_entry base;
 	size_t depth;
 };
 
 /* Returns 1 if the oid was in the omits set before it was invoked. */
 static int filter_trees_update_omits(
 	struct object *obj,
-	struct filter_trees_depth_data *filter_data,
+	struct filter_context *ctx,
 	int include_it)
 {
-	if (!filter_data->omits)
+	if (!ctx->omits)
 		return 0;
 
 	if (include_it)
-		return oidset_remove(filter_data->omits, &obj->oid);
+		return oidset_remove(ctx->omits, &obj->oid);
 	else
-		return oidset_insert(filter_data->omits, &obj->oid);
+		return oidset_insert(ctx->omits, &obj->oid);
 }
 
 static enum list_objects_filter_result filter_trees_depth(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	void *filter_data_)
+	struct filter_context *ctx)
 {
-	struct filter_trees_depth_data *filter_data = filter_data_;
+	struct filter_trees_depth_data *filter_data = ctx->data;
 	struct seen_map_entry *seen_info;
 	int include_it = filter_data->current_depth <
 		filter_data->exclude_depth;
 	int filter_res;
 	int already_seen;
 
 	/*
 	 * Note that we do not use _MARK_SEEN in order to allow re-traversal in
 	 * case we encounter a tree or blob again at a shallower depth.
 	 */
@@ -145,47 +123,47 @@ static enum list_objects_filter_result filter_trees_depth(
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
 		filter_data->current_depth--;
 		return LOFR_ZERO;
 
 	case LOFS_BLOB:
-		filter_trees_update_omits(obj, filter_data, include_it);
+		filter_trees_update_omits(obj, ctx, include_it);
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
+				obj, ctx, include_it);
 			seen_info->depth = filter_data->current_depth;
 
 			if (include_it)
 				filter_res = LOFR_DO_SHOW;
-			else if (filter_data->omits && !been_omitted)
+			else if (ctx->omits && !been_omitted)
 				/*
 				 * Must update omit information of children
 				 * recursively; they have not been omitted yet.
 				 */
 				filter_res = LOFR_ZERO;
 			else
 				filter_res = LOFR_SKIP_TREE;
 		}
 
 		filter_data->current_depth++;
@@ -194,55 +172,48 @@ static enum list_objects_filter_result filter_trees_depth(
 }
 
 static void filter_trees_free(void *filter_data) {
 	struct filter_trees_depth_data *d = filter_data;
 	if (!d)
 		return;
 	oidmap_free(&d->seen_at_depth, 1);
 	free(d);
 }
 
-static void *filter_trees_depth__init(
-	struct oidset *omitted,
+static void filter_trees_depth__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_context *ctx)
 {
 	struct filter_trees_depth_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	oidmap_init(&d->seen_at_depth, 0);
 	d->exclude_depth = filter_options->tree_exclude_depth;
 	d->current_depth = 0;
 
-	*filter_fn = filter_trees_depth;
-	*filter_free_fn = filter_trees_free;
-	return d;
+	ctx->filter_fn = filter_trees_depth;
+	ctx->free_fn = filter_trees_free;
+	ctx->data = d;
 }
 
-/*
- * A filter for list-objects to omit large blobs.
- * And to OPTIONALLY collect a list of the omitted OIDs.
- */
+/* A filter for list-objects to omit large blobs. */
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
-	void *filter_data_)
+	struct filter_context *ctx)
 {
-	struct filter_blobs_limit_data *filter_data = filter_data_;
+	struct filter_blobs_limit_data *filter_data = ctx->data;
 	unsigned long object_length;
 	enum object_type t;
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
 		/* always include all tree objects */
@@ -263,44 +234,41 @@ static enum list_objects_filter_result filter_blobs_limit(
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
+		if (ctx->omits)
+			oidset_insert(ctx->omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 
 include_it:
-	if (filter_data->omits)
-		oidset_remove(filter_data->omits, &obj->oid);
+	if (ctx->omits)
+		oidset_remove(ctx->omits, &obj->oid);
 	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
 
-static void *filter_blobs_limit__init(
-	struct oidset *omitted,
+static void filter_blobs_limit__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_context *ctx)
 {
 	struct filter_blobs_limit_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	d->max_bytes = filter_options->blob_limit_value;
 
-	*filter_fn = filter_blobs_limit;
-	*filter_free_fn = free;
-	return d;
+	ctx->filter_fn = filter_blobs_limit;
+	ctx->free_fn = free;
+	ctx->data = d;
 }
 
 /*
  * A filter driven by a sparse-checkout specification to only
  * include blobs that a sparse checkout would populate.
  *
  * The sparse-checkout spec can be loaded from a blob with the
  * given OID or from a local pathname.  We allow an OID because
  * the repo may be bare or we may be doing the filtering on the
  * server.
@@ -319,36 +287,35 @@ struct frame {
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
-	void *filter_data_)
+	struct filter_context *ctx)
 {
-	struct filter_sparse_data *filter_data = filter_data_;
+	struct filter_sparse_data *filter_data = ctx->data;
 	int val, dtype;
 	struct frame *frame;
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
 		dtype = DT_DIR;
@@ -414,128 +381,117 @@ static enum list_objects_filter_result filter_sparse(
 
 		frame = &filter_data->array_frame[filter_data->nr];
 
 		dtype = DT_REG;
 		val = is_excluded_from_list(pathname, strlen(pathname),
 					    filename, &dtype, &filter_data->el,
 					    r->index);
 		if (val < 0)
 			val = frame->defval;
 		if (val > 0) {
-			if (filter_data->omits)
-				oidset_remove(filter_data->omits, &obj->oid);
+			if (ctx->omits)
+				oidset_remove(ctx->omits, &obj->oid);
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
+		if (ctx->omits)
+			oidset_insert(ctx->omits, &obj->oid);
 
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
 	/* TODO free contents of 'd' */
 	free(d);
 }
 
-static void *filter_sparse_oid__init(
-	struct oidset *omitted,
+static void filter_sparse_oid__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_context *ctx)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
 					   NULL, 0, &d->el) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 
-	*filter_fn = filter_sparse;
-	*filter_free_fn = filter_sparse_free;
-	return d;
+	ctx->filter_fn = filter_sparse;
+	ctx->free_fn = filter_sparse_free;
+	ctx->data = d;
 }
 
-static void *filter_sparse_path__init(
-	struct oidset *omitted,
+static void filter_sparse_path__init(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_context *ctx)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
 	if (add_excludes_from_file_to_list(filter_options->sparse_path_value,
 					   NULL, 0, &d->el, NULL) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 
-	*filter_fn = filter_sparse;
-	*filter_free_fn = filter_sparse_free;
-	return d;
+	ctx->filter_fn = filter_sparse;
+	ctx->free_fn = filter_sparse_free;
+	ctx->data = d;
 }
 
-typedef void *(*filter_init_fn)(
-	struct oidset *omitted,
+typedef void (*filter_init_fn)(
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn);
+	struct filter_context *ctx);
 
 /*
  * Must match "enum list_objects_filter_choice".
  */
 static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
 };
 
-void *list_objects_filter__init(
+void list_objects_filter__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter_context *ctx)
 {
 	filter_init_fn init_fn;
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
 	if (filter_options->choice >= LOFC__COUNT)
 		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->omits = omitted;
 	init_fn = s_filters[filter_options->choice];
 	if (init_fn)
-		return init_fn(omitted, filter_options,
-			       filter_fn, filter_free_fn);
-	*filter_fn = NULL;
-	*filter_free_fn = NULL;
-	return NULL;
+		init_fn(filter_options, ctx);
 }
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 1d45a4ad57..ee807f5d9b 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -53,37 +53,46 @@ enum list_objects_filter_result {
 	LOFR_DO_SHOW   = 1<<1,
 	LOFR_SKIP_TREE = 1<<2,
 };
 
 enum list_objects_filter_situation {
 	LOFS_BEGIN_TREE,
 	LOFS_END_TREE,
 	LOFS_BLOB
 };
 
-typedef enum list_objects_filter_result (*filter_object_fn)(
-	struct repository *r,
-	enum list_objects_filter_situation filter_situation,
-	struct object *obj,
-	const char *pathname,
-	const char *filename,
-	void *filter_data);
+struct filter_context {
+	enum list_objects_filter_result (*filter_fn)(
+		struct repository *r,
+		enum list_objects_filter_situation filter_situation,
+		struct object *obj,
+		const char *pathname,
+		const char *filename,
+		struct filter_context *ctx);
+	void (*free_fn)(void *filter_data);
 
-typedef void (*filter_free_fn)(void *filter_data);
+	struct oidset *omits;
+	void *data;
+};
 
 /*
  * Constructor for the set of defined list-objects filters.
  * Returns a generic "void *filter_data".
  *
  * The returned "filter_fn" will be used by traverse_commit_list()
  * to filter the results.
  *
  * The returned "filter_free_fn" is a destructor for the
  * filter_data.
  */
-void *list_objects_filter__init(
+void list_objects_filter__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn);
+	struct filter_context *ctx);
+
+static inline void list_objects_filter__release(struct filter_context *ctx) {
+	if (ctx->data && ctx->free_fn)
+		ctx->free_fn(ctx->data);
+	memset(ctx, 0, sizeof(*ctx));
+}
 
 #endif /* LIST_OBJECTS_FILTER_H */
diff --git a/list-objects.c b/list-objects.c
index b5651ddd5b..7a73f7deee 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -11,22 +11,21 @@
 #include "list-objects-filter-options.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "trace.h"
 
 struct traversal_context {
 	struct rev_info *revs;
 	show_object_fn show_object;
 	show_commit_fn show_commit;
 	void *show_data;
-	filter_object_fn filter_fn;
-	void *filter_data;
+	struct filter_context filter_ctx;
 };
 
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
 			 const char *name)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
@@ -47,25 +46,25 @@ static void process_blob(struct traversal_context *ctx,
 	 * may cause the actual filter to report an incomplete list
 	 * of missing objects.
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
 	    !has_object_file(&obj->oid) &&
 	    is_promisor_object(&obj->oid))
 		return;
 
 	pathlen = path->len;
 	strbuf_addstr(path, name);
-	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(ctx->revs->repo,
-				   LOFS_BLOB, obj,
-				   path->buf, &path->buf[pathlen],
-				   ctx->filter_data);
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_ctx.filter_fn)
+		r = ctx->filter_ctx.filter_fn(ctx->revs->repo,
+					      LOFS_BLOB, obj,
+					      path->buf, &path->buf[pathlen],
+					      &ctx->filter_ctx);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
 		ctx->show_object(obj, path->buf, ctx->show_data);
 	strbuf_setlen(path, pathlen);
 }
 
 /*
  * Processing a gitlink entry currently does nothing, since
  * we do not recurse into the subproject.
@@ -179,42 +178,42 @@ static void process_tree(struct traversal_context *ctx,
 		 */
 		if (revs->exclude_promisor_objects &&
 		    is_promisor_object(&obj->oid))
 			return;
 
 		if (!revs->do_not_die_on_missing_tree)
 			die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
 	strbuf_addstr(base, name);
-	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn)
-		r = ctx->filter_fn(ctx->revs->repo,
-				   LOFS_BEGIN_TREE, obj,
-				   base->buf, &base->buf[baselen],
-				   ctx->filter_data);
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_ctx.filter_fn)
+		r = ctx->filter_ctx.filter_fn(ctx->revs->repo,
+					      LOFS_BEGIN_TREE, obj,
+					      base->buf, &base->buf[baselen],
+					      &ctx->filter_ctx);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
 		ctx->show_object(obj, base->buf, ctx->show_data);
 	if (base->len)
 		strbuf_addch(base, '/');
 
 	if (r & LOFR_SKIP_TREE)
 		trace_printf("Skipping contents of tree %s...\n", base->buf);
 	else if (!failed_parse)
 		process_tree_contents(ctx, tree, base);
 
-	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
-		r = ctx->filter_fn(ctx->revs->repo,
-				   LOFS_END_TREE, obj,
-				   base->buf, &base->buf[baselen],
-				   ctx->filter_data);
+	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_ctx.filter_fn) {
+		r = ctx->filter_ctx.filter_fn(ctx->revs->repo,
+					      LOFS_END_TREE, obj,
+					      base->buf, &base->buf[baselen],
+					      &ctx->filter_ctx);
 		if (r & LOFR_MARK_SEEN)
 			obj->flags |= SEEN;
 		if (r & LOFR_DO_SHOW)
 			ctx->show_object(obj, base->buf, ctx->show_data);
 	}
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
 }
 
@@ -395,38 +394,34 @@ static void do_traverse(struct traversal_context *ctx)
 void traverse_commit_list(struct rev_info *revs,
 			  show_commit_fn show_commit,
 			  show_object_fn show_object,
 			  void *show_data)
 {
 	struct traversal_context ctx;
 	ctx.revs = revs;
 	ctx.show_commit = show_commit;
 	ctx.show_object = show_object;
 	ctx.show_data = show_data;
-	ctx.filter_fn = NULL;
-	ctx.filter_data = NULL;
+	memset(&ctx.filter_ctx, 0, sizeof(ctx.filter_ctx));
 	do_traverse(&ctx);
 }
 
 void traverse_commit_list_filtered(
 	struct list_objects_filter_options *filter_options,
 	struct rev_info *revs,
 	show_commit_fn show_commit,
 	show_object_fn show_object,
 	void *show_data,
 	struct oidset *omitted)
 {
 	struct traversal_context ctx;
-	filter_free_fn filter_free_fn = NULL;
+	memset(&ctx, 0, sizeof(ctx));
 
 	ctx.revs = revs;
 	ctx.show_object = show_object;
 	ctx.show_commit = show_commit;
 	ctx.show_data = show_data;
-	ctx.filter_fn = NULL;
 
-	ctx.filter_data = list_objects_filter__init(omitted, filter_options,
-						    &ctx.filter_fn, &filter_free_fn);
+	list_objects_filter__init(omitted, filter_options, &ctx.filter_ctx);
 	do_traverse(&ctx);
-	if (ctx.filter_data && filter_free_fn)
-		filter_free_fn(ctx.filter_data);
+	list_objects_filter__release(&ctx.filter_ctx);
 }
-- 
2.21.0

