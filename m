Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F98C001EA
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BF761284
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhDARnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhDARjk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B37C02D549
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1125419wmq.4
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CnoTzJHVAuf871k/UDSVW/LJi9azU3ymhIRK0wnLjGI=;
        b=NKBBA8Lvp3ABGuM7fVb+z3V367lL7uubSNMT9o+n7mmE9XO9Hm7IzypRZ2WqDOtc6T
         QW0nYBe7MKBQONyZurQyXyRQKusv9aVrWYAgEacAoO+M6+HRcYfR1JmquAAnv3XwHfOP
         i7aOeEp1XADLe3uHn85vnZ6zrEfmiSJDYEm+AxRQzu3JNh2Z5vE5J8tcEQFgrg7hao1m
         0ebRKuVKSCGoaMMsb1Xim+ZNxDmViWk96z72tcLQIkP795m11QgaZDgNYPESj69DXbKh
         C0w7KVa6bvlxyjQfg8qeC4/75GCZFQVeE12QoCHMA9gGvUz4V8p0a9JuEbA2FEG3bUfG
         JP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CnoTzJHVAuf871k/UDSVW/LJi9azU3ymhIRK0wnLjGI=;
        b=jDUmWh80vGK/knmLeMVyQl8z/u1V7UTEe7c6Retj7xqzb5X0AJ1t2FYztqINiAsSJP
         xhn2s2h01kM0hIYv/wVRuSjaMDNiYaW2OgvWZUhqPx8URZ8w4Mg4/3IrwqGKBlCjoD7b
         BKzHmWBsSc1hqPmbsBRZ0ylXJk6XjE/U3lbqIzfEzFwVxXFtDSQR9+xY/DGh+1skID42
         UA/FGy6qFlhg4pJ+yJOl9cQmP53GAoC7aTBvVCn0OUnvoq/wlr3492YUZgP9UJUHvlBU
         TO/3uIHeuJRaEhMSs0lvL4IHoEg7Lz+D9iUe0bdVEadv+/4v0kLY7D3DaEgQztFAhcOx
         C+bg==
X-Gm-Message-State: AOAM531oh3kmDPII2z5ca/a1dTWTyoe4NEUf7gwFd3ukuCV35abUxI8B
        zGoDizedzS2AVJsz3RT+JMQ+SaEWsW0=
X-Google-Smtp-Source: ABdhPJxo12OlRmrooRgedRL64mkuImYPCfRdFrX4dRDVKlZCRQ36kvQpCDsGtxzCMYSw4O/wmbIjpA==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr8905703wmk.49.1617291679866;
        Thu, 01 Apr 2021 08:41:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm10157966wrx.46.2021.04.01.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:19 -0700 (PDT)
Message-Id: <038b62dc6744e8d8004f3f8423a40066821c0f1b.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:41:01 +0000
Subject: [PATCH 19/23] fsmonitor--daemon: use a cookie file to sync with file
 system
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

Teach fsmonitor--daemon client threads to create a cookie file
inside the .git directory and then wait until FS events for the
cookie are observed by the FS listener thread.

This helps address the racy nature of file system events by
blocking the client response until the kernel has drained any
event backlog.

This is especially important on MacOS where kernel events are
only issued with a limited frequency.  See the `latency` argument
of `FSeventStreamCreate()`.  The kernel only signals every `latency`
seconds, but does not guarantee that the kernel queue is completely
drained, so we may have to wait more than one interval.  If we
increase the frequency, the system is more likely to drop events.
We avoid these issues by having each client thread create a unique
cookie file and then wait until it is seen in the event stream.

Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 198 ++++++++++++++++++++++++++++++++++++
 fsmonitor--daemon.h         |   5 +
 2 files changed, 203 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 0cb09ef0b984..d6b59a98cedd 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -150,6 +150,149 @@ static int do_as_client__send_flush(void)
 	return 0;
 }
 
+enum fsmonitor_cookie_item_result {
+	FCIR_ERROR = -1, /* could not create cookie file ? */
+	FCIR_INIT = 0,
+	FCIR_SEEN,
+	FCIR_ABORT,
+};
+
+struct fsmonitor_cookie_item {
+	struct hashmap_entry entry;
+	const char *name;
+	enum fsmonitor_cookie_item_result result;
+};
+
+static int cookies_cmp(const void *data, const struct hashmap_entry *he1,
+		     const struct hashmap_entry *he2, const void *keydata)
+{
+	const struct fsmonitor_cookie_item *a =
+		container_of(he1, const struct fsmonitor_cookie_item, entry);
+	const struct fsmonitor_cookie_item *b =
+		container_of(he2, const struct fsmonitor_cookie_item, entry);
+
+	return strcmp(a->name, keydata ? keydata : b->name);
+}
+
+static enum fsmonitor_cookie_item_result fsmonitor_wait_for_cookie(
+	struct fsmonitor_daemon_state *state)
+{
+	int fd;
+	struct fsmonitor_cookie_item cookie;
+	struct strbuf cookie_pathname = STRBUF_INIT;
+	struct strbuf cookie_filename = STRBUF_INIT;
+	const char *slash;
+	int my_cookie_seq;
+
+	pthread_mutex_lock(&state->main_lock);
+
+	my_cookie_seq = state->cookie_seq++;
+
+	strbuf_addbuf(&cookie_pathname, &state->path_cookie_prefix);
+	strbuf_addf(&cookie_pathname, "%i-%i", getpid(), my_cookie_seq);
+
+	slash = find_last_dir_sep(cookie_pathname.buf);
+	if (slash)
+		strbuf_addstr(&cookie_filename, slash + 1);
+	else
+		strbuf_addbuf(&cookie_filename, &cookie_pathname);
+	cookie.name = strbuf_detach(&cookie_filename, NULL);
+	cookie.result = FCIR_INIT;
+	// TODO should we have case-insenstive hash (and in cookie_cmp()) ??
+	hashmap_entry_init(&cookie.entry, strhash(cookie.name));
+
+	/*
+	 * Warning: we are putting the address of a stack variable into a
+	 * global hashmap.  This feels dodgy.  We must ensure that we remove
+	 * it before this thread and stack frame returns.
+	 */
+	hashmap_add(&state->cookies, &cookie.entry);
+
+	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
+			 cookie.name, cookie_pathname.buf);
+
+	/*
+	 * Create the cookie file on disk and then wait for a notification
+	 * that the listener thread has seen it.
+	 */
+	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
+	if (fd >= 0) {
+		close(fd);
+		unlink_or_warn(cookie_pathname.buf);
+
+		while (cookie.result == FCIR_INIT)
+			pthread_cond_wait(&state->cookies_cond,
+					  &state->main_lock);
+
+		hashmap_remove(&state->cookies, &cookie.entry, NULL);
+	} else {
+		error_errno(_("could not create fsmonitor cookie '%s'"),
+			    cookie.name);
+
+		cookie.result = FCIR_ERROR;
+		hashmap_remove(&state->cookies, &cookie.entry, NULL);
+	}
+
+	pthread_mutex_unlock(&state->main_lock);
+
+	free((char*)cookie.name);
+	strbuf_release(&cookie_pathname);
+	return cookie.result;
+}
+
+/*
+ * Mark these cookies as _SEEN and wake up the corresponding client threads.
+ */
+static void fsmonitor_cookie_mark_seen(struct fsmonitor_daemon_state *state,
+				       const struct string_list *cookie_names)
+{
+	/* assert state->main_lock */
+
+	int k;
+	int nr_seen = 0;
+
+	for (k = 0; k < cookie_names->nr; k++) {
+		struct fsmonitor_cookie_item key;
+		struct fsmonitor_cookie_item *cookie;
+
+		key.name = cookie_names->items[k].string;
+		hashmap_entry_init(&key.entry, strhash(key.name));
+
+		cookie = hashmap_get_entry(&state->cookies, &key, entry, NULL);
+		if (cookie) {
+			trace_printf_key(&trace_fsmonitor, "cookie-seen: '%s'",
+					 cookie->name);
+			cookie->result = FCIR_SEEN;
+			nr_seen++;
+		}
+	}
+
+	if (nr_seen)
+		pthread_cond_broadcast(&state->cookies_cond);
+}
+
+/*
+ * Set _ABORT on all pending cookies and wake up all client threads.
+ */
+static void fsmonitor_cookie_abort_all(struct fsmonitor_daemon_state *state)
+{
+	/* assert state->main_lock */
+
+	struct hashmap_iter iter;
+	struct fsmonitor_cookie_item *cookie;
+	int nr_aborted = 0;
+
+	hashmap_for_each_entry(&state->cookies, &iter, cookie, entry) {
+		trace_printf_key(&trace_fsmonitor, "cookie-abort: '%s'",
+				 cookie->name);
+		cookie->result = FCIR_ABORT;
+		nr_aborted++;
+	}
+
+	if (nr_aborted)
+		pthread_cond_broadcast(&state->cookies_cond);
+}
+
 static int lookup_client_test_delay(void)
 {
 	static int delay_ms = -1;
@@ -435,6 +578,9 @@ static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
  *     We should create a new token and start fresh (as if we just
  *     booted up).
  *
+ * [2] Some of those lost events may have been for cookie files.  We
+ *     should assume the worst and abort them rather letting them starve.
+ *
  * If there are no readers of the the current token data series, we
  * can free it now.  Otherwise, let the last reader free it.  Either
  * way, the old token data series is no longer associated with our
@@ -454,6 +600,8 @@ void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
 			 state->current_token_data->token_id.buf,
 			 new_one->token_id.buf);
 
+	fsmonitor_cookie_abort_all(state);
+
 	if (state->current_token_data->client_ref_count == 0)
 		free_me = state->current_token_data;
 	state->current_token_data = new_one;
@@ -526,6 +674,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	kh_str_t *shown;
 	int hash_ret;
 	int result;
+	enum fsmonitor_cookie_item_result cookie_result;
 
 	/*
 	 * We expect `command` to be of the form:
@@ -654,6 +803,39 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		goto send_trivial_response;
 	}
 
+	pthread_mutex_unlock(&state->main_lock);
+
+	/*
+	 * Write a cookie file inside the directory being watched in an
+	 * effort to flush out existing filesystem events that we actually
+	 * care about.  Suspend this client thread until we see the filesystem
+	 * events for this cookie file.
+	 */
+	cookie_result = fsmonitor_wait_for_cookie(state);
+	if (cookie_result != FCIR_SEEN) {
+		error(_("fsmonitor: cookie_result '%d' != SEEN"),
+		      cookie_result);
+		result = 0;
+		goto send_trivial_response;
+	}
+
+	pthread_mutex_lock(&state->main_lock);
+
+	if (strcmp(requested_token_id.buf,
+		   state->current_token_data->token_id.buf)) {
+		/*
+		 * Ack! The listener thread lost sync with the filesystem
+		 * and created a new token while we were waiting for the
+		 * cookie file to be created!  Just give up.
+		 */
+		pthread_mutex_unlock(&state->main_lock);
+
+		trace_printf_key(&trace_fsmonitor,
+				 "lost filesystem sync");
+		result = 0;
+		goto send_trivial_response;
+	}
+
 	/*
 	 * We're going to hold onto a pointer to the current
 	 * token-data while we walk the list of batches of files.
@@ -982,6 +1164,9 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
 		}
 	}
 
+	if (cookie_names->nr)
+		fsmonitor_cookie_mark_seen(state, cookie_names);
+
 	pthread_mutex_unlock(&state->main_lock);
 }
 
@@ -1071,7 +1256,9 @@ static int fsmonitor_run_daemon(void)
 
 	memset(&state, 0, sizeof(state));
 
+	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
+	pthread_cond_init(&state.cookies_cond, NULL);
 	state.error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 	state.test_client_delay_ms = lookup_client_test_delay();
@@ -1094,6 +1281,15 @@ static int fsmonitor_run_daemon(void)
 		state.nr_paths_watching = 2;
 	}
 
+	/*
+	 * We will write filesystem syncing cookie files into
+	 * <gitdir>/<cookie-prefix><pid>-<seq>.
+	 */
+	strbuf_init(&state.path_cookie_prefix, 0);
+	strbuf_addbuf(&state.path_cookie_prefix, &state.path_gitdir_watch);
+	strbuf_addch(&state.path_cookie_prefix, '/');
+	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_COOKIE_PREFIX);
+
 	/*
 	 * Confirm that we can create platform-specific resources for the
 	 * filesystem listener before we bother starting all the threads.
@@ -1106,6 +1302,7 @@ static int fsmonitor_run_daemon(void)
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
+	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
 	fsmonitor_fs_listen__dtor(&state);
 
@@ -1113,6 +1310,7 @@ static int fsmonitor_run_daemon(void)
 
 	strbuf_release(&state.path_worktree_watch);
 	strbuf_release(&state.path_gitdir_watch);
+	strbuf_release(&state.path_cookie_prefix);
 
 	return err;
 }
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 06563b6ed56c..4e580e285ed6 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -45,6 +45,11 @@ struct fsmonitor_daemon_state {
 
 	struct fsmonitor_token_data *current_token_data;
 
+	struct strbuf path_cookie_prefix;
+	pthread_cond_t cookies_cond;
+	int cookie_seq;
+	struct hashmap cookies;
+
 	int error_code;
 	struct fsmonitor_daemon_backend_data *backend_data;
 
-- 
gitgitgadget

