Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533881F744
	for <e@80x24.org>; Mon, 11 Jul 2016 18:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbcGKSPm (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 14:15:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34965 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbcGKSPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 14:15:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id l89so2357418lfi.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 11:15:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9J+6lQ7YavkLQ7bQsg53gLdk6r+kEr8WmfUkl5FyG2Y=;
        b=l9UJXv5DQJa4UPiXiwmTOiCQrrFmTyEAK1FNtUPbMZrlgMwkfbq6sFvfjjQZcgBVP7
         H52oxvR45rzWhTiweLTEFwGXvU73V50+M1LFjGq/Zt4GBc38ih55z2LuoECLzGh4nX1G
         z9ruBvrGZRAtDXPrhvhtejb1lJ1BbY9VM3WEnOtM7Gg8mbIW5KhEqNHAhJt8Bp3BmfOn
         DTht8jvYrSbcH9X0KZkGvcvPzbfFpUvG5gfFOBeCWCL4W5623MfHRY108DWDCi1IXf6+
         9bJkiCSj9hEwMgJIklrvPwAAmvZhCXozCZUZoyyvQ57wBxFKx2I6NB3gxAcWIwEdXCFE
         vwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9J+6lQ7YavkLQ7bQsg53gLdk6r+kEr8WmfUkl5FyG2Y=;
        b=URI9bxvtSAMYus9Z/j9ck0al08qmCGc1qoHuy5oAUeqTXhWyqHXLJi7AT8QoPkUNVx
         yqLnUdvf/ZwqJqKTgmN7QyJR6/M117CWQgbz+U0Qw+uAG5xKnhfsYbJvz/w7izMY7VYU
         XtIYNbZUNEpMyhb8bGhAkb/vnTCWSWUY23QshTVWaoEW8BbhBKZUmtrmqxhRYRkHe4Ai
         Y31NvISoQxaVQZhViUhKamPaMj6qRGYMVE+kaqf5FfRG6vl4jyJWjE07m4DKxe3R6I63
         g+jIvOkVOJ4TGBEcL0srvpIYmv8TzPed0OQbvjpqJBetX3Muc7FR6Fz/es4rXUW5YKiO
         GJAA==
X-Gm-Message-State: ALyK8tJm8cXKH/TZ2mGujOjB4It0K+PGeXj/gWOZ0cyKUx6tXiETp/iTKDwBjnQ6SjhWNQ==
X-Received: by 10.25.215.42 with SMTP id o42mr3273557lfg.40.1468260939265;
        Mon, 11 Jul 2016 11:15:39 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id r76sm1631727lfi.35.2016.07.11.11.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 11:15:38 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Speed up sparse checkout when $GIT_DIR/info/sparse-checkout is unchanged
Date:	Mon, 11 Jul 2016 20:15:32 +0200
Message-Id: <20160711181532.20682-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When a "tree unpacking" operation is needed, which is part of
switching branches using "git checkout", the following happens in a
sparse checkout:

1) Run all existing entries through $GIT_DIR/info/sparse-checkout,
   mark entries that are to-be-excluded or to-be-included.

2) Do n-way merge stuff to add, modify and delete entries.

3) Run all new entries added at step 2 through
   $GIT_DIR/info/sparse-checkout, mark entries that are to-be-excluded
   or to-be-included.

4) Compare the current excluded/include status with the to-be-status
   from steps 1 and 3, delete newly excluded entries from worktree and
   add newly included ones to worktree.

The "all existing entries" number in step 1 does not scale well. As
worktree gets bigger (or more sparse patterns are added), step 1 runs
slower. Which does not help because large worktrees are the reason
sparse-checkout is used, to keep the real worktree small again.

If we know that $GIT_DIR/info/sparse-checkout has not changed, we know
that running checking again would result in the exact same
included/excluded as recorded in the current index because
"sparse-checkout" is the only input to the exclude machinery. In this
case, marking the to-be-status is simply copying the current status
over, which is a lot faster.

The time breakdown of "git checkout" (no arguments) on webkit.git
(100k files) with a sparse checkout file of 4 negative patterns is
like this, where "sparse checkout loop #1" takes about 10% execution
time, which is the time saved after this patch.

read-cache.c:1661       performance: 0.057816104 s: read cache .git/index
files-backend.c:1097    performance: 0.000023980 s: read packed refs
preload-index.c:104     performance: 0.039178367 s: preload index
read-cache.c:1260       performance: 0.002700730 s: refresh index
name-hash.c:128         performance: 0.030409968 s: initialize name hash

unpack-trees.c:1173     performance: 0.100353572 s: sparse checkout loop #1

cache-tree.c:431        performance: 0.137213472 s: cache_tree_update
unpack-trees.c:1305     performance: 0.648923590 s: unpack_trees
read-cache.c:2139       performance: 0.074800165 s: write index, changed mask = 28
unpack-trees.c:1305     performance: 0.137108835 s: unpack_trees
diff-lib.c:506          performance: 0.137152238 s: diff-index
trace.c:420             performance: 0.972682413 s: git command: 'git' 'checkout'

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I mentioned about this some time ago and finally got curious enough
 to try out. The saving is in the signficant range in my opinion, but
 real world effect is probably lower (or much higher if you have so
 many patterns in $GIT_DIR/info/sparse-checkout)

 Note that both cache_tree_update and sparse checkout loop #1 are part
 of unpack_trees() so actual time spent on this function is more like
 0.4s. It's still a lot, but then this function is very scary to
 optimize.

 Documentation/technical/index-format.txt |  6 +++++
 cache.h                                  |  2 ++
 read-cache.c                             | 22 ++++++++++++++++-
 unpack-trees.c                           | 42 ++++++++++++++++++++++++++++++--
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index ade0b0c..3b0770a 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,9 @@ The remaining data of each directory block is grouped by type:
     in the previous ewah bitmap.
 
   - One NUL.
+
+== Sparse checkout cache
+
+  Sparse checkout extension saves the 20 bytes SHA-1 hash of
+  $GIT_DIR/info/sparse-checkout at the time it is applied to the
+  index.
diff --git a/cache.h b/cache.h
index f1dc289..cc4c2b1 100644
--- a/cache.h
+++ b/cache.h
@@ -320,6 +320,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define CACHE_TREE_CHANGED	(1 << 5)
 #define SPLIT_INDEX_ORDERED	(1 << 6)
 #define UNTRACKED_CHANGED	(1 << 7)
+#define SPARSE_CHECKOUT_CHANGED	(1 << 8)
 
 struct split_index;
 struct untracked_cache;
@@ -338,6 +339,7 @@ struct index_state {
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
+	unsigned char sparse_checkout[20];
 };
 
 extern struct index_state the_index;
diff --git a/read-cache.c b/read-cache.c
index db27766..371d2c7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -40,11 +40,13 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
+#define CACHE_EXT_SPARSE 0x5350434F	  /* "SPCO" */
 
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) */
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
 		 CE_ENTRY_ADDED | CE_ENTRY_REMOVED | CE_ENTRY_CHANGED | \
-		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED)
+		 SPLIT_INDEX_ORDERED | UNTRACKED_CHANGED | \
+		 SPARSE_CHECKOUT_CHANGED)
 
 struct index_state the_index;
 static const char *alternate_index_output;
@@ -1384,6 +1386,11 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_UNTRACKED:
 		istate->untracked = read_untracked_extension(data, sz);
 		break;
+	case CACHE_EXT_SPARSE:
+		if (sz != sizeof(istate->sparse_checkout))
+			return error("bad %.4s extension", ext);
+		hashcpy(istate->sparse_checkout, data);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1704,6 +1711,7 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked = NULL;
+	hashclr(&istate->sparse_checkout);
 	return 0;
 }
 
@@ -2101,6 +2109,18 @@ static int do_write_index(struct index_state *istate, int newfd,
 		if (err)
 			return -1;
 	}
+	if (!strip_extensions && !is_null_sha1(istate->sparse_checkout)) {
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_add(&sb, istate->sparse_checkout,
+			   sizeof(istate->sparse_checkout));
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_SPARSE,
+					     sb.len) < 0 ||
+			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 
 	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
 		return -1;
diff --git a/unpack-trees.c b/unpack-trees.c
index 6bc9512..f3916a9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1080,6 +1080,25 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 		       select_flag, skip_wt_flag, el);
 }
 
+static void get_sparse_checkout_hash(unsigned char *sha1)
+{
+	struct stat st;
+	int fd;
+
+	hashclr(sha1);
+	fd = open(git_path("info/sparse-checkout"), O_RDONLY);
+	if (fd == -1)
+		return;
+	if (fstat(fd, &st)) {
+		close(fd);
+		return;
+	}
+	if (index_fd(sha1, fd, &st, OBJ_BLOB,
+		     git_path("info/sparse-checkout"), 0) < 0)
+		hashclr(sha1);
+	close(fd);
+}
+
 static int verify_absent(const struct cache_entry *,
 			 enum unpack_trees_error_types,
 			 struct unpack_trees_options *);
@@ -1094,6 +1113,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct exclude_list el;
+	unsigned char sparse_checkout_hash[20];
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
@@ -1131,8 +1151,21 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
-	if (!o->skip_sparse_checkout)
-		mark_new_skip_worktree(o->el, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
+	if (!o->skip_sparse_checkout) {
+		get_sparse_checkout_hash(sparse_checkout_hash);
+
+		if (!is_null_sha1(sparse_checkout_hash) &&
+		    !hashcmp(o->src_index->sparse_checkout, sparse_checkout_hash)) {
+			struct index_state *istate = o->src_index;
+			for (i = 0; i < istate->cache_nr; i++) {
+				struct cache_entry *ce = istate->cache[i];
+				if (ce_skip_worktree(ce))
+					ce->ce_flags |= CE_NEW_SKIP_WORKTREE;
+			}
+		} else
+			mark_new_skip_worktree(o->el, o->src_index,
+					       0, CE_NEW_SKIP_WORKTREE);
+	}
 
 	if (!dfc)
 		dfc = xcalloc(1, cache_entry_size(0));
@@ -1236,6 +1269,11 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");
 			goto done;
 		}
+
+		if (o->dst_index && !is_null_sha1(sparse_checkout_hash)) {
+			hashcpy(o->result.sparse_checkout, sparse_checkout_hash);
+			o->result.cache_changed |= SPARSE_CHECKOUT_CHANGED;
+		}
 	}
 
 	o->src_index = NULL;
-- 
2.8.2.537.g0965dd9

