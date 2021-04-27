Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E79C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE0761164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 14:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhD0OYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbhD0OYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 10:24:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5161C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 07:23:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j19so3914108qtx.13
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9u1fKMGoQbr6TrwmIIQZdFoHf3kFaIWtMAOWBEYwaJo=;
        b=ReWhMF9mM8Rk8p1c+B00b3o/1+x4miZZhA/5v6uYe72qMGx7JxkXvyIeiL3NJqDciF
         5XiLpdaiYAqxAUTtMsjNv7TSHUsNlva53zdwuUeB/ma5HrtM2EUp3pekW1N3RqsVD21U
         Pc5bo2h/NhlJAK5pnVzZ/aiZG0hylp3M6uH1A6iOgWTQiw7FcHp/5Y+DGRedfdsAcjtH
         6YdrSHgu6dSvl6D9+U+zyrxV/Al9Vebfwq6ckWT5X0wE1xvX4V6W8qkDirqDdsXeBNAC
         pDxQum9ytsJtbv+aiLvJ1XlNW4Xh2fe97q9na8bNMoJzwzvDts7ysPp0n6NEyA6kXP+T
         pi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9u1fKMGoQbr6TrwmIIQZdFoHf3kFaIWtMAOWBEYwaJo=;
        b=cZcBqApLzQ0N4jVTiEPcXKiE4KBdS2E9V2UrRhPhrW7rA75tflvZXuNUke2fRDiKo4
         Y376PuEl0O8t2vw85DmyqI4RHG0KBUhOP2+RUI3h6K2Bf3guv9qoEjAt3852sBJjbja6
         MzaLCoyS1lV5BUFw6k6eEZ3m6+fMtZwT5u1TktGgvUFf2+ucWWN3xcBj+s5Tm8wEMLNn
         wOqqLBeIFJd57sLTej3PoS5FLZ179NPXTwcsGg979zu/0qCvqxXs/DxCylG6gKXCw5Wx
         4cOoUZ33Z5cckpdzrqF1Psu2djtf0qJzPjFdLL1FxFvzI6qJV2HBYNrjLdl8xh21X9rE
         FIIA==
X-Gm-Message-State: AOAM533C7JfcXMWkzojl1PxYaKhdWd7BVVmX1x9dLlpFOKE5ENg4iuzY
        14aiw6eW+mFhiYy3VuCW3Aw=
X-Google-Smtp-Source: ABdhPJyi1fcGH9JzF2yM2d4lj48S7sa/N9hfCnaEbcNgPOB0UnrU99RTKGEzOQOIxRH7n1A8dPaZZQ==
X-Received: by 2002:ac8:7cb5:: with SMTP id z21mr22100715qtv.136.1619533436872;
        Tue, 27 Apr 2021 07:23:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id t18sm2834422qkj.75.2021.04.27.07.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 07:23:56 -0700 (PDT)
Subject: Re: [PATCH 19/23] fsmonitor--daemon: use a cookie file to sync with
 file system
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <038b62dc6744e8d8004f3f8423a40066821c0f1b.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5669d313-4084-dceb-1204-acd005e58657@gmail.com>
Date:   Tue, 27 Apr 2021 10:23:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <038b62dc6744e8d8004f3f8423a40066821c0f1b.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:41 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach fsmonitor--daemon client threads to create a cookie file
> inside the .git directory and then wait until FS events for the
> cookie are observed by the FS listener thread.
> 
> This helps address the racy nature of file system events by
> blocking the client response until the kernel has drained any
> event backlog.

This description matches my expectation of the cookie file,
which furthers my confusion about GIT_TEST_FSMONITOR_CLIENT_DELAY.

> +enum fsmonitor_cookie_item_result {
> +	FCIR_ERROR = -1, /* could not create cookie file ? */
> +	FCIR_INIT = 0,
> +	FCIR_SEEN,
> +	FCIR_ABORT,
> +};
> +
> +struct fsmonitor_cookie_item {
> +	struct hashmap_entry entry;
> +	const char *name;
> +	enum fsmonitor_cookie_item_result result;
> +};
> +
> +static int cookies_cmp(const void *data, const struct hashmap_entry *he1,
> +		     const struct hashmap_entry *he2, const void *keydata)

I'm interested to see why a hashset is necessary.

> +static enum fsmonitor_cookie_item_result fsmonitor_wait_for_cookie(
> +	struct fsmonitor_daemon_state *state)
> +{
> +	int fd;
> +	struct fsmonitor_cookie_item cookie;
> +	struct strbuf cookie_pathname = STRBUF_INIT;
> +	struct strbuf cookie_filename = STRBUF_INIT;
> +	const char *slash;
> +	int my_cookie_seq;
> +
> +	pthread_mutex_lock(&state->main_lock);

Hm. We are entering a locked region. I hope this is only for the
cookie write and not the entire waiting period.

> +	my_cookie_seq = state->cookie_seq++;
> +
> +	strbuf_addbuf(&cookie_pathname, &state->path_cookie_prefix);
> +	strbuf_addf(&cookie_pathname, "%i-%i", getpid(), my_cookie_seq);
> +
> +	slash = find_last_dir_sep(cookie_pathname.buf);
> +	if (slash)
> +		strbuf_addstr(&cookie_filename, slash + 1);
> +	else
> +		strbuf_addbuf(&cookie_filename, &cookie_pathname);

This business about the slash-or-not-slash is good defensive
programming. I imagine the only possible way for there to not
be a slash is if the Git process is running with the .git
directory as its working directory?

> +	cookie.name = strbuf_detach(&cookie_filename, NULL);
> +	cookie.result = FCIR_INIT;
> +	// TODO should we have case-insenstive hash (and in cookie_cmp()) ??

This TODO comment should be cleaned up. Doesn't match C-style, either.

As for the question, I believe that we can limit ourselves to names that
don't need case-insensitive hashes and trust that the filesystem will not
change the case. Using lowercase letters should help with this.

> +	hashmap_entry_init(&cookie.entry, strhash(cookie.name));
> +
> +	/*
> +	 * Warning: we are putting the address of a stack variable into a
> +	 * global hashmap.  This feels dodgy.  We must ensure that we remove
> +	 * it before this thread and stack frame returns.
> +	 */
> +	hashmap_add(&state->cookies, &cookie.entry);

I saw this warning and thought about avoiding it by using the heap, but
even with a heap pointer we need to be careful to remove the result
before returning and stopping the thread.

However, there is likely a higher potential of a bug leading to a
security issue through an error causing stack corruption and unsafe
code execution. Perhaps it is worth converting to using heap data here.

> +	trace_printf_key(&trace_fsmonitor, "cookie-wait: '%s' '%s'",
> +			 cookie.name, cookie_pathname.buf);
> +
> +	/*
> +	 * Create the cookie file on disk and then wait for a notification
> +	 * that the listener thread has seen it.
> +	 */
> +	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
> +	if (fd >= 0) {
> +		close(fd);
> +		unlink_or_warn(cookie_pathname.buf);

Interesting that we are ignoring the warning here. Is it possible that
these cookie files will continue to grow if this unlink fails?

> +
> +		while (cookie.result == FCIR_INIT)
> +			pthread_cond_wait(&state->cookies_cond,
> +					  &state->main_lock);

Ok, we are waiting here for another thread to signal that the cookie
file has been found in the events. What happens if the event gets lost?
I'll look for a later signal that cookie.result can change based on a
timeout, too.

> +
> +		hashmap_remove(&state->cookies, &cookie.entry, NULL);
> +	} else {
> +		error_errno(_("could not create fsmonitor cookie '%s'"),
> +			    cookie.name);
> +
> +		cookie.result = FCIR_ERROR;
> +		hashmap_remove(&state->cookies, &cookie.entry, NULL);
> +	}

Both blocks here remove the cookie entry, so move it to the end of the
method with the other cleanups.

> +
> +	pthread_mutex_unlock(&state->main_lock);

Hm. We are locking the main state throughout this process. I suppose that
the listener thread could be watching multiple repos and updating them
while we wait here for one repo to update. This is a larger lock window
than I was hoping for, but I don't currently see how to reduce it safely.

> +
> +	free((char*)cookie.name);
> +	strbuf_release(&cookie_pathname);
> +	return cookie.result;

Remove the cookie from the hashset along with these lines.

> +}
> +
> +/*
> + * Mark these cookies as _SEEN and wake up the corresponding client threads.
> + */
> +static void fsmonitor_cookie_mark_seen(struct fsmonitor_daemon_state *state,
> +				       const struct string_list *cookie_names)
> +{
> +	/* assert state->main_lock */

I'm now confused what this is trying to document. The 'state' should be
locked by another thread while we are waiting for a cookie response, so
this method is updating the cookie as seen from a different thread that
doesn't have the lock.

...
> +/*
> + * Set _ABORT on all pending cookies and wake up all client threads.
> + */
> +static void fsmonitor_cookie_abort_all(struct fsmonitor_daemon_state *state)
...

> + * [2] Some of those lost events may have been for cookie files.  We
> + *     should assume the worst and abort them rather letting them starve.
> + *
>   * If there are no readers of the the current token data series, we
>   * can free it now.  Otherwise, let the last reader free it.  Either
>   * way, the old token data series is no longer associated with our
> @@ -454,6 +600,8 @@ void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
>  			 state->current_token_data->token_id.buf,
>  			 new_one->token_id.buf);
>  
> +	fsmonitor_cookie_abort_all(state);
> +

I see we abort here if we force a resync. I lost the detail of whether
this is triggered by a timeout, too.

> @@ -654,6 +803,39 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  		goto send_trivial_response;
>  	}
>  
> +	pthread_mutex_unlock(&state->main_lock);
> +
> +	/*
> +	 * Write a cookie file inside the directory being watched in an
> +	 * effort to flush out existing filesystem events that we actually
> +	 * care about.  Suspend this client thread until we see the filesystem
> +	 * events for this cookie file.
> +	 */
> +	cookie_result = fsmonitor_wait_for_cookie(state);

Odd that we unlock before calling this method, then just take the lock
again inside of it.

> +	if (cookie_result != FCIR_SEEN) {
> +		error(_("fsmonitor: cookie_result '%d' != SEEN"),
> +		      cookie_result);
> +		result = 0;
> +		goto send_trivial_response;
> +	}
> +
> +	pthread_mutex_lock(&state->main_lock);
> +
> +	if (strcmp(requested_token_id.buf,
> +		   state->current_token_data->token_id.buf)) {
> +		/*
> +		 * Ack! The listener thread lost sync with the filesystem
> +		 * and created a new token while we were waiting for the
> +		 * cookie file to be created!  Just give up.
> +		 */
> +		pthread_mutex_unlock(&state->main_lock);
> +
> +		trace_printf_key(&trace_fsmonitor,
> +				 "lost filesystem sync");
> +		result = 0;
> +		goto send_trivial_response;
> +	}
> +
>  	/*
>  	 * We're going to hold onto a pointer to the current
>  	 * token-data while we walk the list of batches of files.
> @@ -982,6 +1164,9 @@ void fsmonitor_publish(struct fsmonitor_daemon_state *state,
>  		}
>  	}
>  
> +	if (cookie_names->nr)
> +		fsmonitor_cookie_mark_seen(state, cookie_names);
> +

I was confused as to what updates 'cookie_names', but it appears that
these are updated in the platform-specific code. That seems to happen
in later patches.

Thanks,
-Stolee
