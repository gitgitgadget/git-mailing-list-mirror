Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7D81F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 22:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeHJBMi (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 21:12:38 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:41893 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeHJBMi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 21:12:38 -0400
Received: by mail-qt0-f202.google.com with SMTP id l13-v6so5808373qth.8
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bln7s7dR4MzrtK4sqs3MmHCzXOU6rrf03hrgg7n+P1Q=;
        b=FM/wqr7jXVyEFHgt5iM39yEcr0fFmdtzH6+2daZcRNPG0MkNg34/jWrCmZ6VzB39mQ
         gFR/qb86JkNBMWTVmlJ2kCy+Y8s27PGZSEFDjnmnOHNkF3gCFCaTGBfrAX109F/68LAe
         IKF0c7JSiOnMo/c57iwcd4EDU/msReMlReLcUalD6RO4SD8qgYnAMI9xD7vfRW2inEyM
         4XYoUzNnuCqqqQyJ6cjdzqP9THE/Q/QXJGU4XBJU5kst8n0fBv5yjzaFdLSSbJ3utsx5
         KuTuxD8KnwmboDr1GzhvkY1TkRKORUcZRD8HJ6jSvy4E0j8FP2V/sdagA29cA9Gv7iL4
         HdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bln7s7dR4MzrtK4sqs3MmHCzXOU6rrf03hrgg7n+P1Q=;
        b=jJci3qhafUq2V1tqfF3njSZL2Zf1EYaB9FebyC0qF4mDrNyymiIUi1sfrYK3b3+8eZ
         AGzjFVn3FEM9LuCB6ZcmxxVTiuQsvLfcRB6JmwiEtQZvjGBlBOu++ylcUlMbMXYDS27c
         s+dEnwHMOPRKuZt8ENXnKFxIThYAKfkxfzWATqU7fe9KtkLg0iB66FKBplu76RfVUuAv
         3jXKcuT7FJDxAUiKtrrMwzTh1L5rbfnbP10lQKOvJQqDncQjUDX0ctbMzcyHIN54vhFv
         FIYyqElk439YUdxneLAVqSegkGjTsWkatlhxe0sCfYfXY7KwGodglj8cZbozNHXrIa91
         lEzQ==
X-Gm-Message-State: AOUpUlFSPg6cBSOinFS7kWTeFV/mlmfGTZ9fWEypJjBzXse5+0WzsSgw
        W3Xt13+4hRdReED/jFyJJ3GRSqpA/svJi1jinb8104NrIpu66DXk0cnzc5t23NEPQkNxUiO3O/v
        /7Vacb/uHsy8yeIg+3RcGfcrnA26ztQR3M14OovkpA5v+VpTRwKtcXKJmCjE=
X-Google-Smtp-Source: AA+uWPzMHDEGhHlCH87yA4x0MM4SUy35z+1bMjCSAWEWnX/miirGsejUDfK6HPki8Nv4orivCXjbYFYLz7BT
X-Received: by 2002:a37:1206:: with SMTP id c6-v6mr2172149qkh.20.1533854737498;
 Thu, 09 Aug 2018 15:45:37 -0700 (PDT)
Date:   Thu,  9 Aug 2018 15:45:01 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <71619cbd1004d7acf991011fc0c941d4a5716079.1533854545.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 2/5] list-objects-filter: implement filter only:commits
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach list-objects the "only:commits" filter which allows for filtering
out all non-commit and non-annotated tag objects (unless other objects
are explicitly specified by the user). The purpose of this patch is to
allow smaller partial clones.

The name of this filter - only:commits - is a bit inaccurate because it
still allows annotated tags to pass through. I chose it because it was
the only concise name I could think of that was pretty descriptive. I
considered and decided against "tree:none" because the code and
documentation for filters seems to lack the concept of "you're filtering
this, so we'll implicitly filter all referents of this." So "tree:none"
is vague, since some may think it filters blobs too, while some may not.
"only:commits" is specific and makes it easier to match it to a
potential use case.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt     |  2 ++
 list-objects-filter-options.c          |  4 +++
 list-objects-filter-options.h          |  1 +
 list-objects-filter.c                  | 43 ++++++++++++++++++--------
 t/t5317-pack-objects-filter-objects.sh | 30 ++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh    | 13 ++++++++
 6 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7b273635d..3a60a490a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -743,6 +743,8 @@ specification contained in <path>.
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
 +
+The form '--filter=only:commits' omits all blobs and trees.
++
 The form '--missing=error' requests that rev-list stop with an error if
 a missing object is encountered.  This is the default action.
 +
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0e2bd6a0..aaaaae508 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -69,6 +69,10 @@ static int gently_parse_list_objects_filter(
 		filter_options->choice = LOFC_SPARSE_PATH;
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
+
+	} else if (!strcmp(arg, "only:commits")) {
+		filter_options->choice = LOFC_ONLY_COMMITS;
+		return 0;
 	}
 
 	if (errbuf) {
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 0000a61f8..a68df42c8 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -12,6 +12,7 @@ enum list_objects_filter_choice {
 	LOFC_BLOB_LIMIT,
 	LOFC_SPARSE_OID,
 	LOFC_SPARSE_PATH,
+	LOFC_ONLY_COMMITS,
 	LOFC__COUNT /* must be last */
 };
 
diff --git a/list-objects-filter.c b/list-objects-filter.c
index a0ba78b20..f0a064b4b 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -26,38 +26,39 @@
 #define FILTER_SHOWN_BUT_REVISIT (1<<21)
 
 /*
- * A filter for list-objects to omit ALL blobs from the traversal.
- * And to OPTIONALLY collect a list of the omitted OIDs.
+ * A filter for list-objects to omit ALL blobs from the traversal, and possibly
+ * trees as well.
+ * Can OPTIONALLY collect a list of the omitted OIDs.
  */
-struct filter_blobs_none_data {
+struct filter_none_of_type_data {
+	unsigned omit_trees : 1;
 	struct oidset *omits;
 };
 
-static enum list_objects_filter_result filter_blobs_none(
+static enum list_objects_filter_result filter_none_of_type(
 	enum list_objects_filter_situation filter_situation,
 	struct object *obj,
 	const char *pathname,
 	const char *filename,
 	void *filter_data_)
 {
-	struct filter_blobs_none_data *filter_data = filter_data_;
+	struct filter_none_of_type_data *filter_data = filter_data_;
 
 	switch (filter_situation) {
 	default:
 		die("unknown filter_situation");
 		return LOFR_ZERO;
 
-	case LOFS_BEGIN_TREE:
-		assert(obj->type == OBJ_TREE);
-		/* always include all tree objects */
-		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
-
 	case LOFS_END_TREE:
 		assert(obj->type == OBJ_TREE);
 		return LOFR_ZERO;
 
+	case LOFS_BEGIN_TREE:
+		assert(obj->type == OBJ_TREE);
+		if (!filter_data->omit_trees)
+			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
+
 	case LOFS_BLOB:
-		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
 		if (filter_data->omits)
@@ -72,10 +73,25 @@ static void *filter_blobs_none__init(
 	filter_object_fn *filter_fn,
 	filter_free_fn *filter_free_fn)
 {
-	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
+	struct filter_none_of_type_data *d = xcalloc(1, sizeof(*d));
+	d->omits = omitted;
+
+	*filter_fn = filter_none_of_type;
+	*filter_free_fn = free;
+	return d;
+}
+
+static void* filter_only_commits__init(
+	struct oidset *omitted,
+	struct list_objects_filter_options *filter_options,
+	filter_object_fn *filter_fn,
+	filter_free_fn *filter_free_fn)
+{
+	struct filter_none_of_type_data *d = xcalloc(1, sizeof(*d));
+	d->omit_trees = 1;
 	d->omits = omitted;
 
-	*filter_fn = filter_blobs_none;
+	*filter_fn = filter_none_of_type;
 	*filter_free_fn = free;
 	return d;
 }
@@ -376,6 +392,7 @@ static filter_init_fn s_filters[] = {
 	filter_blobs_limit__init,
 	filter_sparse_oid__init,
 	filter_sparse_path__init,
+	filter_only_commits__init,
 };
 
 void *list_objects_filter__init(
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 6710c8bc8..600d153f9 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -59,6 +59,36 @@ test_expect_success 'verify normal and blob:none packfiles have same commits/tre
 	test_cmp observed expected
 '
 
+test_expect_success 'setup for tests of only:commits' '
+	mkdir r1/subtree &&
+	echo "This is a file in a subtree" > r1/subtree/file &&
+	git -C r1 add subtree/file &&
+	git -C r1 commit -m subtree
+'
+
+test_expect_success 'verify only:commits packfile has no blobs or trees' '
+	git -C r1 pack-objects --rev --stdout --filter=only:commits >commitsonly.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r1 index-pack ../commitsonly.pack &&
+	git -C r1 verify-pack -v ../commitsonly.pack \
+		| grep -E "tree|blob" \
+		| sort >observed &&
+	test_line_count = 0 observed
+'
+
+test_expect_success 'grab tree directly when using only:commits' '
+	# We should get the tree specified directly but not its blobs or subtrees.
+	git -C r1 pack-objects --rev --stdout --filter=only:commits >commitsonly.pack <<-EOF &&
+	HEAD:
+	EOF
+	git -C r1 index-pack ../commitsonly.pack &&
+	git -C r1 verify-pack -v ../commitsonly.pack \
+		| grep -E "tree|blob" \
+		| sort >observed &&
+	test_line_count = 1 observed
+'
+
 # Test blob:limit=<n>[kmg] filter.
 # We boundary test around the size parameter.  The filter is strictly less than
 # the value, so size 500 and 1000 should have the same results, but 1001 should
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 0a37dd5f9..6dbd9477c 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -196,6 +196,19 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 	test_cmp observed expected
 '
 
+# Test only:commits filter.
+
+test_expect_success 'verify only:commits includes trees in "filtered" output' '
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=only:commits \
+		| awk -f print_1.awk \
+		| sed s/~// \
+		| xargs -n1 git -C r3 cat-file -t \
+		| sort -u >filtered_types &&
+	printf "blob\ntree\n" > expected &&
+	test_cmp filtered_types expected
+'
+
+
 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
 # This models previously omitted objects that we did not receive.
 
-- 
2.18.0.597.ga71716f1ad-goog

