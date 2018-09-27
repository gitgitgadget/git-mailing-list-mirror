Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0847D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeI1EhJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:37:09 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:55082 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1EhI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:37:08 -0400
Received: by mail-it1-f201.google.com with SMTP id m131-v6so416367ita.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7iAfGAhluV/fDoxtFme7u3++pVANjIeCrKMGaHo4F4M=;
        b=lGtQRjz6xIyYsJMgdq4KK+70BmNJWELlbe7JufztvralzGDp1FpPFDu/SlZaQItNmj
         zdKCaQ04GEjE+LALgQ1lcqIjWdpiYrE8BvNysqDC0j+4oxTZSA7EcgtMvv1goDrRpzPk
         N5ViZfjdGfC7UI4BFyQNIU4YNpNRL35mHM/nePHwXXII27/PT58PNQPUrIfELc8ZcfA3
         TgmArlek5tdjmuIQo0FMzcdtP+32fv5AiNS1Q3I6b2jCQ+Cbioi4kDQJtQ2WNybT3tkN
         x4rLvErMjpsxzaYb0RkvAPnkKyx2tmXU36jyilGMMKyKLOLSWfml03HZ7JjlmSMh7+JL
         ABcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7iAfGAhluV/fDoxtFme7u3++pVANjIeCrKMGaHo4F4M=;
        b=Pi4R0Vo8coJc6pb4cBonlu/fRGj5Snck8aW1SX45RUKU83JHPvN/QF1SoQ7xvXJmfS
         3jWZDZW5wEub2NmrxsF13RIopXL/8nTfGFAxbcm3i8aQ5cghqk7giiD7GJ2ofanP4m+o
         xmYIPPWE+/7syxe7OAl/EcKpfKUDv5eMsH2Mj8aZlfsxGMh5iqRjKCUve5aHXlwwfB3U
         DvIiOM87sFgcG+8EYqfmHGG1+3uYiiYOvG2TElu4uqggMVihVTJMxR8xK2dopMvmZogj
         9XHNxaustMkkPt5TDmWqUgM37TQleWGh5Hthg3ILNkQVfE3N5OR3wf/WKJ7/U/32Icow
         u7xg==
X-Gm-Message-State: ABuFfoiUm1bUaKLXtay+OIt8+htkXMJ1jNygvAsPo+5dMxrp7Um6aAB9
        o6qATI09tuBLnI5YVdVLIcfYc3wlcDsKWSF+dRCoJ1Oi2aRIpp/vcFfZz5rVwoEoCaCs/aq7pSp
        GBqwJoMegedmKXArBjb2c/EYK8mrAFMCd/j6kNSJ7T1AMKnz7wNLw8ASl8onP
X-Google-Smtp-Source: ACcGV6156hgrmXOvzAGzC29XCQpB/nnyG9sKhLBoGQ1Q0HFf0frYlpKA2UlIsYSuhXltjzvkn618BI4ZESXE
X-Received: by 2002:a24:4c49:: with SMTP id a70-v6mr8660424itb.3.1538086599081;
 Thu, 27 Sep 2018 15:16:39 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:16:03 -0700
Message-Id: <20180927221603.148025-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] FYI / RFC: submodules: introduce repo-like workflow
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, git-core@google.com
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Internally we have rolled out this as an experiment for
"submodules replacing the repo tool[1]". The repo tool is described as:

    Repo unifies Git repositories when necessary, performs uploads to the
    Gerrit revision control system, and automates parts of the Android
    development workflow. Repo is not meant to replace Git, only to make
    it easier to work with Git in the context of Android. The repo command
    is an executable Python script that you can put anywhere in your path.

    In working with the Android source files, you use Repo for
    across-network operations. For example, with a single Repo command you
    can download files from multiple repositories into your local working
    directory.

    In most situations, you can use Git instead of Repo, or mix Repo and
    Git commands to form complex commands.

[1] https://source.android.com/setup/develop/

Submodules can also be understood as unifying Git repositories, even more,
in the superproject the submodules have relationships between their
versions, which the repo tool only provides in releases.

The repo tool does not provide these relationships between versions, but
all the repositories (in case of Android think of ~1000 git repositories)
are put in their place without depending on each other.

This comes with a couple of advantages and disadvantages:

* Many users are familiar with Git, but not submodules. Each repository
  can be used independently with Git and there is no need to update the
  superproject or the repo manifest for a change in a repository.
* It is easy to work with repositories with no version-control-dependencies
  if there are dependencies in the code. In case of Android the
  repositories are bound at natural boundaries. For example the linux
  kernel is one repository, as then upstream work is made easy for this
  repository. So it is desirable to keep an easy-as-repo workflow.
* Fetching changes ("repo sync") needs to fetch all repositories, as there
  is no central place that tracks what has changed. In a superproject
  git fetch can determine which submodules need fetching.  In Androids
  case the daily change is only in a few repositories (think 10s), so
  migrating to a superproject would save an order of magnitude in fetch
  traffic for daily updates of developers.
* Sometimes when the dependencies are not on a clear repository boundary
  one would like to have git-bisect available across the different
  repositories, which repo cannot provide due to its design.

Internally we have the Gerrit as a central point, where the source of
truth is found for a given repository.

This patch adds a new mode to submodule handling, where the superproject
controls the existence of the submodule (just as current submodule
handling), but the submodule HEAD is not detached, but following the same
branch name as the superproject.

Current situation visualized:

  superproject
  HEAD -> "<branch name>" -> OID
                              |
  submodule                   v
  HEAD --------------------> OID

The OID in the submodule is controlled via the HEAD in the submodule that
is set accordingly to the gitlink in the superproject. Confusion can arise
when the (detached) HEAD in the submodule doesn't match the superprojects
gitlink.

This patch visualized:

  superproject
  HEAD -> "<branch name>" -> OID
                 |
  submodule      v
  HEAD -> "<branch name>" -> OID

As there is a central point of truth in our setup (our Gerrit installation)
which keeps the superproject and the submodule branches in sync, this
ought to look the same for the user; removing the "detached HEAD" in the
submodule. git-status will still notice if there is an OID mismatch between
the gitlink and the submodules branch, but that is a race condition and
should be caught by Gerrit.

This changes the following commands in the superproject:

  checkout -B/-b create branches in subs, too
  checkout (-f): update branch in submodule (create if needed) and check
                 it out; Pass the argument down literally if it is a branch
                 name (e.g. "checkout -f master" will run a
                            "checkout -f master" in the submodule as well)
  clone: see checkout
  reset --hard: see checkout

Change-Id: I69b361e5bd9d57226a0976fd36968cf9aeb52ae0
Signed-off-by: Jonathan Nieder <jrn@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-checkout.txt | 13 +++--
 Makefile                       |  1 +
 branch.c                       | 84 +++++++++++++++++++++++++++++++++
 builtin.h                      |  1 +
 builtin/branch.c               | 35 ++++++++++++++
 builtin/checkout.c             | 76 ++++++++++++++++++++++++------
 builtin/clone.c                | 12 ++++-
 builtin/reset.c                | 41 ++++++++++++++--
 entry.c                        | 43 +++++++++++++----
 git-submodule.sh               | 24 +++++++++-
 git.c                          |  1 +
 submodule-move-head.c          | 81 ++++++++++++++++++++++++++++++++
 submodule-move-head.h          | 22 +++++++++
 submodule.c                    | 14 ++++++
 submodule.h                    |  9 +++-
 t/lib-submodule-update.sh      | 86 +++++++++++++++++++++++++++++++++-
 t/t1013-read-tree-submodule.sh |  1 +
 t/t2013-checkout-submodule.sh  |  4 ++
 t/t7112-reset-submodule.sh     |  5 ++
 unpack-trees.c                 | 20 ++++++--
 unpack-trees.h                 | 10 ++++
 21 files changed, 538 insertions(+), 45 deletions(-)
 create mode 100644 submodule-move-head.c
 create mode 100644 submodule-move-head.h

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9db02928c4..19b0c2a272 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -268,13 +268,12 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	worktree.
 
 --[no-]recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
-	submodules according to the commit recorded in the superproject. If
-	local modifications in a submodule would be overwritten the checkout
-	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
-	is used, the work trees of submodules will not be updated.
-	Just like linkgit:git-submodule[1], this will detach the
-	submodules HEAD.
+	Using --recurse-submodules will update the content and current
+	branch of all initialized submodules in addition to the
+	superproject. If local modifications in a submodule would be
+	overwritten, the checkout will fail unless `-f` is used. If
+	nothing (or --no-recurse-submodules) is used, the work trees of
+	submodules will not be updated.
 
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
diff --git a/Makefile b/Makefile
index 13e1c52478..6824dbcccf 100644
--- a/Makefile
+++ b/Makefile
@@ -975,6 +975,7 @@ LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += submodule-config.o
+LIB_OBJS += submodule-move-head.o
 LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
diff --git a/branch.c b/branch.c
index 776f55fc66..e4538f2b36 100644
--- a/branch.c
+++ b/branch.c
@@ -1,9 +1,13 @@
 #include "git-compat-util.h"
 #include "cache.h"
 #include "config.h"
+#include "repository.h"
+#include "submodule.h"
 #include "branch.h"
 #include "refs.h"
 #include "refspec.h"
+#include "tree-walk.h"
+#include "run-command.h"
 #include "remote.h"
 #include "commit.h"
 #include "worktree.h"
@@ -242,6 +246,76 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
+static void create_branch_in_submodule(const char *name, const char *start_name,
+		   const char *start_ref, const struct object_id *start_oid,
+		   int force, int reflog, int clobber_head,
+		   int quiet, enum branch_track track,
+		   int checking_out_branch,
+		   const char *sub_path, const struct object_id *entry_oid)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	trace_printf("create_branch_in_submodule %s", sub_path);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = sub_path;
+	argv_array_push(&cp.args, "branch--helper");
+	argv_array_pushf(&cp.args, "--name=%s", name);
+	if (checking_out_branch) {
+		argv_array_pushf(&cp.args, "--start_name=%s",
+				 start_ref);
+	} else {
+		argv_array_pushf(&cp.args, "--start_name=%s",
+				 oid_to_hex(entry_oid));
+	}
+	argv_array_pushf(&cp.args, "--force=%d", force);
+	argv_array_pushf(&cp.args, "--reflog=%d", reflog);
+	argv_array_pushf(&cp.args, "--clobber_head=%d", clobber_head);
+	argv_array_pushf(&cp.args, "--quiet=%d", quiet);
+	argv_array_pushf(&cp.args, "--track=%d", track);
+
+	if (run_command(&cp))
+		fprintf(stderr, "process for submodule '%s' failed", sub_path);
+	child_process_clear(&cp);
+}
+
+static void create_branch_in_submodules(const char *name, const char *start_name,
+		   const char *start_ref, const struct object_id *start_oid,
+		   int force, int reflog, int clobber_head,
+		   int quiet, enum branch_track track, struct strbuf *rec_path)
+{
+
+	int checking_out_branch = start_ref && starts_with(start_ref, "refs/heads/");
+	void *buf;
+	struct tree_desc tree;
+	struct name_entry entry;
+	int rec_path_len = rec_path->len;
+
+	buf = fill_tree_descriptor(&tree, start_oid);
+	if (!buf)
+		die("could not read %s for checkout", start_name);
+
+	while (tree_entry(&tree, &entry)) {
+
+		if (rec_path->len > 0)
+			strbuf_addch(rec_path, '/');
+		strbuf_addstr(rec_path, entry.path);
+
+		trace_printf("create_branch_in_submodules %s %o", rec_path->buf, entry.mode);
+
+		if (S_ISGITLINK(entry.mode) && is_submodule_active(the_repository, rec_path->buf))
+			create_branch_in_submodule(name, start_name, start_ref,
+						start_oid, force, reflog, clobber_head,
+						quiet, track, checking_out_branch, rec_path->buf, entry.oid);
+		else if (S_ISDIR(entry.mode)) {
+			create_branch_in_submodules(name, start_name, start_ref, entry.oid, force, reflog, clobber_head, quiet, track, rec_path);
+		}
+		strbuf_setlen(rec_path, rec_path_len);
+	}
+	free(buf);
+}
+
 void create_branch(const char *name, const char *start_name,
 		   int force, int clobber_head_ok, int reflog,
 		   int quiet, enum branch_track track)
@@ -250,6 +324,7 @@ void create_branch(const char *name, const char *start_name,
 	struct object_id oid;
 	char *real_ref;
 	struct strbuf ref = STRBUF_INIT;
+	struct strbuf sub_path = STRBUF_INIT;
 	int forcing = 0;
 	int dont_change_ref = 0;
 	int explicit_tracking = 0;
@@ -307,6 +382,14 @@ void create_branch(const char *name, const char *start_name,
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
 
+	/*
+	 * NEEDSWORK: Doesn't handle errors part-way through very well.
+	 */
+	trace_printf("create_branch need to update subs: %d", should_update_submodules());
+	if (behave_google_repo_like() && should_update_submodules())
+		create_branch_in_submodules(name, start_name, real_ref, &oid,
+					    force, reflog, clobber_head_ok, quiet, track, &sub_path);
+
 	if (!dont_change_ref) {
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
@@ -333,6 +416,7 @@ void create_branch(const char *name, const char *start_name,
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
 	strbuf_release(&ref);
+	strbuf_release(&sub_path);
 	free(real_ref);
 }
 
diff --git a/builtin.h b/builtin.h
index 962f0489ab..31030f248f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -135,6 +135,7 @@ extern int cmd_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_branch_helper(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
diff --git a/builtin/branch.c b/builtin/branch.c
index c396c41533..b6db7ec5bf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -36,6 +36,11 @@ static const char * const builtin_branch_usage[] = {
 	NULL
 };
 
+static const char * const builtin_branch_helper_usage[] = {
+	N_("git branch--helper"),
+	NULL
+};
+
 static const char *head;
 static struct object_id head_oid;
 
@@ -578,6 +583,36 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
+int cmd_branch_helper(int argc, const char **argv, const char *prefix)
+{
+	const char *name = NULL, *start_name = NULL;
+	int force = 0, reflog = 0, clobber_head = 0, quiet = 0;
+	enum branch_track track = BRANCH_TRACK_NEVER;
+
+	struct option options[] = {
+		OPT_STRING(0, "name", &name, N_(""), N_("")),
+		OPT_STRING(0, "start_name", &start_name, N_(""), N_("")),
+
+		OPT_INTEGER(0, "force", &force, N_("")),
+		OPT_INTEGER(0, "reflog", &reflog, N_("")),
+		OPT_INTEGER(0, "clobber_head", &clobber_head, N_("")),
+		OPT_INTEGER(0, "quiet", &quiet, N_("")),
+
+		/* implicit int -> enum conversion */
+		OPT_INTEGER(0, "track", &track, N_("")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_branch_helper_usage, 0);
+	if (argc > 0)
+		die (_("branchhelper doesn't know about %s"), argv[0]);
+
+	create_branch(name, start_name, force, clobber_head, reflog,
+		      quiet, track);
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b30b48767e..054d0ef60e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -3,6 +3,7 @@
 #include "checkout.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "repository.h"
 #include "refs.h"
 #include "object-store.h"
 #include "commit.h"
@@ -22,6 +23,7 @@
 #include "ll-merge.h"
 #include "resolve-undo.h"
 #include "submodule-config.h"
+#include "submodule-move-head.h"
 #include "submodule.h"
 #include "advice.h"
 
@@ -421,11 +423,24 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	strbuf_release(&sb);
 }
 
-static int reset_tree(struct tree *tree, const struct checkout_opts *o,
+struct branch_info {
+	const char *name; /* The short name used */
+	const char *path; /* The full name of a real branch */
+	struct commit *commit; /* The named commit */
+	/*
+	 * if not null the branch is detached because it's already
+	 * checked out in this checkout
+	 */
+	char *checkout;
+};
+
+static int reset_tree(struct branch_info *b, const struct checkout_opts *o,
 		      int worktree, int *writeout_error)
 {
 	struct unpack_trees_options opts;
+	struct submodule_move_head_options move_head_opts;
 	struct tree_desc tree_desc;
+	struct tree *tree = get_commit_tree(b->commit);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
@@ -437,6 +452,16 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+
+	if (behave_google_repo_like()) {
+		opts.move_head = unpack_trees_move_head;
+		memset(&move_head_opts, 0, sizeof(move_head_opts));
+		move_head_opts.force = 1;
+		move_head_opts.new_ref = b->path;
+		move_head_opts.target_ref = o->force_detach ? NULL : b->path;
+		opts.unpack_data = &move_head_opts;
+	}
+
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
@@ -456,17 +481,6 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	}
 }
 
-struct branch_info {
-	const char *name; /* The short name used */
-	const char *path; /* The full name of a real branch */
-	struct commit *commit; /* The named commit */
-	/*
-	 * if not null the branch is detached because it's already
-	 * checked out in this checkout
-	 */
-	char *checkout;
-};
-
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -584,7 +598,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 	resolve_undo_clear();
 	if (opts->force) {
-		ret = reset_tree(get_commit_tree(new_branch_info->commit),
+		ret = reset_tree(new_branch_info,
 				 opts, 1, writeout_error);
 		if (ret)
 			return ret;
@@ -592,6 +606,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		struct tree_desc trees[2];
 		struct tree *tree;
 		struct unpack_trees_options topts;
+		struct submodule_move_head_options mopts;
 
 		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
@@ -607,6 +622,16 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			return 1;
 		}
 
+		if (behave_google_repo_like()) {
+			topts.move_head = unpack_trees_move_head;
+			memset(&mopts, 0, sizeof(mopts));
+			mopts.old_ref = old_branch_info->path;
+			mopts.new_ref = new_branch_info->path;
+			mopts.target_ref = opts->force_detach
+					? NULL : new_branch_info->path;
+			topts.unpack_data = &mopts;
+		}
+
 		/* 2-way merge to the new branch */
 		topts.initial_checkout = is_cache_unborn();
 		topts.update = 1;
@@ -672,7 +697,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+			ret = reset_tree(new_branch_info,
 					 opts, 1,
 					 writeout_error);
 			if (ret)
@@ -687,7 +712,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 					  &result);
 			if (ret < 0)
 				exit(128);
-			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+			ret = reset_tree(new_branch_info,
 					 opts, 0,
 					 writeout_error);
 			strbuf_release(&o.obuf);
@@ -722,6 +747,18 @@ static void report_tracking(struct branch_info *new_branch_info)
 	strbuf_release(&sb);
 }
 
+static void create_symref_in_submodules(const char *symref, const char *target, const char *logmsg)
+{
+	int i = 0;
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+		if (!S_ISGITLINK(ce->ce_mode) || !is_submodule_active(the_repository, ce->name))
+			continue;
+
+		create_symref_in_submodule(ce->name, symref, target, logmsg);
+	}
+}
+
 static void update_refs_for_switch(const struct checkout_opts *opts,
 				   struct branch_info *old_branch_info,
 				   struct branch_info *new_branch_info)
@@ -732,6 +769,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		if (opts->new_orphan_branch) {
 			char *refname;
 
+			if (should_update_submodules())
+				die("--orphan --recurse-submodules is not implemented");
+
 			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
 			if (opts->new_branch_log &&
 			    !should_autocreate_reflog(refname)) {
@@ -784,6 +824,12 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
+		/*
+		 * NEEDSWORK: We don't handle attachment on checkout <branch>
+		 * yet.
+		 */
+		if (opts->new_branch && should_update_submodules() && behave_google_repo_like())
+			create_symref_in_submodules("HEAD", new_branch_info->path, msg.buf);
 		if (create_symref("HEAD", new_branch_info->path, msg.buf) < 0)
 			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
diff --git a/builtin/clone.c b/builtin/clone.c
index 15b142d646..d5936ea1c7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -28,6 +28,7 @@
 #include "run-command.h"
 #include "connected.h"
 #include "packfile.h"
+#include "submodule.h"
 #include "list-objects-filter-options.h"
 #include "object-store.h"
 
@@ -738,7 +739,6 @@ static int checkout(int submodule_progress)
 		if (!starts_with(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
 	}
-	free(head);
 
 	/* We need to be in the new work tree for the checkout */
 	setup_work_tree();
@@ -767,8 +767,17 @@ static int checkout(int submodule_progress)
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
+		const char *branch;
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		if (behave_google_repo_like()) {
+			if (!strcmp(head, "HEAD"))
+				; /* detach HEAD in submodules, too. */
+			else if (skip_prefix(head, "refs/heads/", &branch))
+				argv_array_pushl(&args, "--checkout-branch", branch, NULL);
+			else
+				BUG("HEAD not found below refs/heads!");
+		}
 
 		if (option_shallow_submodules == 1)
 			argv_array_push(&args, "--depth=1");
@@ -786,6 +795,7 @@ static int checkout(int submodule_progress)
 		argv_array_clear(&args);
 	}
 
+	free(head);
 	return err;
 }
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 11cd0dcb8c..9cc8c4db52 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -24,6 +24,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "submodule-move-head.h"
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -42,12 +43,16 @@ static inline int is_merge(void)
 	return !access(git_path_merge_head(the_repository), F_OK);
 }
 
-static int reset_index(const struct object_id *oid, int reset_type, int quiet)
+static int reset_index(const char *rev, const struct object_id *oid, int reset_type, int quiet)
 {
-	int i, nr = 0;
+	int i, nr = 0, flags = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
+	struct submodule_move_head_options mopts;
+	char *current_branch = NULL;
+	struct object_id discard;
+	char *new_ref = NULL;
 	int ret = -1;
 
 	memset(&opts, 0, sizeof(opts));
@@ -65,6 +70,31 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 		break;
 	case HARD:
 		opts.update = 1;
+
+		if (behave_google_repo_like()) {
+			/*
+			 * Submodule handling:
+			 * - unless we are detached, attach HEAD in submodules
+			 * - if rev is a branch name, use that branch instead of oid in
+			 *   submodules.
+			 */
+			current_branch = resolve_refdup("HEAD", 0, NULL, &flags);
+			if (!(flags & REF_ISSYMREF))
+				current_branch = NULL;
+			if (dwim_ref(rev, strlen(rev), &discard, &new_ref) != 1 ||
+			    !starts_with(new_ref, "refs/heads/")) {
+				free(new_ref);
+				new_ref = NULL;
+			}
+
+			opts.move_head = unpack_trees_move_head;
+
+			memset(&mopts, 0, sizeof(mopts));
+			mopts.force = 1;
+			mopts.new_ref = new_ref;
+			mopts.target_ref = current_branch;
+			opts.unpack_data = &mopts;
+		}
 		/* fallthrough */
 	default:
 		opts.reset = 1;
@@ -101,6 +131,8 @@ static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 out:
 	for (i = 0; i < nr; i++)
 		free((void *)desc[i].buffer);
+	free(current_branch);
+	free(new_ref);
 	return ret;
 }
 
@@ -317,6 +349,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		oidcpy(&oid, the_hash_algo->empty_tree);
 	} else if (!pathspec.nr) {
 		struct commit *commit;
+
 		if (get_oid_committish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
 		commit = lookup_commit_reference(the_repository, &oid);
@@ -379,9 +412,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 		} else {
-			int err = reset_index(&oid, reset_type, quiet);
+			int err = reset_index(rev, &oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-				err = reset_index(&oid, MIXED, quiet);
+				err = reset_index(rev, &oid, MIXED, quiet);
 			if (err)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
diff --git a/entry.c b/entry.c
index 5d136c5d55..eee5bc498e 100644
--- a/entry.c
+++ b/entry.c
@@ -2,11 +2,23 @@
 #include "blob.h"
 #include "object-store.h"
 #include "dir.h"
+#include "unpack-trees.h"
 #include "streaming.h"
 #include "submodule.h"
 #include "progress.h"
 #include "fsmonitor.h"
 
+/* NEEDSWORK: share code with unpack-trees.c */
+static int move_head(const struct unpack_trees_options *o, const char *path, const char *old, const char *new, unsigned flags)
+{
+	if (behave_google_repo_like()) {
+		if (!o || !o->move_head)
+			return submodule_move_head(path, old, new, flags);
+		return o->move_head(o, path, old, new, flags);
+	} else
+		return submodule_move_head(path, old, new, flags);
+}
+
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
 {
@@ -251,7 +263,7 @@ int finish_delayed_checkout(struct checkout *state)
 	return errs;
 }
 
-static int write_entry(struct cache_entry *ce,
+static int write_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
@@ -357,7 +369,7 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create submodule directory %s", path);
 		sub = submodule_from_ce(ce);
 		if (sub)
-			return submodule_move_head(ce->name,
+			return move_head(o, ce->name,
 				NULL, oid_to_hex(&ce->oid),
 				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		break;
@@ -435,14 +447,15 @@ static void mark_colliding_entries(const struct checkout *state,
  * its name is returned in topath[], which must be able to hold at
  * least TEMPORARY_FILENAME_LENGTH bytes long.
  */
-int checkout_entry(struct cache_entry *ce,
-		   const struct checkout *state, char *topath)
+int unpack_trees_checkout_entry(struct unpack_trees_options *o,
+				struct cache_entry *ce,
+				const struct checkout *state, char *topath)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
 
 	if (topath)
-		return write_entry(ce, topath, state, 1);
+		return write_entry(o, ce, topath, state, 1);
 
 	strbuf_reset(&path);
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
@@ -466,10 +479,10 @@ int checkout_entry(struct cache_entry *ce,
 				if (!(st.st_mode & S_IFDIR))
 					unlink_or_warn(ce->name);
 
-				return submodule_move_head(ce->name,
+				return move_head(o, ce->name,
 					NULL, oid_to_hex(&ce->oid), 0);
 			} else
-				return submodule_move_head(ce->name,
+				return move_head(o, ce->name,
 					"HEAD", oid_to_hex(&ce->oid),
 					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
@@ -506,5 +519,19 @@ int checkout_entry(struct cache_entry *ce,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
-	return write_entry(ce, path.buf, state, 0);
+	return write_entry(o, ce, path.buf, state, 0);
+}
+
+/*
+ * Write the contents from ce out to the working tree.
+ *
+ * When topath[] is not NULL, instead of writing to the working tree
+ * file named by ce, a temporary file is created by this function and
+ * its name is returned in topath[], which must be able to hold at
+ * least TEMPORARY_FILENAME_LENGTH bytes long.
+ */
+int checkout_entry(struct cache_entry *ce,
+		   const struct checkout *state, char *topath)
+{
+	return unpack_trees_checkout_entry(NULL, ce, state, topath);
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index 1b568e29b9..5e6fcbe06e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -424,6 +424,18 @@ fetch_in_submodule () (
 	esac
 )
 
+# usage: checkout_in_submoodule "$sm_path" "$command" "${branch:-}" "$rev"
+checkout_in_submodule () (
+	sanitize_submodule_env &&
+	cd "$1" &&
+	if test -n "$3"
+	then
+		$2 -B "$3" "$4"
+	else
+		$2 "$4"
+	fi
+)
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -476,6 +488,11 @@ cmd_update()
 		--recursive)
 			recursive=1
 			;;
+		--checkout-branch)
+			update="checkout"
+			checkout_dest=$2
+			shift
+			;;
 		--checkout)
 			update="checkout"
 			;;
@@ -592,6 +609,11 @@ cmd_update()
 				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
 			fi
 
+			if test -n "$checkout_dest" && test "$update_module" != checkout
+			then
+				die "Cannot use --checkout-branch with update mode '$update_module'"
+			fi
+
 			must_die_on_failure=
 			case "$update_module" in
 			checkout)
@@ -621,7 +643,7 @@ cmd_update()
 				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
 			esac
 
-			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
+			if checkout_in_submodule "$sm_path" "$command" "$checkout_dest" "$sha1"
 			then
 				say "$say_msg"
 			elif test -n "$must_die_on_failure"
diff --git a/git.c b/git.c
index a6f4b44af5..3b9c112a36 100644
--- a/git.c
+++ b/git.c
@@ -447,6 +447,7 @@ static struct cmd_struct commands[] = {
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
+	{ "branch--helper", cmd_branch_helper, RUN_SETUP },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
diff --git a/submodule-move-head.c b/submodule-move-head.c
new file mode 100644
index 0000000000..4c8f49066f
--- /dev/null
+++ b/submodule-move-head.c
@@ -0,0 +1,81 @@
+#include "cache.h"
+#include "submodule-move-head.h"
+#include "repository.h"
+#include "submodule.h"
+#include "refs.h"
+#include "unpack-trees.h"
+#include "run-command.h"
+
+void create_symref_in_submodule(const char *path, const char *symref, const char *target, const char *logmsg)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/* NEEDSWORK: What about sub-submodules? */
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = path;
+	argv_array_pushl(&cp.args, "symbolic-ref", "-m", logmsg, symref, target, NULL);
+
+	if (run_command(&cp))
+		die("process for submodule '%s' failed", path);
+}
+
+static void create_ref_in_submodule(const char *path, const char *ref, const char *value)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	/* NEEDSWORK: set a reasonable reflog message. */
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.dir = path;
+	argv_array_pushl(&cp.args, "update-ref", ref, value, sha1_to_hex(null_sha1), NULL);
+
+	if (run_command(&cp))
+		die("process for submodule '%s' failed", path);
+}
+
+static int ref_exists_in_submodule(const char *submodule_path, const char *refname)
+{
+	struct ref_store *refs = get_submodule_ref_store(submodule_path);
+	if (!refs)
+		return 0;
+	return refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL) != NULL;
+}
+
+int unpack_trees_move_head(const struct unpack_trees_options *opt, const char *path, const char *old, const char *new, unsigned flags)
+{
+	struct submodule_move_head_options *o = opt->unpack_data;
+	const char *new_ref = o->new_ref;
+	const char *target_ref = o->target_ref;
+	const char *old_commit = old;
+	const char *new_commit = new;
+
+	/*
+	 * NEEDSWORK:
+	 * - set log message
+	 * - what about sub-submodules?
+	 */
+
+	if (!is_submodule_active(the_repository, path))
+		return 0;
+
+	if (old) {
+		if (o->force)
+			old_commit = "HEAD";
+		else if (o->old_ref && ref_exists_in_submodule(path, o->old_ref))
+			old_commit = o->old_ref;
+	}
+	if (new_ref && new && ref_exists_in_submodule(path, new_ref))
+		new_commit = new_ref;
+
+	if (target_ref)
+		flags |= SUBMODULE_MOVE_HEAD_SKIP_REF_UPDATE;
+	if (submodule_move_head(path, old_commit, new_commit, flags) < 0)
+		return -1;
+	if (new && target_ref && !(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
+		if (!ref_exists_in_submodule(path, target_ref))
+			create_ref_in_submodule(path, target_ref, new);
+		create_symref_in_submodule(path, "HEAD", target_ref, "msg");
+	}
+	return 0;
+}
diff --git a/submodule-move-head.h b/submodule-move-head.h
new file mode 100644
index 0000000000..80e2679038
--- /dev/null
+++ b/submodule-move-head.h
@@ -0,0 +1,22 @@
+#ifndef SUBMODULE_MOVE_HEAD_H
+#define SUBMODULE_MOVE_HEAD_H
+
+struct unpack_trees_options;
+
+/* NEEDSWORK: document */
+struct submodule_move_head_options {
+	int force;
+	const char *old_ref;
+	const char *new_ref;
+	const char *target_ref;
+};
+
+/*
+ * For use as unpack_trees_options.move_head. Parameters should be a
+ * struct submodule_move_head_options * in unpack_trees_options.unpack_data.
+ */
+extern int unpack_trees_move_head(const struct unpack_trees_options *opt, const char *path, const char *old, const char *new, unsigned flags);
+
+extern void create_symref_in_submodule(const char *path, const char *symref, const char *target, const char *logmsg);
+
+#endif /* SUBMODULE_MOVE_HEAD_H */
diff --git a/submodule.c b/submodule.c
index b53cb6e9c4..81eace805f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -30,6 +30,17 @@ static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
 
+int behave_google_repo_like(void)
+{
+	static int google_repo_like = -1;
+
+	if (google_repo_like == -1)
+		git_config_get_bool("submodule.repolike", &google_repo_like);
+
+	return google_repo_like;
+}
+
+
 /*
  * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
  * will be disabled because we can't guess what might be configured in
@@ -1676,6 +1687,9 @@ int submodule_move_head(const char *path,
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (new_head) {
+			if (flags & SUBMODULE_MOVE_HEAD_SKIP_REF_UPDATE)
+				goto out;
+
 			child_process_init(&cp);
 			/* also set the HEAD accordingly */
 			cp.git_cmd = 1;
diff --git a/submodule.h b/submodule.h
index e452919aa4..3346b1a12e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -120,8 +120,11 @@ int push_unpushed_submodules(struct oid_array *commits,
  */
 int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
-#define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
-#define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
+#define SUBMODULE_MOVE_HEAD_DRY_RUN             (1<<0)
+#define SUBMODULE_MOVE_HEAD_FORCE               (1<<1)
+#define SUBMODULE_MOVE_HEAD_SKIP_REF_UPDATE     (1<<2)
+
+/* NULL values for old or new represent the "missing" state. */
 int submodule_move_head(const char *path,
 			const char *old,
 			const char *new_head,
@@ -146,4 +149,6 @@ void absorb_git_dir_into_superproject(const char *prefix,
  */
 const char *get_superproject_working_tree(void);
 
+int behave_google_repo_like(void);
+
 #endif
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 016391723c..71d5b506de 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -657,7 +657,54 @@ test_submodule_recursing_with_args_common() {
 			test_submodule_content sub1 origin/add_sub1
 		)
 	'
-	test_expect_success "$command: submodule branch is not changed, detach HEAD instead" '
+
+	if test "$KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED" = 1
+	then
+		RESULT=failure
+	else
+		RESULT=success
+	fi
+	if test "$KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED" = "read-tree"
+	then
+	test_expect_$RESULT "$command: submodule branch is not changed, detach HEAD" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+			test_must_fail git -C sub1 symbolic-ref HEAD >actual
+		)
+	'
+	elif test "$KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED" = "checkout -B current"
+	then
+	test_expect_$RESULT "$command: submodule branch is changed to 'current'" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+			echo refs/heads/current >expect &&
+			git -C sub1 symbolic-ref HEAD >actual &&
+			test_cmp expect actual
+		)
+	'
+	elif test "$KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED" = "reset"
+	then
+	test_expect_$RESULT "$command: submodule branch is changed to superproject, resetting to target" '
 		prolog &&
 		reset_work_tree_to_interested add_sub1 &&
 		(
@@ -665,14 +712,49 @@ test_submodule_recursing_with_args_common() {
 			git -C sub1 checkout -b keep_branch &&
 			git -C sub1 rev-parse HEAD >expect &&
 			git branch -t modify_sub1 origin/modify_sub1 &&
+			git checkout -b newbranch &&
 			$command modify_sub1 &&
+
+			# we modified the wt
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
+
+			# keep_branch does not change
 			git -C sub1 rev-parse keep_branch >actual &&
 			test_cmp expect actual &&
-			test_must_fail git -C sub1 symbolic-ref HEAD
+
+			# the submodule is attached to the same branch as the superproject
+			git -C sub1 symbolic-ref HEAD >actual &&
+			echo refs/heads/newbranch >expect &&
+			test_cmp expect actual
 		)
 	'
+	else
+	test_expect_$RESULT "$command: submodule branch is changed" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git -C sub1 checkout -b keep_branch &&
+			git -C sub1 rev-parse HEAD >expect &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
+
+			# modified wt
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1 &&
+
+			# unrelated keep_branch is fine
+			git -C sub1 rev-parse keep_branch >actual &&
+			test_cmp expect actual &&
+
+			# submodule ref is checked out
+			git -C sub1 symbolic-ref HEAD >actual &&
+			echo refs/heads/modify_sub1 >expect &&
+			test_cmp expect actual
+		)
+	'
+	fi
 
 	# Replacing a tracked file with a submodule produces a checked out submodule
 	test_expect_success "$command: replace tracked file with submodule checks out submodule" '
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 91a6fafcb4..de59ebd121 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -7,6 +7,7 @@ test_description='read-tree can handle submodules'
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED="read-tree"
 
 test_submodule_switch_recursing_with_args "read-tree -u -m"
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 8f86b5f4b2..940f0fca20 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -66,6 +66,10 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 test_submodule_switch_recursing_with_args "checkout"
 
+KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED="checkout -B current"
+test_submodule_switch_recursing_with_args "checkout -B current"
+unset KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED
+
 test_submodule_forced_switch_recursing_with_args "checkout -f"
 
 test_submodule_switch "git checkout"
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index a1cb9ff858..c31acc6578 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -8,13 +8,18 @@ test_description='reset can handle submodules'
 KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+KNOWN_DIFFERENCE_SUBMODULE_REFS_NOT_UPDATED="reset"
 
+KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED=1
 test_submodule_switch_recursing_with_args "reset --keep"
 
+unset KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED
 test_submodule_forced_switch_recursing_with_args "reset --hard"
 
+KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED=1
 test_submodule_switch "git reset --keep"
 
+unset KNOWN_FAILURE_SUBMODULE_REFS_NOT_UPDATED
 test_submodule_switch "git reset --merge"
 
 test_submodule_forced_switch "git reset --hard"
diff --git a/unpack-trees.c b/unpack-trees.c
index 51bfac6aa0..4d4a85226e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -254,6 +254,16 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		fprintf(stderr, _("Aborting\n"));
 }
 
+static int move_head(const struct unpack_trees_options *o, const char *path, const char *old, const char *new, unsigned flags)
+{
+	if (behave_google_repo_like()) {
+		if (!o->move_head)
+			return submodule_move_head(path, old, new, flags);
+		return o->move_head(o, path, old, new, flags);
+	} else
+		return submodule_move_head(path, old, new, flags);
+}
+
 static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *old_id,
 				     const char *new_id,
@@ -268,7 +278,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 	if (o->reset)
 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
 
-	if (submodule_move_head(ce->name, old_id, new_id, flags))
+	if (move_head(o, ce->name, old_id, new_id, flags))
 		return o->gently ? -1 :
 				   add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
 	return 0;
@@ -304,12 +314,12 @@ static void load_gitmodules_file(struct index_state *index,
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
-static void unlink_entry(const struct cache_entry *ce)
+static void unlink_entry(const struct unpack_trees_options *o, const struct cache_entry *ce)
 {
 	const struct submodule *sub = submodule_from_ce(ce);
 	if (sub) {
 		/* state.force is set at the caller. */
-		submodule_move_head(ce->name, "HEAD", NULL,
+		move_head(o, ce->name, "HEAD", NULL,
 				    SUBMODULE_MOVE_HEAD_FORCE);
 	}
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
@@ -408,7 +418,7 @@ static int check_updates(struct unpack_trees_options *o)
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update && !o->dry_run)
-				unlink_entry(ce);
+				unlink_entry(o, ce);
 		}
 	}
 	remove_marked_cache_entries(index);
@@ -450,7 +460,7 @@ static int check_updates(struct unpack_trees_options *o)
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, &state, NULL);
+				errs |= unpack_trees_checkout_entry(o, ce, &state, NULL);
 			}
 		}
 	}
diff --git a/unpack-trees.h b/unpack-trees.h
index 0135080a7b..3f1a205ad0 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -9,12 +9,15 @@
 #define MAX_UNPACK_TREES 8
 
 struct cache_entry;
+struct tree_desc;
 struct unpack_trees_options;
 struct exclude_list;
 
 typedef int (*merge_fn_t)(const struct cache_entry * const *src,
 		struct unpack_trees_options *options);
 
+typedef int (*submodule_move_head_fn)(const struct unpack_trees_options *o, const char *path, const char *old, const char *new, unsigned flags);
+
 enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
@@ -65,6 +68,7 @@ struct unpack_trees_options {
 	struct dir_struct *dir;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
+	submodule_move_head_fn move_head;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
 	struct argv_array msgs_to_free;
 	/*
@@ -86,6 +90,12 @@ struct unpack_trees_options {
 	struct exclude_list *el; /* for internal use */
 };
 
+/* defined in entry.c, for internal use */
+int unpack_trees_checkout_entry(struct unpack_trees_options *o,
+				struct cache_entry *ce,
+				const struct checkout *state,
+				char *topath);
+
 int unpack_trees(unsigned n, struct tree_desc *t,
 		 struct unpack_trees_options *options);
 
-- 
2.19.0

