Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA3D1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeCLC2S (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34272 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932419AbeCLC2R (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E7F26047A;
        Mon, 12 Mar 2018 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821696;
        bh=OEf2jRpZUCp52PWygS8mrUBfyksSQpa0uh95Nfcy+9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NpU++hFgfHjEzm6YhegKl7LB7sE6f4aufjFhmE78j2OmHa0oJ2WhRuXzK2e5EnmD4
         MJkmKjn8YOXM4Ikqh59lq9YMCGsa4MNeQgvx47fmaeSCWOit/TCI3gpT/TYQBpdwZV
         7KsrnsqGkp8qtD/Rn8DTK2gN2xO5UdVnQne5AY5ECkOegKksNm2PygMA8FcjlCMMUM
         IrCeO3tvTbRQlzegV0r0ZTMZpWzj/y4Vf1gWFsdqhLeJCgAOtVrj1xPuHBvxRNOAne
         pZF+pfW+U0Y6bg68GUiSA0zmXRXhA19ddXgycbJY6ZQsWlHNXMHVH+3bwIEHyihyOg
         1JnBAx1J8wDmfWn8EBFTvlCnUOgJXBY5jE4TxKGDvfSxsnKOeI76+NVe3qMLgp9tzc
         L4bwVU4PGGOACRzr1HVCPtUzcPANSM+K1vex0q/ddx9bbEV5fYZgJnXyAFMlFrTnEC
         UgOJJTltbRuzfT475YYBH/NpkTgX71a4Sm9E9uFjgrUA03ms4g7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/36] cache-tree: convert write_*_as_tree to object_id
Date:   Mon, 12 Mar 2018 02:27:23 +0000
Message-Id: <20180312022756.483934-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert write_index_as_tree and write_cache_as_tree to use struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c         |  8 ++++----
 builtin/merge.c      |  2 +-
 builtin/write-tree.c |  2 +-
 cache-tree.c         | 10 +++++-----
 cache-tree.h         |  4 ++--
 sequencer.c          |  4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1151b5c73a..1bcc3606c5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1550,7 +1550,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	discard_cache();
 	read_cache_from(index_path);
 
-	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(&orig_tree, &the_index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
 
 	say(state, stdout, _("Using index info to reconstruct a base tree..."));
@@ -1575,7 +1575,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
 
-	if (write_index_as_tree(their_tree.hash, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(&their_tree, &the_index, index_path, 0, NULL))
 		return error("could not write tree");
 
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
@@ -1626,7 +1626,7 @@ static void do_commit(const struct am_state *state)
 	if (run_hook_le(NULL, "pre-applypatch", NULL))
 		exit(1);
 
-	if (write_cache_as_tree(tree.hash, 0, NULL))
+	if (write_cache_as_tree(&tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
 	if (!get_oid_commit("HEAD", &parent)) {
@@ -2004,7 +2004,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (fast_forward_to(head_tree, head_tree, 1))
 		return -1;
 
-	if (write_cache_as_tree(index.hash, 0, NULL))
+	if (write_cache_as_tree(&index, 0, NULL))
 		return -1;
 
 	index_tree = parse_tree_indirect(&index);
diff --git a/builtin/merge.c b/builtin/merge.c
index e8d9d4383e..0c7437f536 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -639,7 +639,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 
 static void write_tree_trivial(struct object_id *oid)
 {
-	if (write_cache_as_tree(oid->hash, 0, NULL))
+	if (write_cache_as_tree(oid, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 }
 
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 299a121531..c9d3c544e7 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -38,7 +38,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
-	ret = write_cache_as_tree(oid.hash, flags, prefix);
+	ret = write_cache_as_tree(&oid, flags, prefix);
 	switch (ret) {
 	case 0:
 		printf("%s\n", oid_to_hex(&oid));
diff --git a/cache-tree.c b/cache-tree.c
index c52e4303df..ba07a8067e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -599,7 +599,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 	return it;
 }
 
-int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
+int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid;
 	struct lock_file lock_file = LOCK_INIT;
@@ -640,19 +640,19 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 			ret = WRITE_TREE_PREFIX_ERROR;
 			goto out;
 		}
-		hashcpy(sha1, subtree->oid.hash);
+		oidcpy(oid, &subtree->oid);
 	}
 	else
-		hashcpy(sha1, index_state->cache_tree->oid.hash);
+		oidcpy(oid, &index_state->cache_tree->oid);
 
 out:
 	rollback_lock_file(&lock_file);
 	return ret;
 }
 
-int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
+int write_cache_as_tree(struct object_id *oid, int flags, const char *prefix)
 {
-	return write_index_as_tree(sha1, &the_index, get_index_file(), flags, prefix);
+	return write_index_as_tree(oid, &the_index, get_index_file(), flags, prefix);
 }
 
 static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
diff --git a/cache-tree.h b/cache-tree.h
index f7b9cab7ee..cfd5328cc9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -47,8 +47,8 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
-int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
-int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix);
+int write_index_as_tree(struct object_id *oid, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
+int write_cache_as_tree(struct object_id *oid, int flags, const char *prefix);
 void prime_cache_tree(struct index_state *, struct tree *);
 
 extern int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
diff --git a/sequencer.c b/sequencer.c
index 969755b7e0..c8160e974d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1113,7 +1113,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 		commit_list_insert(current_head, &parents);
 	}
 
-	if (write_cache_as_tree(tree.hash, 0, NULL)) {
+	if (write_cache_as_tree(&tree, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
 	}
@@ -1475,7 +1475,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		 * that represents the "current" state for merge-recursive
 		 * to work on.
 		 */
-		if (write_cache_as_tree(head.hash, 0, NULL))
+		if (write_cache_as_tree(&head, 0, NULL))
 			return error(_("your index file is unmerged."));
 	} else {
 		unborn = get_oid("HEAD", &head);
