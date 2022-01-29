Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25F8C433FE
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 00:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351923AbiA2AFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 19:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351873AbiA2AFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 19:05:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE5C06173B
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so15603012ybk.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PlWPZhVyWCWGwCn6XoGsjUWkIPf4iODqKBrxjLt3YNM=;
        b=TA+m9oe1o6yVbxeIkUPV/bQF6KJWiQefE+C6CD+KEUXAhWW0er373JwsiD3KvSwpbb
         krZcbynnwMkNrTw/fs0VTsdS9NTl3TjV4VmAW0pinGHjvuEtMPaxgdUxgjxfz/W7su4w
         IanbvSS7Endj3KmWxCDsAzDhi5uTtMMDwhbxUwGC8wfKPCFDxs7AixNbHeZVNW4g/Lxs
         NYzd7r1vMoUt7ykg+7yCzY5IbvbycuFG16RjhrIHQwJo9ytGhsAf0DGoxW0mWx2t97dA
         6ONTuJCewM/j58q+aFqX8YmNwUsbYpy55xXzi9B6jHGn+9J3BmMmHBpMaMlL5NyVRxcw
         T12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PlWPZhVyWCWGwCn6XoGsjUWkIPf4iODqKBrxjLt3YNM=;
        b=7X59SkkdJ5LgvfFnlDFd6+O0FYV1qSEdwPbPMlxJEG+eMXNmn4Y8PoZJkLNw98MK5n
         as8w9/5M+G8wb9E5n2lpkJxR+wvRp/26n6qH9vUtoZIE1uXCeo/eocVFPb6ZgUQXreF6
         qHmm1FjLl2ilMcfO0HOJwzedRbDzkypGeYm6+LF+5H5najVBgDrmKiqzgeoQerADJB8T
         g+ly/jBFFfKbtQAR4qmc4gRwpY42yO/xv/yJ+loTOPo3vYJxJOfvXYU/0GozbNoLT5bT
         w6jzFeRHbfbwWYOFyQj/s7yKNsWeef84XF59Ae4DUXR7lZ8A0HmXSvwr+PTk0z+57Q55
         +UHw==
X-Gm-Message-State: AOAM531UanD0F0b8eVOEaiS3DT9tLjUpQhei10seCxVT7f+t/yhS6xTr
        JDQ1uC4Gt2pRuLStL6cpPncSuHpPXJ73VRrrqO/Qkkg7VX5A4sIjWJUurERv8hZslLqExBQvFJ1
        t6Z49FMTjrBevSZkex+gAQ9tCDvyMUFX8nWRSuT8u04B+XFwtWc6hz+X8WmfTSoQ=
X-Google-Smtp-Source: ABdhPJz/aUuJQldU9S1MaJnkgO/vmd8CkxqfOKt+xVXFv4IX9EereHiN+Up0AB12Zg6EmJeH0VVPShl80yhVQw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:154f:: with SMTP id
 r15mr16926565ybu.670.1643414707696; Fri, 28 Jan 2022 16:05:07 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:04:45 -0800
In-Reply-To: <20220129000446.99261-1-chooglen@google.com>
Message-Id: <20220129000446.99261-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com> <20220129000446.99261-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v8 5/6] branch: add --recurse-submodules option for branch creation
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
branches in submodules. Start this process by teaching "git branch" the
--recurse-submodules option so that "git branch --recurse-submodules
topic" will create the `topic` branch in the superproject and its
submodules.

Although this commit does not introduce breaking changes, it does not
work well with existing --recurse-submodules commands because "git
branch --recurse-submodules" writes to the submodule ref store, but most
commands only consider the superproject gitlink and ignore the submodule
ref store. For example, "git checkout --recurse-submodules" will check
out the commits in the superproject gitlinks (and put the submodules in
detached HEAD) instead of checking out the submodule branches.

Because of this, this commit introduces a new configuration value,
`submodule.propagateBranches`. The plan is for Git commands to
prioritize submodule ref store information over superproject gitlinks if
this value is true. Because "git branch --recurse-submodules" writes to
submodule ref stores, for the sake of clarity, it will not function
unless this configuration value is set.

This commit also includes changes that support working with submodules
from a superproject commit because "branch --recurse-submodules" (and
future commands) need to read .gitmodules and gitlinks from the
superproject commit, but submodules are typically read from the
filesystem's .gitmodules and the index's gitlinks. These changes are:

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

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/advice.txt    |   3 +
 Documentation/config/submodule.txt |  37 ++--
 Documentation/git-branch.txt       |  19 +-
 advice.c                           |   1 +
 advice.h                           |   1 +
 branch.c                           | 141 ++++++++++++++
 branch.h                           |  29 +++
 builtin/branch.c                   |  44 ++++-
 builtin/submodule--helper.c        |  38 ++++
 submodule-config.c                 |  60 ++++++
 submodule-config.h                 |  34 ++++
 submodule.c                        |  11 +-
 submodule.h                        |   3 +
 t/t3207-branch-submodule.sh        | 292 +++++++++++++++++++++++++++++
 14 files changed, 693 insertions(+), 20 deletions(-)
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
index ee454f8126..6490527b45 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -59,18 +59,33 @@ submodule.active::
 
 submodule.recurse::
 	A boolean indicating if commands should enable the `--recurse-submodules`
-	option by default.
-	Applies to all commands that support this option
-	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
-	`restore` and `switch`) except `clone` and `ls-files`.
+	option by default. Defaults to false.
++
+When set to true, it can be deactivated via the
+`--no-recurse-submodules` option. Note that some Git commands
+lacking this option may call some of the above commands affected by
+`submodule.recurse`; for instance `git remote update` will call
+`git fetch` but does not have a `--no-recurse-submodules` option.
+For these commands a workaround is to temporarily change the
+configuration value by using `git -c submodule.recurse=0`.
++
+The following list shows the commands that accept
+`--recurse-submodules` and whether they are supported by this
+setting.
+
+* `checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`,
+`reset`, `restore` and `switch` are always supported.
+* `clone` and `ls-files` are not supported.
+* `branch` is supported only if `submodule.propagateBranches` is
+enabled
+
+submodule.propagateBranches::
+	[EXPERIMENTAL] A boolean that enables branching support when
+	using `--recurse-submodules` or `submodule.recurse=true`.
+	Enabling this will allow certain commands to accept
+	`--recurse-submodules` and certain commands that already accept
+	`--recurse-submodules` will now consider branches.
 	Defaults to false.
-	When set to true, it can be deactivated via the
-	`--no-recurse-submodules` option. Note that some Git commands
-	lacking this option may call some of the above commands affected by
-	`submodule.recurse`; for instance `git remote update` will call
-	`git fetch` but does not have a `--no-recurse-submodules` option.
-	For these commands a workaround is to temporarily change the
-	configuration value by using `git -c submodule.recurse=0`.
 
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c59687a4d9..f526573951 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,8 @@ SYNOPSIS
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track[=(direct|inherit)] | --no-track] [-f] <branchname> [<start-point>]
+'git branch' [--track[=(direct|inherit)] | --no-track] [-f]
+	[--recurse-submodules] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -235,6 +236,22 @@ how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
 	Do not set up "upstream" configuration, even if the
 	branch.autoSetupMerge configuration variable is set.
 
+--recurse-submodules::
+	THIS OPTION IS EXPERIMENTAL! Causes the current command to
+	recurse into submodules if `submodule.propagateBranches` is
+	enabled. See `submodule.propagateBranches` in
+	linkgit:git-config[1]. Currently, only branch creation is
+	supported.
++
+When used in branch creation, a new branch <branchname> will be created
+in the superproject and all of the submodules in the superproject's
+<start-point>. In submodules, the branch will point to the submodule
+commit in the superproject's <start-point> but the branch's tracking
+information will be set up based on the submodule's branches and remotes
+e.g. `git branch --recurse-submodules topic origin/main` will create the
+submodule branch "topic" that points to the submodule commit in the
+superproject's "origin/main", but tracks the submodule's "origin/main".
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
index 02d46a69b8..70026b3c79 100644
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
@@ -483,6 +485,145 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
 	setup_tracking(new_ref, real_orig_ref, track, quiet);
 }
 
+/**
+ * Creates a branch in a submodule by calling
+ * create_branches_recursively() in a child process. The child process
+ * is necessary because install_branch_config_multiple_remotes() (which
+ * is called by setup_tracking()) does not support writing configs to
+ * submodules.
+ */
+static int submodule_create_branch(struct repository *r,
+				   const struct submodule *submodule,
+				   const char *name, const char *start_oid,
+				   const char *tracking_name, int force,
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
+	/*
+	 * submodule_create_branch() is indirectly invoked by "git
+	 * branch", but we cannot invoke "git branch" in the child
+	 * process. "git branch" accepts a branch name and start point,
+	 * where the start point is assumed to provide both the OID
+	 * (start_oid) and the branch to use for tracking
+	 * (tracking_name). But when recursing through submodules,
+	 * start_oid and tracking name need to be specified separately
+	 * (see create_branches_recursively()).
+	 */
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
+	strvec_pushl(&child.args, name, start_oid, tracking_name, NULL);
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
+				 const char *start_commitish,
+				 const char *tracking_name, int force,
+				 int reflog, int quiet, enum branch_track track,
+				 int dry_run)
+{
+	int i = 0;
+	char *branch_point = NULL;
+	struct object_id super_oid;
+	struct submodule_entry_list submodule_entry_list;
+
+	/* Perform dwim on start_commitish to get super_oid and branch_point. */
+	dwim_branch_start(r, start_commitish, BRANCH_TRACK_NEVER,
+			  &branch_point, &super_oid);
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
+				       start_commitish);
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
+	create_branch(the_repository, name, start_commitish, force, 0, reflog, quiet,
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
index 509cfcc34e..04df2aa5b5 100644
--- a/branch.h
+++ b/branch.h
@@ -71,6 +71,35 @@ void create_branch(struct repository *r,
 		   int reflog, int quiet, enum branch_track track,
 		   int dry_run);
 
+/*
+ * Creates a new branch in a repository and its submodules (and its
+ * submodules, recursively). The parameters are mostly analogous to
+ * those of create_branch() except for start_name, which is represented
+ * by two different parameters:
+ *
+ * - start_commitish is the commit-ish, in repository r, that determines
+ *   which commits the branches will point to. The superproject branch
+ *   will point to the commit of start_commitish and the submodule
+ *   branches will point to the gitlink commit oids in start_commitish's
+ *   tree.
+ *
+ * - tracking_name is the name of the ref, in repository r, that will be
+ *   used to set up tracking information. This value is propagated to
+ *   all submodules, which will evaluate the ref using their own ref
+ *   stores. If NULL, this defaults to start_commitish.
+ *
+ * When this function is called on the superproject, start_commitish
+ * can be any user-provided ref and tracking_name can be NULL (similar
+ * to create_branches()). But when recursing through submodules,
+ * start_commitish is the plain gitlink commit oid. Since the oid cannot
+ * be used for tracking information, tracking_name is propagated and
+ * used for tracking instead.
+ */
+void create_branches_recursively(struct repository *r, const char *name,
+				 const char *start_commitish,
+				 const char *tracking_name, int force,
+				 int reflog, int quiet, enum branch_track track,
+				 int dry_run);
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index b352cc789a..1517452060 100644
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
@@ -100,6 +103,15 @@ static int git_branch_config(const char *var, const char *value, void *cb)
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
 
@@ -622,7 +634,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
-	int reflog = 0, quiet = 0, icase = 0, force = 0;
+	int reflog = 0, quiet = 0, icase = 0, force = 0,
+	    recurse_submodules_explicit = 0;
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
@@ -672,6 +685,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
@@ -714,6 +728,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -852,6 +877,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
+		const char *branch_name = argv[0];
+		const char *start_name = argc == 2 ? argv[1] : head;
+
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
@@ -859,10 +887,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
index 6298cbdd4e..eba2a6e9b0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,6 +20,7 @@
 #include "diff.h"
 #include "object-store.h"
 #include "advice.h"
+#include "branch.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -2983,6 +2984,42 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
@@ -3379,6 +3416,7 @@ static struct cmd_struct commands[] = {
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
index f3c99634a9..07ae7c266e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -265,7 +265,9 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
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
@@ -273,7 +275,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 	const struct string_list *sl;
 	const struct submodule *module;
 
-	module = submodule_from_path(repo, null_oid(), path);
+	module = submodule_from_path(repo, treeish_name, path);
 
 	/* early return if there isn't a path->module mapping */
 	if (!module)
@@ -315,6 +317,11 @@ int is_submodule_active(struct repository *repo, const char *path)
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
index 0000000000..6ef2733396
--- /dev/null
+++ b/t/t3207-branch-submodule.sh
@@ -0,0 +1,292 @@
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
+pwd=$(pwd)
+
+# Creates a clean test environment in "pwd" by copying the repo setup
+# from test_dirs.
+reset_test () {
+	rm -fr super &&
+	rm -fr sub-sub-upstream &&
+	rm -fr sub-upstream &&
+	cp -r test_dirs/* .
+}
+
+# Tests that the expected branch does not exist
+test_no_branch () {
+	DIR=$1 &&
+	BRANCH_NAME=$2 &&
+	test_must_fail git -C "$DIR" rev-parse "$BRANCH_NAME" 2>err &&
+	grep "ambiguous argument .$BRANCH_NAME." err
+}
+
+test_expect_success 'setup superproject and submodule' '
+	mkdir test_dirs &&
+	(
+		cd test_dirs &&
+		git init super &&
+		test_commit -C super foo &&
+		git init sub-sub-upstream &&
+		test_commit -C sub-sub-upstream foo &&
+		git init sub-upstream &&
+		# Submodule in a submodule
+		git -C sub-upstream submodule add "${pwd}/test_dirs/sub-sub-upstream" sub-sub &&
+		git -C sub-upstream commit -m "add submodule" &&
+		# Regular submodule
+		git -C super submodule add "${pwd}/test_dirs/sub-upstream" sub &&
+		# Submodule in a subdirectory
+		git -C super submodule add "${pwd}/test_dirs/sub-sub-upstream" second/sub &&
+		git -C super commit -m "add submodule" &&
+		git -C super config submodule.propagateBranches true &&
+		git -C super/sub submodule update --init
+	) &&
+	reset_test
+'
+
+# Test the argument parsing
+test_expect_success '--recurse-submodules should create branches' '
+	test_when_finished "reset_test" &&
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
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		echo "fatal: branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled" >expected &&
+		test_must_fail git -c submodule.propagateBranches=false branch --recurse-submodules branch-a 2>actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success '--recurse-submodules should fail when not creating branches' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		echo "fatal: --recurse-submodules can only be used to create branches" >expected &&
+		test_must_fail git branch --recurse-submodules -D branch-a 2>actual &&
+		test_cmp expected actual &&
+		# Assert that the branches were not deleted
+		git rev-parse branch-a &&
+		git -C sub rev-parse branch-a
+	)
+'
+
+test_expect_success 'should respect submodule.recurse when creating branches' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git -c submodule.recurse=true branch branch-a &&
+		git rev-parse branch-a &&
+		git -C sub rev-parse branch-a
+	)
+'
+
+test_expect_success 'should ignore submodule.recurse when not creating branches' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		git -c submodule.recurse=true branch -D branch-a &&
+		test_no_branch . branch-a &&
+		git -C sub rev-parse branch-a
+	)
+'
+
+# Test branch creation behavior
+test_expect_success 'should create branches based off commit id in superproject' '
+	test_when_finished "reset_test" &&
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
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git -C sub branch branch-a &&
+		test_must_fail git branch --recurse-submodules branch-a 2>actual &&
+		test_no_branch . branch-a &&
+		grep "submodule .sub.: fatal: A branch named .branch-a. already exists" actual
+	)
+'
+
+test_expect_success 'should create branches if branch exists and --force is given' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git -C sub rev-parse HEAD >expected &&
+		test_commit -C sub baz &&
+		# branch-a in sub now points to a newer commit.
+		git -C sub branch branch-a HEAD &&
+		git -C sub rev-parse branch-a >actual-old-branch-a &&
+		git branch --recurse-submodules --force branch-a &&
+		git rev-parse branch-a &&
+		git -C sub rev-parse branch-a >actual-new-branch-a &&
+		test_cmp expected actual-new-branch-a &&
+		# assert that branch --force actually moved the sub
+		# branch
+		! test_cmp expected actual-old-branch-a
+	)
+'
+
+test_expect_success 'should create branch when submodule is not in HEAD:.gitmodules' '
+	test_when_finished "reset_test" &&
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
+		git checkout --recurse-submodules branch-c &&
+		git -C sub2 rev-parse branch-c &&
+		git -C sub2/sub-sub rev-parse branch-c
+	)
+'
+
+test_expect_success 'should not create branches in inactive submodules' '
+	test_when_finished "reset_test" &&
+	test_config -C super submodule.sub.active false &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a &&
+		git rev-parse branch-a &&
+		test_no_branch sub branch-a
+	)
+'
+
+test_expect_success 'should set up tracking of local branches with track=always' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git -c branch.autoSetupMerge=always branch --recurse-submodules branch-a main &&
+		git -C sub rev-parse main &&
+		test_cmp_config -C sub . branch.branch-a.remote &&
+		test_cmp_config -C sub refs/heads/main branch.branch-a.merge
+	)
+'
+
+test_expect_success 'should set up tracking of local branches with explicit track' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git branch --track --recurse-submodules branch-a main &&
+		git -C sub rev-parse main &&
+		test_cmp_config -C sub . branch.branch-a.remote &&
+		test_cmp_config -C sub refs/heads/main branch.branch-a.merge
+	)
+'
+
+test_expect_success 'should not set up unnecessary tracking of local branches' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		git branch --recurse-submodules branch-a main &&
+		git -C sub rev-parse main &&
+		test_cmp_config -C sub "" --default "" branch.branch-a.remote &&
+		test_cmp_config -C sub "" --default "" branch.branch-a.merge
+	)
+'
+
+reset_remote_test () {
+	rm -fr super-clone &&
+	reset_test
+}
+
+test_expect_success 'setup tests with remotes' '
+	(
+		cd test_dirs &&
+		(
+			cd super &&
+			git branch branch-a &&
+			git checkout -b branch-b &&
+			git submodule add ../sub-upstream sub2 &&
+			# branch-b now has a committed submodule not in branch-a
+			git commit -m "add second submodule"
+		) &&
+		git clone --branch main --recurse-submodules super super-clone &&
+		git -C super-clone config submodule.propagateBranches true
+	) &&
+	reset_remote_test
+'
+
+test_expect_success 'should get fatal error upon branch creation when submodule is not in .git/modules' '
+	test_when_finished "reset_remote_test" &&
+	(
+		cd super-clone &&
+		# This should succeed because super-clone has sub in .git/modules
+		git branch --recurse-submodules branch-a origin/branch-a &&
+		# This should fail because super-clone does not have sub2 .git/modules
+		test_must_fail git branch --recurse-submodules branch-b origin/branch-b 2>actual &&
+		grep "fatal: submodule .sub2.: unable to find submodule" actual &&
+		test_no_branch . branch-b &&
+		test_no_branch sub branch-b &&
+		# User can fix themselves by initializing the submodule
+		git checkout origin/branch-b &&
+		git submodule update --init --recursive &&
+		git branch --recurse-submodules branch-b origin/branch-b
+	)
+'
+
+test_expect_success 'should set up tracking of remote-tracking branches' '
+	test_when_finished "reset_remote_test" &&
+	(
+		cd super-clone &&
+		git branch --recurse-submodules branch-a origin/branch-a &&
+		test_cmp_config origin branch.branch-a.remote &&
+		test_cmp_config refs/heads/branch-a branch.branch-a.merge &&
+		# "origin/branch-a" does not exist for "sub", but it matches the refspec
+		# so tracking should be set up
+		test_cmp_config -C sub origin branch.branch-a.remote &&
+		test_cmp_config -C sub refs/heads/branch-a branch.branch-a.merge &&
+		test_cmp_config -C sub/sub-sub origin branch.branch-a.remote &&
+		test_cmp_config -C sub/sub-sub refs/heads/branch-a branch.branch-a.merge
+	)
+'
+
+test_expect_success 'should not fail when unable to set up tracking in submodule' '
+	test_when_finished "reset_remote_test" &&
+	(
+		cd super-clone &&
+		git remote rename origin ex-origin &&
+		git branch --recurse-submodules branch-a ex-origin/branch-a &&
+		test_cmp_config ex-origin branch.branch-a.remote &&
+		test_cmp_config refs/heads/branch-a branch.branch-a.merge &&
+		test_cmp_config -C sub "" --default "" branch.branch-a.remote &&
+		test_cmp_config -C sub "" --default "" branch.branch-a.merge
+	)
+'
+
+test_done
-- 
2.33.GIT

