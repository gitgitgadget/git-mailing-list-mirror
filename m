Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B74C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiLTMoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiLTMnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 07:43:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12781AF0E
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja17so8594865wmb.3
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 04:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHxQhsaJLSC7d/3L9NJpFHqBowcryKd4uBFXreKuHaY=;
        b=hF0aIrLUHOZy1VeyVv63n4Yen0VdoHESYWUQD2QlH2L0gNcD65X7KVWG/ylHy++ByO
         NxjhLfChWNYTRWxk6jLcraQBpRLvBZ8t3qkQDCsJCyp7GwbKhxw4O0GpaqomZhpFszxF
         zf9iYW2t3rgyCTSnkhXyaeum8eiFsQmuYJ9Wv9kuMwM5nVkWuDhrCoul+g6AjagegQeN
         Q7cK7Y+Z/S6XhYCXNkeJaOrtiRXFLnirB+AjSy8saWbbTH3bfu3kmqOIfSfH1Zu6EuTh
         s86P7Tf08XSv0ZIF22mze86+YI9PLGIvRm95dWukbStkT6P2auupE6R4IAi1RNrHC68+
         PehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHxQhsaJLSC7d/3L9NJpFHqBowcryKd4uBFXreKuHaY=;
        b=Gpk1Doz/26xPXzyt1SribVEjMcVnQp71R47I6oLtGPQJUMYO4IvvxsOPklcgyeFjuu
         G1P693D/MZaYe9ApAJ/p47/ZmV6rxbfIjogqiVMZ096k51nyJQ89jCABMeO4NSirp/0K
         UM4+/g8ynrd2u16K93iT9QDjJoMbYRFOApIbDdaVWCh3eo/MmDdwitCfGRucXlktEN9G
         x4TF+XuXzHYlGib8xPwSeVzfwo9OL052QpQJVNOerIq1E9YCGmQHx0KprU8wL9SkdKzS
         0eWgRyFWvz89yTPWRF8AUwoOCtu2d96BS840ahXJHEzgryGcu5GYUswehPXVAHUUR6Su
         O/VQ==
X-Gm-Message-State: ANoB5pkOYfQB/lO8QU/ztqglrkqbWZEYejv/0h/3URgTlrk80pJIyNex
        hafjDdwulntsDS5i2yEvN+WRypirQkEJIw==
X-Google-Smtp-Source: AA0mqf7Yo3cixC4CB3qwig6mZfsVECmLkQtzbQq6OJjUHWJpEljKZH61UhwERIFG5O1eLRIOtwEuUw==
X-Received: by 2002:a05:600c:384b:b0:3cf:6926:2abb with SMTP id s11-20020a05600c384b00b003cf69262abbmr35395315wmr.7.1671540010396;
        Tue, 20 Dec 2022 04:40:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003d355ad9bb7sm9630759wmq.20.2022.12.20.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:40:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 9/9] read-tree: add "--super-prefix" option, eliminate global
Date:   Tue, 20 Dec 2022 13:39:56 +0100
Message-Id: <patch-v5-9.9-48ba8d4938c-20221220T104519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1106.g08bce9674be
In-Reply-To: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--super-prefix" option to "git" was initially added in [1] for
use with "ls-files"[2], and shortly thereafter "submodule--helper"[3]
and "grep"[4]. It wasn't until [5] that "read-tree" made use of it.

At the time [5] made sense, but since then we've made "ls-files"
recurse in-process in [6], "grep" in [7], and finally
"submodule--helper" in the preceding commits.

Let's also remove it from "read-tree", which allows us to remove the
option to "git" itself.

We can do this because the only remaining user of it is the submodule
API, which will now invoke "read-tree" with its new "--super-prefix"
option. It will only do so when the "submodule_move_head()" function
is called.

That "submodule_move_head()" function was then only invoked by
"read-tree" itself, but now rather than setting an environment
variable to pass "--super-prefix" between cmd_read_tree() we:

- Set a new "super_prefix" in "struct unpack_trees_options". The
  "super_prefixed()" function in "unpack-trees.c" added in [5] will now
  use this, rather than get_super_prefix() looking up the environment
  variable we set earlier in the same process.

- Add the same field to the "struct checkout", which is only needed to
  ferry the "super_prefix" in the "struct unpack_trees_options" all the
  way down to the "entry.c" callers of "submodule_move_head()".

  Those calls which used the super prefix all originated in
  "cmd_read_tree()". The only other caller is the "unlink_entry()"
  caller in "builtin/checkout.c", which now passes a "NULL".

1. 74866d75793 (git: make super-prefix option, 2016-10-07)
2. e77aa336f11 (ls-files: optionally recurse into submodules, 2016-10-07)
3. 89c86265576 (submodule helper: support super prefix, 2016-12-08)
4. 0281e487fd9 (grep: optionally recurse into submodules, 2016-12-16)
5. 3d415425c7b (unpack-trees: support super-prefix option, 2017-01-17)
6. 188dce131fa (ls-files: use repository object, 2017-06-22)
7. f9ee2fcdfa0 (grep: recurse in-process using 'struct repository', 2017-08-02)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git.txt       |  8 +-------
 builtin.h                   |  4 ----
 builtin/checkout.c          |  2 +-
 builtin/read-tree.c         |  1 +
 cache.h                     |  2 --
 entry.c                     | 12 ++++++------
 entry.h                     |  6 +++++-
 environment.c               | 13 -------------
 git.c                       | 37 +++++--------------------------------
 submodule.c                 | 29 ++++++++++-------------------
 submodule.h                 |  5 ++---
 t/t1001-read-tree-m-2way.sh |  2 +-
 t/t5616-partial-clone.sh    |  2 +-
 unpack-trees.c              | 24 ++++++++++++++----------
 unpack-trees.h              |  1 +
 15 files changed, 48 insertions(+), 100 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1d33e083ab8..f9a7a4554cd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,8 +13,7 @@ SYNOPSIS
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
-    [--super-prefix=<path>] [--config-env=<name>=<envvar>]
-    <command> [<args>]
+    [--config-env=<name>=<envvar>] <command> [<args>]
 
 DESCRIPTION
 -----------
@@ -169,11 +168,6 @@ If you just want to run git as if it was started in `<path>` then use
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
 	variable.
 
---super-prefix=<path>::
-	Currently for internal use only.  Set a prefix which gives a path from
-	above a repository down to its root.  One use is to give submodules
-	context about the superproject that invoked it.
-
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
 	environment is not set, it is set to the current working
diff --git a/builtin.h b/builtin.h
index aa955466b4e..46cc7897898 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,10 +51,6 @@
  *	on bare repositories.
  *	This only makes sense when `RUN_SETUP` is also set.
  *
- * `SUPPORT_SUPER_PREFIX`:
- *
- *	The built-in supports `--super-prefix`.
- *
  * `DELAY_PAGER_CONFIG`:
  *
  *	If RUN_SETUP or RUN_SETUP_GENTLY is set, git.c normally handles
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a0142c815fd..cd04f0bf572 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -232,7 +232,7 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 		pos++;
 	}
 	if (!overlay_mode) {
-		unlink_entry(ce);
+		unlink_entry(ce, NULL);
 		return 0;
 	}
 	if (stage == 2)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f702f9d47bb..3ce75417833 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -114,6 +114,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	int prefix_set = 0;
 	struct lock_file lock_file = LOCK_INIT;
 	const struct option read_tree_options[] = {
+		OPT__SUPER_PREFIX(&opts.super_prefix),
 		OPT_CALLBACK_F(0, "index-output", NULL, N_("file"),
 		  N_("write resulting index to <file>"),
 		  PARSE_OPT_NONEG, index_output_cb),
diff --git a/cache.h b/cache.h
index 07d40b0964b..7f7e2b5a38f 100644
--- a/cache.h
+++ b/cache.h
@@ -480,7 +480,6 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
-#define GIT_SUPER_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUPER_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -566,7 +565,6 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
-const char *get_super_prefix(void);
 const char *get_git_work_tree(void);
 
 /*
diff --git a/entry.c b/entry.c
index 616e4f073c1..971ab268714 100644
--- a/entry.c
+++ b/entry.c
@@ -383,7 +383,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 			return error("cannot create submodule directory %s", path);
 		sub = submodule_from_ce(ce);
 		if (sub)
-			return submodule_move_head(ce->name,
+			return submodule_move_head(ce->name, state->super_prefix,
 				NULL, oid_to_hex(&ce->oid),
 				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		break;
@@ -476,7 +476,7 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 			 * no pathname to return.
 			 */
 			BUG("Can't remove entry to a path");
-		unlink_entry(ce);
+		unlink_entry(ce, state->super_prefix);
 		return 0;
 	}
 
@@ -510,10 +510,10 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 				if (!(st.st_mode & S_IFDIR))
 					unlink_or_warn(ce->name);
 
-				return submodule_move_head(ce->name,
+				return submodule_move_head(ce->name, state->super_prefix,
 					NULL, oid_to_hex(&ce->oid), 0);
 			} else
-				return submodule_move_head(ce->name,
+				return submodule_move_head(ce->name, state->super_prefix,
 					"HEAD", oid_to_hex(&ce->oid),
 					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
@@ -560,12 +560,12 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 	return write_entry(ce, path.buf, ca, state, 0, nr_checkouts);
 }
 
-void unlink_entry(const struct cache_entry *ce)
+void unlink_entry(const struct cache_entry *ce, const char *super_prefix)
 {
 	const struct submodule *sub = submodule_from_ce(ce);
 	if (sub) {
 		/* state.force is set at the caller. */
-		submodule_move_head(ce->name, "HEAD", NULL,
+		submodule_move_head(ce->name, super_prefix, "HEAD", NULL,
 				    SUBMODULE_MOVE_HEAD_FORCE);
 	}
 	if (check_leading_path(ce->name, ce_namelen(ce), 1) >= 0)
diff --git a/entry.h b/entry.h
index 9be4659881e..2d4fbb88c8f 100644
--- a/entry.h
+++ b/entry.h
@@ -8,6 +8,7 @@ struct checkout {
 	struct index_state *istate;
 	const char *base_dir;
 	int base_dir_len;
+	const char *super_prefix;
 	struct delayed_checkout *delayed_checkout;
 	struct checkout_metadata meta;
 	unsigned force:1,
@@ -48,8 +49,11 @@ int finish_delayed_checkout(struct checkout *state, int show_progress);
 /*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
+ *
+ * The "super_prefix" is either NULL, or the "--super-prefix" passed
+ * down from "read-tree" et al.
  */
-void unlink_entry(const struct cache_entry *ce);
+void unlink_entry(const struct cache_entry *ce, const char *super_prefix);
 
 void *read_blob_entry(const struct cache_entry *ce, size_t *size);
 int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
diff --git a/environment.c b/environment.c
index 18d042b467d..1ee3686fd8a 100644
--- a/environment.c
+++ b/environment.c
@@ -102,8 +102,6 @@ char *git_work_tree_cfg;
 
 static char *git_namespace;
 
-static char *super_prefix;
-
 /*
  * Repository-local GIT_* environment variables; see cache.h for details.
  */
@@ -121,7 +119,6 @@ const char * const local_repo_env[] = {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
-	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
 	GIT_COMMON_DIR_ENVIRONMENT,
 	NULL
@@ -234,16 +231,6 @@ const char *strip_namespace(const char *namespaced_ref)
 	return NULL;
 }
 
-const char *get_super_prefix(void)
-{
-	static int initialized;
-	if (!initialized) {
-		super_prefix = xstrdup_or_null(getenv(GIT_SUPER_PREFIX_ENVIRONMENT));
-		initialized = 1;
-	}
-	return super_prefix;
-}
-
 static int git_work_tree_initialized;
 
 /*
diff --git a/git.c b/git.c
index 2c31ba27040..32a5be68a17 100644
--- a/git.c
+++ b/git.c
@@ -14,9 +14,8 @@
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
-#define SUPPORT_SUPER_PREFIX	(1<<4)
-#define DELAY_PAGER_CONFIG	(1<<5)
-#define NO_PARSEOPT		(1<<6) /* parse-options is not used */
+#define DELAY_PAGER_CONFIG	(1<<4)
+#define NO_PARSEOPT		(1<<5) /* parse-options is not used */
 
 struct cmd_struct {
 	const char *cmd;
@@ -29,8 +28,7 @@ const char git_usage_string[] =
 	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
 	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	   "           [--super-prefix=<path>] [--config-env=<name>=<envvar>]\n"
-	   "           <command> [<args>]");
+	   "           [--config-env=<name>=<envvar>] <command> [<args>]");
 
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
@@ -226,20 +224,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd, 1);
 			if (envchanged)
 				*envchanged = 1;
-		} else if (!strcmp(cmd, "--super-prefix")) {
-			if (*argc < 2) {
-				fprintf(stderr, _("no prefix given for --super-prefix\n" ));
-				usage(git_usage_string);
-			}
-			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, (*argv)[1], 1);
-			if (envchanged)
-				*envchanged = 1;
-			(*argv)++;
-			(*argc)--;
-		} else if (skip_prefix(cmd, "--super-prefix=", &cmd)) {
-			setenv(GIT_SUPER_PREFIX_ENVIRONMENT, cmd, 1);
-			if (envchanged)
-				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			char *cwd = xgetcwd();
 			is_bare_repository_cfg = 1;
@@ -449,11 +433,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		trace_repo_setup(prefix);
 	commit_pager_choice();
 
-	if (!help && get_super_prefix()) {
-		if (!(p->option & SUPPORT_SUPER_PREFIX))
-			die(_("%s doesn't support --super-prefix"), p->cmd);
-	}
-
 	if (!help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
@@ -504,7 +483,7 @@ static struct cmd_struct commands[] = {
 	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout--worker", cmd_checkout__worker,
-		RUN_SETUP | NEED_WORK_TREE | SUPPORT_SUPER_PREFIX },
+		RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
 	{ "cherry", cmd_cherry, RUN_SETUP },
@@ -583,7 +562,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "range-diff", cmd_range_diff, RUN_SETUP | USE_PAGER },
-	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	{ "read-tree", cmd_read_tree, RUN_SETUP },
 	{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
@@ -727,9 +706,6 @@ static void execv_dashed_external(const char **argv)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int status;
 
-	if (get_super_prefix())
-		die(_("%s doesn't support --super-prefix"), argv[0]);
-
 	if (use_pager == -1 && !is_builtin(argv[0]))
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
@@ -799,9 +775,6 @@ static int run_argv(int *argcp, const char ***argv)
 			 */
 			trace2_cmd_name("_run_git_alias_");
 
-			if (get_super_prefix())
-				die("%s doesn't support --super-prefix", **argv);
-
 			commit_pager_choice();
 
 			strvec_push(&cmd.args, "git");
diff --git a/submodule.c b/submodule.c
index 46a03473195..d730b64b072 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2054,14 +2054,6 @@ void submodule_unset_core_worktree(const struct submodule *sub)
 	strbuf_release(&config_path);
 }
 
-static const char *get_super_prefix_or_empty(void)
-{
-	const char *s = get_super_prefix();
-	if (!s)
-		s = "";
-	return s;
-}
-
 static int submodule_has_dirty_index(const struct submodule *sub)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -2080,7 +2072,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 	return finish_command(&cp);
 }
 
-static void submodule_reset_index(const char *path)
+static void submodule_reset_index(const char *path, const char *super_prefix)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	prepare_submodule_repo_env(&cp.env);
@@ -2089,10 +2081,10 @@ static void submodule_reset_index(const char *path)
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-		     get_super_prefix_or_empty(), path);
 	/* TODO: determine if this might overwright untracked files */
 	strvec_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
+		     (super_prefix ? super_prefix : ""), path);
 
 	strvec_push(&cp.args, empty_tree_oid_hex());
 
@@ -2105,10 +2097,9 @@ static void submodule_reset_index(const char *path)
  * For edge cases (a submodule coming into existence or removing a submodule)
  * pass NULL for old or new respectively.
  */
-int submodule_move_head(const char *path,
-			 const char *old_head,
-			 const char *new_head,
-			 unsigned flags)
+int submodule_move_head(const char *path, const char *super_prefix,
+			const char *old_head, const char *new_head,
+			unsigned flags)
 {
 	int ret = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -2146,7 +2137,7 @@ int submodule_move_head(const char *path,
 		if (old_head) {
 			if (!submodule_uses_gitfile(path))
 				absorb_git_dir_into_superproject(path,
-								 get_super_prefix());
+								 super_prefix);
 		} else {
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
@@ -2155,7 +2146,7 @@ int submodule_move_head(const char *path,
 			strbuf_release(&gitdir);
 
 			/* make sure the index is clean as well */
-			submodule_reset_index(path);
+			submodule_reset_index(path, super_prefix);
 		}
 
 		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
@@ -2173,9 +2164,9 @@ int submodule_move_head(const char *path,
 	cp.no_stdin = 1;
 	cp.dir = path;
 
-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
-		     get_super_prefix_or_empty(), path);
 	strvec_pushl(&cp.args, "read-tree", "--recurse-submodules", NULL);
+	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
+		     (super_prefix ? super_prefix : ""), path);
 
 	if (flags & SUBMODULE_MOVE_HEAD_DRY_RUN)
 		strvec_push(&cp.args, "-n");
diff --git a/submodule.h b/submodule.h
index f90ee547d08..c55a25ca37d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -150,9 +150,8 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name);
 
 #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
-int submodule_move_head(const char *path,
-			const char *old,
-			const char *new_head,
+int submodule_move_head(const char *path, const char *super_prefix,
+			const char *old_head, const char *new_head,
 			unsigned flags);
 
 void submodule_unset_core_worktree(const struct submodule *sub);
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 516a6112fdc..3fb1b0c162d 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -370,7 +370,7 @@ test_expect_success 'read-tree supports the super-prefix' '
 	cat <<-EOF >expect &&
 		error: Updating '\''fictional/a'\'' would lose untracked files in it
 	EOF
-	test_must_fail git --super-prefix fictional/ read-tree -u -m "$treeH" "$treeM" 2>actual &&
+	test_must_fail git read-tree --super-prefix fictional/ -u -m "$treeH" "$treeM" 2>actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 2846ec6629c..f519d2a87a7 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,7 +644,7 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
-test_expect_failure 'lazy-fetch in submodule succeeds' '
+test_expect_success 'lazy-fetch in submodule succeeds' '
 	# setup
 	test_config_global protocol.file.allow always &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a762aa0772..2b8e5da4c21 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -71,7 +71,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	  ? ((o)->msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
-static const char *super_prefixed(const char *path)
+static const char *super_prefixed(const char *path, const char *super_prefix)
 {
 	/*
 	 * It is necessary and sufficient to have two static buffers
@@ -83,7 +83,6 @@ static const char *super_prefixed(const char *path)
 	static unsigned idx = ARRAY_SIZE(buf) - 1;
 
 	if (super_prefix_len < 0) {
-		const char *super_prefix = get_super_prefix();
 		if (!super_prefix) {
 			super_prefix_len = 0;
 		} else {
@@ -236,7 +235,8 @@ static int add_rejected_path(struct unpack_trees_options *o,
 		return -1;
 
 	if (!o->show_all_errors)
-		return error(ERRORMSG(o, e), super_prefixed(path));
+		return error(ERRORMSG(o, e), super_prefixed(path,
+							    o->super_prefix));
 
 	/*
 	 * Otherwise, insert in a list for future display by
@@ -263,7 +263,8 @@ static void display_error_msgs(struct unpack_trees_options *o)
 			error_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			error(ERRORMSG(o, e), super_prefixed(path.buf));
+			error(ERRORMSG(o, e), super_prefixed(path.buf,
+							     o->super_prefix));
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -290,7 +291,8 @@ static void display_warning_msgs(struct unpack_trees_options *o)
 			warning_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			warning(ERRORMSG(o, e), super_prefixed(path.buf));
+			warning(ERRORMSG(o, e), super_prefixed(path.buf,
+							       o->super_prefix));
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -312,7 +314,8 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 	if (o->reset)
 		flags |= SUBMODULE_MOVE_HEAD_FORCE;
 
-	if (submodule_move_head(ce->name, old_id, new_id, flags))
+	if (submodule_move_head(ce->name, o->super_prefix, old_id, new_id,
+				flags))
 		return add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
 	return 0;
 }
@@ -415,6 +418,7 @@ static int check_updates(struct unpack_trees_options *o,
 	int i, pc_workers, pc_threshold;
 
 	trace_performance_enter();
+	state.super_prefix = o->super_prefix;
 	state.force = 1;
 	state.quiet = 1;
 	state.refresh_cache = 1;
@@ -445,7 +449,7 @@ static int check_updates(struct unpack_trees_options *o,
 
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
-			unlink_entry(ce);
+			unlink_entry(ce, o->super_prefix);
 		}
 	}
 
@@ -2959,8 +2963,8 @@ int bind_merge(const struct cache_entry * const *src,
 	if (a && old)
 		return o->quiet ? -1 :
 			error(ERRORMSG(o, ERROR_BIND_OVERLAP),
-			      super_prefixed(a->name),
-			      super_prefixed(old->name));
+			      super_prefixed(a->name, o->super_prefix),
+			      super_prefixed(old->name, o->super_prefix));
 	if (!a)
 		return keep_entry(old, o);
 	else
@@ -3021,7 +3025,7 @@ int stash_worktree_untracked_merge(const struct cache_entry * const *src,
 
 	if (worktree && untracked)
 		return error(_("worktree and untracked commit have duplicate entries: %s"),
-			     super_prefixed(worktree->name));
+			     super_prefixed(worktree->name, o->super_prefix));
 
 	return merged_entry(worktree ? worktree : untracked, NULL, o);
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index 6ab0d74c84d..3a7b3e5f007 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -75,6 +75,7 @@ struct unpack_trees_options {
 		     skip_cache_tree_update;
 	enum unpack_trees_reset_type reset;
 	const char *prefix;
+	const char *super_prefix;
 	int cache_bottom;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
-- 
2.39.0.1071.g97ce8966538

