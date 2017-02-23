Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970372022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdBWXEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:04:52 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36175 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdBWXEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:04:51 -0500
Received: by mail-pg0-f44.google.com with SMTP id s67so2261649pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YliCosNLyTbF+19Pa64N+cG5JDplSeMqh/2ENtQLWwA=;
        b=c5mMH69MvRYhQR6bALBAcxSY+aeEqXPqwd8ijb+ZL8INI45/taAkqGA6AlCWFS0Gev
         rX+7NRaX4PSj1DR8zWSbtNDx1SeblPLq8XHzM5xx/2OQGeDhFlaXiK5IyECjGmWKJgZN
         EbE/GiG7awDPaehfXQhyYvN75lor7uCy7Az005FSEnGaTTdd2W+QE23zLbal/Wd1XKkb
         TyK/byizHVV9EgMaQ3Xl7KQXhQY6vAw9ARi7FEz7ln0wWyQrJ5Te0TCY90tzoFN9OcuH
         P1/ED5YJnRog4v4t4UhZlsCFV+kmo5LrLS5P4GQceZNv/rvj30iOkWqYiB5jH5lwsgv4
         rb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YliCosNLyTbF+19Pa64N+cG5JDplSeMqh/2ENtQLWwA=;
        b=AoSHoXgb40mZL3BotYRKNHmqrNQ8CW1pZ17QxnUXoJX/VOjaScVnS5PWVj+SHuYNR9
         P9vtJ6h2MobGNnrghHxShcBdQ239sMgO5jEfadJnzW1bzSW2EfkwsksM/w6wjTA2beru
         RkJBwc01EzcmnTx9AuHPAxeNmgPsbGkWD643ZhygDxM+FvYmN8SREYxgE2PVkqcmmkHN
         MY91YlKKf2kfU1+cygW3qlrVWFIqzOH5Pi9zLDjRK8rgtgg3wDkiCgETLecx41mSTy8S
         gU+1B3rgf6DY2X4iaFoxYaq/dvus4TPnvIHkltXuvXqWoc+D0/Z/1mi1C5rkUsCjmQt0
         7O6Q==
X-Gm-Message-State: AMke39kXXNUSk8WmqyjEE5sQl7XvcO9XrQmF+xHqWnqgmyKTq3l5XWWF++0xJkH4ucx+fgXB
X-Received: by 10.99.47.199 with SMTP id v190mr50388503pgv.26.1487890671574;
        Thu, 23 Feb 2017 14:57:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id q19sm11631615pfl.21.2017.02.23.14.57.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:57:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [RFCv5 PATCH 00/14] Checkout aware of Submodules!
Date:   Thu, 23 Feb 2017 14:57:20 -0800
Message-Id: <20170223225735.10994-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous work:
https://public-inbox.org/git/20161203003022.29797-1-sbeller@google.com/

v5:
 * as v4 was the first version queued by Junio, we do have an interdiff below!
 * renamed functions
 * changed the API, now the caller has to take care of the submodule strategy
   themselves. (Note this can be different for different situations, e.g.
   when a submodule is deleted, we can do that for any strategy except none and
   !command. But for moving to a new state of the submodule we currently
   only implement "checkout" [unspecified defaults to checkout]. warning about
   the others, doing nothing there.)

v4:
 * addressed all comments of Brian, Junio and Brandon.
 Thanks!
 * one major point of change is the introduction of another patch
   "lib-submodule-update.sh: do not use ./. as submodule remote",
   as that took some time to track down the existing bug.
 
v3:
 * moved tests from t2013 to the generic submodule library.
 * factored out the refactoring patches to be up front
 * As I redid the complete implementation, I have the impression this time
   it is cleaner than previous versions.
 
 I think we still have to fix the corner cases of directory/file/submodule 
 conflicts before merging, but this serves as a status update on my current
 way of thinking how to implement the worktree commands being aware of
 submodules.
 
Thanks,
Stefan

v2:
* based on top of the series sent out an hour ago
  "[PATCHv4 0/5] submodule embedgitdirs"
* Try to embed a submodule if we need to remove it.
* Strictly do not change behavior if not giving the new flag.
* I think I missed some review comments from v1, but I'd like to get
  the current state out over the weekend, as a lot has changed so far.
  On Monday I'll go through the previous discussion with a comb to see
  if I missed something.
  
v1:
When working with submodules, nearly anytime after checking out
a different state of the projects, that has submodules changed
you'd run "git submodule update" with a current version of Git.

There are two problems with this approach:

* The "submodule update" command is dangerous as it
  doesn't check for work that may be lost in the submodule
  (e.g. a dangling commit).
* you may forget to run the command as checkout is supposed
  to do all the work for you.

Integrate updating the submodules into git checkout, with the same
safety promises that git-checkout has, i.e. not throw away data unless
asked to. This is done by first checking if the submodule is at the same
sha1 as it is recorded in the superproject. If there are changes we stop
proceeding the checkout just like it is when checking out a file that
has local changes.

The integration happens in the code that is also used in other commands
such that it will be easier in the future to make other commands aware
of submodule.

This also solves d/f conflicts in case you replace a file/directory
with a submodule or vice versa.

The patches are still a bit rough, but the overall series seems
promising enough to me that I want to put it out here.

Any review, specifically on the design level welcome!

Thanks,
Stefan


Stefan Beller (14):
  lib-submodule-update.sh: reorder create_lib_submodule_repo
  lib-submodule-update.sh: define tests for recursing into submodules
  make is_submodule_populated gently
  connect_work_tree_and_git_dir: safely create leading directories
  update submodules: add submodule config parsing
  update submodules: add a config option to determine if submodules are
    updated
  update submodules: introduce is_interesting_submodule
  update submodules: move up prepare_submodule_repo_env
  update submodules: add submodule_go_from_to
  unpack-trees: pass old oid to verify_clean_submodule
  unpack-trees: check if we can perform the operation for submodules
  read-cache: remove_marked_cache_entries to wipe selected submodules.
  entry.c: update submodules when interesting
  builtin/checkout: add --recurse-submodules switch

diff --git a/entry.c b/entry.c
index ae40611c97..d2b512da90 100644
--- a/entry.c
+++ b/entry.c
@@ -147,6 +147,7 @@ static int write_entry(struct cache_entry *ce,
 	unsigned long size;
 	size_t wrote, newsize = 0;
 	struct stat st;
+	const struct submodule *sub;
 
 	if (ce_mode_s_ifmt == S_IFREG) {
 		struct stream_filter *filter = get_stream_filter(ce->name,
@@ -204,13 +205,10 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
-		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
-				/*
-				 * force=1 is ok for any case as we did a dry
-				 * run before with appropriate force setting
-				 */
-				return submodule_go_from_to(ce->name,
-					NULL, oid_to_hex(&ce->oid), 0, 1);
+		sub = submodule_from_ce(ce);
+		if (sub)
+			return submodule_move_head(ce->name,
+				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -267,12 +265,14 @@ int checkout_entry(struct cache_entry *ce,
 	strbuf_add(&path, ce->name, ce_namelen(ce));
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
+		const struct submodule *sub;
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 		/*
 		 * Needs to be checked before !changed returns early,
 		 * as the possibly empty directory was not changed
 		 */
-		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED)) {
+		sub = submodule_from_ce(ce);
+		if (sub) {
 			int err;
 			if (!is_submodule_populated_gently(ce->name, &err)) {
 				struct stat sb;
@@ -281,11 +281,13 @@ int checkout_entry(struct cache_entry *ce,
 				if (!(st.st_mode & S_IFDIR))
 					unlink_or_warn(ce->name);
 
-				return submodule_go_from_to(ce->name,
-					NULL, oid_to_hex(&ce->oid), 0, 1);
+				return submodule_move_head(ce->name,
+					NULL, oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
 			} else
-				return submodule_go_from_to(ce->name,
-					"HEAD", oid_to_hex(&ce->oid), 0, 1);
+				return submodule_move_head(ce->name,
+					"HEAD", oid_to_hex(&ce->oid),
+					SUBMODULE_MOVE_HEAD_FORCE);
 		}
 
 		if (!changed)
diff --git a/read-cache.c b/read-cache.c
index b78a7f02e3..9a2abacf7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -19,6 +19,7 @@
 #include "split-index.h"
 #include "utf8.h"
 #include "submodule.h"
+#include "submodule-config.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -521,6 +522,22 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 	return 1;
 }
 
+static void remove_submodule_according_to_strategy(const struct submodule *sub)
+{
+	switch (sub->update_strategy.type) {
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_CHECKOUT:
+	case SM_UPDATE_REBASE:
+	case SM_UPDATE_MERGE:
+		submodule_move_head(sub->path, "HEAD", NULL, \
+				    SUBMODULE_MOVE_HEAD_FORCE);
+		break;
+	case SM_UPDATE_NONE:
+	case SM_UPDATE_COMMAND:
+		; /* Do not touch the submodule. */
+	}
+}
+
 /*
  * Remove all cache entries marked for removal, that is where
  * CE_REMOVE is set in ce_flags.  This is much more effective than
@@ -533,10 +550,13 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
-			if (is_active_submodule_with_strategy(ce_array[i], SM_UPDATE_UNSPECIFIED))
-				submodule_go_from_to(ce_array[i]->name, "HEAD", NULL, 0, 1);
-			remove_name_hash(istate, ce_array[i]);
-			save_or_free_index_entry(istate, ce_array[i]);
+			const struct submodule *sub = submodule_from_ce(ce_array[i]);
+			if (sub) {
+				remove_submodule_according_to_strategy(sub);
+			} else {
+				remove_name_hash(istate, ce_array[i]);
+				save_or_free_index_entry(istate, ce_array[i]);
+			}
 		}
 		else
 			ce_array[j++] = ce_array[i];
diff --git a/submodule-config.c b/submodule-config.c
index 93f01c4378..3e8e380d98 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -243,8 +243,6 @@ static int parse_update_recurse(const char *opt, const char *arg,
 	case 0:
 		return RECURSE_SUBMODULES_OFF;
 	default:
-		if (!strcmp(arg, "checkout"))
-			return RECURSE_SUBMODULES_ON;
 		if (die_on_error)
 			die("bad %s argument: %s", opt, arg);
 		return RECURSE_SUBMODULES_ERROR;
diff --git a/submodule.c b/submodule.c
index 84cc62f3bb..a2cf8c9376 100644
--- a/submodule.c
+++ b/submodule.c
@@ -565,31 +565,20 @@ void set_config_update_recurse_submodules(int value)
 	config_update_recurse_submodules = value;
 }
 
-int touch_submodules_in_worktree(void)
+int should_update_submodules(void)
 {
-	/*
-	 * Update can't be "none", "merge" or "rebase",
-	 * treat any value as OFF, except an explicit ON.
-	 */
 	return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
 }
 
-int is_active_submodule_with_strategy(const struct cache_entry *ce,
-				      enum submodule_update_type strategy)
+const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 {
-	const struct submodule *sub;
-
 	if (!S_ISGITLINK(ce->ce_mode))
-		return 0;
-
-	if (!touch_submodules_in_worktree())
-		return 0;
+		return NULL;
 
-	sub = submodule_from_path(null_sha1, ce->name);
-	if (!sub)
-		return 0;
+	if (!should_update_submodules())
+		return NULL;
 
-	return sub->update_strategy.type == strategy;
+	return submodule_from_path(null_sha1, ce->name);
 }
 
 static int has_remote(const char *refname, const struct object_id *oid,
@@ -1252,34 +1241,23 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 
 static int submodule_has_dirty_index(const struct submodule *sub)
 {
-	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0;
 
 	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
 
 	cp.git_cmd = 1;
-	argv_array_pushl(&cp.args, "diff-index", "--cached", "HEAD", NULL);
+	argv_array_pushl(&cp.args, "diff-index", "--quiet", \
+					"--cached", "HEAD", NULL);
 	cp.no_stdin = 1;
-	cp.out = -1;
+	cp.no_stdout = 1;
 	cp.dir = sub->path;
 	if (start_command(&cp))
-		die("could not recurse into submodule %s", sub->path);
+		die("could not recurse into submodule '%s'", sub->path);
 
-	len = strbuf_read(&buf, cp.out, 1024);
-	if (len > 2)
-		ret = 1;
-
-	close(cp.out);
-	if (finish_command(&cp))
-		die("could not recurse into submodule %s", sub->path);
-
-	strbuf_release(&buf);
-	return ret;
+	return finish_command(&cp);
 }
 
-void submodule_clean_index(const char *path)
+void submodule_reset_index(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
@@ -1294,21 +1272,18 @@ void submodule_clean_index(const char *path)
 	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
 
 	if (run_command(&cp))
-		die("could not clean submodule index");
+		die("could not reset submodule index");
 }
 
 /**
  * Moves a submodule at a given path from a given head to another new head.
  * For edge cases (a submodule coming into existence or removing a submodule)
  * pass NULL for old or new respectively.
- *
- * TODO: move dryrun and forced to flags.
  */
-int submodule_go_from_to(const char *path,
+int submodule_move_head(const char *path,
 			 const char *old,
 			 const char *new,
-			 int dry_run,
-			 int force)
+			 unsigned flags)
 {
 	int ret = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1319,7 +1294,13 @@ int submodule_go_from_to(const char *path,
 	if (!sub)
 		die("BUG: could not get submodule information for '%s'", path);
 
-	if (!dry_run) {
+	if (old && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+		/* Check if the submodule has a dirty index. */
+		if (submodule_has_dirty_index(sub))
+			return error(_("submodule '%s' has dirty index"), path);
+	}
+
+	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (old) {
 			if (!submodule_uses_gitfile(path))
 				absorb_git_dir_into_superproject("", path,
@@ -1332,15 +1313,7 @@ int submodule_go_from_to(const char *path,
 			strbuf_release(&sb);
 
 			/* make sure the index is clean as well */
-			submodule_clean_index(path);
-		}
-	}
-
-	if (old && !force) {
-		/* Check if the submodule has a dirty index. */
-		if (submodule_has_dirty_index(sub)) {
-			/* print a thing here? */
-			return -1;
+			submodule_reset_index(path);
 		}
 	}
 
@@ -1353,12 +1326,12 @@ int submodule_go_from_to(const char *path,
 	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
 	argv_array_pushl(&cp.args, "read-tree", NULL);
 
-	if (dry_run)
+	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
 		argv_array_push(&cp.args, "-n");
 	else
 		argv_array_push(&cp.args, "-u");
 
-	if (force)
+	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
 		argv_array_push(&cp.args, "--reset");
 	else
 		argv_array_push(&cp.args, "-m");
@@ -1371,7 +1344,7 @@ int submodule_go_from_to(const char *path,
 		goto out;
 	}
 
-	if (!dry_run) {
+	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
 		if (new) {
 			struct child_process cp1 = CHILD_PROCESS_INIT;
 			/* also set the HEAD accordingly */
diff --git a/submodule.h b/submodule.h
index 3336607bfc..4cdf6445f7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,19 +65,13 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const struct diff_options *opt);
 extern void set_config_fetch_recurse_submodules(int value);
 extern void set_config_update_recurse_submodules(int value);
-
-/*
- * Traditionally Git ignored changes made for submodules.
- * This function checks if we are interested in the given submodule
- * for any kind of operation.
- */
-extern int touch_submodules_in_worktree(void);
+/* Check if we want to update any submodule.*/
+extern int should_update_submodules(void);
 /*
- * Check if the given ce entry is a submodule with the given update
- * strategy configured.
+ * Returns the submodule struct if the given ce entry is a submodule
+ * and it should be updated. Returns NULL otherwise.
  */
-extern int is_active_submodule_with_strategy(const struct cache_entry *ce,
-					     enum submodule_update_type strategy);
+extern const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
@@ -102,10 +96,12 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
 
-extern int submodule_go_from_to(const char *path,
-				const char *old,
-				const char *new,
-				int dry_run, int force);
+#define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
+#define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
+extern int submodule_move_head(const char *path,
+			       const char *old,
+			       const char *new,
+			       unsigned flags);
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 4693ba7a7e..54cd8a6366 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -216,7 +216,7 @@ reset_work_tree_to_interested () {
 	# also have it available:
 	if ! test -d submodule_update/.git/modules/sub1
 	then
-		mkdir submodule_update/.git/modules &&
+		mkdir -p submodule_update/.git/modules &&
 		cp -r submodule_update_repo/.git/modules/sub1 submodule_update/.git/modules/sub1
 	fi
 }
@@ -809,7 +809,7 @@ test_submodule_switch_recursing () {
 			cd submodule_update &&
 			git branch -t add_sub1 origin/add_sub1 &&
 			: >sub1 &&
-			echo sub1 > .git/info/exclude
+			echo sub1 >.git/info/exclude
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -1133,7 +1133,7 @@ test_submodule_forced_switch_recursing () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			: > sub1/expect &&
+			: >sub1/expect &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file
 		)
@@ -1146,7 +1146,7 @@ test_submodule_forced_switch_recursing () {
 		(
 			cd submodule_update &&
 			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
-			: > sub1/untracked_file &&
+			: >sub1/untracked_file &&
 			test_must_fail $command replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
 			test -f sub1/untracked_file
diff --git a/unpack-trees.c b/unpack-trees.c
index 40af8e9b5f..8333da2cc9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -11,6 +11,7 @@
 #include "split-index.h"
 #include "dir.h"
 #include "submodule.h"
+#include "submodule-config.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -47,8 +48,8 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	/* ERROR_WOULD_LOSE_ORPHANED_REMOVED */
 	"Working tree file '%s' would be removed by sparse checkout update.",
 
-	/* ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE */
-	"Submodule '%s' cannot be deleted as it contains untracked files.",
+	/* ERROR_WOULD_LOSE_SUBMODULE */
+	"Submodule '%s' cannot checkout new HEAD.",
 };
 
 #define ERRORMSG(o,type) \
@@ -165,8 +166,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 		_("The following working tree files would be overwritten by sparse checkout update:\n%s");
 	msgs[ERROR_WOULD_LOSE_ORPHANED_REMOVED] =
 		_("The following working tree files would be removed by sparse checkout update:\n%s");
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE] =
-		_("Submodule '%s' cannot be deleted as it contains untracked files.");
+	msgs[ERROR_WOULD_LOSE_SUBMODULE] =
+		_("Submodule '%s' cannot checkout new HEAD");
 
 	opts->show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
@@ -246,13 +247,31 @@ static void display_error_msgs(struct unpack_trees_options *o)
 		fprintf(stderr, _("Aborting\n"));
 }
 
-static int submodule_check_from_to(const struct cache_entry *ce, const char *old_id, const char *new_id, struct unpack_trees_options *o)
+static int check_submodule_move_head(const struct cache_entry *ce,
+				     const char *old_id,
+				     const char *new_id,
+				     struct unpack_trees_options *o)
 {
-	if (submodule_go_from_to(ce->name, old_id,
-				 new_id, 1, o->reset))
-		return o->gently ? -1 :
-			add_rejected_path(o, ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE, ce->name);
-	return 0;
+	const struct submodule *sub = submodule_from_ce(ce);
+	if (!sub)
+		return 0;
+
+	switch (sub->update_strategy.type) {
+	case SM_UPDATE_UNSPECIFIED:
+	case SM_UPDATE_CHECKOUT:
+		if (submodule_move_head(ce->name, old_id, new_id, SUBMODULE_MOVE_HEAD_DRY_RUN))
+			return o->gently ? -1 :
+				add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
+		return 0;
+	case SM_UPDATE_NONE:
+		return 0;
+	case SM_UPDATE_REBASE:
+	case SM_UPDATE_MERGE:
+	case SM_UPDATE_COMMAND:
+	default:
+		warning(_("submodule update strategy not supported for submodule '%s'"), ce->name);
+		return -1;
+	}
 }
 
 static void reload_gitmodules_file(struct index_state *index,
@@ -262,18 +281,18 @@ static void reload_gitmodules_file(struct index_state *index,
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 		if (ce->ce_flags & CE_UPDATE) {
-
 			int r = strcmp(ce->name, ".gitmodules");
 			if (r < 0)
 				continue;
 			else if (r == 0) {
+				submodule_free();
 				checkout_entry(ce, state, NULL);
+				gitmodules_config();
+				git_config(submodule_config, NULL);
 			} else
 				break;
 		}
 	}
-	gitmodules_config();
-	git_config(submodule_config, NULL);
 }
 
 /*
@@ -282,8 +301,21 @@ static void reload_gitmodules_file(struct index_state *index,
  */
 static void unlink_entry(const struct cache_entry *ce)
 {
-	if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
-		submodule_go_from_to(ce->name, "HEAD", NULL, 0, 1);
+	const struct submodule *sub = submodule_from_ce(ce);
+	if (sub) {
+		switch (sub->update_strategy.type) {
+		case SM_UPDATE_UNSPECIFIED:
+		case SM_UPDATE_CHECKOUT:
+		case SM_UPDATE_REBASE:
+		case SM_UPDATE_MERGE:
+			submodule_move_head(ce->name, "HEAD", NULL,
+					    SUBMODULE_MOVE_HEAD_FORCE);
+			break;
+		case SM_UPDATE_NONE:
+		case SM_UPDATE_COMMAND:
+			return; /* Do not touch the submodule. */
+		}
+	}
 	if (!check_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (remove_or_warn(ce->ce_mode, ce->name))
@@ -339,7 +371,7 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
-	if (touch_submodules_in_worktree() && o->update && !o->dry_run)
+	if (should_update_submodules() && o->update && !o->dry_run)
 		reload_gitmodules_file(index, &state);
 
 	for (i = 0; i < index->cache_nr; i++) {
@@ -1400,9 +1432,8 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 		int flags = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE;
 		unsigned changed = ie_match_stat(o->src_index, ce, &st, flags);
 
-		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED)) {
-			int r;
-			r = submodule_check_from_to(ce,
+		if (submodule_from_ce(ce)) {
+			int r = check_submodule_move_head(ce,
 				"HEAD", oid_to_hex(&ce->oid), o);
 			if (r)
 				return o->gently ? -1 :
@@ -1463,12 +1494,11 @@ static int verify_clean_submodule(const char *old_sha1,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
-	if (!is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
+	if (!submodule_from_ce(ce))
 		return 0;
 
-	return submodule_check_from_to(ce,
-				       old_sha1,
-				       oid_to_hex(&ce->oid), o);
+	return check_submodule_move_head(ce, old_sha1,
+					 oid_to_hex(&ce->oid), o);
 }
 
 static int verify_clean_subdirectory(const struct cache_entry *ce,
@@ -1635,10 +1665,10 @@ static int verify_absent_1(const struct cache_entry *ce,
 		if (lstat(path, &st))
 			ret = error_errno("cannot stat '%s'", path);
 		else {
-			if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
-				ret = submodule_check_from_to(ce,
-							oid_to_hex(&ce->oid),
-							NULL, o);
+			if (submodule_from_ce(ce))
+				ret = check_submodule_move_head(ce,
+								oid_to_hex(&ce->oid),
+								NULL, o);
 			else
 				ret = check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
 							 &st, error_type, o);
@@ -1650,9 +1680,9 @@ static int verify_absent_1(const struct cache_entry *ce,
 			return error_errno("cannot stat '%s'", ce->name);
 		return 0;
 	} else {
-		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
-			return submodule_check_from_to(ce, oid_to_hex(&ce->oid),
-						       NULL, o);
+		if (submodule_from_ce(ce))
+			return check_submodule_move_head(ce, oid_to_hex(&ce->oid),
+							 NULL, o);
 
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 					  ce_to_dtype(ce), ce, &st,
@@ -1710,11 +1740,10 @@ static int merged_entry(const struct cache_entry *ce,
 		}
 		invalidate_ce_path(merge, o);
 
-		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED)) {
-			int ret = submodule_check_from_to(ce,
-							  NULL,
-							  oid_to_hex(&ce->oid),
-							  o);
+		if (submodule_from_ce(ce)) {
+			int ret = check_submodule_move_head(ce, NULL,
+							    oid_to_hex(&ce->oid),
+							    o);
 			if (ret)
 				return ret;
 		}
@@ -1739,9 +1768,13 @@ static int merged_entry(const struct cache_entry *ce,
 			update |= old->ce_flags & (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
 			invalidate_ce_path(old, o);
 		}
-		if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED)) {
-			if (submodule_check_from_to(ce, oid_to_hex(&old->oid), oid_to_hex(&ce->oid), o))
-				return -1;
+
+		if (submodule_from_ce(ce)) {
+			int ret = check_submodule_move_head(ce, oid_to_hex(&old->oid),
+							    oid_to_hex(&ce->oid),
+							    o);
+			if (ret)
+				return ret;
 		}
 	} else {
 		/*
diff --git a/unpack-trees.h b/unpack-trees.h
index c0427ce082..6c48117b84 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -21,7 +21,7 @@ enum unpack_trees_error_types {
 	ERROR_SPARSE_NOT_UPTODATE_FILE,
 	ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_ORPHANED_REMOVED,
-	ERROR_WOULD_LOSE_UNTRACKED_SUBMODULE,
+	ERROR_WOULD_LOSE_SUBMODULE,
 	NB_UNPACK_TREES_ERROR_TYPES
 };
 


