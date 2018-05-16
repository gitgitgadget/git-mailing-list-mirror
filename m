Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E85B1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEPWVz (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37674 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeEPWVr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:47 -0400
Received: by mail-pg0-f66.google.com with SMTP id a13-v6so889427pgu.4
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E0KiGfchZSwNlv9DC/hG1GV+P9v6R/zTG/nP3Kx5X6U=;
        b=Z6sBLztSulN6t5Mlsc6SgCNnFCf1d3Ny8D6+/cs2XrDZeupPg65IESSI5o2pLI838F
         bBhihxOZ7VLS+mmDJyb1j3LCrqMZW218IJe3x1M9t/8upPU0g0j1sHBob+6vahOKe+uK
         yAhpzdVSEXzkzFBQkf9pOOIqO6H41OkbzGa6g5joLINgm3nVSHCGMHaJm+gimkaSUtI/
         bg/99SsCehkLvhsRbkfUahV5pktcvufArju4ORndHl5Kgg0XQ4OoN7teXdH0N8IBF465
         d9+wteWZYfgQ14cbn4KOkShF/2P28fKjjvCvEHd9f2Anrnfe2IoHLsOxey4mFo4xh8Af
         ++Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E0KiGfchZSwNlv9DC/hG1GV+P9v6R/zTG/nP3Kx5X6U=;
        b=nZVfr0uLcaBBIm+lpKdZhIaquV/m2a5/+NE0RbfSS5fpzNvNkzJaFAwS3YFw6/2mec
         LC2UVySpnPBgVp3EWPb36lNR7k5d56RZ3IrE1cYbh5hKPmTGnpeAUgeB2zqNeiA3S303
         Yw0rKkIRWWx2n/e0bBnnovPkt70/9y1rDh0zVRTim+AQSHwTVjw3Gp8sGeqbwxpS9Mfn
         d2zyyijg1CBguR7NMLU4tv3Uh6JnXwwMnFfQwgFg0XhhDmjP/mvvEFRlr1G6YpzsvKMD
         SkguG83HfjyEmo6IlMF52mAvAmm8OiRwcC4M/ryUUcT4SIWWftnRgQT9T6lTODDpRkGZ
         lpOA==
X-Gm-Message-State: ALKqPwcCRb9qH0DJY6gMH8kcfcjqQKN90aNyr82R2yX+6mJtBAPHDt8q
        I3EkZT+dASFcH11AyEJWZ8b9kPX8NUU=
X-Google-Smtp-Source: AB8JxZrvS4UrFK2CcpQnOClDaWnZkejSnGzPi826//dr4LT8kObPwxEMf8GFXxsNgXMQdB5TZMvpiQ==
X-Received: by 2002:a65:5d51:: with SMTP id e17-v6mr2148016pgt.100.1526509306318;
        Wed, 16 May 2018 15:21:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k1-v6sm4115732pgt.88.2018.05.16.15.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 11/11] read_cache: convert most calls to repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:18 -0700
Message-Id: <20180516222118.233868-12-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 blame.c               | 5 +++--
 builtin/am.c          | 3 ++-
 builtin/diff.c        | 3 ++-
 builtin/fsck.c        | 3 ++-
 builtin/merge-index.c | 3 ++-
 check-racy.c          | 2 +-
 diff.c                | 5 +++--
 merge-recursive.c     | 3 ++-
 revision.c            | 5 +++--
 sequencer.c           | 5 +++--
 sha1-name.c           | 2 +-
 11 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/blame.c b/blame.c
index 78c9808bd1a..ebfa1c8efcd 100644
--- a/blame.c
+++ b/blame.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tag.h"
+#include "repository.h"
 #include "blame.h"
 
 void blame_origin_decref(struct blame_origin *o)
@@ -159,7 +160,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	unsigned mode;
 	struct strbuf msg = STRBUF_INIT;
 
-	read_cache();
+	repo_read_index_or_die(the_repository);
 	time(&now);
 	commit = alloc_commit_node();
 	commit->object.parsed = 1;
@@ -241,7 +242,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	 * want to run "diff-index --cached".
 	 */
 	discard_cache();
-	read_cache();
+	repo_read_index_or_die(the_repository);
 
 	len = strlen(path);
 	if (!mode) {
diff --git a/builtin/am.c b/builtin/am.c
index d834f9e62b6..3c6e77a5369 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -32,6 +32,7 @@
 #include "apply.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "repository.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1581,7 +1582,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 
 	discard_cache();
-	read_cache();
+	repo_read_index_or_die(the_repository);
 
 	/*
 	 * This is not so wrong. Depending on which base we picked, orig_tree
diff --git a/builtin/diff.c b/builtin/diff.c
index 16bfb22f738..4bba211f1c7 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -17,6 +17,7 @@
 #include "builtin.h"
 #include "submodule.h"
 #include "sha1-array.h"
+#include "repository.h"
 
 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2
@@ -210,7 +211,7 @@ static void refresh_index_quietly(void)
 	if (fd < 0)
 		return;
 	discard_cache();
-	read_cache();
+	repo_read_index(the_repository); /* do not die on error */
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
 	update_index_if_able(&the_index, &lock_file);
 }
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 087360a6757..a42e98235da 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -18,6 +18,7 @@
 #include "decorate.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "repository.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -795,7 +796,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (keep_cache_objects) {
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
-		read_cache();
+		repo_read_index_or_die(the_repository);
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c99443b095b..2d91c7c3b5e 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "run-command.h"
+#include "repository.h"
 
 static const char *pgm;
 static int one_shot, quiet;
@@ -77,7 +78,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
-	read_cache();
+	repo_read_index_or_die(the_repository);
 
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
diff --git a/check-racy.c b/check-racy.c
index 24b6542352a..9b884639cf4 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -6,7 +6,7 @@ int main(int ac, char **av)
 	int dirty, clean, racy;
 
 	dirty = clean = racy = 0;
-	read_cache();
+	repo_read_index_or_die(the_repository);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		struct stat st;
diff --git a/diff.c b/diff.c
index 1289df4b1f9..383f52fa118 100644
--- a/diff.c
+++ b/diff.c
@@ -22,6 +22,7 @@
 #include "argv-array.h"
 #include "graph.h"
 #include "packfile.h"
+#include "repository.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -4210,13 +4211,13 @@ void diff_setup_done(struct diff_options *options)
 		options->rename_limit = diff_rename_limit_default;
 	if (options->setup & DIFF_SETUP_USE_CACHE) {
 		if (!active_cache)
-			/* read-cache does not die even when it fails
+			/* repo_read_indexe does not die even when it fails
 			 * so it is safe for us to do this here.  Also
 			 * it does not smudge active_cache or active_nr
 			 * when it fails, so we do not have to worry about
 			 * cleaning it up ourselves either.
 			 */
-			read_cache();
+			repo_read_index(the_repository);
 	}
 	if (40 < options->abbrev)
 		options->abbrev = 40; /* full */
diff --git a/merge-recursive.c b/merge-recursive.c
index 0c0d48624da..76911c935c3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2151,7 +2151,8 @@ int merge_recursive(struct merge_options *o,
 
 	discard_cache();
 	if (!o->call_depth)
-		read_cache();
+		if (read_cache() < 0)
+			return err(o, _("index file corrupt"));
 
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
diff --git a/revision.c b/revision.c
index 1cff11833e7..8ad9824143d 100644
--- a/revision.c
+++ b/revision.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "argv-array.h"
+#include "repository.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1344,7 +1345,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
 	struct worktree **worktrees, **p;
 
-	read_cache();
+	repo_read_index_or_die(the_repository);
 	do_add_index_objects_to_pending(revs, &the_index);
 
 	if (revs->single_worktree)
@@ -1486,7 +1487,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	head->object.flags |= SYMMETRIC_LEFT;
 
 	if (!active_nr)
-		read_cache();
+		repo_read_index_or_die(the_repository);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
diff --git a/sequencer.c b/sequencer.c
index 4ce5120e777..773165c8cde 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,7 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "repository.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -432,7 +433,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_cache();
+	repo_read_index_or_die(the_repository);
 	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
@@ -489,7 +490,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
-	read_cache();
+	repo_read_index_or_die(the_repository);
 
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
diff --git a/sha1-name.c b/sha1-name.c
index 5b93bf8da36..83d5f945cf1 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1639,7 +1639,7 @@ static int get_oid_with_context_1(const char *name,
 			oc->path = xstrdup(cp);
 
 		if (!active_cache)
-			read_cache();
+			repo_read_index_or_die(the_repository);
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
-- 
2.17.0.582.gccdcbd54c44.dirty

