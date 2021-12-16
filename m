Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FEC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhLPXdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLPXdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:33:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FABEC061401
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:37 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l7-20020a622507000000b00494608c84a4so445782pfl.6
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kRQvoqd6FdciUAKJa/1x431zFPemKhaFaJF+vKEJYb4=;
        b=G84cRPtcPWe+2XGBtWNYooF1nYkQ4SPvznlhGsR3dhpa/vyTR8fyM7UIVVAJUkYK9Q
         W8iXZu1nEaYGkoApoRoZel2Y+IOxnb2ROGJE0BovCG58CJMFitaoXq7P/kWRwmPUPS/L
         ocBUfmxYAC1OzFGdX25MZ8y06kHmAcI3bXIz1Fr7bQm+jxrUmZ/oYKLnIBsvfQnfU0tT
         oUyHj+z8pqL/J59fxQRVOV1od558yhf0zncXQJ5Lj7+sYD742BSjS5CGw/c1qHhLQC2u
         0KbIog8Q0NSFBkpxW3UXOF5ElG8WFniCdLv5Y8704fr7jhDVGXAZupU22bxAmDMoJ1rN
         EmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kRQvoqd6FdciUAKJa/1x431zFPemKhaFaJF+vKEJYb4=;
        b=iOpyNcVHuqgvnvzqsuhXsjLs8cjNEH/NKtliOQ4ltHhAGsjhNrXfm8Vh+csVqR7OVw
         xtA7ruYJaDecciCkEU9REa92byIHIgXwe1lvIg5C3R5mjaWVfGtJnplac5rg7zon8IPV
         aQ0zS2m/ikOC5Jsp1W4IF/0QmdhGJXMpERJXKmT7jL6BR+hamAjS/NeXcblLJWzIo18p
         hZPWzudb+qqiZH763RkEsN3udE0HXwERjnfx+DfzwrKQKj7tEqcjJFw/12f4I91W9ApS
         DjiaNNokyh9YLlPVRkV1WRaTsij2g24zOwhCrOZ9nhS4XfZLXMwJviEieqfdPepMp8pA
         b7cA==
X-Gm-Message-State: AOAM531GscQ/II6+VcpmlnlGDrA+An8cesHN7yy0o8YmwRIrSSttfnzE
        7v9TLz+foCvW6/xWwhbXt9v11MK4arSE9f6RPEaGlVZybXXfLNT5ayDVELChmJCKPlmvw6/jMUk
        mt+SjHUePTaiy4yarHy2xI3ZWKLbEywZzxDBFRFmq94Q+LEEg3y6ttxqiGYOQ33s=
X-Google-Smtp-Source: ABdhPJydfZPXkyVmVFogFUMxTtDsv+thaihhUREy6WfMrYY90KBIUuZ/Kx0SJ7EdNFy96g9Eg/2GPweERZ2ugA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:52cd:0:b0:49f:a7b8:69ad with SMTP id
 g196-20020a6252cd000000b0049fa7b869admr239827pfb.3.1639697616875; Thu, 16 Dec
 2021 15:33:36 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:33:24 -0800
In-Reply-To: <20211216233324.65126-1-chooglen@google.com>
Message-Id: <20211216233324.65126-6-chooglen@google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com> <20211216233324.65126-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 5/5] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To improve the submodules UX, we would like to teach Git to handle
branches in submodules. Start this process by teaching `git branch` the
--recurse-submodules option so that `git branch --recurse-submodules
topic` will create the "topic" branch in the superproject and its
submodules.

Although this commit does not introduce breaking changes, it is
incompatible with existing --recurse-submodules semantics e.g. `git
checkout` does not recursively checkout the expected branches created by
`git branch` yet. To ensure that the correct set of semantics is used,
this commit introduces a new configuration value,
`submodule.propagateBranches`, which enables submodule branching when
true (defaults to false).

This commit includes changes that allow Git to work with submodules
that are in trees (and not just the index):

* add a submodules_of_tree() helper that gives the relevant
  information of an in-tree submodule (e.g. path and oid) and
  initializes the repository
* add is_tree_submodule_active() by adding a treeish_name parameter to
  is_submodule_active()
* add the "submoduleNotUpdated" advice to advise users to update the
  submodules in their trees

Incidentally, fix an incorrect usage string that combined the 'list'
usage of git branch (-l) with the 'create' usage; this string has been
incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c use
parse_options., 2007-10-07).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |  24 ++-
 Documentation/git-branch.txt       |  11 +-
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 130 +++++++++++++
 branch.h                           |  22 +++
 builtin/branch.c                   |  44 ++++-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  60 ++++++
 submodule-config.h                 |  34 ++++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3207-branch-submodule.sh        | 291 +++++++++++++++++++++++++++++
 14 files changed, 659 insertions(+), 14 deletions(-)
 create mode 100755 t/t3207-branch-submodule.sh

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 063eec2511..adee26fbbb 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -116,6 +116,9 @@ advice.*::
 	submoduleAlternateErrorStrategyDie::
 		Advice shown when a submodule.alternateErrorStrategy option
 		configured to "die" causes a fatal error.
+	submodulesNotUpdated::
+		Advice shown when a user runs a submodule command that fails
+		because `git submodule update --init` was not run.
 	addIgnoredFile::
 		Advice shown if a user attempts to add an ignored file to
 		the index.
diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 61d975745e..61492d09a8 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -59,11 +59,8 @@ submodule.active::
 
 submodule.recurse::
 	A boolean indicating if commands should enable the `--recurse-submodules`
-	option by default.
-	Applies to all commands that support this option
-	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
-	`restore` and `switch`) except `clone` and `ls-files`.
-	Defaults to false.
+	option by default. Defaults to false.
+	+
 	When set to true, it can be deactivated via the
 	`--no-recurse-submodules` option. Note that some Git commands
 	lacking this option may call some of the above commands affected by
@@ -71,6 +68,23 @@ submodule.recurse::
 	`git fetch` but does not have a `--no-recurse-submodules` option.
 	For these commands a workaround is to temporarily change the
 	configuration value by using `git -c submodule.recurse=0`.
+	+
+	The following list shows the commands that accept
+	`--recurse-submodules` and whether they are supported by this
+	setting.
+	* `checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`,
+	`reset`, `restore` and `switch` are always supported.
+	* `clone` and `ls-files` are not supported.
+	* `branch` is supported only if `submodule.propagateBranches` is
+	enabled
+
+submodule.propagateBranches::
+	[EXPERIMENTAL] A boolean that enables branching support when
+	using `--recurse-submodules` or `submodule.recurse=true`.
+	Enabling this will allow certain commands to accept
+	`--recurse-submodules` and certain commands that already accept
+	`--recurse-submodules` will now consider branches.
+	Defaults to false.
 
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 2d52ae396b..435dc2b20e 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,8 @@ SYNOPSIS
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [<start-point>]
+'git branch' [--track [direct|inherit] | --no-track] [-f]
+	[--recurse-submodules] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -235,6 +236,14 @@ how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
 	Do not set up "upstream" configuration, even if the
 	branch.autoSetupMerge configuration variable is set.
 
+--recurse-submodules::
+	THIS OPTION IS EXPERIMENTAL! Causes the current command to
+	recurse into submodules if `submodule.propagateBranches` is
+	enabled. See `submodule.propagateBranches` in
+	linkgit:git-config[1].
+	+
+	Currently, only branch creation is supported.
+
 --set-upstream::
 	As this option had confusing syntax, it is no longer supported.
 	Please use `--track` or `--set-upstream-to` instead.
diff --git a/advice.c b/advice.c
index 1dfc91d176..e00d30254c 100644
--- a/advice.c
+++ b/advice.c
@@ -70,6 +70,7 @@ static struct {
 	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
+	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated", 1 },
 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
 };
diff --git a/advice.h b/advice.h
index 601265fd10..a7521d6087 100644
--- a/advice.h
+++ b/advice.h
@@ -44,6 +44,7 @@ struct string_list;
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+	ADVICE_SUBMODULES_NOT_UPDATED,
 	ADVICE_UPDATE_SPARSE_PATH,
 	ADVICE_WAITING_FOR_EDITOR,
 	ADVICE_SKIPPED_CHERRY_PICKS,
diff --git a/branch.c b/branch.c
index 047d9958fc..78cf5af8e2 100644
--- a/branch.c
+++ b/branch.c
@@ -8,6 +8,8 @@
 #include "sequencer.h"
 #include "commit.h"
 #include "worktree.h"
+#include "submodule-config.h"
+#include "run-command.h"
 
 struct tracking {
 	struct refspec_item spec;
@@ -478,6 +480,134 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
 	setup_tracking(new_ref, real_orig_ref, track, quiet);
 }
 
+/**
+ * Creates a branch in a submodule by calling
+ * create_branches_recursively() in a child process. The child process
+ * is necessary because install_branch_config() (and its variants) do
+ * not support writing configs to submodules.
+ */
+static int submodule_create_branch(struct repository *r,
+				   const struct submodule *submodule,
+				   const char *name, const char *start_oid,
+				   const char *start_name, int force,
+				   int reflog, int quiet,
+				   enum branch_track track, int dry_run)
+{
+	int ret = 0;
+	struct child_process child = CHILD_PROCESS_INIT;
+	struct strbuf child_err = STRBUF_INIT;
+	struct strbuf out_buf = STRBUF_INIT;
+	char *out_prefix = xstrfmt("submodule '%s': ", submodule->name);
+	child.git_cmd = 1;
+	child.err = -1;
+	child.stdout_to_stderr = 1;
+
+	prepare_other_repo_env(&child.env_array, r->gitdir);
+	strvec_pushl(&child.args, "submodule--helper", "create-branch", NULL);
+	if (dry_run)
+		strvec_push(&child.args, "--dry-run");
+	if (force)
+		strvec_push(&child.args, "--force");
+	if (quiet)
+		strvec_push(&child.args, "--quiet");
+	if (reflog)
+		strvec_push(&child.args, "--create-reflog");
+	if (track == BRANCH_TRACK_ALWAYS || track == BRANCH_TRACK_EXPLICIT)
+		strvec_push(&child.args, "--track");
+
+	strvec_pushl(&child.args, name, start_oid, start_name, NULL);
+
+	if ((ret = start_command(&child)))
+		return ret;
+	ret = finish_command(&child);
+	strbuf_read(&child_err, child.err, 0);
+	strbuf_add_lines(&out_buf, out_prefix, child_err.buf, child_err.len);
+
+	if (ret)
+		fprintf(stderr, "%s", out_buf.buf);
+	else
+		printf("%s", out_buf.buf);
+
+	strbuf_release(&child_err);
+	strbuf_release(&out_buf);
+	return ret;
+}
+
+void create_branches_recursively(struct repository *r, const char *name,
+				 const char *start_name,
+				 const char *tracking_name, int force,
+				 int reflog, int quiet, enum branch_track track,
+				 int dry_run)
+{
+	int i = 0;
+	char *branch_point = NULL;
+	struct object_id super_oid;
+	struct submodule_entry_list submodule_entry_list;
+
+	/* Perform dwim on start_name to get super_oid and branch_point. */
+	dwim_branch_start(r, start_name, BRANCH_TRACK_NEVER, &branch_point,
+			  &super_oid);
+
+	/*
+	 * If we were not given an explicit name to track, then assume we are at
+	 * the top level and, just like the non-recursive case, the tracking
+	 * name is the branch point.
+	 */
+	if (!tracking_name)
+		tracking_name = branch_point;
+
+	submodules_of_tree(r, &super_oid, &submodule_entry_list);
+	/*
+	 * Before creating any branches, first check that the branch can
+	 * be created in every submodule.
+	 */
+	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
+		if (submodule_entry_list.entries[i].repo == NULL) {
+			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
+				advise(_("You may try updating the submodules using 'git checkout %s && git submodule update --init'"),
+				       start_name);
+			die(_("submodule '%s': unable to find submodule"),
+			    submodule_entry_list.entries[i].submodule->name);
+		}
+
+		if (submodule_create_branch(
+			    submodule_entry_list.entries[i].repo,
+			    submodule_entry_list.entries[i].submodule, name,
+			    oid_to_hex(&submodule_entry_list.entries[i]
+						.name_entry->oid),
+			    tracking_name, force, reflog, quiet, track, 1))
+			die(_("submodule '%s': cannot create branch '%s'"),
+			    submodule_entry_list.entries[i].submodule->name,
+			    name);
+	}
+
+	create_branch(the_repository, name, start_name, force, 0, reflog, quiet,
+		      BRANCH_TRACK_NEVER, dry_run);
+	if (dry_run)
+		return;
+	/*
+	 * NEEDSWORK If tracking was set up in the superproject but not the
+	 * submodule, users might expect "git branch --recurse-submodules" to
+	 * fail or give a warning, but this is not yet implemented because it is
+	 * tedious to determine whether or not tracking was set up in the
+	 * superproject.
+	 */
+	setup_tracking(name, tracking_name, track, quiet);
+
+	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
+		if (submodule_create_branch(
+			    submodule_entry_list.entries[i].repo,
+			    submodule_entry_list.entries[i].submodule, name,
+			    oid_to_hex(&submodule_entry_list.entries[i]
+						.name_entry->oid),
+			    tracking_name, force, reflog, quiet, track, 0))
+			die(_("submodule '%s': cannot create branch '%s'"),
+			    submodule_entry_list.entries[i].submodule->name,
+			    name);
+		repo_clear(submodule_entry_list.entries[i].repo);
+	}
+}
+
 void remove_merge_branch_state(struct repository *r)
 {
 	unlink(git_path_merge_head(r));
diff --git a/branch.h b/branch.h
index 8009266343..63448e4278 100644
--- a/branch.h
+++ b/branch.h
@@ -69,6 +69,28 @@ void create_branch(struct repository *r, const char *name,
 		   const char *start_name, int force, int clobber_head_ok,
 		   int reflog, int quiet, enum branch_track track, int dry_run);
 
+/*
+ * Creates a new branch in repository and its submodules (and its
+ * submodules, recursively). Besides these exceptions, the parameters
+ * function identically to create_branch():
+ *
+ * - start_name is the name of the ref, in repository r, that the new
+ *   branch should start from. In submodules, branches will start from
+ *   the respective gitlink commit ids in start_name's tree.
+ *
+ * - tracking_name is the name used of the ref that will be used to set
+ *   up tracking, e.g. origin/main. This is propagated to submodules so
+ *   that tracking information will appear as if the branch branched off
+ *   tracking_name instead of start_name (which is a plain commit id for
+ *   submodules). If omitted, start_name is used for tracking (just like
+ *   create_branch()).
+ *
+ */
+void create_branches_recursively(struct repository *r, const char *name,
+				 const char *start_name,
+				 const char *tracking_name, int force,
+				 int reflog, int quiet, enum branch_track track,
+				 int dry_run);
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index 6c0069bf00..47155e126f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -27,7 +27,8 @@
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
-	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
+	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
+	N_("git branch [<options>] [-l] [<pattern>...]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
@@ -38,6 +39,8 @@ static const char * const builtin_branch_usage[] = {
 
 static const char *head;
 static struct object_id head_oid;
+static int recurse_submodules = 0;
+static int submodule_propagate_branches = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -99,6 +102,15 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, branch_colors[slot]);
 	}
+	if (!strcmp(var, "submodule.recurse")) {
+		recurse_submodules = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcasecmp(var, "submodule.propagateBranches")) {
+		submodule_propagate_branches = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_color_default_config(var, value, cb);
 }
 
@@ -627,7 +639,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
-	int reflog = 0, quiet = 0, icase = 0, force = 0;
+	int reflog = 0, quiet = 0, icase = 0, force = 0,
+	    recurse_submodules_explicit = 0;
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting;
@@ -678,6 +691,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
@@ -720,6 +734,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (recurse_submodules_explicit) {
+		if (!submodule_propagate_branches)
+			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
+		if (noncreate_actions)
+			die(_("--recurse-submodules can only be used to create branches"));
+	}
+
+	recurse_submodules =
+		(recurse_submodules || recurse_submodules_explicit) &&
+		submodule_propagate_branches;
+
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
 	filter.ignore_case = icase;
@@ -858,6 +883,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
+		const char *branch_name = argv[0];
+		const char *start_name = argc == 2 ? argv[1] : head;
+
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
@@ -865,10 +893,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
-		create_branch(the_repository,
-			      argv[0], (argc == 2) ? argv[1] : head,
-			      force, 0, reflog, quiet, track, 0);
-
+		if (recurse_submodules) {
+			create_branches_recursively(the_repository, branch_name,
+						    start_name, NULL, force,
+						    reflog, quiet, track, 0);
+			return 0;
+		}
+		create_branch(the_repository, branch_name, start_name, force, 0,
+			      reflog, quiet, track, 0);
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6a66c8363c..cc9a2bdbaf 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,6 +20,7 @@
 #include "diff.h"
 #include "object-store.h"
 #include "advice.h"
+#include "branch.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -2995,6 +2996,42 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
+static int module_create_branch(int argc, const char **argv, const char *prefix)
+{
+	enum branch_track track;
+	int quiet = 0, force = 0, reflog = 0, dry_run = 0;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("print only error messages")),
+		OPT__FORCE(&force, N_("force creation"), 0),
+		OPT_BOOL(0, "create-reflog", &reflog,
+			 N_("create the branch's reflog")),
+		OPT_SET_INT('t', "track", &track,
+			    N_("set up tracking mode (see git-pull(1))"),
+			    BRANCH_TRACK_EXPLICIT),
+		OPT__DRY_RUN(&dry_run,
+			     N_("show whether the branch would be created")),
+		OPT_END()
+	};
+	const char *const usage[] = {
+		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start_oid> <start_name>"),
+		NULL
+	};
+
+	git_config(git_default_config, NULL);
+	track = git_branch_track;
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (argc != 3)
+		usage_with_options(usage, options);
+
+	if (!quiet && !dry_run)
+		printf_ln(_("creating branch '%s'"), argv[0]);
+
+	create_branches_recursively(the_repository, argv[0], argv[1], argv[2],
+				    force, reflog, quiet, track, dry_run);
+	return 0;
+}
 struct add_data {
 	const char *prefix;
 	const char *branch;
@@ -3401,6 +3438,7 @@ static struct cmd_struct commands[] = {
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
 	{"set-branch", module_set_branch, 0},
+	{"create-branch", module_create_branch, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/submodule-config.c b/submodule-config.c
index f95344028b..24b8d1a700 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "object-store.h"
 #include "parse-options.h"
+#include "tree-walk.h"
 
 /*
  * submodule cache lookup structure
@@ -726,6 +727,65 @@ const struct submodule *submodule_from_path(struct repository *r,
 	return config_from(r->submodule_cache, treeish_name, path, lookup_path);
 }
 
+/**
+ * Used internally by submodules_of_tree(). Recurses into 'treeish_name'
+ * and appends submodule entries to 'out'. The submodule_cache expects
+ * a root-level treeish_name and paths, so keep track of these values
+ * with 'root_tree' and 'prefix'.
+ */
+static void traverse_tree_submodules(struct repository *r,
+				     const struct object_id *root_tree,
+				     char *prefix,
+				     const struct object_id *treeish_name,
+				     struct submodule_entry_list *out)
+{
+	struct tree_desc tree;
+	struct submodule_tree_entry *st_entry;
+	struct name_entry *name_entry;
+	char *tree_path = NULL;
+
+	name_entry = xmalloc(sizeof(*name_entry));
+
+	fill_tree_descriptor(r, &tree, treeish_name);
+	while (tree_entry(&tree, name_entry)) {
+		if (prefix)
+			tree_path =
+				mkpathdup("%s/%s", prefix, name_entry->path);
+		else
+			tree_path = xstrdup(name_entry->path);
+
+		if (S_ISGITLINK(name_entry->mode) &&
+		    is_tree_submodule_active(r, root_tree, tree_path)) {
+			st_entry = xmalloc(sizeof(*st_entry));
+			st_entry->name_entry = name_entry;
+			st_entry->submodule =
+				submodule_from_path(r, root_tree, tree_path);
+			st_entry->repo = xmalloc(sizeof(*st_entry->repo));
+			if (repo_submodule_init(st_entry->repo, r, tree_path,
+						root_tree))
+				FREE_AND_NULL(st_entry->repo);
+
+			ALLOC_GROW(out->entries, out->entry_nr + 1,
+				   out->entry_alloc);
+			out->entries[out->entry_nr++] = *st_entry;
+		} else if (S_ISDIR(name_entry->mode))
+			traverse_tree_submodules(r, root_tree, tree_path,
+						 &name_entry->oid, out);
+		free(tree_path);
+	}
+}
+
+void submodules_of_tree(struct repository *r,
+			const struct object_id *treeish_name,
+			struct submodule_entry_list *out)
+{
+	CALLOC_ARRAY(out->entries, 0);
+	out->entry_nr = 0;
+	out->entry_alloc = 0;
+
+	traverse_tree_submodules(r, treeish_name, NULL, treeish_name, out);
+}
+
 void submodule_free(struct repository *r)
 {
 	if (r->submodule_cache)
diff --git a/submodule-config.h b/submodule-config.h
index 65875b94ea..fa229a8b97 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -6,6 +6,7 @@
 #include "hashmap.h"
 #include "submodule.h"
 #include "strbuf.h"
+#include "tree-walk.h"
 
 /**
  * The submodule config cache API allows to read submodule
@@ -101,4 +102,37 @@ int check_submodule_name(const char *name);
 void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
 void update_clone_config_from_gitmodules(int *max_jobs);
 
+/*
+ * Submodule entry that contains relevant information about a
+ * submodule in a tree.
+ */
+struct submodule_tree_entry {
+	/* The submodule's tree entry. */
+	struct name_entry *name_entry;
+	/*
+	 * A struct repository corresponding to the submodule. May be
+	 * NULL if the submodule has not been updated.
+	 */
+	struct repository *repo;
+	/*
+	 * A struct submodule containing the submodule config in the
+	 * tree's .gitmodules.
+	 */
+	const struct submodule *submodule;
+};
+
+struct submodule_entry_list {
+	struct submodule_tree_entry *entries;
+	int entry_nr;
+	int entry_alloc;
+};
+
+/**
+ * Given a treeish, return all submodules in the tree and its subtrees,
+ * but excluding nested submodules. Callers that require nested
+ * submodules are expected to recurse into the submodules themselves.
+ */
+void submodules_of_tree(struct repository *r,
+			const struct object_id *treeish_name,
+			struct submodule_entry_list *ret);
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index ad95cdda07..95af84347d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -267,7 +267,9 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
  * ie, the config looks like: "[submodule] active\n".
  * Since that is an invalid pathspec, we should inform the user.
  */
-int is_submodule_active(struct repository *repo, const char *path)
+int is_tree_submodule_active(struct repository *repo,
+			     const struct object_id *treeish_name,
+			     const char *path)
 {
 	int ret = 0;
 	char *key = NULL;
@@ -275,7 +277,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 	const struct string_list *sl;
 	const struct submodule *module;
 
-	module = submodule_from_path(repo, null_oid(), path);
+	module = submodule_from_path(repo, treeish_name, path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -317,6 +319,11 @@ int is_submodule_active(struct repository *repo, const char *path)
 	return ret;
 }
 
+int is_submodule_active(struct repository *repo, const char *path)
+{
+	return is_tree_submodule_active(repo, null_oid(), path);
+}
+
 int is_submodule_populated_gently(const char *path, int *return_error_code)
 {
 	int ret = 0;
diff --git a/submodule.h b/submodule.h
index 6bd2c99fd9..784ceffc0e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -54,6 +54,9 @@ int git_default_submodule_config(const char *var, const char *value, void *cb);
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
+int is_tree_submodule_active(struct repository *repo,
+			     const struct object_id *treeish_name,
+			     const char *path);
 int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
new file mode 100755
index 0000000000..0407220f5c
--- /dev/null
+++ b/t/t3207-branch-submodule.sh
@@ -0,0 +1,291 @@
+#!/bin/sh
+
+test_description='git branch submodule tests'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup superproject and submodule' '
+	git init super &&
+	test_commit foo &&
+	git init sub-sub-upstream &&
+	test_commit -C sub-sub-upstream foo &&
+	git init sub-upstream &&
+	# Submodule in a submodule
+	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream" sub-sub &&
+	git -C sub-upstream commit -m "add submodule" &&
+	# Regular submodule
+	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
+	# Submodule in a subdirectory
+	git -C super submodule add "$TRASH_DIRECTORY/sub-sub-upstream" second/sub &&
+	git -C super commit -m "add submodule" &&
+	git -C super config submodule.propagateBranches true &&
+	git -C super/sub submodule update --init
+'
+
+CLEANUP_SCRIPT_PATH="$TRASH_DIRECTORY/cleanup_branches.sh"
+
+cat >"$CLEANUP_SCRIPT_PATH" <<'EOF'
+	#!/bin/sh
+
+	super_dir="$1"
+	shift
+	(
+		cd "$super_dir" &&
+		git checkout main &&
+		for branch_name in "$@"; do
+			git branch -D "$branch_name"
+			git submodule foreach "$TRASH_DIRECTORY/cleanup_branches.sh . $branch_name || true"
+		done
+	)
+EOF
+chmod +x "$CLEANUP_SCRIPT_PATH"
+
+cleanup_branches() {
+	TRASH_DIRECTORY="\"$TRASH_DIRECTORY\"" "$CLEANUP_SCRIPT_PATH" "$@"
+} >/dev/null 2>/dev/null
+
+# Test the argument parsing
+test_expect_success '--recurse-submodules should create branches' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		git rev-parse branch-a &&
+		git -C sub rev-parse branch-a &&
+		git -C sub/sub-sub rev-parse branch-a &&
+		git -C second/sub rev-parse branch-a
+	)
+'
+
+test_expect_success '--recurse-submodules should die if submodule.propagateBranches is false' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		echo "fatal: branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled" >expected &&
+		test_must_fail git -c submodule.propagateBranches=false branch --recurse-submodules branch-a 2>actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success '--recurse-submodules should fail when not creating branches' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		test_must_fail git branch --recurse-submodules -D branch-a &&
+		# Assert that the branches were not deleted
+		git rev-parse --abbrev-ref branch-a &&
+		git -C sub rev-parse --abbrev-ref branch-a
+	)
+'
+
+test_expect_success 'should respect submodule.recurse when creating branches' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git -c submodule.recurse=true branch branch-a &&
+		git rev-parse --abbrev-ref branch-a &&
+		git -C sub rev-parse --abbrev-ref branch-a
+	)
+'
+
+test_expect_success 'should ignore submodule.recurse when not creating branches' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		git -c submodule.recurse=true branch -D branch-a &&
+		test_must_fail git rev-parse --abbrev-ref branch-a &&
+		git -C sub rev-parse --abbrev-ref branch-a
+	)
+'
+
+# Test branch creation behavior
+test_expect_success 'should create branches based off commit id in superproject' '
+	test_when_finished "cleanup_branches super branch-a branch-b" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		git checkout --recurse-submodules branch-a &&
+		git -C sub rev-parse HEAD >expected &&
+		# Move the tip of sub:branch-a so that it no longer matches the commit in super:branch-a
+		git -C sub checkout branch-a &&
+		test_commit -C sub bar &&
+		# Create a new branch-b branch with start-point=branch-a
+		git branch --recurse-submodules branch-b branch-a &&
+		git rev-parse branch-b &&
+		git -C sub rev-parse branch-b >actual &&
+		# Assert that the commit id of sub:second-branch matches super:branch-a and not sub:branch-a
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'should not create any branches if branch is not valid for all repos' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git -C sub branch branch-a &&
+		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
+		test_must_fail git rev-parse branch-a &&
+
+		cat >expected <<-EOF &&
+		submodule ${SQ}sub${SQ}: fatal: a branch named ${SQ}branch-a${SQ} already exists
+		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-a${SQ}
+		EOF
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'should create branches if branch exists and --force is given' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git -C sub rev-parse HEAD >expected &&
+		test_commit -C sub baz &&
+		git -C sub branch branch-a HEAD~1 &&
+		git branch --recurse-submodules --force branch-a &&
+		git rev-parse branch-a &&
+		# assert that sub:branch-a was moved
+		git -C sub rev-parse branch-a >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'should create branch when submodule is not in HEAD:.gitmodules' '
+	test_when_finished "cleanup_branches super branch-a branch-b branch-c" &&
+	(
+		cd super &&
+		git branch branch-a &&
+		git checkout -b branch-b &&
+		git submodule add ../sub-upstream sub2 &&
+		git -C sub2 submodule update --init &&
+		# branch-b now has a committed submodule not in branch-a
+		git commit -m "add second submodule" &&
+		git checkout branch-a &&
+		git branch --recurse-submodules branch-c branch-b &&
+		git rev-parse branch-c &&
+		git -C sub rev-parse branch-c &&
+		git -C second/sub rev-parse branch-c &&
+		git checkout --recurse-submodules branch-c &&
+		git -C sub2 rev-parse branch-c &&
+		git -C sub2/sub-sub rev-parse branch-c
+	)
+'
+
+test_expect_success 'should set up tracking of local branches with track=always' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git -c branch.autoSetupMerge=always branch --recurse-submodules branch-a main &&
+		git -C sub rev-parse main &&
+		test "$(git -C sub config branch.branch-a.remote)" = . &&
+		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/main
+	)
+'
+
+test_expect_success 'should set up tracking of local branches with explicit track' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git branch --track --recurse-submodules branch-a main &&
+		git -C sub rev-parse main &&
+		test "$(git -C sub config branch.branch-a.remote)" = . &&
+		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/main
+	)
+'
+
+test_expect_success 'should not set up unnecessary tracking of local branches' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a main &&
+		git -C sub rev-parse main &&
+		test "$(git -C sub config branch.branch-a.remote)" = "" &&
+		test "$(git -C sub config branch.branch-a.merge)" = ""
+	)
+'
+
+test_expect_success 'should not create branches in inactive submodules' '
+	test_when_finished "cleanup_branches super branch-a" &&
+	test_config -C super submodule.sub.active false &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		git rev-parse branch-a &&
+		test_must_fail git -C sub branch-a
+	)
+'
+
+test_expect_success 'setup remote-tracking tests' '
+	(
+		cd super &&
+		git branch branch-a &&
+		git checkout -b branch-b &&
+		git submodule add ../sub-upstream sub2 &&
+		# branch-b now has a committed submodule not in branch-a
+		git commit -m "add second submodule"
+	) &&
+	git clone --branch main --recurse-submodules super super-clone &&
+	git -C super-clone config submodule.propagateBranches true
+'
+
+test_expect_success 'should not create branch when submodule is not in .git/modules' '
+	# The cleanup needs to delete sub2 separately because main does not have sub2
+	test_when_finished "git -C super-clone/sub2 branch -D branch-b && \
+		git -C super-clone/sub2/sub-sub branch -D branch-b && \
+		cleanup_branches super-clone branch-a branch-b" &&
+	(
+		cd super-clone &&
+		# This should succeed because super-clone has sub.
+		git branch --recurse-submodules branch-a origin/branch-a &&
+		# This should fail because super-clone does not have sub2.
+		test_must_fail git branch --recurse-submodules branch-b origin/branch-b 2>actual &&
+		cat >expected <<-EOF &&
+		hint: You may try updating the submodules using ${SQ}git checkout origin/branch-b && git submodule update --init${SQ}
+		fatal: submodule ${SQ}sub2${SQ}: unable to find submodule
+		EOF
+		test_cmp expected actual &&
+		test_must_fail git rev-parse branch-b &&
+		test_must_fail git -C sub rev-parse branch-b &&
+		# User can fix themselves by initializing the submodule
+		git checkout origin/branch-b &&
+		git submodule update --init --recursive &&
+		git branch --recurse-submodules branch-b origin/branch-b
+	)
+'
+
+test_expect_success 'should set up tracking of remote-tracking branches' '
+	test_when_finished "cleanup_branches super-clone branch-a" &&
+	(
+		cd super-clone &&
+		git branch --recurse-submodules branch-a origin/branch-a &&
+		test "$(git config branch.branch-a.remote)" = origin &&
+		test "$(git config branch.branch-a.merge)" = refs/heads/branch-a &&
+		# "origin/branch-a" does not exist for "sub", but it matches the refspec
+		# so tracking should be set up
+		test "$(git -C sub config branch.branch-a.remote)" = origin &&
+		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/branch-a &&
+		test "$(git -C sub/sub-sub config branch.branch-a.remote)" = origin &&
+		test "$(git -C sub/sub-sub config branch.branch-a.merge)" = refs/heads/branch-a
+	)
+'
+
+test_expect_success 'should not fail when unable to set up tracking in submodule' '
+	test_when_finished "cleanup_branches super-clone branch-a && \
+		git -C super-clone remote rename ex-origin origin" &&
+	(
+		cd super-clone &&
+		git remote rename origin ex-origin &&
+		git branch --recurse-submodules branch-a ex-origin/branch-a &&
+		test "$(git config branch.branch-a.remote)" = ex-origin &&
+		test "$(git config branch.branch-a.merge)" = refs/heads/branch-a &&
+		test "$(git -C sub config branch.branch-a.remote)" = "" &&
+		test "$(git -C sub config branch.branch-a.merge)" = ""
+	)
+'
+
+test_done
-- 
2.33.GIT

