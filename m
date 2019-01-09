Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219301F803
	for <e@80x24.org>; Wed,  9 Jan 2019 02:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfAIC73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 21:59:29 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:46947 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIC72 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 21:59:28 -0500
Received: by mail-io1-f73.google.com with SMTP id o22so5264928iob.13
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 18:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YQEQOI67Udv8X6825rEXKNWfLx4tGlUaPxkHF/2WjVw=;
        b=P5tK8Dsck5pChQJgMuxT77AqO4GMQzRfJWtd951uFdwolRTZwQ+1kMuWviDFJHX3E2
         HRYLV9L3N+Jz9q2SEHl1r3ZW1QVC6fob19cLkCj0QtFBepYljCw9S75DqQ5VVjn1Tbug
         g1m7BdooCIKMuO9T2/gGzI6ZN8NmHZKDSKB7oXIyYMiLyCTCgw5UbQQVWZdniADXnNdc
         9kcSIDXb+dyUH3MZvvQdi5TJj+nMksNDkE1/HfhGOxWaHdlA2geMF9Xvs6hCXWtFzKDW
         aXug3KH+opIUR5GyYKw6LaKBD5HRnjxfGG5XYhJVLRCuCvz1WTtxbkdbr2g/cV+DkuTd
         kKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YQEQOI67Udv8X6825rEXKNWfLx4tGlUaPxkHF/2WjVw=;
        b=jM/bYbZGd92QW+2X/bRKcWYL3/l1I1SKv9oCYdhx/eK1n+q9FN+0njVo7dgl1sKqtq
         8g9O4cmZsK7tvps2tMDyzR1HjKXAyhjfiH+V7CCTualQ/KRyQQmZHzAivTguPzusgqTR
         7ZsE0HA+KUs/lNNm0Sy5oDYQ0HPPtutLGKG1mJiXUwCKdMpu49XpxR4VRjL78ZvLHB2u
         26JBm8+mLEowA4+gSq97bgMx4eIBAxEUoUEp4m0/ZVcXNRF4MrPsaM7/ioYVGaB2Aibe
         I1oq4s9b/FMAa7dl/Fp25LLsvlRkycHGc6/b5vUDv3l6mPAdKkaHTB6YL+lYwYkwL7o/
         RTfw==
X-Gm-Message-State: AJcUukfFEYJGw1LhrbZLZ5xLlfZXqfF5DL0DQ848AVDw4JG1bABP1aE9
        xJQSDoAxeCbgxejJi9abTkpgAv0uiiZ7VchWgsEKgw7vraaIu8omFKR3sumxyvCyZnk53lfB+Gu
        rGgtt9/17+v2jmRD3WVnsRcVU/w1Rjficp2MYSkTDpSIIKumaa/Yk3ik1WCg=
X-Google-Smtp-Source: ALg8bN5stre51OqX2mhQywnK3YRIIJlbnq6VoP5TSiDTohysbfa38eiHIv2JCPiEOy+4pgIv68arGZmyAXGU
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr3124658ita.8.1547002767340;
 Tue, 08 Jan 2019 18:59:27 -0800 (PST)
Date:   Tue,  8 Jan 2019 18:59:13 -0800
In-Reply-To: <20190109025914.247473-1-matvore@google.com>
Message-Id: <20190109025914.247473-2-matvore@google.com>
Mime-Version: 1.0
References: <20181210234030.176178-1-matvore@google.com> <20190109025914.247473-1-matvore@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 1/2] list-objects-filter: teach tree:# how to handle >0
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        pclouds@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement positive values for <depth> in the tree:<depth> filter. The
exact semantics are described in Documentation/rev-list-options.txt.

The long-term goal at the end of this is to allow a partial clone to
eagerly fetch an entire directory of files by fetching a tree and
specifying <depth>=1. This, for instance, would make a build operation
fast and convenient. It is fast because the partial clone does not need
to fetch each file individually, and convenient because the user does
not need to supply a sparse-checkout specification.

Another way of considering this feature is as a way to reduce
round-trips, since the client can get any number of levels of
directories in a single request, rather than wait for each level of tree
objects to come back, whose entries are used to construct a new request.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt  |   9 ++-
 list-objects-filter-options.c       |   7 +-
 list-objects-filter-options.h       |   3 +-
 list-objects-filter.c               | 116 +++++++++++++++++++++++-----
 t/t6112-rev-list-filters-objects.sh | 111 ++++++++++++++++++++++++++
 5 files changed, 219 insertions(+), 27 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bab5f50b17..f8ab00f7c9 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -734,8 +734,13 @@ specification contained in <path>.
 +
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
-at multiple depths in the commits traversed). Currently, only <depth>=0
-is supported, which omits all blobs and trees.
+at multiple depths in the commits traversed). <depth>=0 will not include
+any trees or blobs unless included explicitly in the command-line (or
+standard input when --stdin is used). <depth>=1 will include only the
+tree and blobs which are referenced directly by a commit reachable from
+<commit> or an explicitly-given object. <depth>=2 is like <depth>=1
+while also including trees and blobs one more level removed from an
+explicitly-given commit or tree.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e8da2e8581..5285e7674d 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -50,16 +50,15 @@ static int gently_parse_list_objects_filter(
 		}
 
 	} else if (skip_prefix(arg, "tree:", &v0)) {
-		unsigned long depth;
-		if (!git_parse_ulong(v0, &depth) || depth != 0) {
+		if (!git_parse_ulong(v0, &filter_options->tree_exclude_depth)) {
 			if (errbuf) {
 				strbuf_addstr(
 					errbuf,
-					_("only 'tree:0' is supported"));
+					_("expected 'tree:<depth>'"));
 			}
 			return 1;
 		}
-		filter_options->choice = LOFC_TREE_NONE;
+		filter_options->choice = LOFC_TREE_DEPTH;
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index af64e5c66f..477cd97029 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -10,7 +10,7 @@ enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
 	LOFC_BLOB_NONE,
 	LOFC_BLOB_LIMIT,
-	LOFC_TREE_NONE,
+	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
 	LOFC_SPARSE_PATH,
 	LOFC__COUNT /* must be last */
@@ -44,6 +44,7 @@ struct list_objects_filter_options {
 	struct object_id *sparse_oid_value;
 	char *sparse_path_value;
 	unsigned long blob_limit_value;
+	unsigned long tree_exclude_depth;
 };
 
 /* Normalized command line arguments */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index a62624a1ce..786e0dd0b1 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -10,6 +10,7 @@
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "oidmap.h"
 #include "oidset.h"
 #include "object-store.h"
 
@@ -84,11 +85,43 @@ static void *filter_blobs_none__init(
  * A filter for list-objects to omit ALL trees and blobs from the traversal.
  * Can OPTIONALLY collect a list of the omitted OIDs.
  */
-struct filter_trees_none_data {
+struct filter_trees_depth_data {
 	struct oidset *omits;
+
+	/*
+	 * Maps trees to the minimum depth at which they were seen. It is not
+	 * necessary to re-traverse a tree at deeper or equal depths than it has
+	 * already been traversed.
+	 *
+	 * We can't use LOFR_MARK_SEEN for tree objects since this will prevent
+	 * it from being traversed at shallower depths.
+	 */
+	struct oidmap seen_at_depth;
+
+	unsigned long exclude_depth;
+	unsigned long current_depth;
 };
 
-static enum list_objects_filter_result filter_trees_none(
+struct seen_map_entry {
+	struct oidmap_entry base;
+	size_t depth;
+};
+
+static void filter_trees_update_omits(
+	struct object *obj,
+	struct filter_trees_depth_data *filter_data,
+	int include_it)
+{
+	if (!filter_data->omits)
+		return;
+
+	if (include_it)
+		oidset_remove(filter_data->omits, &obj->oid);
+	else
+		oidset_insert(filter_data->omits, &obj->oid);
+}
+
+static enum list_objects_filter_result filter_trees_depth(
 	struct repository *r,
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
@@ -96,43 +129,86 @@ static enum list_objects_filter_result filter_trees_none(
 	const char *filename,
 	void *filter_data_)
 {
-	struct filter_trees_none_data *filter_data = filter_data_;
+	struct filter_trees_depth_data *filter_data = filter_data_;
+	struct seen_map_entry *seen_info;
+	int include_it = filter_data->current_depth <
+		filter_data->exclude_depth;
+	int filter_res;
+	int already_seen;
+
+	/*
+	 * Note that we do not use _MARK_SEEN in order to allow re-traversal in
+	 * case we encounter a tree or blob again at a shallower depth.
+	 */
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
-	case LOFS_BEGIN_TREE:
+	case LOFS_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		filter_data->current_depth--;
+		return LOFR_ZERO;
+
 	case LOFS_BLOB:
-		if (filter_data->omits) {
-			oidset_insert(filter_data->omits, &obj->oid);
-			/* _MARK_SEEN but not _DO_SHOW (hard omit) */
-			return LOFR_MARK_SEEN;
+		filter_trees_update_omits(obj, filter_data, include_it);
+		return include_it ? LOFR_MARK_SEEN | LOFR_DO_SHOW : LOFR_ZERO;
+
+	case LOFS_BEGIN_TREE:
+		seen_info = oidmap_get(
+			&filter_data->seen_at_depth, &obj->oid);
+		if (!seen_info) {
+			seen_info = xcalloc(1, sizeof(*seen_info));
+			oidcpy(&seen_info->base.oid, &obj->oid);
+			seen_info->depth = filter_data->current_depth;
+			oidmap_put(&filter_data->seen_at_depth, seen_info);
+			already_seen = 0;
 		} else {
-			/*
-			 * Not collecting omits so no need to to traverse tree.
-			 */
-			return LOFR_SKIP_TREE | LOFR_MARK_SEEN;
+			already_seen =
+				filter_data->current_depth >= seen_info->depth;
 		}
 
-	case LOFS_END_TREE:
-		assert(obj->type == OBJ_TREE);
-		return LOFR_ZERO;
+		if (already_seen) {
+			filter_res = LOFR_SKIP_TREE;
+		} else {
+			seen_info->depth = filter_data->current_depth;
+			filter_trees_update_omits(obj, filter_data, include_it);
+
+			if (include_it)
+				filter_res = LOFR_DO_SHOW;
+			else if (filter_data->omits)
+				filter_res = LOFR_ZERO;
+			else
+				filter_res = LOFR_SKIP_TREE;
+		}
 
+		filter_data->current_depth++;
+		return filter_res;
 	}
 }
 
-static void* filter_trees_none__init(
+static void filter_trees_free(void *filter_data) {
+	struct filter_trees_depth_data *d = filter_data;
+	if (!d)
+		return;
+	oidmap_free(&d->seen_at_depth, 1);
+	free(d);
+}
+
+static void *filter_trees_depth__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	filter_object_fn *filter_fn,
 	filter_free_fn *filter_free_fn)
 {
-	struct filter_trees_none_data *d = xcalloc(1, sizeof(*d));
+	struct filter_trees_depth_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
+	oidmap_init(&d->seen_at_depth, 0);
+	d->exclude_depth = filter_options->tree_exclude_depth;
+	d->current_depth = 0;
 
-	*filter_fn = filter_trees_none;
-	*filter_free_fn = free;
+	*filter_fn = filter_trees_depth;
+	*filter_free_fn = filter_trees_free;
 	return d;
 }
 
@@ -430,7 +506,7 @@ static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
-	filter_trees_none__init,
+	filter_trees_depth__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
 };
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index eb32505a6e..706845f1d9 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -294,6 +294,117 @@ test_expect_success 'filter a GIANT tree through tree:0' '
 	! grep "Skipping contents of tree [^.]" filter_trace
 '
 
+# Test tree:# filters.
+
+expect_has () {
+	commit=$1 &&
+	name=$2 &&
+
+	hash=$(git -C r3 rev-parse $commit:$name) &&
+	grep "^$hash $name$" actual
+}
+
+test_expect_success 'verify tree:1 includes root trees' '
+	git -C r3 rev-list --objects --filter=tree:1 HEAD >actual &&
+
+	# We should get two root directories and two commits.
+	expect_has HEAD "" &&
+	expect_has HEAD~1 ""  &&
+	test_line_count = 4 actual
+'
+
+test_expect_success 'verify tree:2 includes root trees and immediate children' '
+	git -C r3 rev-list --objects --filter=tree:2 HEAD >actual &&
+
+	expect_has HEAD "" &&
+	expect_has HEAD~1 "" &&
+	expect_has HEAD dir1 &&
+	expect_has HEAD pattern &&
+	expect_has HEAD sparse1 &&
+	expect_has HEAD sparse2 &&
+
+	# There are also 2 commit objects
+	test_line_count = 8 actual
+'
+
+test_expect_success 'verify tree:3 includes everything expected' '
+	git -C r3 rev-list --objects --filter=tree:3 HEAD >actual &&
+
+	expect_has HEAD "" &&
+	expect_has HEAD~1 "" &&
+	expect_has HEAD dir1 &&
+	expect_has HEAD dir1/sparse1 &&
+	expect_has HEAD dir1/sparse2 &&
+	expect_has HEAD pattern &&
+	expect_has HEAD sparse1 &&
+	expect_has HEAD sparse2 &&
+
+	# There are also 2 commit objects
+	test_line_count = 10 actual
+'
+
+# Test provisional omit collection logic with a repo that has objects appearing
+# at multiple depths - first deeper than the filter's threshold, then shallow.
+
+test_expect_success 'setup r4' '
+	git init r4 &&
+
+	echo foo > r4/foo &&
+	mkdir r4/subdir &&
+	echo bar > r4/subdir/bar &&
+
+	mkdir r4/filt &&
+	cp -r r4/foo r4/subdir r4/filt &&
+
+	git -C r4 add foo subdir filt &&
+	git -C r4 commit -m "commit msg"
+'
+
+expect_has_with_different_name () {
+	repo=$1 &&
+	name=$2 &&
+
+	hash=$(git -C $repo rev-parse HEAD:$name) &&
+	! grep "^$hash $name$" actual &&
+	grep "^$hash " actual &&
+	! grep "~$hash" actual
+}
+
+test_expect_success 'test tree:# filter provisional omit for blob and tree' '
+	git -C r4 rev-list --objects --filter-print-omitted --filter=tree:2 \
+		HEAD >actual &&
+	expect_has_with_different_name r4 filt/foo &&
+	expect_has_with_different_name r4 filt/subdir
+'
+
+# Test tree:<depth> where a tree is iterated to twice - once where a subentry is
+# too deep to be included, and again where the blob inside it is shallow enough
+# to be included. This makes sure we don't use LOFR_MARK_SEEN incorrectly (we
+# can't use it because a tree can be iterated over again at a lower depth).
+
+test_expect_success 'tree:<depth> where we iterate over tree at two levels' '
+	git init r5 &&
+
+	mkdir -p r5/a/subdir/b &&
+	echo foo > r5/a/subdir/b/foo &&
+
+	mkdir -p r5/subdir/b &&
+	echo foo > r5/subdir/b/foo &&
+
+	git -C r5 add a subdir &&
+	git -C r5 commit -m "commit msg" &&
+
+	git -C r5 rev-list --objects --filter=tree:4 HEAD >actual &&
+	expect_has_with_different_name r5 a/subdir/b/foo
+'
+
+test_expect_success 'tree:<depth> which filters out blob but given as arg' '
+	blob_hash=$(git -C r4 rev-parse HEAD:subdir/bar) &&
+
+	git -C r4 rev-list --objects --filter=tree:1 HEAD $blob_hash >actual &&
+	grep ^$blob_hash actual
+'
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.20.1.97.g81188d93c3-goog

