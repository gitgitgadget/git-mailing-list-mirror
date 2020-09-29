Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A66C47423
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 12:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6EC2083B
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 12:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdZ/bLNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgI2M30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgI2Lbe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 07:31:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664EC0613E2
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 04:31:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so3724004ljd.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8phBJl7m0JRBpR3GUevJgxuNzJWBLQKKRlT2Y67UTZg=;
        b=NdZ/bLNOstzyHd6DNl3Sy76Jt+tMmqSXavTmLxyTwStK2bEv8fBKHZpAZMFmJuJYCy
         SCXtzrrtuKAETY6ru0lQ6qo1zTC077A6F8P7Ll6zPXSw42Ohpxrwq/s0sZZi0VMS3fRi
         l1aYNh/5fOTl1/l6QKuBFsxoy8wz5KIZlakaMb1p8W5bzPcMtLv0cjI8WiATqgsoJJFA
         XRp7ad4kDnwAj+rN7RKZFAwrSBVuPmQJSMPvoI1k5jS0hxB0SxFSjOGVF4DgHb0sPcZe
         DTBWa3QD0+H/Y3fzpMYMlYWxV1mhUbBO9FjlSa9jaGdmvn8hBpnL5m8nvtg4I55xNeVk
         P+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8phBJl7m0JRBpR3GUevJgxuNzJWBLQKKRlT2Y67UTZg=;
        b=GUML+6XAaxzfXURKOkn+VA8WQzCkOEAkFmLCTFYVFI++N4cDOvJOPEIUdR62xt3AhZ
         Hes1GrEkE8MwhBJJU17pAV1QnoCtox9L0UcOW56rEqXJd9cLELkFX1tj0nM9A1tSJo6b
         hlIoBb+BtZeFD2XWt9/rl4h4mgubCeVc1xGGJLE/n3+B45Pg6o8GI4/9S7GtY+JBAXAk
         Agi9ftBYuKXZX3LKA/u2Fm8KWGXg3kPURdPptNgZ4ceCk9unFj+whDkBWLBq96jK2G3j
         JkU8xQYd+qDv6Q6An0vlDIsi9DO1afCL2tJP1ej4KX1MPFm9WEFLKyyNKh4QpD8gwhut
         i17g==
X-Gm-Message-State: AOAM5314ac8hROv9h758FyzTxptHLmQJbA7XF3mA+EZQzPRC0I/cnhUw
        p37r3EgDamCxbiHlhMkF2kw=
X-Google-Smtp-Source: ABdhPJzlwsocv83wkDYXU/oq/3axyCerGl5bzWGwhMK1req36lrv9HlX8b8iDC9sw1EhBF2Fo2sZ2w==
X-Received: by 2002:a2e:b386:: with SMTP id f6mr1025088lje.186.1601379091886;
        Tue, 29 Sep 2020 04:31:31 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z25sm336919ljz.114.2020.09.29.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 04:31:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] diff: get rid of redundant 'dense' argument
Date:   Tue, 29 Sep 2020 14:31:22 +0300
Message-Id: <20200929113122.14201-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of 'dense' argument that is redundant for every function that has
'struct rev_info *rev' argument as well, as the value of 'dense' passed is
always taken from 'rev->dense_combined_merges' field.

The only place where this was not the case is in 'submodule.c' where
'diff_tree_combined_merge()' was called with '1' for 'dense' argument. However,
at that call the 'revs' instance used is local to the function, and we now just
set 'revs->dense_combined_merges' to 1 in this local instance.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/diff.c |  3 +--
 combine-diff.c | 21 +++++++++------------
 diff-lib.c     |  6 ++----
 diff.h         |  6 +++---
 log-tree.c     |  2 +-
 submodule.c    |  3 ++-
 6 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index cb98811c21db..cd4083fed96e 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -203,8 +203,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	for (i = 1; i < ents; i++)
 		oid_array_append(&parents, &ent[i].item->oid);
-	diff_tree_combined(&ent[0].item->oid, &parents,
-			   revs->dense_combined_merges, revs);
+	diff_tree_combined(&ent[0].item->oid, &parents, revs);
 	oid_array_clear(&parents);
 	return 0;
 }
diff --git a/combine-diff.c b/combine-diff.c
index 002e0e5438bc..555b812a9975 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -923,7 +923,6 @@ static void dump_quoted_path(const char *head,
 
 static void show_combined_header(struct combine_diff_path *elem,
 				 int num_parent,
-				 int dense,
 				 struct rev_info *rev,
 				 const char *line_prefix,
 				 int mode_differs,
@@ -939,6 +938,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 	int added = 0;
 	int deleted = 0;
 	int i;
+	int dense = rev->dense_combined_merges;
 
 	if (rev->loginfo && !rev->no_commit_id)
 		show_log(rev);
@@ -1012,7 +1012,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 }
 
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
-			    int dense, int working_tree_file,
+			    int working_tree_file,
 			    struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
@@ -1145,7 +1145,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		}
 	}
 	if (is_binary) {
-		show_combined_header(elem, num_parent, dense, rev,
+		show_combined_header(elem, num_parent, rev,
 				     line_prefix, mode_differs, 0);
 		printf("Binary files differ\n");
 		free(result);
@@ -1200,10 +1200,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				     textconv, elem->path, opt->xdl_opts);
 	}
 
-	show_hunks = make_hunks(sline, cnt, num_parent, dense);
+	show_hunks = make_hunks(sline, cnt, num_parent, rev->dense_combined_merges);
 
 	if (show_hunks || mode_differs || working_tree_file) {
-		show_combined_header(elem, num_parent, dense, rev,
+		show_combined_header(elem, num_parent, rev,
 				     line_prefix, mode_differs, 1);
 		dump_sline(sline, line_prefix, cnt, num_parent,
 			   opt->use_color, result_deleted);
@@ -1284,7 +1284,6 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
  */
 void show_combined_diff(struct combine_diff_path *p,
 		       int num_parent,
-		       int dense,
 		       struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
@@ -1294,7 +1293,7 @@ void show_combined_diff(struct combine_diff_path *p,
 				  DIFF_FORMAT_NAME_STATUS))
 		show_raw_diff(p, num_parent, rev);
 	else if (opt->output_format & DIFF_FORMAT_PATCH)
-		show_patch_diff(p, num_parent, dense, 1, rev);
+		show_patch_diff(p, num_parent, 1, rev);
 }
 
 static void free_combined_pair(struct diff_filepair *pair)
@@ -1454,7 +1453,6 @@ static struct combine_diff_path *find_paths_multitree(
 
 void diff_tree_combined(const struct object_id *oid,
 			const struct oid_array *parents,
-			int dense,
 			struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
@@ -1581,8 +1579,7 @@ void diff_tree_combined(const struct object_id *oid,
 				printf("%s%c", diff_line_prefix(opt),
 				       opt->line_termination);
 			for (p = paths; p; p = p->next)
-				show_patch_diff(p, num_parent, dense,
-						0, rev);
+				show_patch_diff(p, num_parent, 0, rev);
 		}
 	}
 
@@ -1600,7 +1597,7 @@ void diff_tree_combined(const struct object_id *oid,
 	clear_pathspec(&diffopts.pathspec);
 }
 
-void diff_tree_combined_merge(const struct commit *commit, int dense,
+void diff_tree_combined_merge(const struct commit *commit,
 			      struct rev_info *rev)
 {
 	struct commit_list *parent = get_saved_parents(rev, commit);
@@ -1610,6 +1607,6 @@ void diff_tree_combined_merge(const struct commit *commit, int dense,
 		oid_array_append(&parents, &parent->item->object.oid);
 		parent = parent->next;
 	}
-	diff_tree_combined(&commit->object.oid, &parents, dense, rev);
+	diff_tree_combined(&commit->object.oid, &parents, rev);
 	oid_array_clear(&parents);
 }
diff --git a/diff-lib.c b/diff-lib.c
index 346fdcf0b0ce..f95c6de75fc8 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -177,9 +177,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			i--;
 
 			if (revs->combine_merges && num_compare_stages == 2) {
-				show_combined_diff(dpath, 2,
-						   revs->dense_combined_merges,
-						   revs);
+				show_combined_diff(dpath, 2, revs);
 				free(dpath);
 				continue;
 			}
@@ -361,7 +359,7 @@ static int show_modified(struct rev_info *revs,
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old_entry->ce_mode;
 		oidcpy(&p->parent[1].oid, &old_entry->oid);
-		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
+		show_combined_diff(p, 2, revs);
 		free(p);
 		return 0;
 	}
diff --git a/diff.h b/diff.h
index 49242d2733c0..dc6e09a55e62 100644
--- a/diff.h
+++ b/diff.h
@@ -454,11 +454,11 @@ struct combine_diff_path {
 		st_mult(sizeof(struct combine_diff_parent), (n)))
 
 void show_combined_diff(struct combine_diff_path *elem, int num_parent,
-			int dense, struct rev_info *);
+			struct rev_info *);
 
-void diff_tree_combined(const struct object_id *oid, const struct oid_array *parents, int dense, struct rev_info *rev);
+void diff_tree_combined(const struct object_id *oid, const struct oid_array *parents, struct rev_info *rev);
 
-void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
+void diff_tree_combined_merge(const struct commit *commit, struct rev_info *rev);
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
 
diff --git a/log-tree.c b/log-tree.c
index cb8942fec181..1927f917ce94 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -885,7 +885,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 {
-	diff_tree_combined_merge(commit, opt->dense_combined_merges, opt);
+	diff_tree_combined_merge(commit, opt);
 	return !opt->loginfo;
 }
 
diff --git a/submodule.c b/submodule.c
index 543b1123ae12..b3bb59f06644 100644
--- a/submodule.c
+++ b/submodule.c
@@ -865,7 +865,8 @@ static void collect_changed_submodules(struct repository *r,
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
-		diff_tree_combined_merge(commit, 1, &diff_rev);
+		diff_rev.dense_combined_merges = 1;
+		diff_tree_combined_merge(commit, &diff_rev);
 	}
 
 	reset_revision_walk();
-- 
2.25.1

