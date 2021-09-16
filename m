Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC5BC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1052E61108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhIPTzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbhIPTzt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D7C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d21so11292193wra.12
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D6GgmCOQrrqIQQRUUSAtCw+OT7RRq2cUlU9egIhAxmQ=;
        b=CJjSB/OOmFZ1vc6KWGO+cOXESbLuUwu9TpcTTb/7CmNH/FII2NYGMEEX35fbrSsRkQ
         HvzXeeCvdDQjtmFrPJf6k+rTeKmfwLagdnHPJIRisPQfGTtuONmMysQDjz4WAuk85I7f
         uQjpNw3hL7F2ev6DsaSwUl8B7uYRHxOYmoDmB9MFiFCkABOp98G/7w2KuHXOrRf5z/e5
         EtDRL1EqmZ0LeUtgFFlc8mrWiwgfd9XFdkcyBm3EQVArh4B+vRrHolweVBvLViVaGvGX
         hVnNPVTKx4rYICXLS5+hI0uvEBJjmpvFCFgZdXHPsug+j0Sc1mF5k2yc8buuMJ8IIeoU
         o2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D6GgmCOQrrqIQQRUUSAtCw+OT7RRq2cUlU9egIhAxmQ=;
        b=bgU57Z/lpdwjmuKvT4jan80Xos71rfp+xIgyY61XnAb7QGZo2CEqxvkxGVjCzf5rID
         zCsGXoMiQg/VeiNG/T5UsQ4nMHlb+6Lhii5lTligSSyhq5oiB++BqnKP7CSg3xie9MbW
         rehHCYOuYGRXivpIwB70x+GH82sQlOz/ZMbEH8+O7ef65K4h3rwFUMJpCILorc/8rU1t
         LElw1MR/w2Th+N2IuNEwQUDUWWJaObAAMBfkU7KcH+ERtiqvUJr8KqxMPesw1A93K+Hm
         xKu4Wct3RhZVEXbcON3I1YgPXUgEUsQje7TCRn7EJV0+i7Ijp7QNUs0Eisnn0yAijsto
         jqNQ==
X-Gm-Message-State: AOAM531SGWvtYQj+xIsgQpze35rFDL8Kr7LEwailNo9c3psbMePmDVp9
        h0mKjZYXL3tiWaEkeC8zNqk9YKiRAtQ=
X-Google-Smtp-Source: ABdhPJxDqhJ1QInUpnPyAVtk5RyXjepnatvwCm9NE1XPf2gf4TDNguo+GRuG4Y0vYvAb+cUPUfrXHw==
X-Received: by 2002:a5d:59ad:: with SMTP id p13mr7908754wrr.253.1631822066562;
        Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm7728432wms.38.2021.09.16.12.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:26 -0700 (PDT)
Message-Id: <f1266c99adfc45a0570f08682b93ca43a3b7e4e4.1631822063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Sep 2021 19:54:21 +0000
Subject: [PATCH 3/5] fsmonitor: config settings are repository-specific
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Move FSMonitor config settings to a new `struct fsmonitor_settings`
structure.  Add a lazily-loaded pointer to `struct repo_settings`.
Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
related config settings.

Get rid of the `core_fsmonitor` global variable, and add support for
the new `core.useBuiltinFSMonitor` config setting.  Move config code
to lookup the existing `core.fsmonitor` value to `fsmonitor-settings.[ch]`.

The `core_fsmonitor` global variable was used to store the pathname to
the FSMonitor hook and it was used as a boolean to see if FSMonitor
was enabled.  This dual usage will lead to confusion when we add
support for a builtin FSMonitor based on IPC, since the builtin
FSMonitor doesn't need the hook pathname.

Replace the boolean usage with an `enum fsmonitor_mode` to represent
the state of FSMonitor.  And only set the pathname when in HOOK mode.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile               |  1 +
 builtin/update-index.c | 19 +++++++--
 cache.h                |  1 -
 config.c               | 14 ------
 config.h               |  1 -
 environment.c          |  1 -
 fsmonitor-settings.c   | 97 ++++++++++++++++++++++++++++++++++++++++++
 fsmonitor-settings.h   | 21 +++++++++
 fsmonitor.c            | 63 ++++++++++++++++-----------
 fsmonitor.h            | 18 ++++++--
 repo-settings.c        |  2 +
 repository.h           |  3 ++
 t/README               |  4 +-
 13 files changed, 194 insertions(+), 51 deletions(-)
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h

diff --git a/Makefile b/Makefile
index 79e72ca9977..8b5d241df72 100644
--- a/Makefile
+++ b/Makefile
@@ -902,6 +902,7 @@ LIB_OBJS += fmt-merge-msg.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
 LIB_OBJS += fsmonitor-ipc.o
+LIB_OBJS += fsmonitor-settings.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..79db3ff37e2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1214,14 +1214,25 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fsmonitor > 0) {
-		if (git_config_get_fsmonitor() == 0)
+		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
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
+		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+		if (fsm_mode == FSMONITOR_MODE_IPC)
+			warning(_("core.useBuiltinFSMonitor is set; "
+				"remove it if you really want to "
+				"disable fsmonitor"));
+		if (fsm_mode == FSMONITOR_MODE_HOOK)
 			warning(_("core.fsmonitor is set; "
 				"remove it if you really want to "
 				"disable fsmonitor"));
diff --git a/cache.h b/cache.h
index d23de693680..fa83dc2aa84 100644
--- a/cache.h
+++ b/cache.h
@@ -990,7 +990,6 @@ extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
-extern const char *core_fsmonitor;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
diff --git a/config.c b/config.c
index cb4a8058bff..7389ddf18f6 100644
--- a/config.c
+++ b/config.c
@@ -2517,20 +2517,6 @@ int git_config_get_max_percent_split_change(void)
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
index a2200f31115..110c426b082 100644
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
index d6b22ede7ea..e6b66315284 100644
--- a/environment.c
+++ b/environment.c
@@ -84,7 +84,6 @@ int protect_hfs = PROTECT_HFS_DEFAULT;
 #define PROTECT_NTFS_DEFAULT 1
 #endif
 int protect_ntfs = PROTECT_NTFS_DEFAULT;
-const char *core_fsmonitor;
 
 /*
  * The character that begins a commented line in user-editable file
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
new file mode 100644
index 00000000000..2770266f5ee
--- /dev/null
+++ b/fsmonitor-settings.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+#include "config.h"
+#include "repository.h"
+#include "fsmonitor-settings.h"
+
+/*
+ * We keep this structure defintion private and have getters
+ * for all fields so that we can lazy load it as needed.
+ */
+struct fsmonitor_settings {
+	enum fsmonitor_mode mode;
+	char *hook_path;
+};
+
+void fsm_settings__set_ipc(struct repository *r)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_IPC;
+}
+
+void fsm_settings__set_hook(struct repository *r, const char *path)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_HOOK;
+	s->hook_path = strdup(path);
+}
+
+void fsm_settings__set_disabled(struct repository *r)
+{
+	struct fsmonitor_settings *s = r->settings.fsmonitor;
+
+	s->mode = FSMONITOR_MODE_DISABLED;
+	FREE_AND_NULL(s->hook_path);
+}
+
+static int check_for_ipc(struct repository *r)
+{
+	int value;
+
+	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) &&
+	    value) {
+		fsm_settings__set_ipc(r);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int check_for_hook(struct repository *r)
+{
+	const char *const_str;
+
+	if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
+		const_str = getenv("GIT_TEST_FSMONITOR");
+
+	if (const_str && *const_str) {
+		fsm_settings__set_hook(r, const_str);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void lookup_fsmonitor_settings(struct repository *r)
+{
+	struct fsmonitor_settings *s;
+
+	CALLOC_ARRAY(s, 1);
+
+	r->settings.fsmonitor = s;
+
+	if (check_for_ipc(r))
+		return;
+
+	if (check_for_hook(r))
+		return;
+
+	fsm_settings__set_disabled(r);
+}
+
+enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
+{
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->mode;
+}
+
+const char *fsm_settings__get_hook_path(struct repository *r)
+{
+	if (!r->settings.fsmonitor)
+		lookup_fsmonitor_settings(r);
+
+	return r->settings.fsmonitor->hook_path;
+}
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
new file mode 100644
index 00000000000..50b29234616
--- /dev/null
+++ b/fsmonitor-settings.h
@@ -0,0 +1,21 @@
+#ifndef FSMONITOR_SETTINGS_H
+#define FSMONITOR_SETTINGS_H
+
+struct repository;
+
+enum fsmonitor_mode {
+	FSMONITOR_MODE_DISABLED = 0,
+	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
+	FSMONITOR_MODE_IPC = 2,  /* core.useBuiltinFSMonitor */
+};
+
+void fsm_settings__set_ipc(struct repository *r);
+void fsm_settings__set_hook(struct repository *r, const char *path);
+void fsm_settings__set_disabled(struct repository *r);
+
+enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
+const char *fsm_settings__get_hook_path(struct repository *r);
+
+struct fsmonitor_settings;
+
+#endif /* FSMONITOR_SETTINGS_H */
diff --git a/fsmonitor.c b/fsmonitor.c
index ec4c46407c5..63174630c0e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -3,6 +3,7 @@
 #include "dir.h"
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
+#include "fsmonitor-ipc.h"
 #include "run-command.h"
 #include "strbuf.h"
 
@@ -148,15 +149,18 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
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
+	if (fsm_settings__get_mode(r) != FSMONITOR_MODE_HOOK)
 		return -1;
 
-	strvec_push(&cp.args, core_fsmonitor);
+	strvec_push(&cp.args, fsm_settings__get_hook_path(r));
 	strvec_pushf(&cp.args, "%d", version);
 	strvec_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
@@ -238,17 +242,28 @@ void refresh_fsmonitor(struct index_state *istate)
 	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
 	unsigned int i;
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 
-	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
+	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
+	    istate->fsmonitor_has_run_once)
 		return;
 
-	hook_version = fsmonitor_hook_version();
-
 	istate->fsmonitor_has_run_once = 1;
 
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
+
+	if (fsm_mode == FSMONITOR_MODE_IPC) {
+		/* TODO */
+		return;
+	}
+
+	assert(fsm_mode == FSMONITOR_MODE_HOOK);
+
+	hook_version = fsmonitor_hook_version();
+
 	/*
-	 * This could be racy so save the date/time now and query_fsmonitor
+	 * This could be racy so save the date/time now and query_fsmonitor_hook
 	 * should be inclusive to ensure we don't miss potential changes.
 	 */
 	last_update = getnanotime();
@@ -256,13 +271,14 @@ void refresh_fsmonitor(struct index_state *istate)
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
@@ -292,13 +308,17 @@ void refresh_fsmonitor(struct index_state *istate)
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
+					fsm_settings__get_hook_path(r));
+		trace_printf_key(&trace_fsmonitor,
+				 "fsmonitor process '%s' returned %s",
+				 fsm_settings__get_hook_path(r),
+				 query_success ? "success" : "failure");
 	}
 
 	/*
@@ -434,7 +454,8 @@ void remove_fsmonitor(struct index_state *istate)
 void tweak_fsmonitor(struct index_state *istate)
 {
 	unsigned int i;
-	int fsmonitor_enabled = git_config_get_fsmonitor();
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	int fsmonitor_enabled = (fsm_settings__get_mode(r) > FSMONITOR_MODE_DISABLED);
 
 	if (istate->fsmonitor_dirty) {
 		if (fsmonitor_enabled) {
@@ -454,16 +475,8 @@ void tweak_fsmonitor(struct index_state *istate)
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
index f20d72631d7..f9201411aa7 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -3,6 +3,7 @@
 
 #include "cache.h"
 #include "dir.h"
+#include "fsmonitor-settings.h"
 
 extern struct trace_key trace_fsmonitor;
 
@@ -57,7 +58,11 @@ int fsmonitor_is_trivial_response(const struct strbuf *query_result);
  */
 static inline int is_fsmonitor_refreshed(const struct index_state *istate)
 {
-	return !core_fsmonitor || istate->fsmonitor_has_run_once;
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+	return fsm_mode <= FSMONITOR_MODE_DISABLED ||
+		istate->fsmonitor_has_run_once;
 }
 
 /*
@@ -67,7 +72,11 @@ static inline int is_fsmonitor_refreshed(const struct index_state *istate)
  */
 static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
 {
-	if (core_fsmonitor && !(ce->ce_flags & CE_FSMONITOR_VALID)) {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+	if (fsm_mode > FSMONITOR_MODE_DISABLED &&
+	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
 		istate->cache_changed = 1;
 		ce->ce_flags |= CE_FSMONITOR_VALID;
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
@@ -83,7 +92,10 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
  */
 static inline void mark_fsmonitor_invalid(struct index_state *istate, struct cache_entry *ce)
 {
-	if (core_fsmonitor) {
+	struct repository *r = istate->repo ? istate->repo : the_repository;
+	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+
+	if (fsm_mode > FSMONITOR_MODE_DISABLED) {
 		ce->ce_flags &= ~CE_FSMONITOR_VALID;
 		untracked_cache_invalidate_path(istate, ce->name, 1);
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_invalid '%s'", ce->name);
diff --git a/repo-settings.c b/repo-settings.c
index 0cfe8b787db..e69dad1e776 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -26,6 +26,8 @@ void prepare_repo_settings(struct repository *r)
 	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
 	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
 
+	r->settings.fsmonitor = NULL; /* lazy loaded */
+
 	if (!repo_config_get_int(r, "index.version", &value))
 		r->settings.index_version = value;
 	if (!repo_config_get_maybe_bool(r, "core.untrackedcache", &value)) {
diff --git a/repository.h b/repository.h
index 3740c93bc0f..fdc0a818b83 100644
--- a/repository.h
+++ b/repository.h
@@ -4,6 +4,7 @@
 #include "path.h"
 
 struct config_set;
+struct fsmonitor_settings;
 struct git_hash_algo;
 struct index_state;
 struct lock_file;
@@ -35,6 +36,8 @@ struct repo_settings {
 	int gc_write_commit_graph;
 	int fetch_write_commit_graph;
 
+	struct fsmonitor_settings *fsmonitor; /* lazy loaded */
+
 	int index_version;
 	enum untracked_cache_setting core_untracked_cache;
 
diff --git a/t/README b/t/README
index 9e701223020..7be3662e038 100644
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
-- 
gitgitgadget

