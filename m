Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E373C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B26105A
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 13:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhD0NZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 09:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbhD0NZY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 09:25:24 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA6C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 06:24:41 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id a188-20020a4a4cc50000b02901f0ae7068a1so5027431oob.13
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OhYVoxkW++TyzUCzcs4ixRQSn+ZjkBHuDDMTroLH8iI=;
        b=GseQwasPLZYexa5Zy5Bf7C5rdjKnEf8q17FdBTKDt1802WAnzWw87jTvEGwGTEPVtk
         hclCvAzdPPOtt1nroa70sLwxZWEcqdillVMy+Jvf4DQPqTgXtP1s990CBpZ98LNk8aUG
         Kismvo0JJiK8kmn3kXBagh+hGfPLm83dQKxF9yoUQAtJcBJbkq1pHPfh8MzFTG3QL68n
         Nq+s59XMkivDATovVKOyYt3Uul8KDPh4k1vJ2ktxH0nf07L4U4jLYDk72E5M+LE7mAZr
         mVl9SJEplRvO1Q9rT6pDFndFleoF3aes1V1QlAWVAvCRDJpFbUmKJWoBHLj635419mZy
         OjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OhYVoxkW++TyzUCzcs4ixRQSn+ZjkBHuDDMTroLH8iI=;
        b=ZuXMy5lwQO7ZEVB9rFda2hWGqBZfIqvNjgxU+YttX9QudnF6EJ/0MVGZSrZdsvPxwe
         4VXcLalJoglpve6Q7s9sGoqWCZgUmR3FdCmBB45KolI3wUGq68KoCPzs02QXyfbUjIcg
         MOCAhqjBPEgxKYSEzBAtp74MCzMkHcEykIu/VbwaE39YJN7K85kCXXPGKFUcicmFpkkv
         TxGKmT7gobgRvCzkdfgUW6DuZpJXuuJfUK2bjnRt2rER9cY3FJAFOZBcmxDwWJfm1ZxV
         HcvyregwdQ5Pb+hh/dI+5Ng6BqB4hLn8MVYcnABx15Tc5lWEpZ71oY7IEr0FnHRHqdis
         O3Ow==
X-Gm-Message-State: AOAM533KhsfiXscaXlJv2zds+a7z41HTqiG658fbqh+Dj1m64NUFRwOJ
        cip5Ez+p+Y4GAM6xwpF77+g=
X-Google-Smtp-Source: ABdhPJz94afB3mIyq1eBJdKk2I0WiLWfHWFF2w45Rs+ppghDg3LlGX5CoAHwBJ5khJPgZguP5RQX2w==
X-Received: by 2002:a4a:8c0d:: with SMTP id u13mr17773253ooj.59.1619529880406;
        Tue, 27 Apr 2021 06:24:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id f75sm3707843oig.36.2021.04.27.06.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 06:24:39 -0700 (PDT)
Subject: Re: [PATCH 17/23] fsmonitor--daemon: periodically truncate list of
 modified files
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <9f263e70c7245a01210ac743ce3dfda4dcc08308.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1f4a4de9-4067-8608-0379-84098c9b404f@gmail.com>
Date:   Tue, 27 Apr 2021 09:24:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <9f263e70c7245a01210ac743ce3dfda4dcc08308.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach fsmonitor--daemon to periodically truncate the list of
> modified files to save some memory.
> 
> Clients will ask for the set of changes relative to a token that they
> found in the FSMN index extension in the index.  (This token is like a
> point in time, but different).  Clients will then update the index to
> contain the response token (so that subsequent commands will be
> relative to this new token).
> 
> Therefore, the daemon can gradually truncate the in-memory list of
> changed paths as they become obsolete (older that the previous token).

s/older that/older than/

> Since we may have multiple clients making concurrent requests with a
> skew of tokens and clients may be racing to the talk to the daemon,
> we lazily truncate the list.
> 
> We introduce a 5 minute delay and truncate batches 5 minutes after
> they are considered obsolete.

5 minutes seems like a good default timeframe. We can consider
making this customizable in the future.

> +/*
> + * To keep the batch list from growing unbounded in response to filesystem
> + * activity, we try to truncate old batches from the end of the list as
> + * they become irrelevant.
> + *
> + * We assume that the .git/index will be updated with the most recent token
> + * any time the index is updated.  And future commands will only ask for
> + * recent changes *since* that new token.  So as tokens advance into the
> + * future, older batch items will never be requested/needed.  So we can
> + * truncate them without loss of functionality.
> + *
> + * However, multiple commands may be talking to the daemon concurrently
> + * or perform a slow command, so a little "token skew" is possible.
> + * Therefore, we want this to be a little bit lazy and have a generous
> + * delay.

I appreciate this documentation of the "expected" behavior and how it
compares to the "possible" behavior.

> + * The current reader thread walked backwards in time from `token->batch_head`
> + * back to `batch_marker` somewhere in the middle of the batch list.
> + *
> + * Let's walk backwards in time from that marker an arbitrary delay
> + * and truncate the list there.  Note that these timestamps are completely
> + * artificial (based on when we pinned the batch item) and not on any
> + * filesystem activity.
> + */
> +#define MY_TIME_DELAY (5 * 60) /* seconds */

Perhaps put the units into the macro? MY_TIME_DELAY_SECONDS?
> +static void fsmonitor_batch__truncate(struct fsmonitor_daemon_state *state,
> +				      const struct fsmonitor_batch *batch_marker)
> +{
> +	/* assert state->main_lock */

If this comment is intended to be a warning for consumers that they should
have the lock around this method, then maybe that should be in a documentation
comment above the method declaration.

> +	const struct fsmonitor_batch *batch;
> +	struct fsmonitor_batch *rest;
> +	struct fsmonitor_batch *p;
> +	time_t t;

This is only used within the for loop, so it could be defined there.

> +
> +	if (!batch_marker)
> +		return;
> +
> +	trace_printf_key(&trace_fsmonitor, "TRNC mark (%"PRIu64",%"PRIu64")",

What's the value of abbreviating "truncate" like this? Is there a special
reason?

> +			 batch_marker->batch_seq_nr,
> +			 (uint64_t)batch_marker->pinned_time);
> +
> +	for (batch = batch_marker; batch; batch = batch->next) {
> +		if (!batch->pinned_time) /* an overflow batch */
> +			continue;
> +
> +		t = batch->pinned_time + MY_TIME_DELAY;
> +		if (t > batch_marker->pinned_time) /* too close to marker */
> +			continue;> +
> +		goto truncate_past_here;
> +	}
> +
> +	return;
> +
> +truncate_past_here:
> +	state->current_token_data->batch_tail = (struct fsmonitor_batch *)batch;
> +
> +	rest = ((struct fsmonitor_batch *)batch)->next;
> +	((struct fsmonitor_batch *)batch)->next = NULL;
> +
> +	for (p = rest; p; p = fsmonitor_batch__free(p)) {
> +		trace_printf_key(&trace_fsmonitor,
> +				 "TRNC kill (%"PRIu64",%"PRIu64")",
> +				 p->batch_seq_nr, (uint64_t)p->pinned_time);
> +	}

I see that you are not using the method that frees the entire list so
you can trace each entry as it is deleted. That works.

> +}
> +
>  static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
>  {
>  	struct fsmonitor_batch *p;
> @@ -647,6 +716,15 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  			 * that work.
>  			 */
>  			fsmonitor_free_token_data(token_data);
> +		} else if (batch) {
> +			/*
> +			 * This batch is the first item in the list
> +			 * that is older than the requested sequence
> +			 * number and might be considered to be
> +			 * obsolete.  See if we can truncate the list
> +			 * and save some memory.
> +			 */
> +			fsmonitor_batch__truncate(state, batch);

Seems to work as advertised.

Thanks,
-Stolee
