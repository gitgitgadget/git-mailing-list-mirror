Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE6E20248
	for <e@80x24.org>; Mon,  8 Apr 2019 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfDHVGI (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 17:06:08 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:36617 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfDHVGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 17:06:08 -0400
Received: by mail-io1-f74.google.com with SMTP id a7so12375804ioq.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=E4+2rBFVq4nEf/MV/4RJqA9Btd8zYPNhuK8yHHd47AU=;
        b=X8EUbPQ8o244czEmLOYu8+8LRFuzR9yI6xbFFOssUT7oIbOFbcW/M7cyf9+Ln0p43a
         i2bZ6xN682caxyHIqyYZVmcPDPufrRO0mhQbdHv8m/bLB6JB/brv9YhwZDu6Jz9XdExL
         yqzQz0auDKVnZuPVJHG/277oQWhqrMsPiKxgxWX6Md1QUgtUQh7g/+cGfZ/amwO1mLcx
         78M10Za21wSkEIUiMWubxsnCU6Z6YrKnFoQ5nCR8hIoUOtgA7BjwbW5yNEdyIw8a9DHI
         QNnBPLbx4vwpD304oRZrwGVvaP5GcwFh4iL8SNNLms/ti+M8Mh0+KyXoYd7Zs4ksnND3
         9xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=E4+2rBFVq4nEf/MV/4RJqA9Btd8zYPNhuK8yHHd47AU=;
        b=nfqs6be/T2zKTOHH/GWLGdkVxv9N3ShsRyD5wtDSV7I1bunslsh5TViPYlCl1BO0df
         QSSKqKh938vZzl7TjZhBjALWY4s+xoSDt6xOC2cR2GkgWD69qX0HKFJlesOgJzq8xhqh
         qpYtWNrP0EoeZkhfn6nco3ikQEL6ZNAEQNFVdOKsTVzrYwC6EFeSWm6aiNnBj+a3NlJC
         TPbsqcZ6gtH3oOr2s9ABmbETChTSwz+TmB+JdyVJ25NlyfkBb0F7L9yvqv01nlO9fmJV
         2qxhaFSR5nE1AiTpahqE8xu5tsHVTgiy5o74DavijROXzeSYhgkRRw2p0Gc79VymotL2
         LZbQ==
X-Gm-Message-State: APjAAAV2tRNaZuSoOSVP5LulNCAEVlSlFQXwfVD6zGteehY9Pm5Ajqg7
        K3NkbSUpPS5Lt/O1k8Rke9cEcaYAR6gNrlHy9UuCcJS0i5DYzwnQpn3rFmEqAwlmZ8CZk+FOqm/
        nH2PsrJaNoxv+e+La2f0C09iKmrlQbaKiI6XAghMlz7YTTCnHRRz4Qq1KgGPzx3Y=
X-Google-Smtp-Source: APXvYqypF1w8WKuadHjkc7A8bH7O5+zbnmOqvn/M00vXO7Snk+8cmIxKiMSb35nSvEqkjopI7pfqOL2YKMneUQ==
X-Received: by 2002:a05:660c:60b:: with SMTP id i11mr5422260itk.9.1554757566792;
 Mon, 08 Apr 2019 14:06:06 -0700 (PDT)
Date:   Mon,  8 Apr 2019 14:06:04 -0700
In-Reply-To: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
Message-Id: <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
Mime-Version: 1.0
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3] rev-list: exclude promisor objects at walk time
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For large repositories, enumerating the list of all promisor objects (in
order to exclude them from a rev-list walk) can take a significant
amount of time).

When --exclude-promisor-objects is passed to rev-list, don't enumerate
the promisor objects. Instead, filter them (and any children objects)
during the actual graph walk.

Remove the mark_uninteresting() function as it's not used anywhere else.

When testing against a large repo [1], this patch reduces the
connectivity check runtime from 3 minutes to ~7 seconds.

[1]: https://android.googlesource.com/platform/frameworks/base/

Helped-By: Jonathan Tan <jonathantanmy@google.com>
Helped-By: Jeff King <peff@peff.net>
Helped-By: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Changes since V2:
* Pulled the "OK to skip?" logic into a separate function.

Changes since V1:
* Switched to alternate approach, we now do the regular rev-list walk
  but skip promisor objects at walk time, rather than pre-excluding
  them.

Range-diff against v2:
1:  9f327d6d8d ! 1:  9856e7fc74 rev-list: exclude promisor objects at walk time
    @@ -10,9 +10,15 @@
         the promisor objects. Instead, filter them (and any children objects)
         during the actual graph walk.
     
    +    When testing against a large repo [1], this reduces the connectivity
    +    check runtime from 3 minutes to ~7 seconds.
    +
    +    [1]: https://android.googlesource.com/platform/frameworks/base/
    +
         Helped-By: Jonathan Tan <jonathantanmy@google.com>
         Helped-By: Jeff King <peff@peff.net>
         Helped-By: Jonathan Nieder <jrnieder@gmail.com>
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
     
    @@ -20,78 +26,55 @@
      --- a/list-objects.c
      +++ b/list-objects.c
     @@
    - 	struct object *obj = &blob->object;
    - 	size_t pathlen;
    - 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
    -+	struct object_info oi = OBJECT_INFO_INIT;
    + 	void *filter_data;
    + };
      
    - 	if (!ctx->revs->blob_objects)
    - 		return;
    ++static int should_skip_promisor_object(const struct rev_info *revs,
    ++				       const struct object_id *oid)
    ++{
    ++	struct object_info oi = OBJECT_INFO_INIT;
    ++	return (revs->exclude_promisor_objects &&
    ++		!oid_object_info_extended(the_repository, oid, &oi, 0) &&
    ++		oi.whence == OI_PACKED &&
    ++		oi.u.packed.pack->pack_promisor);
    ++}
    ++
    + static void process_blob(struct traversal_context *ctx,
    + 			 struct blob *blob,
    + 			 struct strbuf *path,
     @@
      		die("bad blob object");
      	if (obj->flags & (UNINTERESTING | SEEN))
      		return;
    -+	if (ctx->revs->exclude_promisor_objects &&
    -+	    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
    -+	    oi.whence == OI_PACKED &&
    -+	    oi.u.packed.pack->pack_promisor)
    ++	if (should_skip_promisor_object(ctx->revs, &obj->oid))
     +		return;
      
      	/*
      	 * Pre-filter known-missing objects when explicitly requested.
    -@@
    - 	int baselen = base->len;
    - 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
    - 	int failed_parse;
    -+	struct object_info oi = OBJECT_INFO_INIT;
    - 
    - 	if (!revs->tree_objects)
    - 		return;
     @@
      		die("bad tree object");
      	if (obj->flags & (UNINTERESTING | SEEN))
      		return;
    -+	if (ctx->revs->exclude_promisor_objects &&
    -+	    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
    -+	    oi.whence == OI_PACKED &&
    -+	    oi.u.packed.pack->pack_promisor)
    ++	if (should_skip_promisor_object(ctx->revs, &obj->oid))
     +		return;
      
      	failed_parse = parse_tree_gently(tree, 1);
      	if (failed_parse) {
    -@@
    - 				     struct strbuf *base)
    - {
    - 	int i;
    -+	struct object_info oi = OBJECT_INFO_INIT;
    - 
    - 	assert(base->len == 0);
    - 
     @@
      		struct object *obj = pending->item;
      		const char *name = pending->name;
      		const char *path = pending->path;
    -+		if (ctx->revs->exclude_promisor_objects &&
    -+		    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
    -+		    oi.whence == OI_PACKED &&
    -+		    oi.u.packed.pack->pack_promisor)
    ++		if (should_skip_promisor_object(ctx->revs, &obj->oid))
     +			continue;
     +
      		if (obj->flags & (UNINTERESTING | SEEN))
      			continue;
      		if (obj->type == OBJ_TAG) {
     @@
    - {
    - 	struct commit *commit;
    - 	struct strbuf csp; /* callee's scratch pad */
    -+	struct object_info oi = OBJECT_INFO_INIT;
      	strbuf_init(&csp, PATH_MAX);
      
      	while ((commit = get_revision(ctx->revs)) != NULL) {
    -+		if (ctx->revs->exclude_promisor_objects &&
    -+		    !oid_object_info_extended(the_repository, &commit->object.oid, &oi, 0) &&
    -+		    oi.whence == OI_PACKED &&
    -+		    oi.u.packed.pack->pack_promisor)
    ++		if (should_skip_promisor_object(ctx->revs, &commit->object.oid))
     +			continue;
     +
      		/*

 list-objects.c | 20 ++++++++++++++++++++
 revision.c     | 16 ----------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index dc77361e11..c153ee5dfb 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -22,6 +22,16 @@ struct traversal_context {
 	void *filter_data;
 };
 
+static int should_skip_promisor_object(const struct rev_info *revs,
+				       const struct object_id *oid)
+{
+	struct object_info oi = OBJECT_INFO_INIT;
+	return (revs->exclude_promisor_objects &&
+		!oid_object_info_extended(the_repository, oid, &oi, 0) &&
+		oi.whence == OI_PACKED &&
+		oi.u.packed.pack->pack_promisor);
+}
+
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
@@ -37,6 +47,8 @@ static void process_blob(struct traversal_context *ctx,
 		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+	if (should_skip_promisor_object(ctx->revs, &obj->oid))
+		return;
 
 	/*
 	 * Pre-filter known-missing objects when explicitly requested.
@@ -156,6 +168,8 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+	if (should_skip_promisor_object(ctx->revs, &obj->oid))
+		return;
 
 	failed_parse = parse_tree_gently(tree, 1);
 	if (failed_parse) {
@@ -326,6 +340,9 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		const char *path = pending->path;
+		if (should_skip_promisor_object(ctx->revs, &obj->oid))
+			continue;
+
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
@@ -356,6 +373,9 @@ static void do_traverse(struct traversal_context *ctx)
 	strbuf_init(&csp, PATH_MAX);
 
 	while ((commit = get_revision(ctx->revs)) != NULL) {
+		if (should_skip_promisor_object(ctx->revs, &commit->object.oid))
+			continue;
+
 		/*
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
diff --git a/revision.c b/revision.c
index eb8e51bc63..85974e941d 100644
--- a/revision.c
+++ b/revision.c
@@ -3067,17 +3067,6 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN);
 }
 
-static int mark_uninteresting(const struct object_id *oid,
-			      struct packed_git *pack,
-			      uint32_t pos,
-			      void *cb)
-{
-	struct rev_info *revs = cb;
-	struct object *o = parse_object(revs->repo, oid);
-	o->flags |= UNINTERESTING | SEEN;
-	return 0;
-}
-
 define_commit_slab(indegree_slab, int);
 define_commit_slab(author_date_slab, timestamp_t);
 
@@ -3316,11 +3305,6 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
-	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(mark_uninteresting, revs,
-				       FOR_EACH_OBJECT_PROMISOR_ONLY);
-	}
-
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
-- 
2.21.0.392.gf8f6787159e-goog

