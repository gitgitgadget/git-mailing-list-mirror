Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D8F2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdE3RcS (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:18 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34693 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdE3Rb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:58 -0400
Received: by mail-pf0-f176.google.com with SMTP id 9so78331080pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ttlDO7k2+bEYCYFjzunG2q0x3iATWoTd9yEbvXtHKjs=;
        b=TePVBQTb/bnrlZYfP6F1UgGTSsnP5JEvMS6aGZfgkKlN/OISJCXL7fBLg/uEicZBS/
         4HWX8nbtfiXdXmSNhUA1Tg9+bJfYESPen/13Ph/wpPJYrnNpRuFAsEpFz3MEBQvT8Gks
         bfx7WbQjyGd8dmoDyneXBS+Yh0Gb6Gxn6gPXI4VTU8a2JsPxi8iMATdbJhWU/aZuOgDw
         CR4QNAjzmz0dA+f1yNgY5QsnAS3a56xBsacd/ZFY3JIkMxh508Yr4EkY5r2Eddafb4Ln
         FSWpKH5B/CO/lV2hAaEHXdMKx4zYYfGPyHTNDuMNLNPTHPMnMGd/IGJsouG4qQABn+sz
         XZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ttlDO7k2+bEYCYFjzunG2q0x3iATWoTd9yEbvXtHKjs=;
        b=PxzSov7JkWsh1lhqBLrlomyQ9iPyJxdqD3vrDwe19xPOTfwH3/rGDyyA911rqOphVu
         xrcbE+Kr4qGMhMcyXK2IxCyUfiBoi8McTnZ5f6nxhNC37wl3HpNV/y3g093G9uneUyye
         zawLiM8fygwtJY3Tbr3Mxfe/QZTqSrPyy9Qronh3b+vayOBrmp7Pb84TEXeykcvuve7T
         0XlQFKHz5mwpjdAhPxNMiBFuXf116DXp6qyFODeB7lf9nj+BEHIwUPtyfc9vqhliM/Io
         4+eFkeNqRTbjZGEIdbSEc5f7n5BvcvGJFqJyVMr7GwjTeohasuBHgmdciZ6eok1uuuA+
         QipA==
X-Gm-Message-State: AODbwcBNLO33LU0RAqnXKVE4prx8w8emnDLaJkpGs/hGjTX1Km1GZtcK
        liL4A2QBrzbbIt9Ijwk/UA==
X-Received: by 10.99.116.82 with SMTP id e18mr26291904pgn.1.1496165517504;
        Tue, 30 May 2017 10:31:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:56 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 27/33] diff-tree: convert diff_tree_sha1 to struct object_id
Date:   Tue, 30 May 2017 10:31:03 -0700
Message-Id: <20170530173109.54904-28-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/blame.c       | 20 ++++++++++----------
 builtin/diff-tree.c   |  8 +++-----
 builtin/diff.c        |  2 +-
 builtin/fast-export.c |  4 ++--
 builtin/log.c         |  6 +++---
 builtin/merge.c       |  2 +-
 combine-diff.c        |  4 ++--
 diff.h                |  5 +++--
 line-log.c            |  4 ++--
 log-tree.c            |  8 ++++----
 merge-recursive.c     |  2 +-
 notes-merge.c         |  4 ++--
 patch-ids.c           |  4 ++--
 revision.c            |  4 ++--
 sequencer.c           |  4 ++--
 tree-diff.c           | 12 +++++++-----
 16 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5ad435380..7645aa991 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -565,9 +565,9 @@ static struct origin *find_origin(struct scoreboard *sb,
 	if (is_null_oid(&origin->commit->object.oid))
 		do_diff_cache(&parent->tree->object.oid, &diff_opts);
 	else
-		diff_tree_sha1(parent->tree->object.oid.hash,
-			       origin->commit->tree->object.oid.hash,
-			       "", &diff_opts);
+		diff_tree_oid(&parent->tree->object.oid,
+			      &origin->commit->tree->object.oid,
+			      "", &diff_opts);
 	diffcore_std(&diff_opts);
 
 	if (!diff_queued_diff.nr) {
@@ -635,9 +635,9 @@ static struct origin *find_rename(struct scoreboard *sb,
 	if (is_null_oid(&origin->commit->object.oid))
 		do_diff_cache(&parent->tree->object.oid, &diff_opts);
 	else
-		diff_tree_sha1(parent->tree->object.oid.hash,
-			       origin->commit->tree->object.oid.hash,
-			       "", &diff_opts);
+		diff_tree_oid(&parent->tree->object.oid,
+			      &origin->commit->tree->object.oid,
+			      "", &diff_opts);
 	diffcore_std(&diff_opts);
 
 	for (i = 0; i < diff_queued_diff.nr; i++) {
@@ -1262,7 +1262,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 	/* Try "find copies harder" on new path if requested;
 	 * we do not want to use diffcore_rename() actually to
 	 * match things up; find_copies_harder is set only to
-	 * force diff_tree_sha1() to feed all filepairs to diff_queue,
+	 * force diff_tree_oid() to feed all filepairs to diff_queue,
 	 * and this code needs to be after diff_setup_done(), which
 	 * usually makes find-copies-harder imply copy detection.
 	 */
@@ -1274,9 +1274,9 @@ static void find_copy_in_parent(struct scoreboard *sb,
 	if (is_null_oid(&target->commit->object.oid))
 		do_diff_cache(&parent->tree->object.oid, &diff_opts);
 	else
-		diff_tree_sha1(parent->tree->object.oid.hash,
-			       target->commit->tree->object.oid.hash,
-			       "", &diff_opts);
+		diff_tree_oid(&parent->tree->object.oid,
+			      &target->commit->tree->object.oid,
+			      "", &diff_opts);
 
 	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
 		diffcore_std(&diff_opts);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 5ea1c1431..aef167619 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -49,8 +49,8 @@ static int stdin_diff_trees(struct tree *tree1, const char *p)
 		return -1;
 	printf("%s %s\n", oid_to_hex(&tree1->object.oid),
 			  oid_to_hex(&tree2->object.oid));
-	diff_tree_sha1(tree1->object.oid.hash, tree2->object.oid.hash,
-		       "", &log_tree_opt.diffopt);
+	diff_tree_oid(&tree1->object.oid, &tree2->object.oid,
+		      "", &log_tree_opt.diffopt);
 	log_tree_diff_flush(&log_tree_opt);
 	return 0;
 }
@@ -148,9 +148,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		if (tree2->flags & UNINTERESTING) {
 			SWAP(tree2, tree1);
 		}
-		diff_tree_sha1(tree1->oid.hash,
-			       tree2->oid.hash,
-			       "", &opt->diffopt);
+		diff_tree_oid(&tree1->oid, &tree2->oid, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 		break;
 	}
diff --git a/builtin/diff.c b/builtin/diff.c
index 73b4ff3db..4c6a1a962 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -174,7 +174,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 		swap = 1;
 	oid[swap] = &ent0->item->oid;
 	oid[1 - swap] = &ent1->item->oid;
-	diff_tree_sha1(oid[0]->hash, oid[1]->hash, "", &revs->diffopt);
+	diff_tree_oid(oid[0], oid[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
 }
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e242726f0..d57f36c43 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -562,8 +562,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	    get_object_mark(&commit->parents->item->object) != 0 &&
 	    !full_tree) {
 		parse_commit_or_die(commit->parents->item);
-		diff_tree_sha1(commit->parents->item->tree->object.oid.hash,
-			       commit->tree->object.oid.hash, "", &rev->diffopt);
+		diff_tree_oid(&commit->parents->item->tree->object.oid,
+			      &commit->tree->object.oid, "", &rev->diffopt);
 	}
 	else
 		diff_root_tree_oid(&commit->tree->object.oid,
diff --git a/builtin/log.c b/builtin/log.c
index 6bdba3444..4ef522ee5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1043,9 +1043,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	diff_setup_done(&opts);
 
-	diff_tree_sha1(origin->tree->object.oid.hash,
-		       head->tree->object.oid.hash,
-		       "", &opts);
+	diff_tree_oid(&origin->tree->object.oid,
+		      &head->tree->object.oid,
+		      "", &opts);
 	diffcore_std(&opts);
 	diff_flush(&opts);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index a4a098f40..afaed6a2c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -415,7 +415,7 @@ static void finish(struct commit *head_commit,
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
 		diff_setup_done(&opts);
-		diff_tree_sha1(head->hash, new_head->hash, "", &opts);
+		diff_tree_oid(head, new_head, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
 	}
diff --git a/combine-diff.c b/combine-diff.c
index c82364510..04c4ae856 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1336,7 +1336,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 			opt->output_format = stat_opt;
 		else
 			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_tree_sha1(parents->oid[i].hash, oid->hash, "", opt);
+		diff_tree_oid(&parents->oid[i], oid, "", opt);
 		diffcore_std(opt);
 		paths = intersect_paths(paths, i, num_parent);
 
@@ -1463,7 +1463,7 @@ void diff_tree_combined(const struct object_id *oid,
 		if (stat_opt) {
 			diffopts.output_format = stat_opt;
 
-			diff_tree_sha1(parents->oid[0].hash, oid->hash, "", &diffopts);
+			diff_tree_oid(&parents->oid[0], oid, "", &diffopts);
 			diffcore_std(&diffopts);
 			if (opt->orderfile)
 				diffcore_order(opt->orderfile);
diff --git a/diff.h b/diff.h
index 8d46a6709..e0b503460 100644
--- a/diff.h
+++ b/diff.h
@@ -213,8 +213,9 @@ extern struct combine_diff_path *diff_tree_paths(
 	struct combine_diff_path *p, const unsigned char *sha1,
 	const unsigned char **parent_sha1, int nparent,
 	struct strbuf *base, struct diff_options *opt);
-extern int diff_tree_sha1(const unsigned char *old, const unsigned char *new,
-			  const char *base, struct diff_options *opt);
+extern int diff_tree_oid(const struct object_id *old_oid,
+			 const struct object_id *new_oid,
+			 const char *base, struct diff_options *opt);
 extern int diff_root_tree_oid(const struct object_id *new_oid, const char *base,
 			      struct diff_options *opt);
 
diff --git a/line-log.c b/line-log.c
index a3bd2f2d5..2588ce076 100644
--- a/line-log.c
+++ b/line-log.c
@@ -819,8 +819,8 @@ static void queue_diffs(struct line_log_data *range,
 	assert(commit);
 
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree_sha1(parent ? parent->tree->object.oid.hash : NULL,
-			commit->tree->object.oid.hash, "", opt);
+	diff_tree_oid(parent ? &parent->tree->object.oid : NULL,
+		      &commit->tree->object.oid, "", opt);
 	if (opt->detect_rename) {
 		filter_diffs_for_paths(range, 1);
 		if (diff_might_be_rename())
diff --git a/log-tree.c b/log-tree.c
index b40242534..2903874ec 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -822,8 +822,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			 * we merged _in_.
 			 */
 			parse_commit_or_die(parents->item);
-			diff_tree_sha1(parents->item->tree->object.oid.hash,
-				       oid->hash, "", &opt->diffopt);
+			diff_tree_oid(&parents->item->tree->object.oid,
+				      oid, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
 		}
@@ -837,8 +837,8 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		struct commit *parent = parents->item;
 
 		parse_commit_or_die(parent);
-		diff_tree_sha1(parent->tree->object.oid.hash,
-			       oid->hash, "", &opt->diffopt);
+		diff_tree_oid(&parent->tree->object.oid,
+			      oid, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 
 		showed_log |= !opt->loginfo;
diff --git a/merge-recursive.c b/merge-recursive.c
index ae5238d82..5cc86df2d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -528,7 +528,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.show_rename_progress = o->show_rename_progress;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opts);
-	diff_tree_sha1(o_tree->object.oid.hash, tree->object.oid.hash, "", &opts);
+	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
 		o->needed_rename_limit = opts.needed_rename_limit;
diff --git a/notes-merge.c b/notes-merge.c
index 7d88857a8..70e3fbeef 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -129,7 +129,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
-	diff_tree_sha1(base->hash, remote->hash, "", &opt);
+	diff_tree_oid(base, remote, "", &opt);
 	diffcore_std(&opt);
 
 	changes = xcalloc(diff_queued_diff.nr, sizeof(struct notes_merge_pair));
@@ -192,7 +192,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	DIFF_OPT_SET(&opt, RECURSIVE);
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
-	diff_tree_sha1(base->hash, local->hash, "", &opt);
+	diff_tree_oid(base, local, "", &opt);
 	diffcore_std(&opt);
 
 	for (i = 0; i < diff_queued_diff.nr; i++) {
diff --git a/patch-ids.c b/patch-ids.c
index aaf462c03..9c0ab9e67 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -17,8 +17,8 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 		return -1;
 
 	if (commit->parents)
-		diff_tree_sha1(commit->parents->item->object.oid.hash,
-			       commit->object.oid.hash, "", options);
+		diff_tree_oid(&commit->parents->item->object.oid,
+			      &commit->object.oid, "", options);
 	else
 		diff_root_tree_oid(&commit->object.oid, "", options);
 	diffcore_std(options);
diff --git a/revision.c b/revision.c
index 7637e7556..3030f33ee 100644
--- a/revision.c
+++ b/revision.c
@@ -455,7 +455,7 @@ static int rev_compare_tree(struct rev_info *revs,
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	if (diff_tree_sha1(t1->object.oid.hash, t2->object.oid.hash, "",
+	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
 	return tree_difference;
@@ -471,7 +471,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 
 	tree_difference = REV_TREE_SAME;
 	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
-	retval = diff_tree_sha1(NULL, t1->object.oid.hash, "", &revs->pruning);
+	retval = diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
 	return retval >= 0 && (tree_difference == REV_TREE_SAME);
 }
diff --git a/sequencer.c b/sequencer.c
index a23b948ac..7a114def8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2129,8 +2129,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
 			    !get_sha1(buf.buf, orig.hash) &&
 			    !get_sha1("HEAD", head.hash)) {
-				diff_tree_sha1(orig.hash, head.hash,
-					       "", &log_tree_opt.diffopt);
+				diff_tree_oid(&orig, &head, "",
+					      &log_tree_opt.diffopt);
 				log_tree_diff_flush(&log_tree_opt);
 			}
 		}
diff --git a/tree-diff.c b/tree-diff.c
index f9bbaf3c4..fc020d76d 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -419,7 +419,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	 * load parents first, as they are probably already cached.
 	 *
 	 * ( log_tree_diff() parses commit->parent before calling here via
-	 *   diff_tree_sha1(parent, commit) )
+	 *   diff_tree_oid(parent, commit) )
 	 */
 	for (i = 0; i < nparent; ++i)
 		tptree[i] = fill_tree_descriptor(&tp[i], parents_sha1[i]);
@@ -694,7 +694,9 @@ static int ll_diff_tree_sha1(const unsigned char *old, const unsigned char *new,
 	return 0;
 }
 
-int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base_str, struct diff_options *opt)
+int diff_tree_oid(const struct object_id *old_oid,
+		  const struct object_id *new_oid,
+		  const char *base_str, struct diff_options *opt)
 {
 	struct strbuf base;
 	int retval;
@@ -702,9 +704,9 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	strbuf_init(&base, PATH_MAX);
 	strbuf_addstr(&base, base_str);
 
-	retval = ll_diff_tree_sha1(old, new, &base, opt);
+	retval = ll_diff_tree_sha1(old_oid->hash, new_oid->hash, &base, opt);
 	if (!*base_str && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
-		try_to_follow_renames(old, new, &base, opt);
+		try_to_follow_renames(old_oid->hash, new_oid->hash, &base, opt);
 
 	strbuf_release(&base);
 
@@ -713,5 +715,5 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 
 int diff_root_tree_oid(const struct object_id *new_oid, const char *base, struct diff_options *opt)
 {
-	return diff_tree_sha1(NULL, new_oid->hash, base, opt);
+	return diff_tree_oid(NULL, new_oid, base, opt);
 }
-- 
2.13.0.219.gdb65acc882-goog

