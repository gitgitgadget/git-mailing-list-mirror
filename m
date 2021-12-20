Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA842C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhLTQu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 11:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhLTQuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 11:50:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001CC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:50:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w16so12429198edc.11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TGQ1jQsyZohxGjEHI8Tj9SIcdz75Dl7q8UilhIEWWaM=;
        b=c2aV1qC9eL8/kDKABx+twjZZrhKZSKOjbDH5kZ3vgeP7NK48d2tHQgeBeZN4G6qbdp
         ARRuHKEME5sjqOwGxAiX636qy28n33qGIZVI13GY+/Miq5wwesjiK6d96R8RQFoyObHH
         NB08NybrH6JCECDArAUo+0XQT8sT3MN7ISQizt178n/VVsSg7eoj2zgnCEKbasLi2WMC
         snzPRDMowAnv2zUZW2ktRYUm2jeKSoyZTe2ryrUzrBmwat6mWIAs0O9ivlokyDPTAfxo
         4xIRxXfAFpbPyMExv3u9OXetw5sRQ4RjsUbykUrVbTzlQsbetVzlOUtolJEMHICSzL+M
         R5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TGQ1jQsyZohxGjEHI8Tj9SIcdz75Dl7q8UilhIEWWaM=;
        b=nPNmFP+kM7HG4VsTnCu/H0Uz90CGnH4DWNytA6ANWM2gvRcVDDd4FultLLmgns5yYo
         hJJ6xJ9OnkwsRLE29FC0zHbXNBZcIH8B3aPPHPWyhOWCng73KNK3nQQE9/8wE26/dYzT
         DdcTDyWtRlmKQ266rr5nfjQzTQKx06zAJhTFZOKeNfTj7RjHqxMGwNX5SlZsU1rgAbfY
         q6CccO2i3lljgH2C/GbwrT9FLGZWuVx51q7vbUD5ZN5M7VT2944OzpIIzSn8RQyC/DYC
         LCGnhpcsaQ1reT8StRY6Uvo9BHG9L5GVSHx/5fVn3sL4KHGvX/KCwZTtI2jTabg4TD9b
         swHw==
X-Gm-Message-State: AOAM533UFTLCc6ndb9ET0UawrQfcSymYR77nWLKp+pM4czhf8yDlCytw
        49P6Tvf8nZo/ahvc0oJS+Eqp6zf2b8psIg==
X-Google-Smtp-Source: ABdhPJzQEHxm9Ib7l+NB40Z7LIi57SK1RqrRAGdsPZ3qqx3ZstDgQ5gaDpEfLhw/adeBJjCQsM9ovg==
X-Received: by 2002:a05:6402:5191:: with SMTP id q17mr5179866edd.45.1640019053914;
        Mon, 20 Dec 2021 08:50:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e13sm5421970ejs.179.2021.12.20.08.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 08:50:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzLsD-000TbV-1j;
        Mon, 20 Dec 2021 17:50:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 7/9] trace2: add stopwatch timers
Date:   Mon, 20 Dec 2021 17:42:25 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <dd4f0576254defa3ab0e73a73c9c433f28fcca5b.1640012469.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <dd4f0576254defa3ab0e73a73c9c433f28fcca5b.1640012469.git.gitgitgadget@gmail.com>
Message-ID: <211220.86h7b3usnn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> +static void tr2main_emit_summary_timers(uint64_t us_elapsed_absolute)
> +{
> +	struct tr2_tgt *tgt_j;
> +	int j;
> +	struct tr2tmr_block merged;
> +
> +	memset(&merged, 0, sizeof(merged));

Nit: just do a " = { 0 }" assignment above instead.

> +	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
> +		BUG("invalid timer id: %d", tid);
> +
> +	tr2tmr_start(tid);
> +}
> +
> +void trace2_timer_stop(enum trace2_timer_id tid)
> +{
> +	if (!trace2_enabled)
> +		return;
> +
> +	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
> +		BUG("invalid timer id: %d", tid);

nit / style: maybe assert() instead for cases where assert() produces
better info than BUG(). I.e. it would quote the whole expression, and
show you what condition it violated....

> +void tr2tmr_stop(enum trace2_timer_id tid)
> +{
> +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
> +	struct tr2tmr_timer *t = &ctx->timers.timer[tid];
> +	uint64_t us_now;
> +	uint64_t us_interval;
> +
> +	assert(t->recursion_count > 0);

...as you opted to do here.

> +
> +	t->recursion_count--;
> +	if (t->recursion_count > 0)
> +		return; /* still in recursive call */
> +
> +	us_now = getnanotime() / 1000;
> +	us_interval = us_now - t->start_us;
> +
> +	t->total_us += us_interval;
> +
> +	if (!t->interval_count) {
> +		t->min_us = us_interval;
> +		t->max_us = us_interval;
> +	} else {
> +		if (us_interval < t->min_us)
> +			t->min_us = us_interval;
> +		if (us_interval > t->max_us)
> +			t->max_us = us_interval;
> +	}

Perhaps more readable/easily understood as just a (untested):

    if (!t->interval_count || us_interval >= t->min_us)
	    t->min_us = us_interval;
    if (!t->interval_count || us_interval >= t->max_us)
	    t->max_us = us_interval;

I.e. to avoid duplicating the identical assignment...

> [...]
> +		if (!t->interval_count)
> +			continue; /* this timer was not used by this thread. */
> +
> +		t_merged->total_us += t->total_us;
> +
> +		if (!t_merged->interval_count) {
> +			t_merged->min_us = t->min_us;
> +			t_merged->max_us = t->max_us;
> +		} else {
> +			if (t->min_us < t_merged->min_us)
> +				t_merged->min_us = t->min_us;
> +			if (t->max_us > t_merged->max_us)
> +				t_merged->max_us = t->max_us;
> +		}

...ditto, maybe since it's used at least twice factor it out to some
trivial "static" helper here (maybe not worth it..)>

> +	/*
> +	 * Number of nested starts on the stack in this thread.  (We
> +	 * ignore recursive starts and use this to track the recursive
> +	 * calls.)
> +	 */
> +	unsigned int recursion_count;

Earlier we have various forms of:

    if (t->recursion_count > 1)

But since it's unsigned can we just make those a:

    if (t->recursion_count)

?
