Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA85201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 21:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbdKLV3O (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 16:29:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55988 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751021AbdKLV3J (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 16:29:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CB0C1604A4;
        Sun, 12 Nov 2017 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510522148;
        bh=89ojWd93HD4xINbTfB4JJEJZVsXOafrsMtIFGihj8I4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ugz4HJbCYFABBUpHw+u01dX5lSSPYyEFPZJ7ri67T3mgVrlrY9+hY0pehfc9pgwyn
         i8FqTPxp3pOZU+8UgNBQtm2WcA3H2K4kXWU6ud6YoGDKsqmP0Rfadx2kmUaURHVNl3
         hBtl5eI1ke81Jq8rPn6bcZyPwY/lBD6NHP6XnDxq439WR9MjzKcVY6PRY9mzWPUnIc
         rWrrN9MUxJU+lhs8aKCzW4okrrL8z4RE7AuxB7o+uQveClAkAvsqS83ocTIAXJBOZM
         PVVcZnUFqT/QMZvkLLgliF6D5QeC4VjMmf5CrVmCZZsEgF59MPcStQr9mFdzj/WeAM
         zWXF1BhmYH/2QUYfTp9kqL4qHBpER06KLwyJnRzlP9AeKgb+O97fSpxzKnMg3vtIIi
         ZPmUaMMHLROBrg4SmJy5v7ftM6g13X8XbBH9aEboa0AxLX2MSfsIGuClNEcAfpz3Lo
         sn8Ep8iMT47vMSu20LCNl/Yyww14QHP9/o/f0dunC4y9zFnrtDK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/4] Switch empty tree and blob lookups to use hash abstraction
Date:   Sun, 12 Nov 2017 21:28:54 +0000
Message-Id: <20171112212854.791179-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
In-Reply-To: <20171112212854.791179-1-sandals@crustytoothpaste.net>
References: <20171112212854.791179-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch the uses of empty_tree_oid and empty_blob_oid to use the
current_hash abstraction that represents the current hash algorithm in
use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c       | 2 +-
 builtin/checkout.c | 2 +-
 builtin/diff.c     | 2 +-
 builtin/pull.c     | 2 +-
 cache.h            | 8 ++++----
 diff-lib.c         | 2 +-
 merge-recursive.c  | 2 +-
 notes-merge.c      | 2 +-
 sequencer.c        | 6 +++---
 submodule.c        | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 92c4853505..99dbde3e85 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1433,7 +1433,7 @@ static void write_index_patch(const struct am_state *state)
 	if (!get_oid_tree("HEAD", &head))
 		tree = lookup_tree(&head);
 	else
-		tree = lookup_tree(&empty_tree_oid);
+		tree = lookup_tree(the_hash_algo->empty_tree);
 
 	fp = xfopen(am_path(state, "patch"), "w");
 	init_revisions(&rev_info, NULL);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6c2b4cd419..2b64805f35 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -514,7 +514,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 		tree = parse_tree_indirect(old->commit ?
 					   &old->commit->object.oid :
-					   &empty_tree_oid);
+					   the_hash_algo->empty_tree);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		tree = parse_tree_indirect(&new->commit->object.oid);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
diff --git a/builtin/diff.c b/builtin/diff.c
index 9808d062a8..16bfb22f73 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -379,7 +379,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr) {
 					struct tree *tree;
-					tree = lookup_tree(&empty_tree_oid);
+					tree = lookup_tree(the_hash_algo->empty_tree);
 					add_pending_object(&rev, &tree->object, "HEAD");
 				}
 				break;
diff --git a/builtin/pull.c b/builtin/pull.c
index a28f0ffadd..3d26f8ff32 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -545,7 +545,7 @@ static int pull_into_void(const struct object_id *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(&empty_tree_oid, merge_head, 0))
+	if (checkout_fast_forward(the_hash_algo->empty_tree, merge_head, 0))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
diff --git a/cache.h b/cache.h
index c238688f6c..d68895b45f 100644
--- a/cache.h
+++ b/cache.h
@@ -1024,22 +1024,22 @@ extern const struct object_id empty_blob_oid;
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
-	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
+	return !hashcmp(sha1, the_hash_algo->empty_blob->hash);
 }
 
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
-	return !hashcmp(oid->hash, EMPTY_BLOB_SHA1_BIN);
+	return !oidcmp(oid, the_hash_algo->empty_blob);
 }
 
 static inline int is_empty_tree_sha1(const unsigned char *sha1)
 {
-	return !hashcmp(sha1, EMPTY_TREE_SHA1_BIN);
+	return !hashcmp(sha1, the_hash_algo->empty_tree->hash);
 }
 
 static inline int is_empty_tree_oid(const struct object_id *oid)
 {
-	return !hashcmp(oid->hash, EMPTY_TREE_SHA1_BIN);
+	return !oidcmp(oid, the_hash_algo->empty_tree);
 }
 
 /* set default permissions by passing mode arguments to open(2) */
diff --git a/diff-lib.c b/diff-lib.c
index 731f0886d6..893fee432c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -217,7 +217,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       &empty_tree_oid, 0,
+					       the_hash_algo->empty_tree, 0,
 					       ce->name, 0);
 				continue;
 			}
diff --git a/merge-recursive.c b/merge-recursive.c
index 2ca8444c65..f89cc751e1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2081,7 +2081,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(&empty_tree_oid);
+		tree = lookup_tree(the_hash_algo->empty_tree);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index 4a83b0ebd5..0f6573cb17 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -595,7 +595,7 @@ int notes_merge(struct notes_merge_options *o,
 	bases = get_merge_bases(local, remote);
 	if (!bases) {
 		base_oid = &null_oid;
-		base_tree_oid = &empty_tree_oid;
+		base_tree_oid = the_hash_algo->empty_tree;
 		if (o->verbosity >= 4)
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
diff --git a/sequencer.c b/sequencer.c
index 6d027b06c8..2c191aeb36 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -347,7 +347,7 @@ static int read_oneliner(struct strbuf *buf,
 
 static struct tree *empty_tree(void)
 {
-	return lookup_tree(&empty_tree_oid);
+	return lookup_tree(the_hash_algo->empty_tree);
 }
 
 static int error_dirty_index(struct replay_opts *opts)
@@ -705,7 +705,7 @@ static int is_original_commit_empty(struct commit *commit)
 				oid_to_hex(&parent->object.oid));
 		ptree_oid = &parent->tree->object.oid;
 	} else {
-		ptree_oid = &empty_tree_oid; /* commit is root */
+		ptree_oid = the_hash_algo->empty_tree; /* commit is root */
 	}
 
 	return !oidcmp(ptree_oid, &commit->tree->object.oid);
@@ -958,7 +958,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	} else {
 		unborn = get_oid("HEAD", &head);
 		if (unborn)
-			oidcpy(&head, &empty_tree_oid);
+			oidcpy(&head, the_hash_algo->empty_tree);
 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD",
 				       NULL, 0))
 			return error_dirty_index(opts);
diff --git a/submodule.c b/submodule.c
index 3ee4a0caa7..ec269a6fc0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -587,7 +587,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
-	const struct object_id *old = &empty_tree_oid, *new = &empty_tree_oid;
+	const struct object_id *old = the_hash_algo->empty_tree, *new = the_hash_algo->empty_tree;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
