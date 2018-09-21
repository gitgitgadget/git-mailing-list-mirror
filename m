Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEB41F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391519AbeIVCXO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 22:23:14 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37591 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391517AbeIVCXO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 22:23:14 -0400
Received: by mail-pf1-f201.google.com with SMTP id v9-v6so7032902pff.4
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mgM40qMWfEoIxPqTpoIns8JsKvkKo0kvvCSL68u4r0g=;
        b=GI5sh+QMhSSSiGQnhot3sWqG6dYMOjL0Z0xpklf673bZGMSYzTqrrPiS88RoCUZX0z
         2I/hr3Sg/WWkqb6NwoZe08M22eHRTqTFXtOke8CMtkT4JmpH06RtB8YdJx3L36AIHFB+
         v0HGZYH5p8fHUFWxg6XybQVZzbCkbqk77bJpp4OSBM4OgNxIpEKDPz2wNdCobbtgp25z
         +bE+gTvW85aIzDXHIwRIs2Hy/29VzciDzg47CA8FQ33Shl5czQzK/nQsKM0VNgOgWJYM
         ZcsdL42Cy+pRF+qTG7PPeLympJwF16uWm3EMYUGiPtve8DyQSBcPGcPrWUxuhgDtL9IL
         BVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mgM40qMWfEoIxPqTpoIns8JsKvkKo0kvvCSL68u4r0g=;
        b=J4DkMjxFqlIayXar5agC15KjNxDjfaKoOf8UHSp7wjfuHSzTlP1b4qb6dY4JwIE3OW
         ieBDDL5lJsDKNhCLafHVtfoIcfpWPz1siY1sWNdj2igyy0aEpPDzeRVGZSPHopjrFa5d
         5jyfanXvEEqAG01Q9h+ZspwSVlW0kga3uzk+0Mi2KFnfkkJ2DPt6bMR27HWf/8uWu1FY
         vVwaQvB8vYP+XAGRhaBTHaW1B+QPd712ieYkgrPyvwWOaYC3Jj8fLYL8wJiC+eYLr2Us
         xjLIC57OTLciu5w9WjhKV8hI928u//2NWtgxg7MhcBnN81s9a5GH21XON8T0K+dkseuz
         f6vg==
X-Gm-Message-State: APzg51Bq+s2ALDXJxW12RKlrdvWJxxWZNCs5j6wLkXETtP0JNkSBv1KF
        AJPWBke7wshGUVqLTxCpu23JzioXsblL7eSzf6DIqXJuVrssWjNhArhSTRNLc57EJr/cS2Mm16v
        /1qi3PGf7yaV2lastPjJURKZ5Vfi6hqhKelfvlAohbWPCURKvkvk9Qk/1W4A=
X-Google-Smtp-Source: ANB0VdaH53V5j7YlzSWGKYvYAnxToZCFAEBsR1pkM/Iki3EEBPvwXSpEc2wFPb8/9qhmi7bp7Loi71gi54kN
X-Received: by 2002:a65:4981:: with SMTP id r1-v6mr2155803pgs.0.1537561961573;
 Fri, 21 Sep 2018 13:32:41 -0700 (PDT)
Date:   Fri, 21 Sep 2018 13:32:04 -0700
In-Reply-To: <cover.1537561420.git.matvore@google.com>
Message-Id: <5e87a9cfcd096784965892c1f87c78bed2f24367.1537561420.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1537561420.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v9 8/8] list-objects-filter: implement filter tree:0
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

Teach list-objects the "tree:0" filter which allows for filtering
out all tree and blob objects (unless other objects are explicitly
specified by the user). The purpose of this patch is to allow smaller
partial clones.

The name of this filter - tree:0 - does not explicitly specify that
it also filters out all blobs, but this should not cause much confusion
because blobs are not at all useful without the trees that refer to
them.

I also considered only:commits as a name, but this is inaccurate because
it suggests that annotated tags are omitted, but actually they are
included.

The name "tree:0" allows later filtering based on depth, i.e. "tree:1"
would filter out all but the root tree and blobs. In order to avoid
confusion between 0 and capital O, the documentation was worded in a
somewhat round-about way that also hints at this future improvement to
the feature.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt     |  5 +++
 list-objects-filter-options.c          | 13 +++++++
 list-objects-filter-options.h          |  1 +
 list-objects-filter.c                  | 49 ++++++++++++++++++++++++++
 t/t5317-pack-objects-filter-objects.sh | 28 +++++++++++++++
 t/t5616-partial-clone.sh               | 41 +++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh    | 13 +++++++
 7 files changed, 150 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7b273635d..5f1672913 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -731,6 +731,11 @@ the requested refs.
 +
 The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
 specification contained in <path>.
++
+The form '--filter=tree:<depth>' omits all blobs and trees whose depth
+from the root tree is >= <depth> (minimum depth if an object is located
+at multiple depths in the commits traversed). Currently, only <depth>=0
+is supported, which omits all blobs and trees.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d259bdb2c..e8da2e858 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -49,6 +49,19 @@ static int gently_parse_list_objects_filter(
 			return 0;
 		}
 
+	} else if (skip_prefix(arg, "tree:", &v0)) {
+		unsigned long depth;
+		if (!git_parse_ulong(v0, &depth) || depth != 0) {
+			if (errbuf) {
+				strbuf_addstr(
+					errbuf,
+					_("only 'tree:0' is supported"));
+			}
+			return 1;
+		}
+		filter_options->choice = LOFC_TREE_NONE;
+		return 0;
+
 	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
 		struct object_context oc;
 		struct object_id sparse_oid;
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 0000a61f8..af64e5c66 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -10,6 +10,7 @@ enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
 	LOFC_BLOB_NONE,
 	LOFC_BLOB_LIMIT,
+	LOFC_TREE_NONE,
 	LOFC_SPARSE_OID,
 	LOFC_SPARSE_PATH,
 	LOFC__COUNT /* must be last */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 5f8b1a002..09b2b05d5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -79,6 +79,54 @@ static void *filter_blobs_none__init(
 	return d;
 }
 
+/*
+ * A filter for list-objects to omit ALL trees and blobs from the traversal.
+ * Can OPTIONALLY collect a list of the omitted OIDs.
+ */
+struct filter_trees_none_data {
+	struct oidset *omits;
+};
+
+static enum list_objects_filter_result filter_trees_none(
+	enum list_objects_filter_situation filter_situation,
+	struct object *obj,
+	const char *pathname,
+	const char *filename,
+	void *filter_data_)
+{
+	struct filter_trees_none_data *filter_data = filter_data_;
+
+	switch (filter_situation) {
+	default:
+		BUG("unknown filter_situation: %d", filter_situation);
+
+	case LOFS_BEGIN_TREE:
+	case LOFS_BLOB:
+		if (filter_data->omits)
+			oidset_insert(filter_data->omits, &obj->oid);
+		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
+
+	case LOFS_END_TREE:
+		assert(obj->type == OBJ_TREE);
+		return LOFR_ZERO;
+
+	}
+}
+
+static void* filter_trees_none__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	struct filter_trees_none_data *d = xcalloc(1, sizeof(*d));
+	d->omits = omitted;
+
+	*filter_fn = filter_trees_none;
+	*filter_free_fn = free;
+	return d;
+}
+
 /*
  * A filter for list-objects to omit large blobs.
  * And to OPTIONALLY collect a list of the omitted OIDs.
@@ -371,6 +419,7 @@ static filter_init_fn s_filters[] = {
 	NULL,
 	filter_blobs_none__init,
 	filter_blobs_limit__init,
+	filter_trees_none__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
 };
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 9839b48c1..510d3537f 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -72,6 +72,34 @@ test_expect_success 'get an error for missing tree object' '
 	grep -q "bad tree object" bad_tree
 '
 
+test_expect_success 'setup for tests of tree:0' '
+	mkdir r1/subtree &&
+	echo "This is a file in a subtree" >r1/subtree/file &&
+	git -C r1 add subtree/file &&
+	git -C r1 commit -m subtree
+'
+
+test_expect_success 'verify tree:0 packfile has no blobs or trees' '
+	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r1 index-pack ../commitsonly.pack &&
+	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
+	! grep -E "tree|blob" objs
+'
+
+test_expect_success 'grab tree directly when using tree:0' '
+	# We should get the tree specified directly but not its blobs or subtrees.
+	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
+	HEAD:
+	EOF
+	git -C r1 index-pack ../commitsonly.pack &&
+	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
+	awk "/tree|blob/{print \$1}" objs >trees_and_blobs &&
+	git -C r1 rev-parse HEAD: >expected &&
+	test_cmp expected trees_and_blobs
+'
+
 # Test blob:limit=<n>[kmg] filter.
 # We boundary test around the size parameter.  The filter is strictly less than
 # the value, so size 500 and 1000 should have the same results, but 1001 should
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index bbbe7537d..7b6294ca5 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -154,6 +154,47 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack -
 	grep "git index-pack.*--fsck-objects" trace
 '
 
+test_expect_success 'use fsck before and after manually fetching a missing subtree' '
+	# push new commit so server has a subtree
+	mkdir src/dir &&
+	echo "in dir" >src/dir/file.txt &&
+	git -C src add dir/file.txt &&
+	git -C src commit -m "file in dir" &&
+	git -C src push -u srv master &&
+	SUBTREE=$(git -C src rev-parse HEAD:dir) &&
+
+	rm -rf dst &&
+	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
+	git -C dst fsck &&
+
+	# Make sure we only have commits, and all trees and blobs are missing.
+	git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
+	awk -f print_1.awk fetched_objects |
+	xargs -n1 git -C dst cat-file -t >fetched_types &&
+
+	sort -u fetched_types >unique_types.observed &&
+	echo commit >unique_types.expected &&
+	test_cmp unique_types.expected unique_types.observed &&
+
+	# Auto-fetch a tree with cat-file.
+	git -C dst cat-file -p $SUBTREE >tree_contents &&
+	grep file.txt tree_contents &&
+
+	# fsck still works after an auto-fetch of a tree.
+	git -C dst fsck &&
+
+	# Auto-fetch all remaining trees and blobs with --missing=error
+	git -C dst rev-list master --missing=error --objects >fetched_objects &&
+	test_line_count = 70 fetched_objects &&
+
+	awk -f print_1.awk fetched_objects |
+	xargs -n1 git -C dst cat-file -t >fetched_types &&
+
+	sort -u fetched_types >unique_types.observed &&
+	printf "blob\ncommit\ntree\n" >unique_types.expected &&
+	test_cmp unique_types.expected unique_types.observed
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 11186209b..6e5c41a68 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -224,6 +224,19 @@ test_expect_success 'rev-list W/ --missing=print and --missing=allow-any for tre
 	test_must_be_empty rev_list_err
 '
 
+# Test tree:0 filter.
+
+test_expect_success 'verify tree:0 includes trees in "filtered" output' '
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=tree:0 |
+	awk -f print_1.awk |
+	sed s/~// |
+	xargs -n1 git -C r3 cat-file -t |
+	sort -u >filtered_types &&
+
+	printf "blob\ntree\n" >expected &&
+	test_cmp expected filtered_types
+'
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.19.0.444.g18242da7ef-goog

