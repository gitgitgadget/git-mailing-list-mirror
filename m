Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B756CC55178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A80221FC
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyXqNXCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438054AbgJUNWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437452AbgJUNWo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:22:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892EC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i1so3166760wro.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mVdReK6IljK6KItoeZdc9pBvxXF5d9jZUJhEdnNCf44=;
        b=uyXqNXCHc3VdmkVH3Ca68UbhU1z4XPNYJh4SmlU+TIZmO/WmhxsRkUbRfLr+glUXOJ
         ZbhrOKTruXhRsS72/fQ9GkTC6Ky2Mgyyx0OeONmFbTTUhvKP05qe95E66PH2hJp0PnlS
         KTtJFIN3oNdcbrRRphCzsptMXZysQPK33WrWCKCs63DSHf/GOmi54rtnokcfyjIjRAYn
         RhBW+ZcGBiEo0q4U3na6pXZUQ/8HXBIwFdObgFkzr/8lR/PiY2O+fDVK3m6iyjSUjPCz
         CZo1xFECsVnY34zdKAUIb0fEhs8/EKhcru01IkdHQUNHLdwW3EFpe2445dxFnTahQnlg
         PnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mVdReK6IljK6KItoeZdc9pBvxXF5d9jZUJhEdnNCf44=;
        b=B2PLrFwNjQdld++jITuGIaCelX+Kas8sO/RKoxsPmbCjAnR7kIXYgTM61V0nT5PxO2
         jMYWerhIEYy28n5/qeM8bGxlW09tBPYOq2AN66YWZqw89nkfU337nK2p7ZWDLkH6MxHC
         er+E+v+cAJ+3yZVWv2UQYvuTsPz8uIY5FK+6FeuFCb2viUEss0AaKGtyVurPp9nuXSs/
         AAscnVRMULVWG5qW/sXNIOG6IR8DZ39IIDzRUxZLefbj6UcndbaBTw3RRAdeTdB6Mwie
         bkE4hUfQjJFpPVrKrwX7ujI4TSjFcPh6RK0aTZXWe5q03lIjTv6Fwsiif7e2HzafHkKA
         KGHQ==
X-Gm-Message-State: AOAM531k4cPT3twAquu/AtoBKLJcmBjrgfZvhOo9d/Jz0a5MJOjsWhjN
        V+QTbMBMmOH/0/o3vFhQqLBVPzxkPHk=
X-Google-Smtp-Source: ABdhPJxRxGkQqpg2QT6W4Q49jA3OOHbHTTJjOnM9OOTA/K4SmKLHUpfJDsCHVfhQVgJwqoLi+SNxiQ==
X-Received: by 2002:adf:e80f:: with SMTP id o15mr4891196wrm.308.1603286561634;
        Wed, 21 Oct 2020 06:22:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o140sm3145663wme.43.2020.10.21.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:22:41 -0700 (PDT)
Message-Id: <a1357fb3b309984db000cc8fa212db1d24f7ab4c.1603286556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 13:22:34 +0000
Subject: [PATCH 3/4] fast-rebase: demonstrate merge-ort's API via
 temporary/hidden command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add a special built-in that is only of use to git-developers and only
during the development of merge-ort, and which is designed to
immediately fail and print:
   git: 'fast-rebase' is not a git command
unless a special GIT_TEST_MERGE_ALGORITHM environment variable is set.

This special builtin serves two purposes:

  1) Demonstrate the desired API of merge-ort.  In particular,
     fast-rebase takes advantage of the separation of the merging
     operation from the updating of the index and working tree, to
     allow it to pick N commits, but only update the index and working
     tree once at the end.  Look for the calls to
     merge_inmemory_nonrecursive() and merge_switch_to_result().

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
 Makefile              |   1 +
 builtin.h             |   1 +
 builtin/fast-rebase.c | 210 ++++++++++++++++++++++++++++++++++++++++++
 git.c                 |   1 +
 4 files changed, 213 insertions(+)
 create mode 100644 builtin/fast-rebase.c

diff --git a/Makefile b/Makefile
index 382fe73c76..1b40d780fa 100644
--- a/Makefile
+++ b/Makefile
@@ -1087,6 +1087,7 @@ BUILTIN_OBJS += builtin/difftool.o
 BUILTIN_OBJS += builtin/env--helper.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fast-import.o
+BUILTIN_OBJS += builtin/fast-rebase.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
 BUILTIN_OBJS += builtin/fmt-merge-msg.o
diff --git a/builtin.h b/builtin.h
index 53fb290963..75ff7dc8a9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -151,6 +151,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix);
 int cmd_env__helper(int argc, const char **argv, const char *prefix);
 int cmd_fast_export(int argc, const char **argv, const char *prefix);
 int cmd_fast_import(int argc, const char **argv, const char *prefix);
+int cmd_fast_rebase(int argc, const char **argv, const char *prefix);
 int cmd_fetch(int argc, const char **argv, const char *prefix);
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
diff --git a/builtin/fast-rebase.c b/builtin/fast-rebase.c
new file mode 100644
index 0000000000..ae78a8b1c1
--- /dev/null
+++ b/builtin/fast-rebase.c
@@ -0,0 +1,210 @@
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
+#include "builtin.h"
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
+int cmd_fast_rebase(int argc, const char **argv, const char *prefix)
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
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		printf("Sorry, I am not a psychiatrist; I can not give you the help you need.  Oh, you meant usage...\n");
+		exit(129);
+	}
+
+	if (!getenv("GIT_TEST_MERGE_ALGORITHM")) {
+		fprintf_ln(stderr, _("git: 'fast-rebase' is not a git command. See 'git --help'."));
+		exit(1);
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
+		merge_inmemory_nonrecursive(&merge_opt,
+					    base_tree,
+					    result.tree,
+					    next_tree,
+					    &result);
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
diff --git a/git.c b/git.c
index 4bdcdad2cc..af84f11e69 100644
--- a/git.c
+++ b/git.c
@@ -512,6 +512,7 @@ static struct cmd_struct commands[] = {
 	{ "env--helper", cmd_env__helper },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
+	{ "fast-rebase", cmd_fast_rebase, RUN_SETUP /* | NEED_WORK_TREE */ },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
-- 
gitgitgadget

