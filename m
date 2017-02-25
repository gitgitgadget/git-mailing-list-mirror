Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1D7201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdBYBTW (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:19:22 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33439 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdBYBTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:19:14 -0500
Received: by mail-pg0-f41.google.com with SMTP id z128so18030603pgb.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GgLknoxmDZOh0MFsuzQQz9uAgurD8yP0husFGVncumI=;
        b=XOTi9ZmH0eRBvkATYlwOJV1+Llej8Kp1OD5QdLgDcGR1KeDi7QgtKzexh5zCyTpGOK
         SAWPd9riDD9MN/4HXFdRjR1lQjrx8yARtcD9d9sy1ZLmQ0Bzuuaiy7JocX8FpAZEqGGp
         3hY464n4DsT9poQgHpOYlxfvYorPBpCtbYH9OmiTSVSq82GlgF3gjq4l11keVJg54oLG
         sq/DZfSiR2UWpydyqhhRc6/MfqgP1ky0PrR/erf+0rU3GXAkwLhj4GBY180IQkKGhMR3
         X2v66/+9cLaFVwKisouf7ZDT4Kjrt5NsKM1x5iYU7pSv5c24N3inIST1Q/jbNNEHdhG8
         rZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GgLknoxmDZOh0MFsuzQQz9uAgurD8yP0husFGVncumI=;
        b=E+8Tie3hI9Y2JQQfrUoLeMrVDqDMMxSi2GMj7yIxhNjHUGjDGYMCH/BUk685Ib7pTz
         weRjXOB60KPGtExrr9RK4pjuYr5VeHuQtLEd7tvpGCmZRKs4GrAzTRIYViZMuJHZpfQo
         pO2kLBnPsujDfkvWwCtYl8n3q8Nfn/rrRCJ/yOvPTdvYKhe1O/WkPvZVoqv9fn1BzjMe
         kF92ds+Rr9L2VUHF3sso02YkCK5FzME3RIztkpzgu1VcRzV8f6c+U530/rd0geVMOSWb
         fBAYSIRpJPtJOFCCEzGVsGYdFh0DeihQBMeNIbRKU82JMWz8HiQeMooNFv+QPKuGBiho
         Fhbg==
X-Gm-Message-State: AMke39lPGmLwSbVmT3IQlD0nDLEXnHh8kxRSN1sWkbS1Whsfc/ekLlydgfh7wzQ8REJwOoWL
X-Received: by 10.98.86.68 with SMTP id k65mr7116752pfb.13.1487985523436;
        Fri, 24 Feb 2017 17:18:43 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id 67sm17082280pfd.120.2017.02.24.17.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 17:18:42 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, peartben@gmail.com, benpeart@microsoft.com
Subject: [PATCH 1/3] revision: unify {tree,blob}_objects in rev_info
Date:   Fri, 24 Feb 2017 17:18:36 -0800
Message-Id: <06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1487984670.git.jonathantanmy@google.com>
References: <cover.1487984670.git.jonathantanmy@google.com>
In-Reply-To: <cover.1487984670.git.jonathantanmy@google.com>
References: <cover.1487984670.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever tree_objects is set to 1 in revision.h's struct rev_info,
blob_objects is likewise set, and vice versa. Combine those two fields
into one.

Some of the existing code does not handle tree_objects being different
from blob_objects properly. For example, "handle_commit" in revision.c
recurses from an UNINTERESTING tree into its subtree if tree_objects ==
1, completely ignoring blob_objects; it probably should still recurse if
tree_objects == 0 and blob_objects == 1 (to mark the blobs), and should
behave differently depending on blob_objects (controlling the
instantiation and marking of blob objects). This commit resolves the
issue by forbidding tree_objects from being different to blob_objects.

It could be argued that in the future, Git might need to distinguish
tree_objects from blob_objects - in particular, a user might want
rev-list to print the trees but not the blobs. However, this results in
a minor performance savings at best in that objects no longer need to be
instantiated (causing memory allocations and hashtable insertions) - no
disk reads are being done for objects whether blob_objects is set or
not.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 bisect.c            |  2 +-
 builtin/rev-list.c  |  6 +++---
 list-objects.c      |  4 ++--
 pack-bitmap-write.c |  3 +--
 pack-bitmap.c       |  3 +--
 reachable.c         |  3 +--
 revision.c          | 16 ++++++----------
 revision.h          |  3 +--
 8 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/bisect.c b/bisect.c
index 8e63c40d2..265b32905 100644
--- a/bisect.c
+++ b/bisect.c
@@ -634,7 +634,7 @@ static void bisect_common(struct rev_info *revs)
 {
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
-	if (revs->tree_objects)
+	if (revs->tree_and_blob_objects)
 		mark_edges_uninteresting(revs, NULL);
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0aa93d589..6c2651b31 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -345,7 +345,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		revs.commit_format = CMIT_FMT_RAW;
 
 	if ((!revs.commits &&
-	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
+	     (!(revs.tag_objects || revs.tree_and_blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
 		usage(rev_list_usage);
@@ -374,7 +374,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 				return 0;
 			}
 		} else if (revs.max_count < 0 &&
-			   revs.tag_objects && revs.tree_objects && revs.blob_objects) {
+			   revs.tag_objects && revs.tree_and_blob_objects) {
 			if (!prepare_bitmap_walk(&revs)) {
 				traverse_bitmap_commit_list(&show_object_fast);
 				return 0;
@@ -384,7 +384,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
-	if (revs.tree_objects)
+	if (revs.tree_and_blob_objects)
 		mark_edges_uninteresting(&revs, show_edge);
 
 	if (bisect_list) {
diff --git a/list-objects.c b/list-objects.c
index f3ca6aafb..796957105 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -18,7 +18,7 @@ static void process_blob(struct rev_info *revs,
 	struct object *obj = &blob->object;
 	size_t pathlen;
 
-	if (!revs->blob_objects)
+	if (!revs->tree_and_blob_objects)
 		return;
 	if (!obj)
 		die("bad blob object");
@@ -78,7 +78,7 @@ static void process_tree(struct rev_info *revs,
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
 
-	if (!revs->tree_objects)
+	if (!revs->tree_and_blob_objects)
 		return;
 	if (!obj)
 		die("bad tree object");
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 970559601..5080e276b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -258,8 +258,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 
 	init_revisions(&revs, NULL);
 	revs.tag_objects = 1;
-	revs.tree_objects = 1;
-	revs.blob_objects = 1;
+	revs.tree_and_blob_objects = 1;
 	revs.no_walk = 0;
 
 	revs.include_check = should_include;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 39bcc1684..445a24e0d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -951,8 +951,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		die("Commit %s doesn't have an indexed bitmap", oid_to_hex(&root->oid));
 
 	revs->tag_objects = 1;
-	revs->tree_objects = 1;
-	revs->blob_objects = 1;
+	revs->tree_and_blob_objects = 1;
 
 	result_popcnt = bitmap_popcount(result);
 
diff --git a/reachable.c b/reachable.c
index d0199cace..9a3beb75f 100644
--- a/reachable.c
+++ b/reachable.c
@@ -166,8 +166,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	 * in all object types, not just commits.
 	 */
 	revs->tag_objects = 1;
-	revs->blob_objects = 1;
-	revs->tree_objects = 1;
+	revs->tree_and_blob_objects = 1;
 
 	/* Add all refs from the index file */
 	add_index_objects_to_pending(revs, 0);
diff --git a/revision.c b/revision.c
index b37dbec37..5e49d9e0e 100644
--- a/revision.c
+++ b/revision.c
@@ -267,7 +267,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 */
 	if (object->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)object;
-		if (!revs->tree_objects)
+		if (!revs->tree_and_blob_objects)
 			return NULL;
 		if (flags & UNINTERESTING) {
 			mark_tree_contents_uninteresting(tree);
@@ -281,7 +281,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 	 * Blob object? You know the drill by now..
 	 */
 	if (object->type == OBJ_BLOB) {
-		if (!revs->blob_objects)
+		if (!revs->tree_and_blob_objects)
 			return NULL;
 		if (flags & UNINTERESTING)
 			return NULL;
@@ -1817,23 +1817,19 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--objects")) {
 		revs->tag_objects = 1;
-		revs->tree_objects = 1;
-		revs->blob_objects = 1;
+		revs->tree_and_blob_objects = 1;
 	} else if (!strcmp(arg, "--objects-edge")) {
 		revs->tag_objects = 1;
-		revs->tree_objects = 1;
-		revs->blob_objects = 1;
+		revs->tree_and_blob_objects = 1;
 		revs->edge_hint = 1;
 	} else if (!strcmp(arg, "--objects-edge-aggressive")) {
 		revs->tag_objects = 1;
-		revs->tree_objects = 1;
-		revs->blob_objects = 1;
+		revs->tree_and_blob_objects = 1;
 		revs->edge_hint = 1;
 		revs->edge_hint_aggressive = 1;
 	} else if (!strcmp(arg, "--verify-objects")) {
 		revs->tag_objects = 1;
-		revs->tree_objects = 1;
-		revs->blob_objects = 1;
+		revs->tree_and_blob_objects = 1;
 		revs->verify_objects = 1;
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked = 1;
diff --git a/revision.h b/revision.h
index 9fac1a607..43cce137f 100644
--- a/revision.h
+++ b/revision.h
@@ -89,8 +89,7 @@ struct rev_info {
 			simplify_merges:1,
 			simplify_by_decoration:1,
 			tag_objects:1,
-			tree_objects:1,
-			blob_objects:1,
+			tree_and_blob_objects:1,
 			verify_objects:1,
 			edge_hint:1,
 			edge_hint_aggressive:1,
-- 
2.11.0.483.g087da7b7c-goog

