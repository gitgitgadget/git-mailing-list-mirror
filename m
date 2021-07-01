Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EF7C11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEEC6140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhGAOu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhGAOuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C364DC0613DB
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so7034997wms.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mMIzOiO//AaaC5WUT/3D5iEauks3LZySkNj2HRQPzwo=;
        b=rujT/M4R3LBhSiJXyxHsrWwgqZhZxV1uUlS+bShByIKKhpppvcUEbqYQoviUYrJKWM
         Yw/GXwk9tGKtJqizlRgY9OXWyOKdH1+6JJ0rzSQFKNcLJQmMwpaZ5MleUAx+L+z7tt2t
         Nbsu9U+KnygHoQLFowTnpr0hnVsgXuzfZ8zHPCUiEQFPnJ1BffbskXg4WWiQm1bj7xHi
         EHJ5sS40mW5Tuv+xFr2VeHeau3e1Cd14tOCKuArXCnjd0NwMZLLZV083Ay0Ip8yzJqX0
         jKIKeizrPHx267gr7DHLCjxM8Cgrs4DWKT1PXZLeOFpfdYZpNzsssaRTGIfE8XyrdVCE
         S2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mMIzOiO//AaaC5WUT/3D5iEauks3LZySkNj2HRQPzwo=;
        b=q4HRd7zM/GLLS76t4zNLcmpJHsdst1MPbeYnpyyYn+ir16Ahqbjshnq2cPTfRHZqMB
         UPuifRUhLvUV7zggFarevvahtdZQgWlVdXHx5VrLl3R/n3HvoMOeejiR6zmtSdnQHaDt
         BruHA4btfZ4q7yHW+MRHEBNNrdDYhWVrh9NBBMNh1Rkqec/7RFa87eToaxEm1r5NDplW
         ccTbHS+caQnk/9qjca+Kb1UvyPAzcLKFijNAgkK3+LLJ915vzbrXvUNcBQeanVAits5d
         4ehDzEfGqNPbdSuotuJLrMGL9oMYoJiTKx0YUcv+JmbLYcShzT4aSA1upYpXFBKyqM0Y
         fEgQ==
X-Gm-Message-State: AOAM5313YPuratcAUqywyHce5dPeKDo6rF2b39PGTyWWfOab5T8wEHC/
        QCQD8MJBLEzcIU2kD4YgL4xxfwJEii8=
X-Google-Smtp-Source: ABdhPJxEmm3hJMA7JMfMSdMLEuCvqwx9JpcCtDGtJmIkZuh5O8dWLZzGFaI/RI6uiEZvvFzlS4/Dhw==
X-Received: by 2002:a1c:b306:: with SMTP id c6mr11048183wmf.37.1625150869306;
        Thu, 01 Jul 2021 07:47:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm132886wrw.42.2021.07.01.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:49 -0700 (PDT)
Message-Id: <8b64b7cd3674163adb0588d42eccf4873b30974b.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:16 +0000
Subject: [PATCH v3 06/34] fsmonitor: config settings are repository-specific
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Move FSMonitor config settings to `struct repo_settings`, get rid of
the `core_fsmonitor` global variable, and add support for the new
`core.useBuiltinFSMonitor` config setting.  Move config code to lookup
`core.fsmonitor` into `prepare_repo_settings()` with the rest of the
setup code.

The `core_fsmonitor` global variable was used to store the pathname to
the FSMonitor hook and it was used as a boolean to see if FSMonitor
was enabled.  This dual usage will lead to confusion when we add
support for a builtin FSMonitor based on IPC, since the builtin
FSMonitor doesn't need the hook pathname.

Replace the boolean usage with an `enum fsmonitor_mode` to represent
the state of FSMonitor.  And only set the pathname when in HOOK mode.

Also, disable FSMonitor when the repository working directory is
incompatible.  For example, in bare repositories, since there aren't
any files to watch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/update-index.c      | 20 +++++++++---
 cache.h                     |  1 -
 config.c                    | 14 --------
 config.h                    |  1 -
 environment.c               |  1 -
 fsmonitor.c                 | 65 +++++++++++++++++++++++--------------
 fsmonitor.h                 | 14 ++++++--
 repo-settings.c             | 48 +++++++++++++++++++++++++++
 repository.h                | 11 +++++++
 t/README                    |  4 +--
 t/t7519-status-fsmonitor.sh | 22 +++++++++++++
 11 files changed, 150 insertions(+), 51 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f1f16f2de52..0141899caa3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1216,14 +1216,26 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fsmonitor > 0) {
-		if (git_config_get_fsmonitor() == 0)
+		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_INCOMPATIBLE)
+			return error(
+				_("repository is incompatible with fsmonitor"));
+
+		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_DISABLED) {
+			warning(_("core.useBuiltinFSMonitor is unset; "
+				"set it if you really want to enable the "
+				"builtin fsmonitor"));
 			warning(_("core.fsmonitor is unset; "
-				"set it if you really want to "
-				"enable fsmonitor"));
+				"set it if you really want to enable the "
+				"hook-based fsmonitor"));
+		}
 		add_fsmonitor(&the_index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
-		if (git_config_get_fsmonitor() == 1)
+		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_IPC)
+			warning(_("core.useBuiltinFSMonitor is set; "
+				"remove it if you really want to "
+				"disable fsmonitor"));
+		if (r->settings.fsmonitor_mode == FSMONITOR_MODE_HOOK)
 			warning(_("core.fsmonitor is set; "
 				"remove it if you really want to "
 				"disable fsmonitor"));
diff --git a/cache.h b/cache.h
index ba04ff8bd36..50463876852 100644
--- a/cache.h
+++ b/cache.h
@@ -981,7 +981,6 @@ extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
-extern const char *core_fsmonitor;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
diff --git a/config.c b/config.c
index f9c400ad306..ec3b88b4639 100644
--- a/config.c
+++ b/config.c
@@ -2516,20 +2516,6 @@ int git_config_get_max_percent_split_change(void)
 	return -1; /* default value */
 }
 
-int git_config_get_fsmonitor(void)
-{
-	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
-		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
-
-	if (core_fsmonitor && !*core_fsmonitor)
-		core_fsmonitor = NULL;
-
-	if (core_fsmonitor)
-		return 1;
-
-	return 0;
-}
-
 int git_config_get_index_threads(int *dest)
 {
 	int is_bool, val;
diff --git a/config.h b/config.h
index 9038538ffdc..b8d6b75d4fe 100644
--- a/config.h
+++ b/config.h
@@ -609,7 +609,6 @@ int git_config_get_index_threads(int *dest);
 int git_config_get_untracked_cache(void);
 int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
-int git_config_get_fsmonitor(void);
 
 /* This dies if the configured or default date is in the future */
 int git_config_get_expiry(const char *key, const char **output);
diff --git a/environment.c b/environment.c
index 2f27008424a..7b5e8ff78da 100644
--- a/environment.c
+++ b/environment.c
@@ -84,7 +84,6 @@ int protect_hfs = PROTECT_HFS_DEFAULT;
 #define PROTECT_NTFS_DEFAULT 1
 #endif
 int protect_ntfs = PROTECT_NTFS_DEFAULT;
-const char *core_fsmonitor;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/fsmonitor.c b/fsmonitor.c
index ab9bfc60b34..374189be7d9 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
 #include "run-command.h"
 #include "strbuf.h"
 
@@ -148,15 +149,21 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 /*
  * Call the query-fsmonitor hook passing the last update token of the saved results.
  */
-static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
+static int query_fsmonitor_hook(struct repository *r,
+				int version,
+				const char *last_update,
+				struct strbuf *query_result)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int result;
 
-	if (!core_fsmonitor)
+	if (r->settings.fsmonitor_mode != FSMONITOR_MODE_HOOK)
 		return -1;
 
-	strvec_push(&cp.args, core_fsmonitor);
+	assert(r->settings.fsmonitor_hook_path);
+	assert(*r->settings.fsmonitor_hook_path);
+
+	strvec_push(&cp.args, r->settings.fsmonitor_hook_path);
 	strvec_pushf(&cp.args, "%d", version);
 	strvec_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
@@ -238,17 +245,27 @@ void refresh_fsmonitor(struct index_state *istate)
 	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
 	unsigned int i;
+	struct repository *r = istate->repo ? istate->repo : the_repository;
 
-	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
+	if (r->settings.fsmonitor_mode <= FSMONITOR_MODE_DISABLED ||
+	    istate->fsmonitor_has_run_once)
 		return;
 
-	hook_version = fsmonitor_hook_version();
-
 	istate->fsmonitor_has_run_once = 1;
 
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
+
+	if (r->settings.fsmonitor_mode == FSMONITOR_MODE_IPC) {
+		/* TODO */
+		return;
+	}
+
+	assert(r->settings.fsmonitor_mode == FSMONITOR_MODE_HOOK);
+
+	hook_version = fsmonitor_hook_version();
+
 	/*
-	 * This could be racy so save the date/time now and query_fsmonitor
+	 * This could be racy so save the date/time now and query_fsmonitor_hook
 	 * should be inclusive to ensure we don't miss potential changes.
 	 */
 	last_update = getnanotime();
@@ -256,13 +273,14 @@ void refresh_fsmonitor(struct index_state *istate)
 		strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
 
 	/*
-	 * If we have a last update token, call query_fsmonitor for the set of
+	 * If we have a last update token, call query_fsmonitor_hook for the set of
 	 * changes since that token, else assume everything is possibly dirty
 	 * and check it all.
 	 */
 	if (istate->fsmonitor_last_update) {
 		if (hook_version == -1 || hook_version == HOOK_INTERFACE_VERSION2) {
-			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION2,
+			query_success = !query_fsmonitor_hook(
+				r, HOOK_INTERFACE_VERSION2,
 				istate->fsmonitor_last_update, &query_result);
 
 			if (query_success) {
@@ -292,13 +310,17 @@ void refresh_fsmonitor(struct index_state *istate)
 		}
 
 		if (hook_version == HOOK_INTERFACE_VERSION1) {
-			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
+			query_success = !query_fsmonitor_hook(
+				r, HOOK_INTERFACE_VERSION1,
 				istate->fsmonitor_last_update, &query_result);
 		}
 
-		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
-		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
-			core_fsmonitor, query_success ? "success" : "failure");
+		trace_performance_since(last_update, "fsmonitor process '%s'",
+					r->settings.fsmonitor_hook_path);
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor process '%s' returned %s",
+				 r->settings.fsmonitor_hook_path,
+				 query_success ? "success" : "failure");
 	}
 
 	/* a fsmonitor process can return '/' to indicate all entries are invalid */
@@ -411,7 +433,8 @@ void remove_fsmonitor(struct index_state *istate)
 void tweak_fsmonitor(struct index_state *istate)
 {
 	unsigned int i;
-	int fsmonitor_enabled = git_config_get_fsmonitor();
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	int fsmonitor_enabled = r->settings.fsmonitor_mode > FSMONITOR_MODE_DISABLED;
 
 	if (istate->fsmonitor_dirty) {
 		if (fsmonitor_enabled) {
@@ -431,16 +454,8 @@ void tweak_fsmonitor(struct index_state *istate)
 		istate->fsmonitor_dirty = NULL;
 	}
 
-	switch (fsmonitor_enabled) {
-	case -1: /* keep: do nothing */
-		break;
-	case 0: /* false */
-		remove_fsmonitor(istate);
-		break;
-	case 1: /* true */
+	if (fsmonitor_enabled)
 		add_fsmonitor(istate);
-		break;
-	default: /* unknown value: do nothing */
-		break;
-	}
+	else
+		remove_fsmonitor(istate);
 }
diff --git a/fsmonitor.h b/fsmonitor.h
index f20d72631d7..9cc14e05239 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -57,7 +57,10 @@ int fsmonitor_is_trivial_response(const struct strbuf *query_result);
  */
 static inline int is_fsmonitor_refreshed(const struct index_state *istate)
 {
-	return !core_fsmonitor || istate->fsmonitor_has_run_once;
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+
+	return r->settings.fsmonitor_mode <= FSMONITOR_MODE_DISABLED ||
+		istate->fsmonitor_has_run_once;
 }
 
 /*
@@ -67,7 +70,10 @@ static inline int is_fsmonitor_refreshed(const struct index_state *istate)
  */
 static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
 {
-	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+
+	if (r->settings.fsmonitor_mode > FSMONITOR_MODE_DISABLED &&
+	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
 		istate->cache_changed = 1;
 		ce->ce_flags |= CE_FSMONITOR_VALID;
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
@@ -83,7 +89,9 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
  */
 static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
 {
-	if (core_fsmonitor) {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+
+	if (r->settings.fsmonitor_mode > FSMONITOR_MODE_DISABLED) {
 		ce->ce_flags &= ~CE_FSMONITOR_VALID;
 		untracked_cache_invalidate_path(istate, ce->name, 1);
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
diff --git a/repo-settings.c b/repo-settings.c
index 0cfe8b787db..faf197ff60a 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -5,10 +5,42 @@
 
 #define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
 
+/*
+ * Return 1 if the repo/workdir is incompatible with FSMonitor.
+ */
+static int is_repo_incompatible_with_fsmonitor(struct repository *r)
+{
+	const char *const_strval;
+
+	/*
+	 * Bare repositories don't have a working directory and
+	 * therefore, nothing to watch.
+	 */
+	if (!r->worktree)
+		return 1;
+
+	/*
+	 * GVFS (aka VFS for Git) is incompatible with FSMonitor.
+	 *
+	 * Granted, core Git does not know anything about GVFS and
+	 * we shouldn't make assumptions about a downstream feature,
+	 * but users can install both versions.  And this can lead
+	 * to incorrect results from core Git commands.  So, without
+	 * bringing in any of the GVFS code, do a simple config test
+	 * for a published config setting.  (We do not look at the
+	 * various *_TEST_* environment variables.)
+	 */
+	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_strval))
+		return 1;
+
+	return 0;
+}
+
 void prepare_repo_settings(struct repository *r)
 {
 	int value;
 	char *strval;
+	const char *const_strval;
 
 	if (r->settings.initialized)
 		return;
@@ -26,6 +58,22 @@ void prepare_repo_settings(struct repository *r)
 	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
 	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
 
+	r->settings.fsmonitor_hook_path = NULL;
+	r->settings.fsmonitor_mode = FSMONITOR_MODE_DISABLED;
+	if (is_repo_incompatible_with_fsmonitor(r))
+		r->settings.fsmonitor_mode = FSMONITOR_MODE_INCOMPATIBLE;
+	else if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value)
+		   && value)
+		r->settings.fsmonitor_mode = FSMONITOR_MODE_IPC;
+	else {
+		if (repo_config_get_pathname(r, "core.fsmonitor", &const_strval))
+			const_strval = getenv("GIT_TEST_FSMONITOR");
+		if (const_strval && *const_strval) {
+			r->settings.fsmonitor_hook_path = strdup(const_strval);
+			r->settings.fsmonitor_mode = FSMONITOR_MODE_HOOK;
+		}
+	}
+
 	if (!repo_config_get_int(r, "index.version", &value))
 		r->settings.index_version = value;
 	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
diff --git a/repository.h b/repository.h
index a45f7520fd9..09154298ba1 100644
--- a/repository.h
+++ b/repository.h
@@ -26,6 +26,14 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP = 3,
 };
 
+enum fsmonitor_mode {
+	FSMONITOR_MODE_INCOMPATIBLE = -2,
+	FSMONITOR_MODE_UNSET = -1,
+	FSMONITOR_MODE_DISABLED = 0,
+	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
+	FSMONITOR_MODE_IPC = 2, /* core.useBuiltinFSMonitor */
+};
+
 struct repo_settings {
 	int initialized;
 
@@ -34,6 +42,9 @@ struct repo_settings {
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 
+	enum fsmonitor_mode fsmonitor_mode;
+	char *fsmonitor_hook_path;
+
 	int index_version;
 	enum untracked_cache_setting core_untracked_cache;
 
diff --git a/t/README b/t/README
index 1a2072b2c8a..852a4eae9da 100644
--- a/t/README
+++ b/t/README
@@ -398,8 +398,8 @@ every 'git commit-graph write', as if the `--changed-paths` option was
 passed in.
 
 GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
-code path for utilizing a file system monitor to speed up detecting
-new or changed files.
+code path for utilizing a (hook based) file system monitor to speed up
+detecting new or changed files.
 
 GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
 for the index version specified.  Can be set to any valid version
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 637391c6ce4..02919c68ddd 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -383,4 +383,26 @@ test_expect_success 'status succeeds after staging/unstaging' '
 	)
 '
 
+# Test that we detect and disallow repos that are incompatible with FSMonitor.
+test_expect_success 'incompatible bare repo' '
+	test_when_finished "rm -rf ./bare-clone" &&
+	git clone --bare . ./bare-clone &&
+	cat >expect <<-\EOF &&
+	error: repository is incompatible with fsmonitor
+	EOF
+	test_must_fail git -C ./bare-clone update-index --fsmonitor 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'incompatible core.virtualfilesystem' '
+	test_when_finished "rm -rf ./fake-gvfs-clone" &&
+	git clone . ./fake-gvfs-clone &&
+	git -C ./fake-gvfs-clone config core.virtualfilesystem true &&
+	cat >expect <<-\EOF &&
+	error: repository is incompatible with fsmonitor
+	EOF
+	test_must_fail git -C ./fake-gvfs-clone update-index --fsmonitor 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

