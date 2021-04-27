Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD763C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 17:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19AE61154
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 17:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhD0RXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbhD0RXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 13:23:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC8AC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 10:22:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso51194783otv.6
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=72/3PdR5SDhKSEu03AF0IccW5AW7E6DK0Vbvl8SX76M=;
        b=b2jtek/e8bud53LrfBO+eALbaRWp+5cWqhkdboGGTDFT26bvOugeH3He2d/mJVjssl
         MZr0yMWfAKRJ7wOgqFLQ7PqsylnvVDKIbwX5B05U42/8YH1IrxJnTh8S7NCIZ33F2g5R
         p6lo43SGmh5sJpMNRjD1Srlp/hU0sou5F89Sl5o3ab99cbBGIKv3m+IPX2JyVgStG/O5
         8mkpbGywi2IJkMIeM0gkTxGuIWsQvUJ5qOVCzmL2o1tedpQY7qZRTBMpatB0S8j5gw05
         iuBaJzaEHYQ22FTfj/d37KEe2cOC+L7rv7gWDhZcTAl7ZpBo6Pp66ivpy9YXWlNScjU5
         6z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=72/3PdR5SDhKSEu03AF0IccW5AW7E6DK0Vbvl8SX76M=;
        b=q/Pzf7BkvycQ0zrce9GJrW/VPfX8icuPL7hXu7JGK7am66zdhcUQPIuaHI748m+frV
         XeX4XF1cNIrHaJPnihFmdV1qu0gn9hP3TJxoqdzJkb6KiIciJhfP7SkLVv5HdIBl5ciX
         jsp1w+OuSfOcVfjsXVA3LJIigQ4x0+simrIjCCQ37+bMmiJeiAhF0uJ/ceJVTztRJROi
         lEg49NWPXm6E5jZ9sZliItJC+PEn7ZnbpD9MJSi/yHhwU1hDTYjcaEsvW9QAEfORmwvo
         fpoy8CYlbwCwxeL7KgYgo3ebbp2tj6nvGX6BTq0Ej0C//GgoN2IPEu/u/y1+TtZn3ZtU
         8xrQ==
X-Gm-Message-State: AOAM532D2aUGUsO+VkE1RC0BY7bjt2gmypNZ+5L3i9n2EJibDNfqndU+
        4GuB4+y2kseIOMXyCgPP/2E=
X-Google-Smtp-Source: ABdhPJzKrhf/5xNjB5h26vy4JVFZ8tEUFhWa7gJ4rONceaQKSAs+Oi2Xn5y8Erq2yL0e6EcbOygTGA==
X-Received: by 2002:a9d:86e:: with SMTP id 101mr3447205oty.369.1619544152546;
        Tue, 27 Apr 2021 10:22:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id a19sm94191otp.57.2021.04.27.10.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 10:22:32 -0700 (PDT)
Subject: Re: [PATCH 13/23] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <a57ddb3bc7cc2de9a48472c4faff32ef46132f73.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4b0066f5-5962-e57e-5987-5358f3d394f7@gmail.com>
Date:   Tue, 27 Apr 2021 13:22:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a57ddb3bc7cc2de9a48472c4faff32ef46132f73.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach the win32 backend to register a watch on the working tree
> root directory (recursively).  Also watch the <gitdir> if it is
> not inside the working tree.  And to collect path change notifications
> into batches and publish.

Is it valuable to list the important API methods here for an interested
reader to discover them? Perhaps using links to the docs [1] might be
too ephemeral, in case those URLs stop being valid.

In any case, here are the URLs I found helpful:

[1] https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-readdirectorychangesw
[2] https://docs.microsoft.com/en-us/windows/win32/api/ioapiset/nf-ioapiset-getoverlappedresult
[3] https://docs.microsoft.com/en-us/windows/win32/fileio/cancelioex-func
[4] https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-resetevent
[5] https://docs.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-file_notify_information
[6] https://docs.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitformultipleobjects

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  compat/fsmonitor/fsmonitor-fs-listen-win32.c | 493 +++++++++++++++++++
>  1 file changed, 493 insertions(+)
> 
> diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> index 880446b49e35..2f1fcf85a0a4 100644
> --- a/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> +++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> @@ -2,20 +2,513 @@
>  #include "config.h"
>  #include "fsmonitor.h"
>  #include "fsmonitor-fs-listen.h"
> +#include "fsmonitor--daemon.h"
> +
> +/*
> + * The documentation of ReadDirectoryChangesW() states that the maximum
> + * buffer size is 64K when the monitored directory is remote.
> + *
> + * Larger buffers may be used when the monitored directory is local and
> + * will help us receive events faster from the kernel and avoid dropped
> + * events.
> + *
> + * So we try to use a very large buffer and silently fallback to 64K if
> + * we get an error.
> + */
> +#define MAX_RDCW_BUF_FALLBACK (65536)
> +#define MAX_RDCW_BUF          (65536 * 8)
> +
> +struct one_watch
> +{
> +	char buffer[MAX_RDCW_BUF];
> +	DWORD buf_len;
> +	DWORD count;
> +
> +	struct strbuf path;
> +	HANDLE hDir;
> +	HANDLE hEvent;
> +	OVERLAPPED overlapped;
> +
> +	/*
> +	 * Is there an active ReadDirectoryChangesW() call pending.  If so, we
> +	 * need to later call GetOverlappedResult() and possibly CancelIoEx().
> +	 */
> +	BOOL is_active;
> +};
> +
> +struct fsmonitor_daemon_backend_data
> +{
> +	struct one_watch *watch_worktree;
> +	struct one_watch *watch_gitdir;
> +
> +	HANDLE hEventShutdown;
> +
> +	HANDLE hListener[3]; /* we don't own these handles */
> +#define LISTENER_SHUTDOWN 0
> +#define LISTENER_HAVE_DATA_WORKTREE 1
> +#define LISTENER_HAVE_DATA_GITDIR 2
> +	int nr_listener_handles;
> +};
> +
> +/*
> + * Convert the WCHAR path from the notification into UTF8 and
> + * then normalize it.
> + */
> +static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
> +				  struct strbuf *normalized_path)
> +{
> +	int reserve;
> +	int len = 0;
> +
> +	strbuf_reset(normalized_path);
> +	if (!info->FileNameLength)
> +		goto normalize;
> +
> +	/*
> +	 * Pre-reserve enough space in the UTF8 buffer for
> +	 * each Unicode WCHAR character to be mapped into a
> +	 * sequence of 2 UTF8 characters.  That should let us
> +	 * avoid ERROR_INSUFFICIENT_BUFFER 99.9+% of the time.
> +	 */
> +	reserve = info->FileNameLength + 1;
> +	strbuf_grow(normalized_path, reserve);
> +
> +	for (;;) {
> +		len = WideCharToMultiByte(CP_UTF8, 0, info->FileName,
> +					  info->FileNameLength / sizeof(WCHAR),
> +					  normalized_path->buf,
> +					  strbuf_avail(normalized_path) - 1,
> +					  NULL, NULL);
> +		if (len > 0)
> +			goto normalize;
> +		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
> +			error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
> +			      GetLastError(),
> +			      (int)(info->FileNameLength / sizeof(WCHAR)),
> +			      info->FileName);
> +			return -1;
> +		}
> +
> +		strbuf_grow(normalized_path,
> +			    strbuf_avail(normalized_path) + reserve);
> +	}
> +
> +normalize:
> +	strbuf_setlen(normalized_path, len);
> +	return strbuf_normalize_path(normalized_path);
> +}
>  
>  void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state)
>  {
> +	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
> +}
> +
> +static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
> +				      const char *path)
> +{
> +	struct one_watch *watch = NULL;
> +	DWORD desired_access = FILE_LIST_DIRECTORY;
> +	DWORD share_mode =
> +		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;

Ah, this is probably why we can delete a repo that is under a watch.

> +	HANDLE hDir;
> +
> +	hDir = CreateFileA(path,
> +			   desired_access, share_mode, NULL, OPEN_EXISTING,
> +			   FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
> +			   NULL);
> +	if (hDir == INVALID_HANDLE_VALUE) {
> +		error(_("[GLE %ld] could not watch '%s'"),
> +		      GetLastError(), path);
> +		return NULL;
> +	}
> +
> +	watch = xcalloc(1, sizeof(*watch));
> +
> +	watch->buf_len = sizeof(watch->buffer); /* assume full MAX_RDCW_BUF */
> +
> +	strbuf_init(&watch->path, 0);
> +	strbuf_addstr(&watch->path, path);
> +
> +	watch->hDir = hDir;
> +	watch->hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
> +
> +	return watch;
> +}
> +
> +static void destroy_watch(struct one_watch *watch)
> +{
> +	if (!watch)
> +		return;
> +
> +	strbuf_release(&watch->path);
> +	if (watch->hDir != INVALID_HANDLE_VALUE)
> +		CloseHandle(watch->hDir);
> +	if (watch->hEvent != INVALID_HANDLE_VALUE)
> +		CloseHandle(watch->hEvent);
> +
> +	free(watch);
> +}
> +
> +static int start_rdcw_watch(struct fsmonitor_daemon_backend_data *data,
> +			    struct one_watch *watch)
> +{
> +	DWORD dwNotifyFilter =
> +		FILE_NOTIFY_CHANGE_FILE_NAME |
> +		FILE_NOTIFY_CHANGE_DIR_NAME |
> +		FILE_NOTIFY_CHANGE_ATTRIBUTES |
> +		FILE_NOTIFY_CHANGE_SIZE |
> +		FILE_NOTIFY_CHANGE_LAST_WRITE |
> +		FILE_NOTIFY_CHANGE_CREATION;
> +
> +	ResetEvent(watch->hEvent);
> +
> +	memset(&watch->overlapped, 0, sizeof(watch->overlapped));
> +	watch->overlapped.hEvent = watch->hEvent;
> +
> +start_watch:
> +	watch->is_active = ReadDirectoryChangesW(
> +		watch->hDir, watch->buffer, watch->buf_len, TRUE,
> +		dwNotifyFilter, &watch->count, &watch->overlapped, NULL);
> +
> +	if (!watch->is_active &&
> +	    GetLastError() == ERROR_INVALID_PARAMETER &&
> +	    watch->buf_len > MAX_RDCW_BUF_FALLBACK) {
> +		watch->buf_len = MAX_RDCW_BUF_FALLBACK;
> +		goto start_watch;
> +	}
> +
> +	if (watch->is_active)
> +		return 0;
> +
> +	error("ReadDirectoryChangedW failed on '%s' [GLE %ld]",
> +	      watch->path.buf, GetLastError());
> +	return -1;
> +}
> +
> +static int recv_rdcw_watch(struct one_watch *watch)
> +{
> +	watch->is_active = FALSE;
> +
> +	if (GetOverlappedResult(watch->hDir, &watch->overlapped, &watch->count,
> +				TRUE))
> +		return 0;
> +
> +	// TODO If an external <gitdir> is deleted, the above returns an error.
> +	// TODO I'm not sure that there's anything that we can do here other
> +	// TODO than failing -- the <worktree>/.git link file would be broken
> +	// TODO anyway.  We might try to check for that and return a better
> +	// TODO error message.

These are not fit C-style comments. This situation can be handled
by a later patch series, if valuable enough.

> +
> +	error("GetOverlappedResult failed on '%s' [GLE %ld]",
> +	      watch->path.buf, GetLastError());
> +	return -1;
> +}
> +
> +static void cancel_rdcw_watch(struct one_watch *watch)
> +{
> +	DWORD count;
> +
> +	if (!watch || !watch->is_active)
> +		return;
> +
> +	CancelIoEx(watch->hDir, &watch->overlapped);
> +	GetOverlappedResult(watch->hDir, &watch->overlapped, &count, TRUE);
> +	watch->is_active = FALSE;
> +}
> +
> +/*
> + * Process filesystem events that happen anywhere (recursively) under the
> + * <worktree> root directory.  For a normal working directory, this includes
> + * both version controlled files and the contents of the .git/ directory.
> + *
> + * If <worktree>/.git is a file, then we only see events for the file
> + * itself.
> + */
> +static int process_worktree_events(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsmonitor_daemon_backend_data *data = state->backend_data;
> +	struct one_watch *watch = data->watch_worktree;
> +	struct strbuf path = STRBUF_INIT;
> +	struct string_list cookie_list = STRING_LIST_INIT_DUP;
> +	struct fsmonitor_batch *batch = NULL;
> +	const char *p = watch->buffer;
> +
> +	/*
> +	 * If the kernel gets more events than will fit in the kernel
> +	 * buffer associated with our RDCW handle, it drops them and
> +	 * returns a count of zero.  (A successful call, but with
> +	 * length zero.)
> +	 */

I suppose that since we create a cookie file, we don't expect a zero
result to ever be a meaningful value? Or, is there another way to
differentiate between "nothing happened" and "too much happened"?

> +	if (!watch->count) {
> +		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
> +				   "overflow");
> +		fsmonitor_force_resync(state);
> +		return LISTENER_HAVE_DATA_WORKTREE;
> +	}
> +
> +	/*
> +	 * On Windows, `info` contains an "array" of paths that are
> +	 * relative to the root of whichever directory handle received
> +	 * the event.
> +	 */
> +	for (;;) {
> +		FILE_NOTIFY_INFORMATION *info = (void *)p;
> +		const char *slash;
> +		enum fsmonitor_path_type t;
> +
> +		strbuf_reset(&path);
> +		if (normalize_path_in_utf8(info, &path) == -1)
> +			goto skip_this_path;
> +
> +		t = fsmonitor_classify_path_workdir_relative(path.buf);
> +
> +		switch (t) {
> +		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
> +			/* special case cookie files within .git */
> +
> +			/* Use just the filename of the cookie file. */
> +			slash = find_last_dir_sep(path.buf);
> +			string_list_append(&cookie_list,
> +					   slash ? slash + 1 : path.buf);

Ok, I see now how we special-case cookies in the list of events.

> +			break;
> +
> +		case IS_INSIDE_DOT_GIT:
> +			/* ignore everything inside of "<worktree>/.git/" */
> +			break;
> +
> +		case IS_DOT_GIT:
> +			/* "<worktree>/.git" was deleted (or renamed away) */
> +			if ((info->Action == FILE_ACTION_REMOVED) ||
> +			    (info->Action == FILE_ACTION_RENAMED_OLD_NAME)) {
> +				trace2_data_string("fsmonitor", NULL,
> +						   "fsm-listen/dotgit",
> +						   "removed");
> +				goto force_shutdown;
> +			}
> +			break;
> +
> +		case IS_WORKDIR_PATH:
> +			/* queue normal pathname */
> +			if (!batch)
> +				batch = fsmonitor_batch__new();
> +			fsmonitor_batch__add_path(batch, path.buf);
> +			break;
> +
> +		case IS_GITDIR:
> +		case IS_INSIDE_GITDIR:
> +		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
> +		default:
> +			BUG("unexpected path classification '%d' for '%s'",
> +			    t, path.buf);
So these events should be caught by the _other_ watcher. I suppose
BUG() is somewhat appropriate, but also seems heavy-handed. For
example, the 'goto' in the next line will never be visited. A die()
would even be appropriate, but somewhat less harsh than a BUG(),
especially for a background process.

> +			goto skip_this_path;
> +		}
> +
> +skip_this_path:
> +		if (!info->NextEntryOffset)
> +			break;
> +		p += info->NextEntryOffset;
> +	}
> +
> +	fsmonitor_publish(state, batch, &cookie_list);
> +	batch = NULL;
> +	string_list_clear(&cookie_list, 0);
> +	strbuf_release(&path);
> +	return LISTENER_HAVE_DATA_WORKTREE;
> +
> +force_shutdown:
> +	fsmonitor_batch__free(batch);
> +	string_list_clear(&cookie_list, 0);
> +	strbuf_release(&path);
> +	return LISTENER_SHUTDOWN;
> +}
> +
> +/*
> + * Process filesystem events that happend anywhere (recursively) under the

s/happend/happened

> + * external <gitdir> (such as non-primary worktrees or submodules).
> + * We only care about cookie files that our client threads created here.
> + *
> + * Note that we DO NOT get filesystem events on the external <gitdir>
> + * itself (it is not inside something that we are watching).  In particular,
> + * we do not get an event if the external <gitdir> is deleted.

This is an interesting change of behavior. I forget if it is listed in
the documentation file, but definitely could be. I imagine wanting a
"Troubleshooting" section that describes special cases like this.

Also, because of this worktree-specific behavior, we might want to
recommend using 'git config --worktree' when choosing to use FS Monitor,
so that each worktree is opted-in as requested. Without --worktree, all
worktrees with a common base would stard using FS Monitor simultaneously.

> + */
> +static int process_gitdir_events(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsmonitor_daemon_backend_data *data = state->backend_data;
> +	struct one_watch *watch = data->watch_gitdir;
> +	struct strbuf path = STRBUF_INIT;
> +	struct string_list cookie_list = STRING_LIST_INIT_DUP;
> +	const char *p = watch->buffer;
> +
> +	if (!watch->count) {
> +		trace2_data_string("fsmonitor", NULL, "fsm-listen/kernel",
> +				   "overflow");
> +		fsmonitor_force_resync(state);
> +		return LISTENER_HAVE_DATA_GITDIR;
> +	}
> +
> +	for (;;) {
> +		FILE_NOTIFY_INFORMATION *info = (void *)p;
> +		const char *slash;
> +		enum fsmonitor_path_type t;
> +
> +		strbuf_reset(&path);
> +		if (normalize_path_in_utf8(info, &path) == -1)
> +			goto skip_this_path;
> +
> +		t = fsmonitor_classify_path_gitdir_relative(path.buf);
> +
> +		trace_printf_key(&trace_fsmonitor, "BBB: %s", path.buf);
> +
> +		switch (t) {
> +		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
> +			/* special case cookie files within gitdir */
> +
> +			/* Use just the filename of the cookie file. */
> +			slash = find_last_dir_sep(path.buf);
> +			string_list_append(&cookie_list,
> +					   slash ? slash + 1 : path.buf);
> +			break;
> +
> +		case IS_INSIDE_GITDIR:
> +			goto skip_this_path;
> +
> +		default:
> +			BUG("unexpected path classification '%d' for '%s'",
> +			    t, path.buf);

If we decide against BUG() earlier, then also get this one.

> +			goto skip_this_path;
> +		}
> +
> +skip_this_path:
> +		if (!info->NextEntryOffset)
> +			break;
> +		p += info->NextEntryOffset;
> +	}
> +
> +	fsmonitor_publish(state, NULL, &cookie_list);
> +	string_list_clear(&cookie_list, 0);
> +	strbuf_release(&path);
> +	return LISTENER_HAVE_DATA_GITDIR;
>  }
>  
>  void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
>  {
> +	struct fsmonitor_daemon_backend_data *data = state->backend_data;
> +	DWORD dwWait;
> +
> +	state->error_code = 0;
> +
> +	if (start_rdcw_watch(data, data->watch_worktree) == -1)
> +		goto force_error_stop;
> +
> +	if (data->watch_gitdir &&
> +	    start_rdcw_watch(data, data->watch_gitdir) == -1)
> +		goto force_error_stop;
> +
> +	for (;;) {
> +		dwWait = WaitForMultipleObjects(data->nr_listener_handles,
> +						data->hListener,
> +						FALSE, INFINITE);

Since you use INFINITE here, that says that we will wait for at least one
signal, solving the confusion about zero results: zero results unambiguously
indicates a loss of events.

> +
> +		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_WORKTREE) {
> +			if (recv_rdcw_watch(data->watch_worktree) == -1)
> +				goto force_error_stop;
> +			if (process_worktree_events(state) == LISTENER_SHUTDOWN)
> +				goto force_shutdown;
> +			if (start_rdcw_watch(data, data->watch_worktree) == -1)
> +				goto force_error_stop;
> +			continue;
> +		}
> +
> +		if (dwWait == WAIT_OBJECT_0 + LISTENER_HAVE_DATA_GITDIR) {
> +			if (recv_rdcw_watch(data->watch_gitdir) == -1)
> +				goto force_error_stop;
> +			if (process_gitdir_events(state) == LISTENER_SHUTDOWN)
> +				goto force_shutdown;
> +			if (start_rdcw_watch(data, data->watch_gitdir) == -1)
> +				goto force_error_stop;
> +			continue;
> +		}
> +
> +		if (dwWait == WAIT_OBJECT_0 + LISTENER_SHUTDOWN)
> +			goto clean_shutdown;
> +
> +		error(_("could not read directory changes [GLE %ld]"),
> +		      GetLastError());
> +		goto force_error_stop;
> +	}
> +
> +force_error_stop:
> +	state->error_code = -1;
> +
> +force_shutdown:
> +	/*
> +	 * Tell the IPC thead pool to stop (which completes the await
> +	 * in the main thread (which will also signal this thread (if
> +	 * we are still alive))).
> +	 */
> +	ipc_server_stop_async(state->ipc_server_data);
> +
> +clean_shutdown:
> +	cancel_rdcw_watch(data->watch_worktree);
> +	cancel_rdcw_watch(data->watch_gitdir);
>  }
>  
>  int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
>  {
> +	struct fsmonitor_daemon_backend_data *data;
> +
> +	data = xcalloc(1, sizeof(*data));

CALLOC_ARRAY()

> +
> +	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
> +
> +	data->watch_worktree = create_watch(state,
> +					    state->path_worktree_watch.buf);
> +	if (!data->watch_worktree)
> +		goto failed;
> +
> +	if (state->nr_paths_watching > 1) {
> +		data->watch_gitdir = create_watch(state,
> +						  state->path_gitdir_watch.buf);
> +		if (!data->watch_gitdir)
> +			goto failed;
> +	}
> +
> +	data->hListener[LISTENER_SHUTDOWN] = data->hEventShutdown;
> +	data->nr_listener_handles++;
> +
> +	data->hListener[LISTENER_HAVE_DATA_WORKTREE] =
> +		data->watch_worktree->hEvent;
> +	data->nr_listener_handles++;
> +
> +	if (data->watch_gitdir) {
> +		data->hListener[LISTENER_HAVE_DATA_GITDIR] =
> +			data->watch_gitdir->hEvent;
> +		data->nr_listener_handles++;
> +	}

This is a clever organization of the event handles. I imagine it
will requires some rework if we decide to include another optional
handle whose inclusion is orthogonal to the gitdir one, but that
is unlikely enough to keep these well-defined array indices.

> +	state->backend_data = data;
> +	return 0;
> +
> +failed:
> +	CloseHandle(data->hEventShutdown);
> +	destroy_watch(data->watch_worktree);
> +	destroy_watch(data->watch_gitdir);
> +
>  	return -1;
>  }
>  
>  void fsmonitor_fs_listen__dtor(struct fsmonitor_daemon_state *state)
>  {
> +	struct fsmonitor_daemon_backend_data *data;
> +
> +	if (!state || !state->backend_data)
> +		return;
> +
> +	data = state->backend_data;
> +
> +	CloseHandle(data->hEventShutdown);
> +	destroy_watch(data->watch_worktree);
> +	destroy_watch(data->watch_gitdir);
> +
> +	FREE_AND_NULL(state->backend_data);
>  }

I tried to follow all the API calls and check the documentation for
any misuse, but did not find any. I can only contribute nitpicks
here, and rely on the tests to really see that this is working as
expected.

I was hoping to find in here why we need to sleep in the test suite,
but have not pinpointed that issue yet.

Thanks,
-Stolee
