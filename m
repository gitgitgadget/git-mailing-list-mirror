Received: from sender4-pp-e104.zoho.com (sender4-pp-e104.zoho.com [136.143.188.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD333B6F4
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223936; cv=pass; b=jV6MJMDbcfpbiV8PtRgtMssMYs+Zv7B0cq4eurPcWkLhrU2+tzDWzyEFEMG2S1NfhR3u4WF/bSd/S+GtN//EbxBv98J8l1QmOeqo2Gda07DXpZuJzwJcKUT+Pr7F46Bnx16hwJ0IO64ERGpD1VJTNzNy5hDYBNJ+0aYe0xllGcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223936; c=relaxed/simple;
	bh=iLTWsRf0buhb5AS67cX7FD0Iyxq73ylD42byZaCUxK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjURVxH9JiBG90RfS9taxuz84D2g6kcLL70C94o9XCwG8as88l/exmXHiGxTq4ep66v55DG9aaSj9bxTaxFqUPwbr6l4cRFjbVV7e3ufXFgt/ic3Vwcwcg8GuFHgFZ2T9xJPn1YBPV+4prD0BC6Y9mbHsZb0HN5eMmd+3DLu+8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FnUF37CZ; arc=pass smtp.client-ip=136.143.188.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FnUF37CZ"
ARC-Seal: i=1; a=rsa-sha256; t=1770223908; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ls9xwOxxdc/TmRhHBHMJsZIzdmZdqaJ8JP/Ctc0+det65ojDcrZKJZ6Ap5FX/ahy2OOski6OhsnXqyRSnpX3xvF8aOdzMlivpJAvKyp8imsT/EwM1md3S5WmZp9CTtqvUFD1/p027KGYNgaZtiwJmnBabAEVd6SRau9BUWs8+Mw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770223908; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CJM7yFEIjrnUsJmnd5ixyWWaqJl5kPgUbSpIBF4ijgk=; 
	b=SK3saXDmc8XOU+IHTwAY+ts+x24sYWq2Iwnu5vrYlymuni/uOfOWBA2ZeACRa7bM8WGXW1WlRiwDEZjhzDb3p1JIVnNotJjG0qCKepo2m4V3sTjTL0NuI4sfRrYYmxgBBVFyicbJ9/vl8gPPttTsFWRqyejjdst/zviyiA/MY+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770223907;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CJM7yFEIjrnUsJmnd5ixyWWaqJl5kPgUbSpIBF4ijgk=;
	b=FnUF37CZk3leLDpBfZoc40ZQPtBtgDXnWQeJbjRZkjSJ5GOfcxFvy6UNaInSIjOo
	uN+VoREooHpa2B/rXeqdB20HarUC/xUu7pvrULjEz5V3QE5jbAVODrIkrO7s4XDiWN4
	w6POe0k2oU5tqC957E8kHyinyrmhexwupnwgzsVA=
Received: by mx.zohomail.com with SMTPS id 1770223905498789.9733882485499;
	Wed, 4 Feb 2026 08:51:45 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 1/4] hook: run a list of hooks
Date: Wed,  4 Feb 2026 18:51:23 +0200
Message-ID: <20260204165126.1548805-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Teach hook.[hc] to run lists of hooks to prepare for multihook support.

Currently, the hook list contains only one entry representing the
"legacy" hook from the hookdir, but next commits will allow users
to supply more than one executable/command for a single hook event
in addition to these default "legacy" hooks.

All hook commands still run sequentially. A further patch series will
enable running them in parallel by increasing .jobs > 1 where possible.

Each hook command requires its own internal state copy, even when
running sequentially, so add an API to allow hooks to duplicate/free
their internal void *pp_task_cb state.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c |  23 ++++++-
 hook.c                 | 133 +++++++++++++++++++++++++++++++++--------
 hook.h                 |  38 +++++++++++-
 refs.c                 |  23 ++++++-
 transport.c            |  23 ++++++-
 5 files changed, 210 insertions(+), 30 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b5379a4895..72fde2207c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -849,7 +849,8 @@ struct receive_hook_feed_state {
 
 static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
 {
-	struct receive_hook_feed_state *state = pp_task_cb;
+	struct string_list_item *h = pp_task_cb;
+	struct receive_hook_feed_state *state = h->util;
 	struct command *cmd = state->cmd;
 
 	strbuf_reset(&state->buf);
@@ -901,6 +902,24 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
 	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
 }
 
+static void *copy_receive_hook_feed_state(const void *data)
+{
+	const struct receive_hook_feed_state *orig = data;
+	struct receive_hook_feed_state *new_data = xmalloc(sizeof(*new_data));
+	memcpy(new_data, orig, sizeof(*new_data));
+	strbuf_init(&new_data->buf, 0);
+	return new_data;
+}
+
+static void free_receive_hook_feed_state(void *data)
+{
+	struct receive_hook_feed_state *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_receive_hook(struct command *commands,
 			    const char *hook_name,
 			    int skip_broken,
@@ -944,6 +963,8 @@ static int run_receive_hook(struct command *commands,
 	strbuf_init(&feed_state.buf, 0);
 	opt.feed_pipe_cb_data = &feed_state;
 	opt.feed_pipe = feed_receive_hook_cb;
+	opt.copy_feed_pipe_cb_data = copy_receive_hook_feed_state;
+	opt.free_feed_pipe_cb_data = free_receive_hook_feed_state;
 
 	ret = run_hooks_opt(the_repository, hook_name, &opt);
 
diff --git a/hook.c b/hook.c
index cde7198412..fb90f91f3b 100644
--- a/hook.c
+++ b/hook.c
@@ -47,9 +47,49 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
+/*
+ * Provides a list of hook commands to run for the 'hookname' event.
+ *
+ * This function consolidates hooks from two sources:
+ * 1. The config-based hooks (not yet implemented).
+ * 2. The "traditional" hook found in the repository hooks directory
+ *    (e.g., .git/hooks/pre-commit).
+ *
+ * The list is ordered by execution priority.
+ *
+ * The caller is responsible for freeing the memory of the returned list
+ * using string_list_clear() and free().
+ */
+static struct string_list *list_hooks(struct repository *r, const char *hookname)
+{
+	struct string_list *hook_head;
+
+	if (!hookname)
+		BUG("null hookname was provided to hook_list()!");
+
+	hook_head = xmalloc(sizeof(struct string_list));
+	string_list_init_dup(hook_head);
+
+	/*
+	 * Add the default hook from hookdir. It does not have a friendly name
+	 * like the hooks specified via configs, so add it with an empty name.
+	 */
+	if (r->gitdir && find_hook(r, hookname))
+		string_list_append(hook_head, "");
+
+	return hook_head;
+}
+
 int hook_exists(struct repository *r, const char *name)
 {
-	return !!find_hook(r, name);
+	int exists = 0;
+	struct string_list *hooks = list_hooks(r, name);
+
+	exists = hooks->nr > 0;
+
+	string_list_clear(hooks, 1);
+	free(hooks);
+	return exists;
 }
 
 static int pick_next_hook(struct child_process *cp,
@@ -58,10 +98,11 @@ static int pick_next_hook(struct child_process *cp,
 			  void **pp_task_cb)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
-	const char *hook_path = hook_cb->hook_path;
+	struct string_list *hook_list = hook_cb->hook_command_list;
+	struct string_list_item *to_run = hook_cb->next_hook++;
 
-	if (!hook_path)
-		return 0;
+	if (!to_run || to_run >= hook_list->items + hook_list->nr)
+		return 0; /* no hook left to run */
 
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
@@ -85,33 +126,50 @@ static int pick_next_hook(struct child_process *cp,
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
-	strvec_push(&cp->args, hook_path);
+	/* find hook commands */
+	if (!*to_run->string) {
+		/* ...from hookdir signified by empty name */
+		const char *hook_path = find_hook(hook_cb->repository,
+						  hook_cb->hook_name);
+		if (!hook_path)
+			BUG("hookdir in hook list but no hook present in filesystem");
+
+		if (hook_cb->options->dir)
+			hook_path = absolute_path(hook_path);
+
+		strvec_push(&cp->args, hook_path);
+	}
+
+	if (!cp->args.nr)
+		BUG("configured hook must have at least one command");
+
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
 
 	/*
 	 * Provide per-hook internal state via task_cb for easy access, so
 	 * hook callbacks don't have to go through hook_cb->options.
 	 */
-	*pp_task_cb = hook_cb->options->feed_pipe_cb_data;
-
-	/*
-	 * This pick_next_hook() will be called again, we're only
-	 * running one hook, so indicate that no more work will be
-	 * done.
-	 */
-	hook_cb->hook_path = NULL;
+	*pp_task_cb = to_run;
 
 	return 1;
 }
 
-static int notify_start_failure(struct strbuf *out UNUSED,
+static int notify_start_failure(struct strbuf *out,
 				void *pp_cb,
-				void *pp_task_cp UNUSED)
+				void *pp_task_cb)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
+	struct string_list_item *hook = pp_task_cb;
 
 	hook_cb->rc |= 1;
 
+	if (out && hook) {
+		if (*hook->string)
+			strbuf_addf(out, _("Couldn't start hook '%s'\n"), hook->string);
+		else
+			strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
+	}
+
 	return 1;
 }
 
@@ -145,8 +203,9 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.rc = 0,
 		.hook_name = hook_name,
 		.options = options,
+		.hook_command_list = list_hooks(r, hook_name),
+		.repository = r,
 	};
-	const char *const hook_path = find_hook(r, hook_name);
 	int ret = 0;
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
@@ -172,26 +231,50 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (!options->jobs)
 		BUG("run_hooks_opt must be called with options.jobs >= 1");
 
+	/*
+	 * Ensure cb_data copy and free functions are either provided together,
+	 * or neither one is provided.
+	 */
+	if ((options->copy_feed_pipe_cb_data && !options->free_feed_pipe_cb_data) ||
+	    (!options->copy_feed_pipe_cb_data && options->free_feed_pipe_cb_data))
+		BUG("copy_feed_pipe_cb_data and free_feed_pipe_cb_data must be set together");
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
-	if (!hook_path && !options->error_if_missing)
-		goto cleanup;
-
-	if (!hook_path) {
-		ret = error("cannot find a hook named %s", hook_name);
+	if (!cb_data.hook_command_list->nr) {
+		if (options->error_if_missing)
+			ret = error("cannot find a hook named %s", hook_name);
 		goto cleanup;
 	}
 
-	cb_data.hook_path = hook_path;
-	if (options->dir) {
-		strbuf_add_absolute_path(&abs_path, hook_path);
-		cb_data.hook_path = abs_path.buf;
+	/*
+	 * Initialize the iterator/cursor which holds the next hook to run.
+	 * run_process_parallel() calls pick_next_hook() which increments it for
+	 * each hook command in the list until all hooks have been run.
+	 */
+	cb_data.next_hook = cb_data.hook_command_list->items;
+
+	/*
+	 * Give each hook its own copy of the initial void *pp_task_cb state, if
+	 * a copy callback was provided.
+	 */
+	if (options->copy_feed_pipe_cb_data) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, cb_data.hook_command_list)
+			item->util = options->copy_feed_pipe_cb_data(options->feed_pipe_cb_data);
 	}
 
 	run_processes_parallel(&opts);
 	ret = cb_data.rc;
 cleanup:
+	if (options->free_feed_pipe_cb_data) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, cb_data.hook_command_list)
+			options->free_feed_pipe_cb_data(item->util);
+	}
+	string_list_clear(cb_data.hook_command_list, 0);
+	free(cb_data.hook_command_list);
 	strbuf_release(&abs_path);
 	run_hooks_opt_clear(options);
 	return ret;
diff --git a/hook.h b/hook.h
index 20eb56fd63..33a0e33684 100644
--- a/hook.h
+++ b/hook.h
@@ -2,6 +2,7 @@
 #define HOOK_H
 #include "strvec.h"
 #include "run-command.h"
+#include "string-list.h"
 
 struct repository;
 
@@ -86,12 +87,28 @@ struct run_hooks_opt
 	 * Opaque data pointer used to keep internal state across callback calls.
 	 *
 	 * It can be accessed directly via the third callback arg 'pp_task_cb':
-	 * struct ... *state = pp_task_cb;
+	 * struct ... *state = ((struct string_list_item *)pp_task_cb)->util;
 	 *
 	 * The caller is responsible for managing the memory for this data.
 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
+
+	/**
+	 * Some hooks need a copy of the initial `feed_pipe_cb_data` state, so
+	 * they can keep track of progress without affecting one another.
+	 *
+	 * If provided, this function will be called to copy `feed_pipe_cb_data`
+	 * for each hook.
+	 */
+	void *(*copy_feed_pipe_cb_data)(const void *data);
+
+	/**
+	 * Called to free the memory duplicated by `copy_feed_pipe_cb_data`.
+	 *
+	 * Must always be provided when `copy_feed_pipe_cb_data` is provided.
+	 */
+	void (*free_feed_pipe_cb_data)(void *data);
 };
 
 #define RUN_HOOKS_OPT_INIT { \
@@ -105,8 +122,25 @@ struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
 	const char *hook_name;
-	const char *hook_path;
+
+	/**
+	 * A list of hook commands/paths to run for the 'hook_name' event.
+	 *
+	 * The 'string' member of each item contains the executable path (e.g.
+	 * "/path/to/.git/hooks/pre-commit") or command.
+	 */
+	struct string_list *hook_command_list;
+
+	/**
+	 * Iterator/cursor for the above list, pointing to the next hook to run.
+	 *
+	 * The 'util' member of the string_list_item holds the per-hook state
+	 * data (feed_pipe_cb_data) which is passed to callbacks via 'pp_task_cb'.
+	 */
+	struct string_list_item *next_hook;
+
 	struct run_hooks_opt *options;
+	struct repository *repository;
 };
 
 /*
diff --git a/refs.c b/refs.c
index 1e2ac90018..d1a1ace641 100644
--- a/refs.c
+++ b/refs.c
@@ -2472,7 +2472,8 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 {
 	struct hook_cb_data *hook_cb = pp_cb;
 	struct ref_transaction *transaction = hook_cb->options->feed_pipe_ctx;
-	struct transaction_feed_cb_data *feed_cb_data = pp_task_cb;
+	struct string_list_item *hook = pp_task_cb;
+	struct transaction_feed_cb_data *feed_cb_data = hook->util;
 	struct strbuf *buf = &feed_cb_data->buf;
 	struct ref_update *update;
 	size_t i = feed_cb_data->index++;
@@ -2511,6 +2512,24 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 	return 0; /* no more input to feed */
 }
 
+static void *copy_transaction_feed_cb_data(const void *data)
+{
+	struct transaction_feed_cb_data *new_data = xmalloc(sizeof(struct transaction_feed_cb_data));
+	memcpy(new_data, data, sizeof(struct transaction_feed_cb_data));
+	strbuf_init(&new_data->buf, 0);
+	new_data->index = 0; /* a fresh iterator for each hook */
+	return new_data;
+}
+
+static void free_transaction_feed_cb_data(void *data)
+{
+	struct transaction_feed_cb_data *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
@@ -2523,6 +2542,8 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	opt.feed_pipe = transaction_hook_feed_stdin;
 	opt.feed_pipe_ctx = transaction;
 	opt.feed_pipe_cb_data = &feed_ctx;
+	opt.copy_feed_pipe_cb_data = copy_transaction_feed_cb_data;
+	opt.free_feed_pipe_cb_data = free_transaction_feed_cb_data;
 
 	strbuf_init(&feed_ctx.buf, 0);
 
diff --git a/transport.c b/transport.c
index e876cc9189..176050e663 100644
--- a/transport.c
+++ b/transport.c
@@ -1323,7 +1323,8 @@ struct feed_pre_push_hook_data {
 
 static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
 {
-	struct feed_pre_push_hook_data *data = pp_task_cb;
+	struct string_list_item *h = pp_task_cb;
+	struct feed_pre_push_hook_data *data = h->util;
 	const struct ref *r = data->refs;
 	int ret = 0;
 
@@ -1357,6 +1358,24 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
 	return 0;
 }
 
+static void *copy_pre_push_hook_data(const void *data)
+{
+	const struct feed_pre_push_hook_data *orig = data;
+	struct feed_pre_push_hook_data *new_data = xmalloc(sizeof(*new_data));
+	strbuf_init(&new_data->buf, 0);
+	new_data->refs = orig->refs;
+	return new_data;
+}
+
+static void free_pre_push_hook_data(void *data)
+{
+	struct feed_pre_push_hook_data *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
@@ -1372,6 +1391,8 @@ static int run_pre_push_hook(struct transport *transport,
 
 	opt.feed_pipe = pre_push_hook_feed_stdin;
 	opt.feed_pipe_cb_data = &data;
+	opt.copy_feed_pipe_cb_data = copy_pre_push_hook_data;
+	opt.free_feed_pipe_cb_data = free_pre_push_hook_data;
 
 	/*
 	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
-- 
2.52.0.732.gb351b5166d.dirty

