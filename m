Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DCEC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9475161006
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhDZVBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhDZVBq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 17:01:46 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F854C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:01:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso2333261ott.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VH0k604KDteuc1wKC4W8g9t5qFHqILWpsNNeTjDoCWg=;
        b=BBOSfM+6rDSb0d7i1Rr9dFyMwpuCyOoaQkUJEbIFKD6nCFyHUjA2f9CIi9n4PPWHu1
         WpI9lnoB4U7k0yzJq6h0nse0DYuzn7j3NPSTH22tewOVmXLLFIntGgz6E7cITuEvj/Ni
         zRrESZmwIajAbCMd1SUt3OSmmszkLCC1n2/fb77kX3LEPy+kQ+Wb6Zz2Gi5M2GXPc/i1
         SXTQPr+W7QNl42TQH5JUjhMojt694TRHfJvfdWluHfBfhvFZc8E49+ogwGVGtE8jxrU1
         MLsmxxYpj2Qp0v0qs/bdh2h/zaoOWj1LI5H8TC6prsbOnvf8T5QsbyvunD5Z/zIIft7L
         XJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VH0k604KDteuc1wKC4W8g9t5qFHqILWpsNNeTjDoCWg=;
        b=Dm4MESPRkZZ8mN0Sfxz6N37y3Md+Hs7sZPGUvBbd+DgJLD8ioWlnAJ6t/KbpAqoP/8
         x10B6F8QZxMP8Q090HNZODJHuMtA9IjE4KLDTp+F1QIxhAWSbB43OjDr+N/sGxOLuh2K
         TvsQpeqsy3Lnj+siUukxlRSFaIc+HTMu/8Vm44k6TGlAPMG0063VM3M4az3QmFOTdI8q
         gXKBtD1OnFo6RJx3W6m4HzK13QLXoaWBmeUqPmHMEKsY5dwDXRy/7QY91S/Vzui121Ld
         hLpVcLzYIgPUUGXgkF0gjY+iJof+RJIRjaYdSJhzXSPoJmA0uj+S/sTRJtZxw3V1Mj5v
         X+1g==
X-Gm-Message-State: AOAM5300qzZh27ZpaLGGa3Ocz4XK2zt5xlCkNtqXGSLgOWIKUQNV1lOQ
        Xrm64FZMEr9UJFkwJzfJ5gU=
X-Google-Smtp-Source: ABdhPJzCK9yL/z9SNhFpebJaMftG/7kDiBlKUnDSXq4yrWmCSVGw3RK5rjl9AMKUpZEimEko18dk/Q==
X-Received: by 2002:a9d:4713:: with SMTP id a19mr16012035otf.71.1619470863730;
        Mon, 26 Apr 2021 14:01:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id q9sm3300490oig.7.2021.04.26.14.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 14:01:03 -0700 (PDT)
Subject: Re: [PATCH 16/23] fsmonitor--daemon: implement handle_client callback
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <2b4ae4fc3d622f0fee8eb5e527a51467e13acfc5.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <35876c33-4e1a-bc07-cd6c-8d43a25c7903@gmail.com>
Date:   Mon, 26 Apr 2021 17:01:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <2b4ae4fc3d622f0fee8eb5e527a51467e13acfc5.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach fsmonitor--daemon to respond to IPC requests from client
> Git processes and respond with a list of modified pathnames
> relative to the provided token.

(I'm skipping ahead to this part. I'll examine the platform
specific bits after I finish with "the Git bits".)

> +static void fsmonitor_format_response_token(
> +	struct strbuf *response_token,
> +	const struct strbuf *response_token_id,
> +	const struct fsmonitor_batch *batch)
> +{
> +	uint64_t seq_nr = (batch) ? batch->batch_seq_nr + 1 : 0;
> +
> +	strbuf_reset(response_token);
> +	strbuf_addf(response_token, "builtin:%s:%"PRIu64,
> +		    response_token_id->buf, seq_nr);]

Ah, right. The token string gets _even more specific_ to allow
for multiple "checkpoints" within a batch.

> +static int fsmonitor_parse_client_token(const char *buf_token,
> +					struct strbuf *requested_token_id,
> +					uint64_t *seq_nr)
> +{
> +	const char *p;
> +	char *p_end;
> +
> +	strbuf_reset(requested_token_id);
> +	*seq_nr = 0;
> +
> +	if (!skip_prefix(buf_token, "builtin:", &p))
> +		return 1;
> +
> +	while (*p && *p != ':')
> +		strbuf_addch(requested_token_id, *p++);

My mind is going towards microoptimizations, but I wonder if there
is a difference using

	q = strchr(p, ':');
	if (!q)
		return 1;
	strbuf_add(requested_token_id, p, q - p);

We trade one scan with several method calls for instead two scans
and two method calls, but also those two scans are very optimized.

Probably not worth it, as this is something like 20 bytes of data
per round-trip.

> +	if (!skip_prefix(command, "builtin:", &p)) {
> +		/* assume V1 timestamp or garbage */
> +
> +		char *p_end;
> +
> +		strtoumax(command, &p_end, 10);
> +		trace_printf_key(&trace_fsmonitor,
> +				 ((*p_end) ?
> +				  "fsmonitor: invalid command line '%s'" :
> +				  "fsmonitor: unsupported V1 protocol '%s'"),
> +				 command);
> +		result = -1;
> +		goto send_trivial_response;
> +	}

This is an interesting protection for users currently using FS
Monitor but upgrade to the builtin approach.

> +	if (fsmonitor_parse_client_token(command, &requested_token_id,
> +					 &requested_oldest_seq_nr)) {

It appears you will call skip_prefix() twice this way, once to
determine we are actually the right kind of token, but a second
time as part of this call. Perhaps the helper method could start
from 'p' which has already advanced beyond "buildin:"?

> +		trace_printf_key(&trace_fsmonitor,
> +				 "fsmonitor: invalid V2 protocol token '%s'",
> +				 command);
> +		result = -1;
> +		goto send_trivial_response;
> +	}

This method is getting a bit long. Could the interesting data
structure code below be extracted as a method?

> +	pthread_mutex_lock(&state->main_lock);
> +
> +	if (!state->current_token_data) {
> +		/*
> +		 * We don't have a current token.  This may mean that
> +		 * the listener thread has not yet started.
> +		 */
> +		pthread_mutex_unlock(&state->main_lock);
> +		result = 0;
> +		goto send_trivial_response;
> +	}
> +	if (strcmp(requested_token_id.buf,
> +		   state->current_token_data->token_id.buf)) {
> +		/*
> +		 * The client last spoke to a different daemon
> +		 * instance -OR- the daemon had to resync with
> +		 * the filesystem (and lost events), so reject.
> +		 */
> +		pthread_mutex_unlock(&state->main_lock);
> +		result = 0;
> +		trace2_data_string("fsmonitor", the_repository,
> +				   "response/token", "different");
> +		goto send_trivial_response;
> +	}
> +	if (!state->current_token_data->batch_tail) {
> +		/*
> +		 * The listener has not received any filesystem
> +		 * events yet since we created the current token.
> +		 * We can respond with an empty list, since the
> +		 * client has already seen the current token and
> +		 * we have nothing new to report.  (This is
> +		 * instead of sending a trivial response.)
> +		 */
> +		pthread_mutex_unlock(&state->main_lock);
> +		result = 0;
> +		goto send_empty_response;
> +	}
> +	if (requested_oldest_seq_nr <
> +	    state->current_token_data->batch_tail->batch_seq_nr) {
> +		/*
> +		 * The client wants older events than we have for
> +		 * this token_id.  This means that the end of our
> +		 * batch list was truncated and we cannot give the
> +		 * client a complete snapshot relative to their
> +		 * request.
> +		 */
> +		pthread_mutex_unlock(&state->main_lock);
> +
> +		trace_printf_key(&trace_fsmonitor,
> +				 "client requested truncated data");
> +		result = 0;
> +		goto send_trivial_response;
> +	}

If these are part of a helper method, then they could be reorganized
to "goto" the end of the method which returns an error code after
unlocking the mutex. The multiple unlocks are making me nervous.

> +
> +	/*
> +	 * We're going to hold onto a pointer to the current
> +	 * token-data while we walk the list of batches of files.
> +	 * During this time, we will NOT be under the lock.
> +	 * So we ref-count it.

I was wondering if this would happen. I'm glad it is.

> +	 * This allows the listener thread to continue prepending
> +	 * new batches of items to the token-data (which we'll ignore).
> +	 *
> +	 * AND it allows the listener thread to do a token-reset
> +	 * (and install a new `current_token_data`).
> +	 *
> +	 * We mark the current head of the batch list as "pinned" so
> +	 * that the listener thread will treat this item as read-only
> +	 * (and prevent any more paths from being added to it) from
> +	 * now on.
> +	 */
> +	token_data = state->current_token_data;
> +	token_data->client_ref_count++;
> +
> +	batch_head = token_data->batch_head;
> +	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
> +
> +	pthread_mutex_unlock(&state->main_lock);

We are now pinned. Makes sense.

> +	/*
> +	 * FSMonitor Protocol V2 requires that we send a response header
> +	 * with a "new current token" and then all of the paths that changed
> +	 * since the "requested token".
> +	 */
> +	fsmonitor_format_response_token(&response_token,
> +					&token_data->token_id,
> +					batch_head);
> +
> +	reply(reply_data, response_token.buf, response_token.len + 1);
> +	total_response_len += response_token.len + 1;

I was going to say we should let "reply" return the number of bytes written,
but that is already an error code. But then we seem to be ignoring it here.
Should we at least do something like "err |= reply()" to collect any errors?

> +
> +	trace2_data_string("fsmonitor", the_repository, "response/token",
> +			   response_token.buf);
> +	trace_printf_key(&trace_fsmonitor, "response token: %s", response_token.buf);
> +
> +	shown = kh_init_str();
> +	for (batch = batch_head;
> +	     batch && batch->batch_seq_nr >= requested_oldest_seq_nr;
> +	     batch = batch->next) {
> +		size_t k;
> +
> +		for (k = 0; k < batch->nr; k++) {
> +			const char *s = batch->interned_paths[k];
> +			size_t s_len;
> +
> +			if (kh_get_str(shown, s) != kh_end(shown))
> +				duplicates++;
> +			else {
> +				kh_put_str(shown, s, &hash_ret);

It appears that you could make use of 'struct strmap' instead of managing your
own khash structure.

> +
> +				trace_printf_key(&trace_fsmonitor,
> +						 "send[%"PRIuMAX"]: %s",
> +						 count, s);
> +
> +				/* Each path gets written with a trailing NUL */
> +				s_len = strlen(s) + 1;
> +
> +				if (payload.len + s_len >=
> +				    LARGE_PACKET_DATA_MAX) {
> +					reply(reply_data, payload.buf,
> +					      payload.len);
> +					total_response_len += payload.len;
> +					strbuf_reset(&payload);
> +				}
> +
> +				strbuf_add(&payload, s, s_len);
> +				count++;
> +			}
> +		}
> +	}
> +
> +	if (payload.len) {
> +		reply(reply_data, payload.buf, payload.len);
> +		total_response_len += payload.len;
> +	}
> +
> +	kh_release_str(shown);
> +
> +	pthread_mutex_lock(&state->main_lock);
> +	if (token_data->client_ref_count > 0)
> +		token_data->client_ref_count--;
> +
> +	if (token_data->client_ref_count == 0) {
> +		if (token_data != state->current_token_data) {
> +			/*
> +			 * The listener thread did a token-reset while we were
> +			 * walking the batch list.  Therefore, this token is
> +			 * stale and can be discarded completely.  If we are
> +			 * the last reader thread using this token, we own
> +			 * that work.
> +			 */
> +			fsmonitor_free_token_data(token_data);
> +		}
> +	}

Perhaps this could be extracted to a method, so that any (locked) caller
could run

	free_token_if_unused(state, token_data);

and the token will either keep around (because client_ref_count > 0 or
state->current_token_data is still on token_data). Otherwise I predict
this being implemented in two places, which is too many when dealing with
memory ownership.

> +
> +	pthread_mutex_unlock(&state->main_lock);
> +
> +	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
> +	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
> +	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
> +
> +	strbuf_release(&response_token);
> +	strbuf_release(&requested_token_id);
> +	strbuf_release(&payload);
> +
> +	return 0;
> +
> +send_trivial_response:
> +	pthread_mutex_lock(&state->main_lock);
> +	fsmonitor_format_response_token(&response_token,
> +					&state->current_token_data->token_id,
> +					state->current_token_data->batch_head);
> +	pthread_mutex_unlock(&state->main_lock);
> +
> +	reply(reply_data, response_token.buf, response_token.len + 1);
> +	trace2_data_string("fsmonitor", the_repository, "response/token",
> +			   response_token.buf);
> +	reply(reply_data, "/", 2);
> +	trace2_data_intmax("fsmonitor", the_repository, "response/trivial", 1);
> +
> +	strbuf_release(&response_token);
> +	strbuf_release(&requested_token_id);
> +
> +	return result;
> +
> +send_empty_response:
> +	pthread_mutex_lock(&state->main_lock);
> +	fsmonitor_format_response_token(&response_token,
> +					&state->current_token_data->token_id,
> +					NULL);
> +	pthread_mutex_unlock(&state->main_lock);
> +
> +	reply(reply_data, response_token.buf, response_token.len + 1);
> +	trace2_data_string("fsmonitor", the_repository, "response/token",
> +			   response_token.buf);
> +	trace2_data_intmax("fsmonitor", the_repository, "response/empty", 1);
> +
> +	strbuf_release(&response_token);
> +	strbuf_release(&requested_token_id);
> +
> +	return 0;
> +}
> +
>  static ipc_server_application_cb handle_client;
>  
>  static int handle_client(void *data, const char *command,
>  			 ipc_server_reply_cb *reply,
>  			 struct ipc_server_reply_data *reply_data)
>  {
> -	/* struct fsmonitor_daemon_state *state = data; */
> +	struct fsmonitor_daemon_state *state = data;
>  	int result;
>  
> +	trace_printf_key(&trace_fsmonitor, "requested token: %s", command);
> +
>  	trace2_region_enter("fsmonitor", "handle_client", the_repository);
>  	trace2_data_string("fsmonitor", the_repository, "request", command);
>  
> -	result = 0; /* TODO Do something here. */
> +	result = do_handle_client(state, command, reply, reply_data);
>  
>  	trace2_region_leave("fsmonitor", "handle_client", the_repository);
>  

A simple integration with earlier work. Good.

Thanks,
-Stolee
