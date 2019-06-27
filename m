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
	by dcvr.yhbt.net (Postfix) with ESMTP id C1BB01F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfF0Wy1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:27 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48577 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfF0Wy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:26 -0400
Received: by mail-ua1-f74.google.com with SMTP id s14so613459uap.15
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9HktLtxBfH3lsYSwks8R6VbVlmRoz5arUYbn8F64Ppg=;
        b=hsbsHJH65Rv84s3NWefN8pv40kntR367ZUN0Dh2yatjBEpwGqw8p0/sUnrVoCbDUje
         hI6cJ8ZguAtoje06Ziut3UZ7XpqoI08GjcocE4JDBWDMEEhnwlfq4ig6TTLL0lTzek1h
         fep+iF144j8sZZTfOdViK1J6RwbLRDMnzDTHtDfypkMQDpuofHFNCU9yGzf5G7W/6gyY
         OMIBntI/1FAfkn1mI5Wdl3LWXgr9D1fLO3vhsSzWxVUPM9s3veKe+frDXyFPw9Yic3bI
         mOrdvtoxQWTZMYf6KSGKHVKVmIt30EKKenab4CkRnIMuoQnaB+MuNlrgF8Vgxwq+07SU
         p6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9HktLtxBfH3lsYSwks8R6VbVlmRoz5arUYbn8F64Ppg=;
        b=NK4lpy/QyXPPVqOmHaFDTi3bdWOX00GwTv+NHyTh3LAsZjU+2xSYoIod1bmCi8KkSw
         53vW47Bfi/M2HldFiMj7hMM1gkL0MJ1O47D3rVh3s+6vc/zVkLR7F9ScRn6ltuCOoP93
         1sr0yavKsUp5cYRDUO8TjE1u83uix7Gg2z+CeS4eMMZQgm1QAicG+5Xs1mdFE+jnO/4R
         bq8hdoISoO4lC5bpeYwf9Fzc1l0Zo72j3f5q7VfRY6u+fD8tI4Xs4aPLsPvh1KAgNQgH
         x6fVXV9PWoAkUGVzeXsdQc8RSzDJ4YpH1BwFadAU4ALU4cZ78iBkXaDQr3t43T66teAz
         zqdg==
X-Gm-Message-State: APjAAAU7sBxmca/V04aHvsI1wbZLlX7MncrDvLtEi9K3FQUY3cRpMhvi
        ZkI/eCgRnX3XjjBInk6EK1fpburU39tLU5askfTP8bKqaVVu07vIFFIxfjSrcGINbUAiJeJ8TlL
        eTGU/PFSBrmbXCf7SzXMIm8DMUgwuaPyCt/W53VQxIc1USElUseTXKu3OevI=
X-Google-Smtp-Source: APXvYqxjacqHAucnW/tpFqcY4GITXlOPmGfdx7FxAZ7kvz5HuS7+9GVEp6bvjzvrdevjT7KgXvcV+D2sMGT9
X-Received: by 2002:ab0:7782:: with SMTP id x2mr4007164uar.140.1561676064382;
 Thu, 27 Jun 2019 15:54:24 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:05 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <4fe4baf34506a956a53688b7a2d2d6665878cdf6.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 01/10] list-objects-filter: encapsulate filter components
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de, Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Encapsulate filter_fn, filter_free_fn, and filter_data into their own
opaque struct.

Due to opaqueness, filter_fn and filter_free_fn can no longer be
accessed directly by users. Currently, all usages of filter_fn are
guarded by a necessary check:

	(obj->flags & NOT_USER_GIVEN) && filter_fn

Take the opportunity to include this check into the new function
list_objects_filter__filter_object(), so that we no longer need to write
this check at every caller of the filter function.

Also, the init functions in list-objects-filter.c no longer need to
confusingly return the filter constituents in various places (filter_fn
and filter_free_fn as out parameters, and filter_data as the function's
return value); they can just initialize the "struct filter" passed in.

Helped-by: Jeff Hostetler <git@jeffhostetler.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 112 ++++++++++++++++++++++++++++--------------
 list-objects-filter.h |  35 ++++++-------
 list-objects.c        |  55 +++++++++------------
 3 files changed, 113 insertions(+), 89 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 36e1f774bc..e06b82def0 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -19,20 +19,34 @@
  * FILTER_SHOWN_BUT_REVISIT -- we set this bit on tree objects
  * that have been shown, but should be revisited if they appear
  * in the traversal (until we mark it SEEN).  This is a way to
  * let us silently de-dup calls to show() in the caller.  This
  * is subtly different from the "revision.h:SHOWN" and the
  * "sha1-name.c:ONELINE_SEEN" bits.  And also different from
  * the non-de-dup usage in pack-bitmap.c
  */
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
 
+struct filter {
+	enum list_objects_filter_result (*filter_object_fn)(
+		struct repository *r,
+		enum list_objects_filter_situation filter_situation,
+		struct object *obj,
+		const char *pathname,
+		const char *filename,
+		void *filter_data);
+
+	void (*free_fn)(void *filter_data);
+
+	void *filter_data;
+};
+
 /*
  * A filter for list-objects to omit ALL blobs from the traversal.
  * And to OPTIONALLY collect a list of the omitted OIDs.
  */
 struct filter_blobs_none_data {
 	struct oidset *omits;
 };
 
 static enum list_objects_filter_result filter_blobs_none(
 	struct repository *r,
@@ -60,32 +74,31 @@ static enum list_objects_filter_result filter_blobs_none(
 	case LOFS_BLOB:
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
 		if (filter_data->omits)
 			oidset_insert(filter_data->omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 }
 
-static void *filter_blobs_none__init(
+static void filter_blobs_none__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter *filter)
 {
 	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
 
-	*filter_fn = filter_blobs_none;
-	*filter_free_fn = free;
-	return d;
+	filter->filter_data = d;
+	filter->filter_object_fn = filter_blobs_none;
+	filter->free_fn = free;
 }
 
 /*
  * A filter for list-objects to omit ALL trees and blobs from the traversal.
  * Can OPTIONALLY collect a list of the omitted OIDs.
  */
 struct filter_trees_depth_data {
 	struct oidset *omits;
 
 	/*
@@ -194,35 +207,34 @@ static enum list_objects_filter_result filter_trees_depth(
 }
 
 static void filter_trees_free(void *filter_data) {
 	struct filter_trees_depth_data *d = filter_data;
 	if (!d)
 		return;
 	oidmap_free(&d->seen_at_depth, 1);
 	free(d);
 }
 
-static void *filter_trees_depth__init(
+static void filter_trees_depth__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter *filter)
 {
 	struct filter_trees_depth_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
 	oidmap_init(&d->seen_at_depth, 0);
 	d->exclude_depth = filter_options->tree_exclude_depth;
 	d->current_depth = 0;
 
-	*filter_fn = filter_trees_depth;
-	*filter_free_fn = filter_trees_free;
-	return d;
+	filter->filter_data = d;
+	filter->filter_object_fn = filter_trees_depth;
+	filter->free_fn = filter_trees_free;
 }
 
 /*
  * A filter for list-objects to omit large blobs.
  * And to OPTIONALLY collect a list of the omitted OIDs.
  */
 struct filter_blobs_limit_data {
 	struct oidset *omits;
 	unsigned long max_bytes;
 };
@@ -274,33 +286,32 @@ static enum list_objects_filter_result filter_blobs_limit(
 			oidset_insert(filter_data->omits, &obj->oid);
 		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
 	}
 
 include_it:
 	if (filter_data->omits)
 		oidset_remove(filter_data->omits, &obj->oid);
 	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
 
-static void *filter_blobs_limit__init(
+static void filter_blobs_limit__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter *filter)
 {
 	struct filter_blobs_limit_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
 	d->max_bytes = filter_options->blob_limit_value;
 
-	*filter_fn = filter_blobs_limit;
-	*filter_free_fn = free;
-	return d;
+	filter->filter_data = d;
+	filter->filter_object_fn = filter_blobs_limit;
+	filter->free_fn = free;
 }
 
 /*
  * A filter driven by a sparse-checkout specification to only
  * include blobs that a sparse checkout would populate.
  *
  * The sparse-checkout spec can be loaded from a blob with the
  * given OID or from a local pathname.  We allow an OID because
  * the repo may be bare or we may be doing the filtering on the
  * server.
@@ -449,71 +460,98 @@ static enum list_objects_filter_result filter_sparse(
 }
 
 
 static void filter_sparse_free(void *filter_data)
 {
 	struct filter_sparse_data *d = filter_data;
 	free(d->array_frame);
 	free(d);
 }
 
-static void *filter_sparse_oid__init(
+static void filter_sparse_oid__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct filter *filter)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
 	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
 					   NULL, 0, &d->el) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
 	d->array_frame[d->nr].defval = 0; /* default to include */
 	d->array_frame[d->nr].child_prov_omit = 0;
 	d->nr++;
 
-	*filter_fn = filter_sparse;
-	*filter_free_fn = filter_sparse_free;
-	return d;
+	filter->filter_data = d;
+	filter->filter_object_fn = filter_sparse;
+	filter->free_fn = filter_sparse_free;
 }
 
-typedef void *(*filter_init_fn)(
+typedef void (*filter_init_fn)(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn);
+	struct filter *filter);
 
 /*
  * Must match "enum list_objects_filter_choice".
  */
 static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
 };
 
-void *list_objects_filter__init(
+struct filter *list_objects_filter__init(
 	struct oidset *omitted,
-	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
+	struct list_objects_filter_options *filter_options)
 {
+	struct filter *filter;
 	filter_init_fn init_fn;
 
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
 	if (filter_options->choice >= LOFC__COUNT)
 		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
 	init_fn = s_filters[filter_options->choice];
-	if (init_fn)
-		return init_fn(omitted, filter_options,
-			       filter_fn, filter_free_fn);
-	*filter_fn = NULL;
-	*filter_free_fn = NULL;
-	return NULL;
+	if (!init_fn)
+		return NULL;
+
+	filter = xcalloc(1, sizeof(*filter));
+	init_fn(omitted, filter_options, filter);
+	return filter;
+}
+
+enum list_objects_filter_result list_objects_filter__filter_object(
+	struct repository *r,
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	struct filter *filter)
+{
+	if (filter && (obj->flags & NOT_USER_GIVEN))
+		return filter->filter_object_fn(r, filter_situation, obj,
+						pathname, filename,
+						filter->filter_data);
+	/*
+	 * No filter is active or user gave object explicitly. In this case,
+	 * always show the object (except when LOFS_END_TREE, since this tree
+	 * had already been shown when LOFS_BEGIN_TREE).
+	 */
+	if (filter_situation == LOFS_END_TREE)
+		return 0;
+	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+}
+
+void list_objects_filter__free(struct filter *filter)
+{
+	if (!filter)
+		return;
+	filter->free_fn(filter->filter_data);
+	free(filter);
 }
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 1d45a4ad57..6908954266 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -53,37 +53,34 @@ enum list_objects_filter_result {
 	LOFR_DO_SHOW   = 1<<1,
 	LOFR_SKIP_TREE = 1<<2,
 };
 
 enum list_objects_filter_situation {
 	LOFS_BEGIN_TREE,
 	LOFS_END_TREE,
 	LOFS_BLOB
 };
 
-typedef enum list_objects_filter_result (*filter_object_fn)(
+struct filter;
+
+/* Constructor for the set of defined list-objects filters. */
+struct filter *list_objects_filter__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options);
+
+/*
+ * Lets `filter` decide how to handle the `obj`. If `filter` is NULL, this
+ * function behaves as expected if no filter is configured: all objects are
+ * included.
+ */
+enum list_objects_filter_result list_objects_filter__filter_object(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
-	void *filter_data);
-
-typedef void (*filter_free_fn)(void *filter_data);
+	struct filter *filter);
 
-/*
- * Constructor for the set of defined list-objects filters.
- * Returns a generic "void *filter_data".
- *
- * The returned "filter_fn" will be used by traverse_commit_list()
- * to filter the results.
- *
- * The returned "filter_free_fn" is a destructor for the
- * filter_data.
- */
-void *list_objects_filter__init(
-	struct oidset *omitted,
-	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn);
+/* Destroys `filter`. Does nothing if `filter` is null. */
+void list_objects_filter__free(struct filter *filter);
 
 #endif /* LIST_OBJECTS_FILTER_H */
diff --git a/list-objects.c b/list-objects.c
index b5651ddd5b..9307d91fb3 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -11,32 +11,31 @@
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
+	struct filter *filter;
 };
 
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
 			 const char *name)
 {
 	struct object *obj = &blob->object;
 	size_t pathlen;
-	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
+	enum list_objects_filter_result r;
 
 	if (!ctx->revs->blob_objects)
 		return;
 	if (!obj)
 		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 
 	/*
 	 * Pre-filter known-missing objects when explicitly requested.
@@ -47,25 +46,24 @@ static void process_blob(struct traversal_context *ctx,
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
+	r = list_objects_filter__filter_object(ctx->revs->repo,
+					       LOFS_BLOB, obj,
+					       path->buf, &path->buf[pathlen],
+					       ctx->filter);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
 		ctx->show_object(obj, path->buf, ctx->show_data);
 	strbuf_setlen(path, pathlen);
 }
 
 /*
  * Processing a gitlink entry currently does nothing, since
  * we do not recurse into the subproject.
@@ -150,21 +148,21 @@ static void process_tree_contents(struct traversal_context *ctx,
 }
 
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
 			 const char *name)
 {
 	struct object *obj = &tree->object;
 	struct rev_info *revs = ctx->revs;
 	int baselen = base->len;
-	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
+	enum list_objects_filter_result r;
 	int failed_parse;
 
 	if (!revs->tree_objects)
 		return;
 	if (!obj)
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 
 	failed_parse = parse_tree_gently(tree, 1);
@@ -179,47 +177,44 @@ static void process_tree(struct traversal_context *ctx,
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
+	r = list_objects_filter__filter_object(ctx->revs->repo,
+					       LOFS_BEGIN_TREE, obj,
+					       base->buf, &base->buf[baselen],
+					       ctx->filter);
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
-		if (r & LOFR_MARK_SEEN)
-			obj->flags |= SEEN;
-		if (r & LOFR_DO_SHOW)
-			ctx->show_object(obj, base->buf, ctx->show_data);
-	}
+	r = list_objects_filter__filter_object(ctx->revs->repo,
+					       LOFS_END_TREE, obj,
+					       base->buf, &base->buf[baselen],
+					       ctx->filter);
+	if (r & LOFR_MARK_SEEN)
+		obj->flags |= SEEN;
+	if (r & LOFR_DO_SHOW)
+		ctx->show_object(obj, base->buf, ctx->show_data);
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
 }
 
 static void mark_edge_parents_uninteresting(struct commit *commit,
 					    struct rev_info *revs,
 					    show_edge_fn show_edge)
 {
 	struct commit_list *parents;
@@ -395,38 +390,32 @@ static void do_traverse(struct traversal_context *ctx)
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
+	ctx.filter = NULL;
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
 
 	ctx.revs = revs;
 	ctx.show_object = show_object;
 	ctx.show_commit = show_commit;
 	ctx.show_data = show_data;
-	ctx.filter_fn = NULL;
-
-	ctx.filter_data = list_objects_filter__init(omitted, filter_options,
-						    &ctx.filter_fn, &filter_free_fn);
+	ctx.filter = list_objects_filter__init(omitted, filter_options);
 	do_traverse(&ctx);
-	if (ctx.filter_data && filter_free_fn)
-		filter_free_fn(ctx.filter_data);
+	list_objects_filter__free(ctx.filter);
 }
-- 
2.21.0

