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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4A7C11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5347D61414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhGAOur (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhGAOuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7693C06178A
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v5so8607706wrt.3
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TOIsbteyOxly7Ebv5T9N4h7JB9VV+mW6FkAPqdMo/4k=;
        b=PA/nclOQw2yvYYNrnEaaUCBzGpjWSMKEl9X8OigaY9jXH88KRky3HEcFuqL3NF6GU5
         uVbIEPOHA+mLsf+phknKSagsrGNIVhY3HZQFlAhJicWUpvwbIukR6/x3cTQUv7gDxQhE
         gFiA0vcXR1eddBRxz/mcBAtucsc42S1pvLTrj/uR+i77w0LF8PcmoYWD9Vvvup8HxvW9
         oritKfV+0XtQUajOIqj3STfA/ME2qp+J7yL/SVEFIgbcT3r9diuP7XFs/lvYfj3G4mB6
         aM+S+Mdul4l5zFFQAJkF0U3SyOi9NvBv2tIeuMiO0pR2V9zUMSxGGFVztc+vxnRKLy4+
         FMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TOIsbteyOxly7Ebv5T9N4h7JB9VV+mW6FkAPqdMo/4k=;
        b=OFhj3+E6S0szUZEF2SPSYGxMrnCm0pMG0k3h9B+fr7LaSidDfa1MbCaQkyuObXO4EN
         8288UBOzo4rI/jbdJQEHPTpYWst4/QAo0zxxaZvNC5n/kyzdwmPQ8pIYq3euOXvp8flP
         YFvfQ5B+zmzWwoW8uqYeMgOlMuel4QlOcZ0Ub+spNqZlX9ajzdyxVc8+VnmkGtTzyD+3
         7qFaI+ZTf4x5GLfytV06/RBelyIZBt4rWt5hMpXkBwRC6ea3fSyUx7P/FTzMg/HXBo1h
         jrLD15OPOFWOa1LzAByDpgsCWUp65R0rqxYfTtk08qRu/OCmMoWSteiUfC3WS+EQOWcU
         EpBw==
X-Gm-Message-State: AOAM532R53Knb9CqqGgzW4blU5urnwSTLP31ANayE9epl5Jaz65Fme46
        vdqZcKz3tU3Jqekwmf4jIgllhhZ9z+U=
X-Google-Smtp-Source: ABdhPJx258gqv6MY88BdLfAV3CzP/hNWrEIA2AkPWUU2lbjQqfgGYBAZ9hGM74Sb9On0iKHiVbflrg==
X-Received: by 2002:a5d:498d:: with SMTP id r13mr21350332wrq.379.1625150882346;
        Thu, 01 Jul 2021 07:48:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm9726141wma.22.2021.07.01.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:02 -0700 (PDT)
Message-Id: <555caca2216dd3e459c118d76b46eb983a58e051.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:39 +0000
Subject: [PATCH v3 29/34] fsmonitor--daemon: use a cookie file to sync with
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
 builtin/fsmonitor--daemon.c | 228 +++++++++++++++++++++++++++++++++++-
 fsmonitor--daemon.h         |   5 +
 2 files changed, 232 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 8249420ba18..25f18f2726b 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -94,6 +94,149 @@ static int do_as_client__status(void)
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
@@ -397,6 +540,9 @@ static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
  *     We should create a new token and start fresh (as if we just
  *     booted up).
  *
+ * [2] Some of those lost events may have been for cookie files.  We
+ *     should assume the worst and abort them rather letting them starve.
+ *
  * If there are no concurrent threads readering the current token data
  * series, we can free it now.  Otherwise, let the last reader free
  * it.
@@ -418,6 +564,8 @@ static void with_lock__do_force_resync(struct fsmonitor_daemon_state *state)
 	state->current_token_data = new_one;
 
 	fsmonitor_free_token_data(free_me);
+
+	with_lock__abort_all_cookies(state);
 }
 
 void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
@@ -492,6 +640,8 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
+	int do_cookie = 0;
+	enum fsmonitor_cookie_item_result cookie_result;
 
 	/*
 	 * We expect `command` to be of the form:
@@ -552,6 +702,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			 * We have a V2 valid token:
 			 *     "builtin:<token_id>:<seq_nr>"
 			 */
+			do_cookie = 1;
 		}
 	}
 
@@ -560,6 +711,30 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
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
 
@@ -771,7 +946,9 @@ static int handle_client(void *data,
 	return result;
 }
 
-#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
+#define FSMONITOR_DIR           "fsmonitor--daemon"
+#define FSMONITOR_COOKIE_DIR    "cookies"
+#define FSMONITOR_COOKIE_PREFIX (FSMONITOR_DIR "/" FSMONITOR_COOKIE_DIR "/")
 
 enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
 	const char *rel)
@@ -924,6 +1101,9 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
 		}
 	}
 
+	if (cookie_names->nr)
+		with_lock__mark_cookies_seen(state, cookie_names);
+
 	pthread_mutex_unlock(&state->main_lock);
 }
 
@@ -1013,7 +1193,9 @@ static int fsmonitor_run_daemon(void)
 
 	memset(&state, 0, sizeof(state));
 
+	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
 	pthread_mutex_init(&state.main_lock, NULL);
+	pthread_cond_init(&state.cookies_cond, NULL);
 	state.error_code = 0;
 	state.current_token_data = fsmonitor_new_token_data();
 
@@ -1038,6 +1220,44 @@ static int fsmonitor_run_daemon(void)
 		state.nr_paths_watching = 2;
 	}
 
+	/*
+	 * We will write filesystem syncing cookie files into
+	 * <gitdir>/<fsmonitor-dir>/<cookie-dir>/<pid>-<seq>.
+	 *
+	 * The extra layers of subdirectories here keep us from
+	 * changing the mtime on ".git/" or ".git/foo/" when we create
+	 * or delete cookie files.
+	 *
+	 * There have been problems with some IDEs that do a
+	 * non-recursive watch of the ".git/" directory and run a
+	 * series of commands any time something happens.
+	 *
+	 * For example, if we place our cookie files directly in
+	 * ".git/" or ".git/foo/" then a `git status` (or similar
+	 * command) from the IDE will cause a cookie file to be
+	 * created in one of those dirs.  This causes the mtime of
+	 * those dirs to change.  This triggers the IDE's watch
+	 * notification.  This triggers the IDE to run those commands
+	 * again.  And the process repeats and the machine never goes
+	 * idle.
+	 *
+	 * Adding the extra layers of subdirectories prevents the
+	 * mtime of ".git/" and ".git/foo" from changing when a
+	 * cookie file is created.
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
@@ -1050,6 +1270,7 @@ static int fsmonitor_run_daemon(void)
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
+	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
 	fsmonitor_fs_listen__dtor(&state);
 
@@ -1057,6 +1278,11 @@ done:
 
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
index 89a9ef20b24..e9fc099bae9 100644
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

