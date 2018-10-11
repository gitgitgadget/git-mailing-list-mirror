Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD521F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJLGiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:38:55 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55503 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeJLGix (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:38:53 -0400
Received: by mail-pl1-f201.google.com with SMTP id ce7-v6so7872960plb.22
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u0FTBANf5B0FwxLTIqiyOqTjdy4YbpzGlGk3e4HGKs8=;
        b=U/BO6FJqfSH7T05kqPW+OmrhCEi5HtsqqtYuRI5Zpe/+zlzseeoEBwIh6U+7psmsRe
         8VCEg+BUvg9tFC5uL30f8nmBdzlIeD3iFNqF4MsVaejNYyH9BX815/IXTdBoEF7k+x7R
         soChlFCh6YEi695eqWfPr1Ah9x2sgf01cioyIkdHzppHf+hZWShQYXaRmcxr0SAieO7W
         m9MLGvoElCN0lYrjMM35Cmzd+B40HUs/5WlB8aPf0k/GPkpf+/vpLA/BUoolf3ci9gD8
         X+Xp7F7HUQyub+N+dsQ8dKiaywgLN1a/P0ka0sEY8ZYTUg5hG1KlWr//tmYEZwoBF4hL
         Mx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u0FTBANf5B0FwxLTIqiyOqTjdy4YbpzGlGk3e4HGKs8=;
        b=J9LIMdQrrSfaQNa5LlPSamMCQb6FOOwOFRwt1kR/AOpVpG93xMeVrTiUvJT52tNLhI
         ygR2M1Q+fVKfvZDkcSBXyNwL3Ce61uwibiIe2qwuxL40MF0LINkwGYLd3DIVo9P76QuG
         yBdHTT580zTp2iHrxjUjszYDi6b0O/4fm3V78jeUO1i9GHFzj1WHKtHXM87d1xD1Rcyr
         BklNyfjtG69JBD0Yf59dpdlKV0/cBGSSJYt+GK+4fVNFFKjO0rp9uhy10fB456cFlYkw
         TkyxCLzb2X80ftZ84/MySxdN6nfwMLcWKX4K7vlR48AZjZ7uuCjelu7bWDGJWrxYwZBi
         A3iQ==
X-Gm-Message-State: ABuFfoitg4eFU5MdaJBTjXpwCCMtSGQ7K/GX/n9rYhAw5tzb5YsX0AJO
        cBRjdsCix5kifbMGClRabS0yx2Vp16nC8yxfkeEezTCH8N7yK/PBFgf2enT+A1ilzhDuko2P1W9
        gLxWSdthyT4Nc6XQCQE4oypLAU8TP44zsfCmP7ZrcJpBFB83+IX6fCA3OXWc=
X-Google-Smtp-Source: ACcGV60yqtrDiwAca9qI8lx2wQbokWQb8pUFjm+cRicDO/xGeYOLkeYJCmjMcTF00LQXZF9oEvqEq9VMiT2o
X-Received: by 2002:a63:e903:: with SMTP id i3-v6mr1958086pgh.45.1539299365099;
 Thu, 11 Oct 2018 16:09:25 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:09:02 -0700
In-Reply-To: <cover.1539298957.git.matvore@google.com>
Message-Id: <e340f743e6749e65525e1342dc47faaa6540f04b.1539298957.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1539298957.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC PATCH 3/3] list-objects-filter: teach tree:# how to handle >0
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
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

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt  |  8 ++-
 list-objects-filter-options.c       |  6 +--
 list-objects-filter-options.h       |  1 +
 list-objects-filter.c               | 49 +++++++++++++----
 t/t6112-rev-list-filters-objects.sh | 84 +++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 16 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index c2c1c40e6..c78985c41 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -734,8 +734,12 @@ specification contained in <path>.
 +
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
-at multiple depths in the commits traversed). Currently, only <depth>=0
-is supported, which omits all blobs and trees.
+at multiple depths in the commits traversed). <depth>=0 will not include
+any trees or blobs unless included explicitly in <object>. <depth>=1
+will include only the tree and blobs which are referenced directly by a
+commit reachable from <object> or an object given in <object>. <depth>=2
+is like <depth>=1 while also including trees and blobs one more level
+removed from <object> or a reachable commit.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e8da2e858..9dc61d6e6 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -50,12 +50,12 @@ static int gently_parse_list_objects_filter(
 		}
 
 	} else if (skip_prefix(arg, "tree:", &v0)) {
-		unsigned long depth;
-		if (!git_parse_ulong(v0, &depth) || depth != 0) {
+		if (!git_parse_ulong(v0,
+				     &filter_options->tree_depth_limit_value)) {
 			if (errbuf) {
 				strbuf_addstr(
 					errbuf,
-					_("only 'tree:0' is supported"));
+					_("expected 'tree:<int>'"));
 			}
 			return 1;
 		}
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index af64e5c66..c1ae70cd8 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -44,6 +44,7 @@ struct list_objects_filter_options {
 	struct object_id *sparse_oid_value;
 	char *sparse_path_value;
 	unsigned long blob_limit_value;
+	unsigned long tree_depth_limit_value;
 };
 
 /* Normalized command line arguments */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 37fba456d..e69fb9b82 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -83,53 +83,80 @@ static void *filter_blobs_none__init(
  * A filter for list-objects to omit ALL trees and blobs from the traversal.
  * Can OPTIONALLY collect a list of the omitted OIDs.
  */
-struct filter_trees_none_data {
+struct filter_trees_depth_data {
 	struct oidset *omits;
+	unsigned long max_depth;
+	unsigned long current_depth;
 };
 
-static enum list_objects_filter_result filter_trees_none(
+static enum list_objects_filter_result filter_trees_depth(
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
 	void *filter_data_)
 {
-	struct filter_trees_none_data *filter_data = filter_data_;
+	struct filter_trees_depth_data *filter_data = filter_data_;
+
+	int too_deep = filter_data->current_depth >= filter_data->max_depth;
+
+	/*
+	 * Note that we do not use _MARK_SEEN in order to allow re-traversal in
+	 * case we encounter a tree or blob again at a shallower depth.
+	 */
 
 	switch (filter_situation) {
 	default:
 		BUG("unknown filter_situation: %d", filter_situation);
 
-	case LOFS_BEGIN_TREE:
 	case LOFS_BLOB:
+		if (!too_deep) goto include_it;
+
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+
+		return LOFR_ZERO;
+
+	case LOFS_BEGIN_TREE:
+		filter_data->current_depth++;
+
+		if (!too_deep) goto include_it;
+
 		if (filter_data->omits) {
 			oidset_insert(filter_data->omits, &obj->oid);
-			/* _MARK_SEEN but not _DO_SHOW (hard omit) */
-			return LOFR_MARK_SEEN;
+			return LOFR_ZERO;
 		}
 		else
 			/*
 			 * Not collecting omits so no need to to traverse tree.
 			 */
-			return LOFR_SKIP_TREE | LOFR_MARK_SEEN;
+			return LOFR_SKIP_TREE;
 
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
+		filter_data->current_depth--;
 		return LOFR_ZERO;
 
 	}
+
+include_it:
+	if (filter_data->omits)
+		oidset_remove(filter_data->omits, &obj->oid);
+	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
 }
 
-static void* filter_trees_none__init(
+static void* filter_trees_depth__init(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
 	filter_object_fn *filter_fn,
 	filter_free_fn *filter_free_fn)
 {
-	struct filter_trees_none_data *d = xcalloc(1, sizeof(*d));
+	struct filter_trees_depth_data *d = xcalloc(1, sizeof(*d));
 	d->omits = omitted;
+	d->max_depth = filter_options->tree_depth_limit_value;
+	d->current_depth = 0;
 
-	*filter_fn = filter_trees_none;
+	*filter_fn = filter_trees_depth;
 	*filter_free_fn = free;
 	return d;
 }
@@ -426,7 +453,7 @@ static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
-	filter_trees_none__init,
+	filter_trees_depth__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
 };
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index efb1bee2e..43ee0df80 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -254,6 +254,90 @@ test_expect_success 'filter a GIANT tree through tree:0' '
 	test_line_count = 2 actual
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
+	commit=$1 &&
+	name=$2 &&
+
+	hash=$(git -C r4 rev-parse $commit:$name) &&
+	! grep "^$hash $name$" actual &&
+	grep "^$hash " actual &&
+	! grep "~$hash" actual
+}
+
+test_expect_success 'test tree:# filter provisional omit for blob and tree' '
+	git -C r4 rev-list --objects --filter-print-omitted --filter=tree:2 \
+		HEAD >actual &&
+
+	expect_has_with_different_name HEAD filt/foo &&
+	expect_has_with_different_name HEAD filt/subdir
+'
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.19.1.331.ge82ca0e54c-goog

