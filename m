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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C38C2B9FB
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7A161164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhEVN7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhEVN6w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5236C06138E
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so2004200wmq.2
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NKyTYcyaVKCOZRQ2A0UdZY/nTIrMMGzVkqVeo5wXvFU=;
        b=VQS4OG2l1nDavaJkEz2DhJzvK3HDYVceuCTWpMATp0qwqdC4loKFc3Qg6g/+pvqQtS
         b/sNDmC/8ZFEKri9az8/roX3jpTWu+ZIGzcqJKA29BQklwVdJ3BENHFAa25fLbX5TL7o
         ZFEEutwxWEa4zUfLSK9Wn3LkAxAhtbs2bwUE+Xy8mKbVIeAzRu2+fxv0epLNvA9TTC99
         ji4fOQtg4L5EA9o51o3Ix2IxDY2vwN1UD1hbChUs7IS0DCuBt5fw3DGJmqxiYPW2J+N/
         8YiYYyxJdmlURrZ2PtX6x5oZftbOuo+ylZSYL9IJY4AVP5NUB2c1qBL1dHHt6DYfgpZ8
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NKyTYcyaVKCOZRQ2A0UdZY/nTIrMMGzVkqVeo5wXvFU=;
        b=jmltM9ITRruKMW4m025X+YF3IXEJhSdaZ/Yp2vHIIACb/kBcqIUdovgtKxE7FpYkok
         K8/22bhTtNQKE0EYXVMYVOjG85FDqsKxHTQEPTMfwDZZUlAa7KdVgnde08MT+4L2KDpS
         9jW4YfVC8Wbo5rjsgkORt5rc3eD8HyYxf9GSpEKyZ+eCqaemZ5WkgVgArg/G5QOx1+TX
         h8WaHQ2Rx1UQS/MY4mLeKlVuvMKaIBsJNM0RsHq2+cLHGRv1GLU+vuJyDNoQ1hqaYjJw
         IAbrV/QcDiq4hnN+qi4EEuynWlC0f3GV5zTgwz9wq2wDbrrdD6G9tTKCnmpMyYuLj4Cb
         /alw==
X-Gm-Message-State: AOAM530ouBO2zJeMdLrXeG/yLyIX2d8SzhBqWGcJPaBywvyJHl85XS6m
        lk7o6XyumNby4KP1G97MYQdHKhnrQN4=
X-Google-Smtp-Source: ABdhPJwJTo93Z21IGsGZCjsoPYB+mGAN6ySt8cUfvVp9cWc28cPBrfFI/HJ/2c6QfY28f+b80lBxMg==
X-Received: by 2002:a1c:3945:: with SMTP id g66mr13001198wma.70.1621691844416;
        Sat, 22 May 2021 06:57:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10sm5670602wrq.12.2021.05.22.06.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:24 -0700 (PDT)
Message-Id: <bb7b1912bb47331ac5fea0b4fd8259bb8964e807.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:57:01 +0000
Subject: [PATCH v2 22/28] fsmonitor--daemon: use a cookie file to sync with
 file system
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
 builtin/fsmonitor--daemon.c | 210 +++++++++++++++++++++++++++++++++++-
 fsmonitor--daemon.h         |   5 +
 2 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index e807aa8f6741..985a82cf39e0 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -92,6 +92,149 @@ static int do_as_client__status(void)
 	}
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
+static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
+	struct fsmonitor_daemon_state *state)
+{
+	/* assert current thread holding state->main_lock */
+
+	int fd;
+	struct fsmonitor_cookie_item *cookie;
+	struct strbuf cookie_pathname = STRBUF_INIT;
+	struct strbuf cookie_filename = STRBUF_INIT;
+	enum fsmonitor_cookie_item_result result;
+	int my_cookie_seq;
+
+	CALLOC_ARRAY(cookie, 1);
+
+	my_cookie_seq = state->cookie_seq++;
+
+	strbuf_addf(&cookie_filename, "%i-%i", getpid(), my_cookie_seq);
+
+	strbuf_addbuf(&cookie_pathname, &state->path_cookie_prefix);
+	strbuf_addbuf(&cookie_pathname, &cookie_filename);
+
+	cookie->name = strbuf_detach(&cookie_filename, NULL);
+	cookie->result = FCIR_INIT;
+	hashmap_entry_init(&cookie->entry, strhash(cookie->name));
+
+	hashmap_add(&state->cookies, &cookie->entry);
+
+	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
+			 cookie->name, cookie_pathname.buf);
+
+	/*
+	 * Create the cookie file on disk and then wait for a notification
+	 * that the listener thread has seen it.
+	 */
+	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
+	if (fd >= 0) {
+		close(fd);
+		unlink(cookie_pathname.buf);
+
+		/*
+		 * NEEDSWORK: This is an infinite wait (well, unless another
+		 * thread sends us an abort).  I'd like to change this to
+		 * use `pthread_cond_timedwait()` and return an error/timeout
+		 * and let the caller do the trivial response thing.
+		 */
+		while (cookie->result == FCIR_INIT)
+			pthread_cond_wait(&state->cookies_cond,
+					  &state->main_lock);
+	} else {
+		error_errno(_("could not create fsmonitor cookie '%s'"),
+			    cookie->name);
+
+		cookie->result = FCIR_ERROR;
+	}
+
+	hashmap_remove(&state->cookies, &cookie->entry, NULL);
+
+	result = cookie->result;
+
+	free((char*)cookie->name);
+	free(cookie);
+	strbuf_release(&cookie_pathname);
+
+	return result;
+}
+
+/*
+ * Mark these cookies as _SEEN and wake up the corresponding client threads.
+ */
+static void with_lock__mark_cookies_seen(struct fsmonitor_daemon_state *state,
+					 const struct string_list *cookie_names)
+{
+	/* assert current thread holding state->main_lock */
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
+static void with_lock__abort_all_cookies(struct fsmonitor_daemon_state *state)
+{
+	/* assert current thread holding state->main_lock */
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
 /*
  * Requests to and from a FSMonitor Protocol V2 provider use an opaque
  * "token" as a virtual timestamp.  Clients can request a summary of all
@@ -395,6 +538,9 @@ static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
  *     We should create a new token and start fresh (as if we just
  *     booted up).
  *
+ * [2] Some of those lost events may have been for cookie files.  We
+ *     should assume the worst and abort them rather letting them starve.
+ *
  * If there are no concurrent threads readering the current token data
  * series, we can free it now.  Otherwise, let the last reader free
  * it.
@@ -416,6 +562,8 @@ static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
 	state->current_token_data = new_one;
 
 	fsmonitor_free_token_data(free_me);
+
+	with_lock__abort_all_cookies(state);
 }
 
 void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
@@ -490,6 +638,8 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
+	int do_cookie = 0;
+	enum fsmonitor_cookie_item_result cookie_result;
 
 	/*
 	 * We expect `command` to be of the form:
@@ -522,6 +672,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		 */
 		do_flush = 1;
 		do_trivial = 1;
+		do_cookie = 1;
 
 	} else if (!skip_prefix(command, "builtin:", &p)) {
 		/* assume V1 timestamp or garbage */
@@ -535,6 +686,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 				  "fsmonitor: unsupported V1 protocol '%s'"),
 				 command);
 		do_trivial = 1;
+		do_cookie = 1;
 
 	} else {
 		/* We have "builtin:*" */
@@ -544,12 +696,14 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 					 "fsmonitor: invalid V2 protocol token '%s'",
 					 command);
 			do_trivial = 1;
+			do_cookie = 1;
 
 		} else {
 			/*
 			 * We have a V2 valid token:
 			 *     "builtin:<token_id>:<seq_nr>"
 			 */
+			do_cookie = 1;
 		}
 	}
 
@@ -558,6 +712,30 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	if (!state->current_token_data)
 		BUG("fsmonitor state does not have a current token");
 
+	/*
+	 * Write a cookie file inside the directory being watched in
+	 * an effort to flush out existing filesystem events that we
+	 * actually care about.  Suspend this client thread until we
+	 * see the filesystem events for this cookie file.
+	 *
+	 * Creating the cookie lets us guarantee that our FS listener
+	 * thread has drained the kernel queue and we are caught up
+	 * with the kernel.
+	 *
+	 * If we cannot create the cookie (or otherwise guarantee that
+	 * we are caught up), we send a trivial response.  We have to
+	 * assume that there might be some very, very recent activity
+	 * on the FS still in flight.
+	 */
+	if (do_cookie) {
+		cookie_result = with_lock__wait_for_cookie(state);
+		if (cookie_result != FCIR_SEEN) {
+			error(_("fsmonitor: cookie_result '%d' != SEEN"),
+			      cookie_result);
+			do_trivial = 1;
+		}
+	}
+
 	if (do_flush)
 		with_lock__do_force_resync(state);
 
@@ -769,7 +947,9 @@ static int handle_client(void *data,
 	return result;
 }
 
-#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
+#define FSMONITOR_DIR           "fsmonitor--daemon"
+#define FSMONITOR_COOKIE_DIR    "cookies"
+#define FSMONITOR_COOKIE_PREFIX (FSMONITOR_DIR "/" FSMONITOR_COOKIE_DIR "/")
 
 enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
 	const char *rel)
@@ -922,6 +1102,9 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
 		}
 	}
 
+	if (cookie_names->nr)
+		with_lock__mark_cookies_seen(state, cookie_names);
+
 	pthread_mutex_unlock(&state->main_lock);
 }
 
@@ -1011,7 +1194,9 @@ static int fsmonitor_run_daemon(void)
 
 	memset(&state, 0, sizeof(state));
 
+	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
+	pthread_cond_init(&state.cookies_cond, NULL);
 	state.error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 
@@ -1035,6 +1220,23 @@ static int fsmonitor_run_daemon(void)
 		state.nr_paths_watching = 2;
 	}
 
+	/*
+	 * We will write filesystem syncing cookie files into
+	 * <gitdir>/<fsmonitor-dir>/<cookie-dir>/<pid>-<seq>.
+	 */
+	strbuf_init(&state.path_cookie_prefix, 0);
+	strbuf_addbuf(&state.path_cookie_prefix, &state.path_gitdir_watch);
+
+	strbuf_addch(&state.path_cookie_prefix, '/');
+	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_DIR);
+	mkdir(state.path_cookie_prefix.buf, 0777);
+
+	strbuf_addch(&state.path_cookie_prefix, '/');
+	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_COOKIE_DIR);
+	mkdir(state.path_cookie_prefix.buf, 0777);
+
+	strbuf_addch(&state.path_cookie_prefix, '/');
+
 	/*
 	 * Confirm that we can create platform-specific resources for the
 	 * filesystem listener before we bother starting all the threads.
@@ -1047,6 +1249,7 @@ static int fsmonitor_run_daemon(void)
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
+	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
 	fsmonitor_fs_listen__dtor(&state);
 
@@ -1054,6 +1257,11 @@ static int fsmonitor_run_daemon(void)
 
 	strbuf_release(&state.path_worktree_watch);
 	strbuf_release(&state.path_gitdir_watch);
+	strbuf_release(&state.path_cookie_prefix);
+
+	/*
+	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
+	 */
 
 	return err;
 }
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 89a9ef20b24b..e9fc099bae9c 100644
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

