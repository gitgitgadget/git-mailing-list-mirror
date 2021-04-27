Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED6DC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 18:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC20761139
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhD0Sgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhD0Sgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 14:36:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F9C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 11:35:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso5076277ott.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0xT9aq6qk/PBeawrJvpiCvlEqCMDFPOQVZeSEguvABY=;
        b=diT8ed3QBYxFwnlj0jYAm4t995k4pGTV3i6+mfnytpm1HNKDoTFJlaOp+Z63QLiPbE
         twnghROq/9v7UOpYCZXivZfLRGYidoc82Diwt5OXjt5jczRefixOSXV1c6BgRH63O9Hd
         o5Wa/UwGA0WIVBP7AMaWDHg4iIIFm/9xIh3nb1qaVdNsJ3dGWd/9aFhNv13+mQ66Wukz
         JqybBXff61mhYk53u5hHzqk1G/2y3hwMGopN/2KK2czHqNJZa7NjgaHfd4BS5E8UzagC
         MOOC1qvedvxvOgyvGIggAD/IGGcRaDRb2RZxnELagMh+cZzHIPleAIGvNr5mb5F2yZy7
         RFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0xT9aq6qk/PBeawrJvpiCvlEqCMDFPOQVZeSEguvABY=;
        b=rlD3bTz4gZpZSLyDlBbafHUL1MQeOrQdo2XXdDZDCsqL5FtS5Kbj7tEi91Z2euQzmD
         1URYe4MdqL+ytTQeENhJeOaPmHv6rcKayEOla14PVqySCrE4HXADtIRdLAIFWO458muX
         X51G4ySSkDhglC/ylcO0SR/AF7O7riglGdowzew6GhiuwlrUmU+3LVWCwMBFP5Ykzz4x
         Bx1O87tJBZyFEtQ9ohXUK3qRwAZCM7zRybi41YTagkomR7hDozWF/GxWqcbiqyJenn7w
         qvE8rDtnpX89FbzEsU/aHNsDth+Ztra9SEOdlSeJxw9EH7WSUTGDAh9R/XHQdM0X+nyz
         Pjjw==
X-Gm-Message-State: AOAM531dNjAE+LxQIBW5Ci8lVkPVbtuk0ezgGg06SjM3t0GdlRszBcZK
        O3eD4XMVFeNizGOzrzQQy/M=
X-Google-Smtp-Source: ABdhPJxFDY16+1Lo5WF+sQEvFemo6IY1ov/n2nJEwKxnXH8+x0muT/bKZBBw6AF6SOxCUH5KFoIp5g==
X-Received: by 2002:a9d:7359:: with SMTP id l25mr19588878otk.57.1619548555477;
        Tue, 27 Apr 2021 11:35:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id k20sm848606ook.26.2021.04.27.11.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 11:35:55 -0700 (PDT)
Subject: Re: [PATCH 15/23] fsmonitor-fs-listen-macos: implement FSEvent
 listener on MacOS
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <d469d3f02e335292f4debd55ff67184b2b91b04f.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <26cd8593-58ad-bc97-5348-fdc6aaaba4ec@gmail.com>
Date:   Tue, 27 Apr 2021 14:35:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d469d3f02e335292f4debd55ff67184b2b91b04f.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Implement file system event listener on MacOS using FSEvent,
> CoreFoundation, and CoreServices.

Again, I'm not sure if we _should_ be including URLs to
documentation in our messages, but here are some I found helpful:

[1] https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/FSEvents_ProgGuide/UsingtheFSEventsFramework/UsingtheFSEventsFramework.html
[2] https://developer.apple.com/documentation/corefoundation/1541796-cfrunloopstop
[3] https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Multithreading/RunLoopManagement/RunLoopManagement.html

> Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  compat/fsmonitor/fsmonitor-fs-listen-macos.c | 368 +++++++++++++++++++
>  1 file changed, 368 insertions(+)
> 
> diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> index bec5130d9e1d..e055fb579cc4 100644
> --- a/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> +++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
> @@ -97,20 +97,388 @@ void FSEventStreamRelease(FSEventStreamRef stream);
>  #include "cache.h"
>  #include "fsmonitor.h"
>  #include "fsmonitor-fs-listen.h"
> +#include "fsmonitor--daemon.h"
> +
> +struct fsmonitor_daemon_backend_data
> +{
> +	CFStringRef cfsr_worktree_path;
> +	CFStringRef cfsr_gitdir_path;
> +
> +	CFArrayRef cfar_paths_to_watch;
> +	int nr_paths_watching;
> +
> +	FSEventStreamRef stream;
> +
> +	CFRunLoopRef rl;
> +
> +	enum shutdown_style {
> +		SHUTDOWN_EVENT = 0,
> +		FORCE_SHUTDOWN,
> +		FORCE_ERROR_STOP,
> +	} shutdown_style;
> +
> +	unsigned int stream_scheduled:1;
> +	unsigned int stream_started:1;
> +};
> +
> +static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
> +{
> +	struct strbuf msg = STRBUF_INIT;

Before going through these ifs and constructing a string, it
might be a good idea to check if the trace event will actually
be sent somewhere. If the logging method is switched to a
trace2 method, then up here we can do:

	if (!trace2_is_enabled())
		return;

> +	if (flag & kFSEventStreamEventFlagMustScanSubDirs)
> +		strbuf_addstr(&msg, "MustScanSubDirs|");
> +	if (flag & kFSEventStreamEventFlagUserDropped)
> +		strbuf_addstr(&msg, "UserDropped|");
> +	if (flag & kFSEventStreamEventFlagKernelDropped)
> +		strbuf_addstr(&msg, "KernelDropped|");
> +	if (flag & kFSEventStreamEventFlagEventIdsWrapped)
> +		strbuf_addstr(&msg, "EventIdsWrapped|");
> +	if (flag & kFSEventStreamEventFlagHistoryDone)
> +		strbuf_addstr(&msg, "HistoryDone|");
> +	if (flag & kFSEventStreamEventFlagRootChanged)
> +		strbuf_addstr(&msg, "RootChanged|");
> +	if (flag & kFSEventStreamEventFlagMount)
> +		strbuf_addstr(&msg, "Mount|");
> +	if (flag & kFSEventStreamEventFlagUnmount)
> +		strbuf_addstr(&msg, "Unmount|");
> +	if (flag & kFSEventStreamEventFlagItemChangeOwner)
> +		strbuf_addstr(&msg, "ItemChangeOwner|");
> +	if (flag & kFSEventStreamEventFlagItemCreated)
> +		strbuf_addstr(&msg, "ItemCreated|");
> +	if (flag & kFSEventStreamEventFlagItemFinderInfoMod)
> +		strbuf_addstr(&msg, "ItemFinderInfoMod|");
> +	if (flag & kFSEventStreamEventFlagItemInodeMetaMod)
> +		strbuf_addstr(&msg, "ItemInodeMetaMod|");
> +	if (flag & kFSEventStreamEventFlagItemIsDir)
> +		strbuf_addstr(&msg, "ItemIsDir|");
> +	if (flag & kFSEventStreamEventFlagItemIsFile)
> +		strbuf_addstr(&msg, "ItemIsFile|");
> +	if (flag & kFSEventStreamEventFlagItemIsHardlink)
> +		strbuf_addstr(&msg, "ItemIsHardlink|");
> +	if (flag & kFSEventStreamEventFlagItemIsLastHardlink)
> +		strbuf_addstr(&msg, "ItemIsLastHardlink|");
> +	if (flag & kFSEventStreamEventFlagItemIsSymlink)
> +		strbuf_addstr(&msg, "ItemIsSymlink|");
> +	if (flag & kFSEventStreamEventFlagItemModified)
> +		strbuf_addstr(&msg, "ItemModified|");
> +	if (flag & kFSEventStreamEventFlagItemRemoved)
> +		strbuf_addstr(&msg, "ItemRemoved|");
> +	if (flag & kFSEventStreamEventFlagItemRenamed)
> +		strbuf_addstr(&msg, "ItemRenamed|");
> +	if (flag & kFSEventStreamEventFlagItemXattrMod)
> +		strbuf_addstr(&msg, "ItemXattrMod|");
> +	if (flag & kFSEventStreamEventFlagOwnEvent)
> +		strbuf_addstr(&msg, "OwnEvent|");
> +	if (flag & kFSEventStreamEventFlagItemCloned)
> +		strbuf_addstr(&msg, "ItemCloned|");
> +
> +	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=%u %s",
> +			 path, flag, msg.buf);

Should this be a trace2 call?

> +
> +	strbuf_release(&msg);
> +}
> +
> +static int ef_is_root_delete(const FSEventStreamEventFlags ef)
> +{
> +	return (ef & kFSEventStreamEventFlagItemIsDir &&
> +		ef & kFSEventStreamEventFlagItemRemoved);
> +}
> +
> +static int ef_is_root_renamed(const FSEventStreamEventFlags ef)
> +{
> +	return (ef & kFSEventStreamEventFlagItemIsDir &&
> +		ef & kFSEventStreamEventFlagItemRenamed);
> +}

Will these be handled differently? Or is it enough to detect
ef_is_root_moved_or_deleted()?

> +static void fsevent_callback(ConstFSEventStreamRef streamRef,
> +			     void *ctx,
> +			     size_t num_of_events,
> +			     void *event_paths,
> +			     const FSEventStreamEventFlags event_flags[],
> +			     const FSEventStreamEventId event_ids[])
> +{
> +	struct fsmonitor_daemon_state *state = ctx;
> +	struct fsmonitor_daemon_backend_data *data = state->backend_data;
> +	char **paths = (char **)event_paths;
> +	struct fsmonitor_batch *batch = NULL;
> +	struct string_list cookie_list = STRING_LIST_INIT_DUP;
> +	const char *path_k;
> +	const char *slash;
> +	int k;
> +
> +	/*
> +	 * Build a list of all filesystem changes into a private/local
> +	 * list and without holding any locks.
> +	 */
> +	for (k = 0; k < num_of_events; k++) {
> +		/*
> +		 * On Mac, we receive an array of absolute paths.
> +		 */
> +		path_k = paths[k];
> +
> +		/*
> +		 * If you want to debug FSEvents, log them to GIT_TRACE_FSMONITOR.
> +		 * Please don't log them to Trace2.
> +		 *
> +		 * trace_printf_key(&trace_fsmonitor, "XXX '%s'", path_k);
> +		 */

Oh, I see. _Not_ trace2. What should we do to see if this is enabled
to avoid over-working in the case we are not using GIT_TRACE_FSMONITOR?

> +		/*
> +		 * If event[k] is marked as dropped, we assume that we have
> +		 * lost sync with the filesystem and should flush our cached
> +		 * data.  We need to:
> +		 *
> +		 * [1] Abort/wake any client threads waiting for a cookie and
> +		 *     flush the cached state data (the current token), and
> +		 *     create a new token.
> +		 *
> +		 * [2] Discard the batch that we were locally building (since
> +		 *     they are conceptually relative to the just flushed
> +		 *     token).
> +		 */
> +		if ((event_flags[k] & kFSEventStreamEventFlagKernelDropped) ||
> +		    (event_flags[k] & kFSEventStreamEventFlagUserDropped)) {

Perhaps create a macro EVENT_FLAG_DROPPED that is the union of these two? Then
a single "event_flags[k] & EVENT_FLAG_DROPPED" would suffice here. Helps cover
up how complicated the macOS API names are, too.

> +			/*
> +			 * see also kFSEventStreamEventFlagMustScanSubDirs
> +			 */
> +			trace2_data_string("fsmonitor", NULL,
> +					   "fsm-listen/kernel", "dropped");
> +
> +			fsmonitor_force_resync(state);
> +
> +			if (fsmonitor_batch__free(batch))
> +				BUG("batch should not have a next");

I mentioned before that BUG() seems overkill for these processes, but this
one fits. If this batch has a next, then we did something wrong, right? Do
we have an automated test that checks enough events to maybe cause a second
batch to be created?

> +			string_list_clear(&cookie_list, 0);
> +
> +			/*
> +			 * We assume that any events that we received
> +			 * in this callback after this dropped event
> +			 * may still be valid, so we continue rather
> +			 * than break.  (And just in case there is a
> +			 * delete of ".git" hiding in there.)
> +			 */
> +			continue;
> +		}
> +
> +		switch (fsmonitor_classify_path_absolute(state, path_k)) {
> +
> +		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
> +		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
> +			/* special case cookie files within .git or gitdir */
> +
> +			/* Use just the filename of the cookie file. */
> +			slash = find_last_dir_sep(path_k);
> +			string_list_append(&cookie_list,
> +					   slash ? slash + 1 : path_k);
> +			break;
> +
> +		case IS_INSIDE_DOT_GIT:
> +		case IS_INSIDE_GITDIR:
> +			/* ignore all other paths inside of .git or gitdir */
> +			break;
> +
> +		case IS_DOT_GIT:
> +		case IS_GITDIR:
> +			/*
> +			 * If .git directory is deleted or renamed away,
> +			 * we have to quit.
> +			 */
> +			if (ef_is_root_delete(event_flags[k])) {
> +				trace2_data_string("fsmonitor", NULL,
> +						   "fsm-listen/gitdir",
> +						   "removed");
> +				goto force_shutdown;
> +			}
> +			if (ef_is_root_renamed(event_flags[k])) {
> +				trace2_data_string("fsmonitor", NULL,
> +						   "fsm-listen/gitdir",
> +						   "renamed");
> +				goto force_shutdown;
> +			}

I see. The only difference is in how we trace the result. I'm not sure
this tracing message is worth the differentiation.

> +			break;
> +
> +		case IS_WORKDIR_PATH:
> +			/* try to queue normal pathnames */
> +
> +			if (trace_pass_fl(&trace_fsmonitor))
> +				log_flags_set(path_k, event_flags[k]);
> +
> +			/* fsevent could be marked as both a file and directory */

The _same_ event? Interesting. And I see that you need to log the name
differently in the case of a file or a directory.

> +			if (event_flags[k] & kFSEventStreamEventFlagItemIsFile) {
> +				const char *rel = path_k +
> +					state->path_worktree_watch.len + 1;
> +
> +				if (!batch)
> +					batch = fsmonitor_batch__new();
> +				fsmonitor_batch__add_path(batch, rel);
> +			}
> +
> +			if (event_flags[k] & kFSEventStreamEventFlagItemIsDir) {
> +				const char *rel = path_k +
> +					state->path_worktree_watch.len + 1;
> +				char *p = xstrfmt("%s/", rel);

In a critical path, xstrfmt() may be too slow for such a simple case.
Likely we should instead use a strbuf with:

	strbuf_addstr(&p, rel);
	strbuf_addch(&p, '/');

Bonus points if we can use the data to predict the size of the strbuf's
buffer.

> +
> +				if (!batch)
> +					batch = fsmonitor_batch__new();
> +				fsmonitor_batch__add_path(batch, p);
> +
> +				free(p);
> +			}
> +
> +			break;
> +
> +		case IS_OUTSIDE_CONE:
> +		default:
> +			trace_printf_key(&trace_fsmonitor,
> +					 "ignoring '%s'", path_k);
> +			break;
> +		}
> +	}
> +
> +	fsmonitor_publish(state, batch, &cookie_list);
> +	string_list_clear(&cookie_list, 0);
> +	return;
> +
> +force_shutdown:
> +	if (fsmonitor_batch__free(batch))
> +		BUG("batch should not have a next");
> +	string_list_clear(&cookie_list, 0);
> +
> +	data->shutdown_style = FORCE_SHUTDOWN;
> +	CFRunLoopStop(data->rl);
> +	return;
> +}
> +
> +/*
> + * TODO Investigate the proper value for the `latency` argument in the call
> + * TODO to `FSEventStreamCreate()`.  I'm not sure that this needs to be a
> + * TODO config setting or just something that we tune after some testing.
> + * TODO
> + * TODO With a latency of 0.1, I was seeing lots of dropped events during
> + * TODO the "touch 100000" files test within t/perf/p7519, but with a
> + * TODO latency of 0.001 I did not see any dropped events.  So the "correct"
> + * TODO value may be somewhere in between.
> + * TODO
> + * TODO https://developer.apple.com/documentation/coreservices/1443980-fseventstreamcreate
> + */

As Eric mentioned in another thread, this should say "NEEDSWORK" at
the top. This is a good candidate for follow-up after the basics of
the series is stable.

>  int fsmonitor_fs_listen__ctor(struct fsmonitor_daemon_state *state)
>  {
> +	FSEventStreamCreateFlags flags = kFSEventStreamCreateFlagNoDefer |
> +		kFSEventStreamCreateFlagWatchRoot |
> +		kFSEventStreamCreateFlagFileEvents;
> +	FSEventStreamContext ctx = {
> +		0,
> +		state,
> +		NULL,
> +		NULL,
> +		NULL
> +	};
> +	struct fsmonitor_daemon_backend_data *data;
> +	const void *dir_array[2];
> +
> +	data = xcalloc(1, sizeof(*data));

CALLOC_ARRAY()

> +	state->backend_data = data;
> +
> +	data->cfsr_worktree_path = CFStringCreateWithCString(
> +		NULL, state->path_worktree_watch.buf, kCFStringEncodingUTF8);
> +	dir_array[data->nr_paths_watching++] = data->cfsr_worktree_path;
> +
> +	if (state->nr_paths_watching > 1) {
> +		data->cfsr_gitdir_path = CFStringCreateWithCString(
> +			NULL, state->path_gitdir_watch.buf,
> +			kCFStringEncodingUTF8);
> +		dir_array[data->nr_paths_watching++] = data->cfsr_gitdir_path;
> +	}
> +
> +	data->cfar_paths_to_watch = CFArrayCreate(NULL, dir_array,
> +						  data->nr_paths_watching,
> +						  NULL);
> +	data->stream = FSEventStreamCreate(NULL, fsevent_callback, &ctx,
> +					   data->cfar_paths_to_watch,
> +					   kFSEventStreamEventIdSinceNow,
> +					   0.001, flags);
> +	if (data->stream == NULL)
> +		goto failed;
> +
> +	/*
> +	 * `data->rl` needs to be set inside the listener thread.
> +	 */
> +
> +	return 0;
> +
> +failed:
> +	error("Unable to create FSEventStream.");
> +
> +	FREE_AND_NULL(state->backend_data);
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
> +	if (data->stream) {
> +		if (data->stream_started)
> +			FSEventStreamStop(data->stream);
> +		if (data->stream_scheduled)
> +			FSEventStreamInvalidate(data->stream);
> +		FSEventStreamRelease(data->stream);
> +	}
> +
> +	FREE_AND_NULL(state->backend_data);
>  }
>  
>  void fsmonitor_fs_listen__stop_async(struct fsmonitor_daemon_state *state)
>  {
> +	struct fsmonitor_daemon_backend_data *data;
> +
> +	data = state->backend_data;
> +	data->shutdown_style = SHUTDOWN_EVENT;
> +
> +	CFRunLoopStop(data->rl);
>  }
>  
>  void fsmonitor_fs_listen__loop(struct fsmonitor_daemon_state *state)
>  {
> +	struct fsmonitor_daemon_backend_data *data;
> +
> +	data = state->backend_data;
> +
> +	data->rl = CFRunLoopGetCurrent();
> +
> +	FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
> +	data->stream_scheduled = 1;
> +
> +	if (!FSEventStreamStart(data->stream)) {
> +		error("Failed to start the FSEventStream");
> +		goto force_error_stop_without_loop;
> +	}
> +	data->stream_started = 1;
> +
> +	CFRunLoopRun();
> +
> +	switch (data->shutdown_style) {
> +	case FORCE_ERROR_STOP:
> +		state->error_code = -1;
> +		/* fall thru */
> +	case FORCE_SHUTDOWN:
> +		ipc_server_stop_async(state->ipc_server_data);
> +		/* fall thru */
> +	case SHUTDOWN_EVENT:
> +	default:
> +		break;
> +	}
> +	return;
> +
> +force_error_stop_without_loop:
> +	state->error_code = -1;
> +	ipc_server_stop_async(state->ipc_server_data);
> +	return;
>  }

Thanks,
-Stolee
