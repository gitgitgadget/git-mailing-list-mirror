Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE265C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAED6105A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbhDZUXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhDZUXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 16:23:31 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF36C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:22:49 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id i3-20020a4ad3830000b02901ef20f8cae8so5269481oos.11
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PBuwZCK0pLiIHKAbpUURqc9sDOkxNdHAS+jvNECbczM=;
        b=KMzKcy/X9SMs4QUkicCjaL3hm9OOo93aZoC5I7luMa7l+WYRqfLkMI9vcTjlGs4VUT
         XMaUR3ucDSTYkPCSj/1ETbhv8ophF73L61FoRqASrcUMYv1o/XPNCHPW7zBPDfGLTbuu
         Xuk5CKjoAueyBrTiC52OZxBe9iQUwDTH7N3+87ktfuCTL6ZP3XSF/8IvS49e510f1xTC
         1TbNyTVP7D1pzZBXJ5TVREVv2dXSS+DZCzlBTvFAQhodBP5lFzLwZDrzJ6W/HXkUeI4Y
         L/XhJA1OZ5JstsJp7VVLMHRRUGH7WgX3Ks4No4tIwJWvMZWaG5TU4YNDCigWCKv87syR
         cDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PBuwZCK0pLiIHKAbpUURqc9sDOkxNdHAS+jvNECbczM=;
        b=Y+v39aiqQh28nBioihowKhr+X2LclH0WKIMrHDS71b0LpWXPb1jLDoZtiSvwz1Pzhs
         /OWcQ/qBECXB5TRR/iRo0DolNTmKJktG4a1iDgJTG/SAhape3bDGGLkIpjIKmgiNNqBr
         vJ9hE20iQrgv/LHJlZkxxZbxPeQ5PCtnsN6NM67+prG03XzLw2WR3sG116RoqeiOBoSe
         qvzy/Cw0WXbQPUfkgI8dMcp+zPZPDyk7tu68yQERlC2GnoeXMoYOV16j8XAaogUCGosd
         0+iphZBoYjgdCni+INrugcT1Xa3fyazFcRVZ6vihgqWNK/fmQnJuJXvHSOjsVUZw4/xI
         afXw==
X-Gm-Message-State: AOAM533hegt8skEzP3ZmBzJXmngQqGhGKENwb6tDi0vRTw2qTCpUDZP2
        oG/tmFjJlb0Eni93+tQ2g3A=
X-Google-Smtp-Source: ABdhPJwFa7v+YLZASk04vunIcTolrOSL054Cz+PoGNF3ab3YhAHcXJjGSevN/rQhceYDqYN7q7Nd7Q==
X-Received: by 2002:a4a:8dd6:: with SMTP id a22mr14958591ool.74.1619468567386;
        Mon, 26 Apr 2021 13:22:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id j4sm3281861oiw.0.2021.04.26.13.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 13:22:46 -0700 (PDT)
Subject: Re: [PATCH 12/23] fsmonitor--daemon: create token-based changed path
 cache
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <f1fa803ebe9c9f78608c22e55ec590f8c6775c94.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <df33c12b-ada3-05dc-3d17-6cc9d205b4cc@gmail.com>
Date:   Mon, 26 Apr 2021 16:22:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f1fa803ebe9c9f78608c22e55ec590f8c6775c94.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach fsmonitor--daemon to build lists of changed paths and associate
> them with a token-id.  This will be used by the platform-specific
> backends to accumulate changed paths in response to filesystem events.
> 
> The platform-specific event loops receive batches containing one or
> more changed paths.  Their fs listener thread will accumulate them in

I think the lowercase "fs" here is strange. "Their listener thread"
could be interpreted as the IPC listener, so it's probably best to
spell it out: "Their filesystem listener thread".

> a `fsmonitor_batch` (and without locking) and then "publish" them to
> associate them with the current token and to make them visible to the
> client worker threads.
...
> +struct fsmonitor_batch {
> +	struct fsmonitor_batch *next;
> +	uint64_t batch_seq_nr;
> +	const char **interned_paths;
> +	size_t nr, alloc;
> +	time_t pinned_time;
> +};

A linked list to help with adding while consuming it, but also
batching for efficiency. I can see how this will work out
nicely.

> +struct fsmonitor_batch *fsmonitor_batch__new(void)
> +{
> +	struct fsmonitor_batch *batch = xcalloc(1, sizeof(*batch));

I mentioned earlier that I think `CALLOC_ARRAY(batch, 1)` is the
typical pattern here.

> +
> +	return batch;
> +}
> +
> +struct fsmonitor_batch *fsmonitor_batch__free(struct fsmonitor_batch *batch)

Since this method frees the tip of the list and returns the next
item (instead of freeing the entire list), perhaps this would be
better named as _pop()?

> +{
> +	struct fsmonitor_batch *next;
> +
> +	if (!batch)
> +		return NULL;
> +
> +	next = batch->next;
> +
> +	/*
> +	 * The actual strings within the array are interned, so we don't
> +	 * own them.
> +	 */
> +	free(batch->interned_paths);
> +
> +	return next;
> +}
> +
> +void fsmonitor_batch__add_path(struct fsmonitor_batch *batch,
> +			       const char *path)
> +{
> +	const char *interned_path = strintern(path);

This use of interned paths is interesting, although I become
concerned for the amount of memory we are consuming over the
lifetime of the process. This could be considered as a target
for future improvements, perhaps with an LRU cache or something
similar.

> +
> +	trace_printf_key(&trace_fsmonitor, "event: %s", interned_path);
> +
> +	ALLOC_GROW(batch->interned_paths, batch->nr + 1, batch->alloc);
> +	batch->interned_paths[batch->nr++] = interned_path;
> +}
> +
> +static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
> +				     const struct fsmonitor_batch *batch_src)
> +{
> +	/* assert state->main_lock */
> +

This comment seems stale.

> +	size_t k;
> +
> +	ALLOC_GROW(batch_dest->interned_paths,
> +		   batch_dest->nr + batch_src->nr + 1,
> +		   batch_dest->alloc);
> +
> +	for (k = 0; k < batch_src->nr; k++)
> +		batch_dest->interned_paths[batch_dest->nr++] =
> +			batch_src->interned_paths[k];
> +}
> +
> +static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)

This one _does_ free the whole list.

> +{
> +	struct fsmonitor_batch *p;
> +
> +	if (!token)
> +		return;
> +
> +	assert(token->client_ref_count == 0);
> +
> +	strbuf_release(&token->token_id);
> +
> +	for (p = token->batch_head; p; p = fsmonitor_batch__free(p))
> +		;
> +
> +	free(token);
> +}
> +
> +/*
> + * Flush all of our cached data about the filesystem.  Call this if we
> + * lose sync with the filesystem and miss some notification events.
> + *
> + * [1] If we are missing events, then we no longer have a complete
> + *     history of the directory (relative to our current start token).
> + *     We should create a new token and start fresh (as if we just
> + *     booted up).
> + *
> + * If there are no readers of the the current token data series, we
> + * can free it now.  Otherwise, let the last reader free it.  Either
> + * way, the old token data series is no longer associated with our
> + * state data.
> + */
> +void fsmonitor_force_resync(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsmonitor_token_data *free_me = NULL;
> +	struct fsmonitor_token_data *new_one = NULL;
> +
> +	new_one = fsmonitor_new_token_data();
> +
> +	pthread_mutex_lock(&state->main_lock);
> +
> +	trace_printf_key(&trace_fsmonitor,
> +			 "force resync [old '%s'][new '%s']",
> +			 state->current_token_data->token_id.buf,
> +			 new_one->token_id.buf);
> +
> +	if (state->current_token_data->client_ref_count == 0)
> +		free_me = state->current_token_data;
> +	state->current_token_data = new_one;
> +
> +	pthread_mutex_unlock(&state->main_lock);
> +
> +	fsmonitor_free_token_data(free_me);
> +}
> +

Swap the pointer under a lock, free outside of it. Good.

> +/*
> + * We try to combine small batches at the front of the batch-list to avoid
> + * having a long list.  This hopefully makes it a little easier when we want
> + * to truncate and maintain the list.  However, we don't want the paths array
> + * to just keep growing and growing with realloc, so we insert an arbitrary
> + * limit.
> + */
> +#define MY_COMBINE_LIMIT (1024)
> +
> +void fsmonitor_publish(struct fsmonitor_daemon_state *state,
> +		       struct fsmonitor_batch *batch,
> +		       const struct string_list *cookie_names)
> +{
> +	if (!batch && !cookie_names->nr)
> +		return;
> +
> +	pthread_mutex_lock(&state->main_lock);
> +
> +	if (batch) {
> +		struct fsmonitor_batch *head;
> +
> +		head = state->current_token_data->batch_head;
> +		if (!head) {
> +			batch->batch_seq_nr = 0;
> +			batch->next = NULL;
> +			state->current_token_data->batch_head = batch;
> +			state->current_token_data->batch_tail = batch;
> +		} else if (head->pinned_time) {
> +			/*
> +			 * We cannot alter the current batch list
> +			 * because:
> +			 *
> +			 * [a] it is being transmitted to at least one
> +			 * client and the handle_client() thread has a
> +			 * ref-count, but not a lock on the batch list
> +			 * starting with this item.
> +			 *
> +			 * [b] it has been transmitted in the past to
> +			 * at least one client such that future
> +			 * requests are relative to this head batch.
> +			 *
> +			 * So, we can only prepend a new batch onto
> +			 * the front of the list.
> +			 */
> +			batch->batch_seq_nr = head->batch_seq_nr + 1;
> +			batch->next = head;
> +			state->current_token_data->batch_head = batch;
> +		} else if (head->nr + batch->nr > MY_COMBINE_LIMIT) {
> +			/*
> +			 * The head batch in the list has never been
> +			 * transmitted to a client, but folding the
> +			 * contents of the new batch onto it would
> +			 * exceed our arbitrary limit, so just prepend
> +			 * the new batch onto the list.
> +			 */
> +			batch->batch_seq_nr = head->batch_seq_nr + 1;
> +			batch->next = head;
> +			state->current_token_data->batch_head = batch;
> +		} else {
> +			/*
> +			 * We are free to append the paths in the given
> +			 * batch onto the end of the current head batch.
> +			 */
> +			fsmonitor_batch__combine(head, batch);
> +			fsmonitor_batch__free(batch);
> +		}
> +	}
> +
> +	pthread_mutex_unlock(&state->main_lock);
> +}

I appreciate the careful comments in this critical piece of the
data structure. Also, it is good that you already have a batch
of results to merge into the list instead of updating a lock for
every filesystem event.

Thanks,
-Stolee
