Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF89C4741F
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A067F20759
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdSTujGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJ2Uch (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgJ2Uce (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:32:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD825C0613D7
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:32:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k18so1039623wmj.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3UOUvb0C/w+fD2FCxP9MhvlUcs/BBagXvRQQqA42S8E=;
        b=RdSTujGTapD+nJFzV3xAG5/Sy/x1OVMc3yKlRzqT69e5rVQXyyC5z4Zn/NxKYa/yLH
         jDgxS6nLGRd7Qa0Jdz+kgjnL0ReFNWmsZFPkAGCsB47LtzKN0iHGBrILfCxPZoseKVdH
         c0OmXny1jnTZn8vuJT377BIMqp3wRHrlD8OS5/w0iJIxYG6OhLd/KapRYyvc2XIp9DFN
         GbZu6WF2Ouoq7UQmklnezIjnFBiYTVHuJZH6EAB5nDBfuaTVgHbgh0IHqqjxqp9ErC1l
         lamWdhli/QAYWPahNow7LrfPqapka42/ypcBEVFh6h+nCNUkxcDoLcSMWSbbbLgLSM39
         t6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3UOUvb0C/w+fD2FCxP9MhvlUcs/BBagXvRQQqA42S8E=;
        b=Pq7SsUx7TYiClT7VfmydOc0ApMAubAYavZMbzHJzG+mzYv8gmFn6E3BTaz0BzEny3i
         GGTQHwkYq5QOMzp98VmQLGczyRSomqPm96Kf4hVDfzAUIYdjRjV4n/IDxPnxHqVkuFXB
         QdNAotF0cPVQ3oHHiB9/19JX14BM/u1ma7jYH7s9Drr3naiPjjjWUj5DJjO/V3R+mRYh
         IhbVPm+Nvg93aS5PzA2GYQ2P60mZHMrspmjWIXvzbHieGlxnD2NO5lKOGtZie/TNqiVz
         twtppQrjntyCmgApgKvgrGaJNZd2699sPKd+R7IFB01k9fFLHcKL07QX5eHrbNfYSGFB
         rduA==
X-Gm-Message-State: AOAM530Fr53otfO8uu+mlAt0qXD3SMzL1PPHHTw72mN4PXGcYdQbUyGc
        zF9MbaiiKOvwB5uML+ur078FZw/ygsY=
X-Google-Smtp-Source: ABdhPJwe1DNNX6sPiVcoHOlWr/D0CsC7U1Vy/GDlVQZGVRujLymgFMwJFwvPpldFnH65o1hTb0/Uwg==
X-Received: by 2002:a7b:c741:: with SMTP id w1mr1051595wmk.67.1604003539200;
        Thu, 29 Oct 2020 13:32:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm7389943wru.86.2020.10.29.13.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:32:18 -0700 (PDT)
Message-Id: <fce0db8778fd4664e7fc4092882ea13c6a01f39e.1604003535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
References: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
        <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 20:32:13 +0000
Subject: [PATCH v4 3/4] fast-rebase: demonstrate merge-ort's API via new
 test-tool command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add a new test-tool command named 'fast-rebase', which is a
super-slimmed down and nowhere near as capable version of 'git rebase'.
'test-tool fast-rebase' is not currently planned for usage in the
testsuite, but is here for two purposes:

  1) Demonstrate the desired API of merge-ort.  In particular,
     fast-rebase takes advantage of the separation of the merging
     operation from the updating of the index and working tree, to
     allow it to pick N commits, but only update the index and working
     tree once at the end.  Look for the calls to
     merge_incore_nonrecursive() and merge_switch_to_result().

  2) Provide a convenient benchmark that isn't polluted by the heavy
     disk writing and forking of unnecessary processes that comes from
     sequencer.c and merge-recursive.c.  fast-rebase is not meant to
     replace sequencer.c, just give ideas on how sequencer.c can be
     changed.  Updating sequencer.c with these goals is probably a
     large amount of work; writing a simple targeted command with
     no documentation, less-than-useful help messages, numerous
     limitations in terms of flags it can accept and situations it can
     handle, and which is flagged off from users is a much easier
     interim step.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile                    |   1 +
 t/helper/test-fast-rebase.c | 211 ++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 4 files changed, 214 insertions(+)
 create mode 100644 t/helper/test-fast-rebase.c

diff --git a/Makefile b/Makefile
index 382fe73c76..24b9fecc0f 100644
--- a/Makefile
+++ b/Makefile
@@ -704,6 +704,7 @@ TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
+TEST_BUILTINS_OBJS += test-fast-rebase.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
new file mode 100644
index 0000000000..373212256a
--- /dev/null
+++ b/t/helper/test-fast-rebase.c
@@ -0,0 +1,211 @@
+/*
+ * "git fast-rebase" builtin command
+ *
+ * FAST: Forking Any Subprocesses (is) Taboo
+ *
+ * This is meant SOLELY as a demo of what is possible.  sequencer.c and
+ * rebase.c should be refactored to use the ideas here, rather than attempting
+ * to extend this file to replace those (unless Phillip or Dscho say that
+ * refactoring is too hard and we need a clean slate, but I'm guessing that
+ * refactoring is the better route).
+ */
+
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
+#include "test-tool.h"
+
+#include "cache-tree.h"
+#include "commit.h"
+#include "lockfile.h"
+#include "merge-ort.h"
+#include "refs.h"
+#include "revision.h"
+#include "sequencer.h"
+#include "strvec.h"
+#include "tree.h"
+
+static const char *short_commit_name(struct commit *commit)
+{
+	return find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV);
+}
+
+static struct commit *peel_committish(const char *name)
+{
+	struct object *obj;
+	struct object_id oid;
+
+	if (get_oid(name, &oid))
+		return NULL;
+	obj = parse_object(the_repository, &oid);
+	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
+}
+
+static char *get_author(const char *message)
+{
+	size_t len;
+	const char *a;
+
+	a = find_commit_header(message, "author", &len);
+	if (a)
+		return xmemdupz(a, len);
+
+	return NULL;
+}
+
+static struct commit *create_commit(struct tree *tree,
+				    struct commit *based_on,
+				    struct commit *parent)
+{
+	struct object_id ret;
+	struct object *obj;
+	struct commit_list *parents = NULL;
+	char *author;
+	char *sign_commit = NULL;
+	struct commit_extra_header *extra;
+	struct strbuf msg = STRBUF_INIT;
+	const char *out_enc = get_commit_output_encoding();
+	const char *message = logmsg_reencode(based_on, NULL, out_enc);
+	const char *orig_message = NULL;
+	const char *exclude_gpgsig[] = { "gpgsig", NULL };
+
+	commit_list_insert(parent, &parents);
+	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
+	find_commit_subject(message, &orig_message);
+	strbuf_addstr(&msg, orig_message);
+	author = get_author(message);
+	reset_ident_date();
+	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
+				 &ret, author, NULL, sign_commit, extra)) {
+		error(_("failed to write commit object"));
+		return NULL;
+	}
+	free(author);
+	strbuf_release(&msg);
+
+	obj = parse_object(the_repository, &ret);
+	return (struct commit *)obj;
+}
+
+int cmd__fast_rebase(int argc, const char **argv)
+{
+	struct commit *onto;
+	struct commit *last_commit = NULL, *last_picked_commit = NULL;
+	struct object_id head;
+	struct lock_file lock = LOCK_INIT;
+	int clean = 1;
+	struct strvec rev_walk_args = STRVEC_INIT;
+	struct rev_info revs;
+	struct commit *commit;
+	struct merge_options merge_opt;
+	struct tree *next_tree, *base_tree, *head_tree;
+	struct merge_result result;
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf branch_name = STRBUF_INIT;
+
+	/*
+	 * test-tool stuff doesn't set up the git directory by default; need to
+	 * do that manually.
+	 */
+	setup_git_directory();
+
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		printf("Sorry, I am not a psychiatrist; I can not give you the help you need.  Oh, you meant usage...\n");
+		exit(129);
+	}
+
+	if (argc != 5 || strcmp(argv[1], "--onto"))
+		die("usage: read the code, figure out how to use it, then do so");
+
+	onto = peel_committish(argv[2]);
+	strbuf_addf(&branch_name, "refs/heads/%s", argv[4]);
+
+	/* Sanity check */
+	if (get_oid("HEAD", &head))
+		die(_("Cannot read HEAD"));
+	assert(oideq(&onto->object.oid, &head));
+
+	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	assert(repo_read_index(the_repository) >= 0);
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	revs.verbose_header = 1;
+	revs.max_parents = 1;
+	revs.cherry_mark = 1;
+	revs.limited = 1;
+	revs.reverse = 1;
+	revs.right_only = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+	strvec_pushl(&rev_walk_args, "", argv[4], "--not", argv[3], NULL);
+
+	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1)
+		return error(_("unhandled options"));
+
+	strvec_clear(&rev_walk_args);
+
+	if (prepare_revision_walk(&revs) < 0)
+		return error(_("error preparing revisions"));
+
+	init_merge_options(&merge_opt, the_repository);
+	memset(&result, 0, sizeof(result));
+	merge_opt.show_rename_progress = 1;
+	merge_opt.branch1 = "HEAD";
+	head_tree = get_commit_tree(onto);
+	result.tree = head_tree;
+	last_commit = onto;
+	while ((commit = get_revision(&revs))) {
+		struct commit *base;
+
+		fprintf(stderr, "Rebasing %s...\r",
+			oid_to_hex(&commit->object.oid));
+		assert(commit->parents && !commit->parents->next);
+		base = commit->parents->item;
+
+		next_tree = get_commit_tree(commit);
+		base_tree = get_commit_tree(base);
+
+		merge_opt.branch2 = short_commit_name(commit);
+		merge_opt.ancestor = xstrfmt("parent of %s", merge_opt.branch2);
+
+		merge_incore_nonrecursive(&merge_opt,
+					  base_tree,
+					  result.tree,
+					  next_tree,
+					  &result);
+
+		free((char*)merge_opt.ancestor);
+		merge_opt.ancestor = NULL;
+		if (!result.clean)
+			die("Aborting: Hit a conflict and restarting is not implemented.");
+		last_picked_commit = commit;
+		last_commit = create_commit(result.tree, commit, last_commit);
+	}
+	fprintf(stderr, "\nDone.\n");
+	/* TODO: There should be some kind of rev_info_free(&revs) call... */
+	memset(&revs, 0, sizeof(revs));
+
+	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
+
+	if (result.clean < 0)
+		exit(128);
+
+	strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
+		    oid_to_hex(&last_picked_commit->object.oid),
+		    oid_to_hex(&last_commit->object.oid));
+	if (update_ref(reflog_msg.buf, branch_name.buf,
+		       &last_commit->object.oid,
+		       &last_picked_commit->object.oid,
+		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
+		error(_("could not update %s"), argv[4]);
+		die("Failed to update %s", argv[4]);
+	}
+	if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
+		die(_("unable to update HEAD"));
+	strbuf_release(&reflog_msg);
+	strbuf_release(&branch_name);
+
+	prime_cache_tree(the_repository, the_repository->index, result.tree);
+	if (write_locked_index(&the_index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		die(_("unable to write %s"), get_index_file());
+	return (clean == 0);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a0d3966b29..8bce7db076 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -28,6 +28,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
+	{ "fast-rebase", cmd__fast_rebase },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "hashmap", cmd__hashmap },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 07034d3f38..fd0cafe5ca 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -18,6 +18,7 @@ int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
+int cmd__fast_rebase(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
-- 
gitgitgadget

