Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7471F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932499AbcH1X2N (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40964 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752228AbcH1X2C (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C04B5280A7;
        Sun, 28 Aug 2016 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426880;
        bh=Kqc9up0LkSrkLJPjPckzfyfYXujymFHFXunO8ZhFmcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSX1TWwqcF/EC/q473i3EZ8oacp737aWW37k05HSAgg73dLRrSs6lAJXc61NKuogi
         mGpRhZHHHeuZVDDu7F7twGvVEWvtMjg1JHtMo/GXZ2/oGzNzasFutC08Q6qTdv4/AL
         qEpt3yGhJYJXW0L15Very5eBM1LHSmXgDrgc6ysnEEBAULptVMEp7LHKKxzAWtsquD
         318eQmIY0OJSuDoUNhdF8wLhi7Ct8EOHczB8gUeqVHBh0nhKSQVK1Y4jMONJwR+J6P
         qyFl9KZqUlLPXgWlUYtevVlJsmjFd3JQHlHAyCADgb/TmZSsZlMb2j+RDwS/MU4Mgc
         fH8MZXZWmWFNLpgedsz6pUjxHa1q3sG3ytovhWMzo6LBIvljbWCtXBWNRIX9n5Jvx3
         POV3Yct65+rvHgs3dLmZDXSoP9lEop4MVc85cEZ+V5uIoK/9cXhsUdRlX/9WwflhXd
         CX7tawRBGHdqUTy3LpRK9DH3C2g1bHEq5kfeZckj6V2c/DWQQ4m
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 01/20] cache: convert struct cache_entry to use struct object_id
Date:   Sun, 28 Aug 2016 23:27:38 +0000
Message-Id: <20160828232757.373278-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct cache_entry to use struct object_id by applying the
following semantic patch and the object_id transforms from contrib:

@@
struct cache_entry E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct cache_entry *E1;
@@
- E1->sha1
+ E1->oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/apply.c                  | 10 +++++-----
 builtin/blame.c                  |  2 +-
 builtin/checkout.c               |  6 +++---
 builtin/fsck.c                   |  2 +-
 builtin/grep.c                   |  3 ++-
 builtin/ls-files.c               |  2 +-
 builtin/merge-index.c            |  2 +-
 builtin/read-tree.c              |  2 +-
 builtin/rm.c                     |  2 +-
 builtin/submodule--helper.c      |  5 +++--
 builtin/update-index.c           | 10 +++++-----
 cache-tree.c                     |  4 ++--
 cache.h                          |  2 +-
 diff-lib.c                       | 31 ++++++++++++++++++-------------
 diff.c                           |  2 +-
 dir.c                            |  7 ++++---
 entry.c                          |  9 +++++----
 merge-recursive.c                |  2 +-
 read-cache.c                     | 24 ++++++++++++------------
 rerere.c                         |  3 ++-
 resolve-undo.c                   |  2 +-
 revision.c                       |  2 +-
 sha1_name.c                      |  2 +-
 t/helper/test-dump-split-index.c |  2 +-
 tree.c                           |  2 +-
 unpack-trees.c                   |  8 ++++----
 26 files changed, 79 insertions(+), 69 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1a488f9e..ba0e75bf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3220,7 +3220,7 @@ static int read_file_or_gitlink(const struct cache_entry *ce, struct strbuf *buf
 {
 	if (!ce)
 		return 0;
-	return read_blob_object(buf, ce->sha1, ce->ce_mode);
+	return read_blob_object(buf, ce->oid.hash, ce->ce_mode);
 }
 
 static struct patch *in_fn_table(struct apply_state *state, const char *name)
@@ -3959,7 +3959,7 @@ static int get_current_sha1(const char *path, unsigned char *sha1)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		return -1;
-	hashcpy(sha1, active_cache[pos]->sha1);
+	hashcpy(sha1, active_cache[pos]->oid.hash);
 	return 0;
 }
 
@@ -4211,7 +4211,7 @@ static void add_index_file(struct apply_state *state,
 		const char *s;
 
 		if (!skip_prefix(buf, "Subproject commit ", &s) ||
-		    get_sha1_hex(s, ce->sha1))
+		    get_sha1_hex(s, ce->oid.hash))
 			die(_("corrupt patch for submodule %s"), path);
 	} else {
 		if (!state->cached) {
@@ -4220,7 +4220,7 @@ static void add_index_file(struct apply_state *state,
 					  path);
 			fill_stat_cache_info(ce, &st);
 		}
-		if (write_sha1_file(buf, size, blob_type, ce->sha1) < 0)
+		if (write_sha1_file(buf, size, blob_type, ce->oid.hash) < 0)
 			die(_("unable to create backing store for newly created file %s"), path);
 	}
 	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
@@ -4335,7 +4335,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_mode = create_ce_mode(mode);
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
-		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
+		oidcpy(&ce->oid, &patch->threeway_stage[stage - 1]);
 		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
 			die(_("unable to add cache entry for %s"), patch->new_name);
 	}
diff --git a/builtin/blame.c b/builtin/blame.c
index 7ec78234..06b2c743 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2409,7 +2409,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	}
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
-	hashcpy(ce->sha1, origin->blob_sha1);
+	hashcpy(ce->oid.hash, origin->blob_sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d072..a9523ffa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -76,7 +76,7 @@ static int update_some(const unsigned char *sha1, struct strbuf *base,
 
 	len = base->len + strlen(pathname);
 	ce = xcalloc(1, cache_entry_size(len));
-	hashcpy(ce->sha1, sha1);
+	hashcpy(ce->oid.hash, sha1);
 	memcpy(ce->name, base->buf, base->len);
 	memcpy(ce->name + base->len, pathname, len - base->len);
 	ce->ce_flags = create_ce_flags(0) | CE_UPDATE;
@@ -92,7 +92,7 @@ static int update_some(const unsigned char *sha1, struct strbuf *base,
 	if (pos >= 0) {
 		struct cache_entry *old = active_cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
-		    !hashcmp(ce->sha1, old->sha1)) {
+		    !oidcmp(&ce->oid, &old->oid)) {
 			old->ce_flags |= CE_UPDATE;
 			free(ce);
 			return 0;
@@ -186,7 +186,7 @@ static int checkout_merged(int pos, struct checkout *state)
 		stage = ce_stage(ce);
 		if (!stage || strcmp(path, ce->name))
 			break;
-		hashcpy(threeway[stage - 1], ce->sha1);
+		hashcpy(threeway[stage - 1], ce->oid.hash);
 		if (stage == 2)
 			mode = create_ce_mode(ce->ce_mode);
 		pos++;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2de272ea..f604adff 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -722,7 +722,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			mode = active_cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
 				continue;
-			blob = lookup_blob(active_cache[i]->sha1);
+			blob = lookup_blob(active_cache[i]->oid.hash);
 			if (!blob)
 				continue;
 			obj = &blob->object;
diff --git a/builtin/grep.c b/builtin/grep.c
index ae738312..8887b6ad 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -398,7 +398,8 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
 			if (ce_stage(ce) || ce_intent_to_add(ce))
 				continue;
-			hit |= grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
+			hit |= grep_sha1(opt, ce->oid.hash, ce->name, 0,
+					 ce->name);
 		}
 		else
 			hit |= grep_file(opt, ce->name);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 00ea91aa..197f153f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -187,7 +187,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 		printf("%s%06o %s %d\t",
 		       tag,
 		       ce->ce_mode,
-		       find_unique_abbrev(ce->sha1,abbrev),
+		       find_unique_abbrev(ce->oid.hash,abbrev),
 		       ce_stage(ce));
 	}
 	write_eolinfo(ce, ce->name);
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 1c3427c3..ce356b1d 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -22,7 +22,7 @@ static int merge_entry(int pos, const char *path)
 		if (strcmp(ce->name, path))
 			break;
 		found++;
-		sha1_to_hex_r(hexbuf[stage], ce->sha1);
+		sha1_to_hex_r(hexbuf[stage], ce->oid.hash);
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8c693e75..9bd1fd75 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -78,7 +78,7 @@ static void debug_stage(const char *label, const struct cache_entry *ce,
 	else
 		printf("%06o #%d %s %.8s\n",
 		       ce->ce_mode, ce_stage(ce), ce->name,
-		       sha1_to_hex(ce->sha1));
+		       oid_to_hex(&ce->oid));
 }
 
 static int debug_merge(const struct cache_entry * const *stages,
diff --git a/builtin/rm.c b/builtin/rm.c
index b2fee3e9..109969d5 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -199,7 +199,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		if (no_head
 		     || get_tree_entry(head, name, sha1, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
-		     || hashcmp(ce->sha1, sha1))
+		     || hashcmp(ce->oid.hash, sha1))
 			staged_changes = 1;
 
 		/*
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e79790f0..566cfdd7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -296,7 +296,8 @@ static int module_list(int argc, const char **argv, const char *prefix)
 		if (ce_stage(ce))
 			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
 		else
-			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+			printf("%06o %s %d\t", ce->ce_mode,
+			       oid_to_hex(&ce->oid), ce_stage(ce));
 
 		utf8_fprintf(stdout, "%s\n", ce->name);
 	}
@@ -683,7 +684,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
-			sha1_to_hex(ce->sha1), ce_stage(ce),
+			oid_to_hex(&ce->oid), ce_stage(ce),
 			needs_cloning, ce->name);
 	string_list_append(&suc->projectlines, sb.buf);
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba04b197..a60a30a8 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -275,7 +275,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(ce->sha1, path, st,
+	if (index_path(ce->oid.hash, path, st,
 		       info_only ? 0 : HASH_WRITE_OBJECT)) {
 		free(ce);
 		return -1;
@@ -403,7 +403,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 
-	hashcpy(ce->sha1, sha1);
+	hashcpy(ce->oid.hash, sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
@@ -601,7 +601,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 
-	hashcpy(ce->sha1, sha1);
+	hashcpy(ce->oid.hash, sha1);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = namelen;
@@ -658,7 +658,7 @@ static int unresolve_one(const char *path)
 		ret = -1;
 		goto free_return;
 	}
-	if (!hashcmp(ce_2->sha1, ce_3->sha1) &&
+	if (!oidcmp(&ce_2->oid, &ce_3->oid) &&
 	    ce_2->ce_mode == ce_3->ce_mode) {
 		fprintf(stderr, "%s: identical in both, skipping.\n",
 			path);
@@ -743,7 +743,7 @@ static int do_reupdate(int ac, const char **av,
 			old = read_one_ent(NULL, head_sha1,
 					   ce->name, ce_namelen(ce), 0);
 		if (old && ce->ce_mode == old->ce_mode &&
-		    !hashcmp(ce->sha1, old->sha1)) {
+		    !oidcmp(&ce->oid, &old->oid)) {
 			free(old);
 			continue; /* unchanged */
 		}
diff --git a/cache-tree.c b/cache-tree.c
index f28b1f45..345ea359 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -168,7 +168,7 @@ static int verify_cache(struct cache_entry **cache,
 				break;
 			}
 			fprintf(stderr, "%s: unmerged (%s)\n",
-				ce->name, sha1_to_hex(ce->sha1));
+				ce->name, oid_to_hex(&ce->oid));
 		}
 	}
 	if (funny)
@@ -349,7 +349,7 @@ static int update_one(struct cache_tree *it,
 			}
 		}
 		else {
-			sha1 = ce->sha1;
+			sha1 = ce->oid.hash;
 			mode = ce->ce_mode;
 			entlen = pathlen - baselen;
 			i++;
diff --git a/cache.h b/cache.h
index b780a91a..a679484e 100644
--- a/cache.h
+++ b/cache.h
@@ -173,7 +173,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned int ce_namelen;
 	unsigned int index;	/* for link extension */
-	unsigned char sha1[20];
+	struct object_id oid;
 	char name[FLEX_ARRAY]; /* more */
 };
 
diff --git a/diff-lib.c b/diff-lib.c
index bc49c708..3007c852 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -155,7 +155,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				if (2 <= stage) {
 					int mode = nce->ce_mode;
 					num_compare_stages++;
-					hashcpy(dpath->parent[stage-2].oid.hash, nce->sha1);
+					oidcpy(&dpath->parent[stage - 2].oid,
+					       &nce->oid);
 					dpath->parent[stage-2].mode = ce_mode_from_stat(nce, mode);
 					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
@@ -209,7 +210,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					continue;
 				}
 				diff_addremove(&revs->diffopt, '-', ce->ce_mode,
-					       ce->sha1, !is_null_sha1(ce->sha1),
+					       ce->oid.hash,
+					       !is_null_oid(&ce->oid),
 					       ce->name, 0);
 				continue;
 			}
@@ -225,8 +227,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 		oldmode = ce->ce_mode;
-		old_sha1 = ce->sha1;
-		new_sha1 = changed ? null_sha1 : ce->sha1;
+		old_sha1 = ce->oid.hash;
+		new_sha1 = changed ? null_sha1 : ce->oid.hash;
 		diff_change(&revs->diffopt, oldmode, newmode,
 			    old_sha1, new_sha1,
 			    !is_null_sha1(old_sha1),
@@ -261,7 +263,7 @@ static int get_stat_data(const struct cache_entry *ce,
 			 int cached, int match_missing,
 			 unsigned *dirty_submodule, struct diff_options *diffopt)
 {
-	const unsigned char *sha1 = ce->sha1;
+	const unsigned char *sha1 = ce->oid.hash;
 	unsigned int mode = ce->ce_mode;
 
 	if (!cached && !ce_uptodate(ce)) {
@@ -324,12 +326,13 @@ static int show_modified(struct rev_info *revs,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
-					     old->sha1, 1, old->ce_mode, 0);
+					     old->oid.hash, 1, old->ce_mode,
+					     0);
 		return -1;
 	}
 
 	if (revs->combine_merges && !cached &&
-	    (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
+	    (hashcmp(sha1, old->oid.hash) || oidcmp(&old->oid, &new->oid))) {
 		struct combine_diff_path *p;
 		int pathlen = ce_namelen(new);
 
@@ -343,22 +346,22 @@ static int show_modified(struct rev_info *revs,
 		memset(p->parent, 0, 2 * sizeof(struct combine_diff_parent));
 		p->parent[0].status = DIFF_STATUS_MODIFIED;
 		p->parent[0].mode = new->ce_mode;
-		hashcpy(p->parent[0].oid.hash, new->sha1);
+		oidcpy(&p->parent[0].oid, &new->oid);
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old->ce_mode;
-		hashcpy(p->parent[1].oid.hash, old->sha1);
+		oidcpy(&p->parent[1].oid, &old->oid);
 		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
 		free(p);
 		return 0;
 	}
 
 	oldmode = old->ce_mode;
-	if (mode == oldmode && !hashcmp(sha1, old->sha1) && !dirty_submodule &&
+	if (mode == oldmode && !hashcmp(sha1, old->oid.hash) && !dirty_submodule &&
 	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
-		    old->sha1, sha1, 1, !is_null_sha1(sha1),
+		    old->oid.hash, sha1, 1, !is_null_sha1(sha1),
 		    old->name, 0, dirty_submodule);
 	return 0;
 }
@@ -392,7 +395,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 		struct diff_filepair *pair;
 		pair = diff_unmerge(&revs->diffopt, idx->name);
 		if (tree)
-			fill_filespec(pair->one, tree->sha1, 1, tree->ce_mode);
+			fill_filespec(pair->one, tree->oid.hash, 1,
+				      tree->ce_mode);
 		return;
 	}
 
@@ -408,7 +412,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
-		diff_index_show_file(revs, "-", tree, tree->sha1, 1, tree->ce_mode, 0);
+		diff_index_show_file(revs, "-", tree, tree->oid.hash, 1,
+				     tree->ce_mode, 0);
 		return;
 	}
 
diff --git a/diff.c b/diff.c
index 534c12e2..bba80665 100644
--- a/diff.c
+++ b/diff.c
@@ -2700,7 +2700,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * This is not the sha1 we are looking for, or
 	 * unreusable because it is not a regular file.
 	 */
-	if (hashcmp(sha1, ce->sha1) || !S_ISREG(ce->ce_mode))
+	if (hashcmp(sha1, ce->oid.hash) || !S_ISREG(ce->ce_mode))
 		return 0;
 
 	/*
diff --git a/dir.c b/dir.c
index 0ea235f3..9e09bcbd 100644
--- a/dir.c
+++ b/dir.c
@@ -525,7 +525,7 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 		return NULL;
 	if (!ce_skip_worktree(active_cache[pos]))
 		return NULL;
-	data = read_sha1_file(active_cache[pos]->sha1, &type, &sz);
+	data = read_sha1_file(active_cache[pos]->oid.hash, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
@@ -533,7 +533,7 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	*size = xsize_t(sz);
 	if (sha1_stat) {
 		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
+		hashcpy(sha1_stat->sha1, active_cache[pos]->oid.hash);
 	}
 	return data;
 }
@@ -713,7 +713,8 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				 !ce_stage(active_cache[pos]) &&
 				 ce_uptodate(active_cache[pos]) &&
 				 !would_convert_to_git(fname))
-				hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
+				hashcpy(sha1_stat->sha1,
+					active_cache[pos]->oid.hash);
 			else
 				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
 			fill_stat_data(&sha1_stat->stat, &st);
diff --git a/entry.c b/entry.c
index 519e0422..ce80d292 100644
--- a/entry.c
+++ b/entry.c
@@ -82,7 +82,7 @@ static int create_file(const char *path, unsigned int mode)
 static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
-	void *new = read_sha1_file(ce->sha1, &type, size);
+	void *new = read_sha1_file(ce->oid.hash, &type, size);
 
 	if (new) {
 		if (type == OBJ_BLOB)
@@ -127,7 +127,7 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 	if (fd < 0)
 		return -1;
 
-	result |= stream_blob_to_fd(fd, ce->sha1, filter, 1);
+	result |= stream_blob_to_fd(fd, ce->oid.hash, filter, 1);
 	*fstat_done = fstat_output(fd, state, statbuf);
 	result |= close(fd);
 
@@ -148,7 +148,8 @@ static int write_entry(struct cache_entry *ce,
 	struct stat st;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(ce->name, ce->sha1);
+		struct stream_filter *filter = get_stream_filter(ce->name,
+								 ce->oid.hash);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
@@ -162,7 +163,7 @@ static int write_entry(struct cache_entry *ce,
 		new = read_blob_entry(ce, &size);
 		if (!new)
 			return error("unable to read sha1 file of %s (%s)",
-				path, sha1_to_hex(ce->sha1));
+				path, oid_to_hex(&ce->oid));
 
 		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
 			ret = symlink(new, path);
diff --git a/merge-recursive.c b/merge-recursive.c
index e3491268..e3db594d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -382,7 +382,7 @@ static struct string_list *get_unmerged(void)
 		}
 		e = item->util;
 		e->stages[ce_stage(ce)].mode = ce->ce_mode;
-		hashcpy(e->stages[ce_stage(ce)].oid.hash, ce->sha1);
+		oidcpy(&e->stages[ce_stage(ce)].oid, &ce->oid);
 	}
 
 	return unmerged;
diff --git a/read-cache.c b/read-cache.c
index 491e52d1..31eddec5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -161,7 +161,7 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 	if (fd >= 0) {
 		unsigned char sha1[20];
 		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
-			match = hashcmp(sha1, ce->sha1);
+			match = hashcmp(sha1, ce->oid.hash);
 		/* index_fd() closed the file descriptor already */
 	}
 	return match;
@@ -178,7 +178,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 	if (strbuf_readlink(&sb, ce->name, expected_size))
 		return -1;
 
-	buffer = read_sha1_file(ce->sha1, &type, &size);
+	buffer = read_sha1_file(ce->oid.hash, &type, &size);
 	if (buffer) {
 		if (size == sb.len)
 			match = memcmp(buffer, sb.buf, size);
@@ -202,7 +202,7 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	 */
 	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
 		return 0;
-	return hashcmp(sha1, ce->sha1);
+	return hashcmp(sha1, ce->oid.hash);
 }
 
 static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
@@ -262,7 +262,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 
 	/* Racily smudged entry? */
 	if (!ce->ce_stat_data.sd_size) {
-		if (!is_empty_blob_sha1(ce->sha1))
+		if (!is_empty_blob_sha1(ce->oid.hash))
 			changed |= DATA_CHANGED;
 	}
 
@@ -624,7 +624,7 @@ void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 	unsigned char sha1[20];
 	if (write_sha1_file("", 0, blob_type, sha1))
 		die("cannot create an empty blob in the object database");
-	hashcpy(ce->sha1, sha1);
+	hashcpy(ce->oid.hash, sha1);
 }
 
 int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags, int force_mode)
@@ -691,7 +691,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		return 0;
 	}
 	if (!intent_only) {
-		if (index_path(ce->sha1, path, st, HASH_WRITE_OBJECT)) {
+		if (index_path(ce->oid.hash, path, st, HASH_WRITE_OBJECT)) {
 			free(ce);
 			return error("unable to index file %s", path);
 		}
@@ -705,7 +705,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	/* It was suspected to be racily clean, but it turns out to be Ok */
 	was_same = (alias &&
 		    !ce_stage(alias) &&
-		    !hashcmp(alias->sha1, ce->sha1) &&
+		    !oidcmp(&alias->oid, &ce->oid) &&
 		    ce->ce_mode == alias->ce_mode);
 
 	if (pretend)
@@ -744,7 +744,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 
-	hashcpy(ce->sha1, sha1);
+	hashcpy(ce->oid.hash, sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
@@ -1424,7 +1424,7 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	ce->index = 0;
-	hashcpy(ce->sha1, ondisk->sha1);
+	hashcpy(ce->oid.hash, ondisk->sha1);
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
 	return ce;
@@ -1849,7 +1849,7 @@ static char *copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	ondisk->uid  = htonl(ce->ce_stat_data.sd_uid);
 	ondisk->gid  = htonl(ce->ce_stat_data.sd_gid);
 	ondisk->size = htonl(ce->ce_stat_data.sd_size);
-	hashcpy(ondisk->sha1, ce->sha1);
+	hashcpy(ondisk->sha1, ce->oid.hash);
 
 	flags = ce->ce_flags & ~CE_NAMEMASK;
 	flags |= (ce_namelen(ce) >= CE_NAMEMASK ? CE_NAMEMASK : ce_namelen(ce));
@@ -2038,7 +2038,7 @@ static int do_write_index(struct index_state *istate, int newfd,
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
 			ce_smudge_racily_clean_entry(ce);
-		if (is_null_sha1(ce->sha1)) {
+		if (is_null_oid(&ce->oid)) {
 			static const char msg[] = "cache entry has null sha1: %s";
 			static int allow = -1;
 
@@ -2285,7 +2285,7 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
 	}
 	if (pos < 0)
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	data = read_sha1_file(istate->cache[pos]->oid.hash, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
diff --git a/rerere.c b/rerere.c
index aaadec17..5d083ca5 100644
--- a/rerere.c
+++ b/rerere.c
@@ -980,7 +980,8 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 			break;
 		i = ce_stage(ce) - 1;
 		if (!mmfile[i].ptr) {
-			mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
+			mmfile[i].ptr = read_sha1_file(ce->oid.hash, &type,
+						       &size);
 			mmfile[i].size = size;
 		}
 	}
diff --git a/resolve-undo.c b/resolve-undo.c
index 468a2eb9..b40f3173 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -24,7 +24,7 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 	if (!lost->util)
 		lost->util = xcalloc(1, sizeof(*ui));
 	ui = lost->util;
-	hashcpy(ui->sha1[stage - 1], ce->sha1);
+	hashcpy(ui->sha1[stage - 1], ce->oid.hash);
 	ui->mode[stage - 1] = ce->ce_mode;
 }
 
diff --git a/revision.c b/revision.c
index 8a29cb03..969b3d14 100644
--- a/revision.c
+++ b/revision.c
@@ -1275,7 +1275,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		blob = lookup_blob(ce->sha1);
+		blob = lookup_blob(ce->oid.hash);
 		if (!blob)
 			die("unable to add index blob to traversal");
 		add_pending_object_with_path(revs, &blob->object, "",
diff --git a/sha1_name.c b/sha1_name.c
index ca7ddd6f..e4404391 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1435,7 +1435,7 @@ static int get_sha1_with_context_1(const char *name,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
-				hashcpy(sha1, ce->sha1);
+				hashcpy(sha1, ce->oid.hash);
 				oc->mode = ce->ce_mode;
 				free(new_path);
 				return 0;
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index d1689248..e44430b6 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -23,7 +23,7 @@ int cmd_main(int ac, const char **av)
 	for (i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
 		printf("%06o %s %d\t%s\n", ce->ce_mode,
-		       sha1_to_hex(ce->sha1), ce_stage(ce), ce->name);
+		       oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
 	}
 	printf("replacements:");
 	if (si->replace_bitmap)
diff --git a/tree.c b/tree.c
index 0089e52d..2b5a5a86 100644
--- a/tree.c
+++ b/tree.c
@@ -26,7 +26,7 @@ static int read_one_entry_opt(const unsigned char *sha1, const char *base, int b
 	ce->ce_namelen = baselen + len;
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
-	hashcpy(ce->sha1, sha1);
+	hashcpy(ce->oid.hash, sha1);
 	return add_cache_entry(ce, opt);
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 11c37fbc..9238308f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -625,7 +625,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 	ce->ce_mode = create_ce_mode(n->mode);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
-	hashcpy(ce->sha1, n->oid->hash);
+	oidcpy(&ce->oid, n->oid);
 	make_traverse_path(ce->name, info, n);
 
 	return ce;
@@ -1287,7 +1287,7 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
 	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
 		return 0;
 	return a->ce_mode == b->ce_mode &&
-	       !hashcmp(a->sha1, b->sha1);
+	       !oidcmp(&a->oid, &b->oid);
 }
 
 
@@ -1393,7 +1393,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		/* If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!hashcmp(sha1, ce->sha1))
+		if (!hashcmp(sha1, ce->oid.hash))
 			return 0;
 		return verify_clean_submodule(ce, error_type, o);
 	}
@@ -1665,7 +1665,7 @@ static void show_stage_entry(FILE *o,
 		fprintf(o, "%s%06o %s %d\t%s\n",
 			label,
 			ce->ce_mode,
-			sha1_to_hex(ce->sha1),
+			oid_to_hex(&ce->oid),
 			ce_stage(ce),
 			ce->name);
 }
