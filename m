Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB7C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2DA64FFE
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhCLJIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhCLJIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 04:08:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1B2C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:08:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y6so6867798eds.1
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ZOENA4fb4EEXgEYRLEyRuU6pSdeEZsrgxKHg8LuXbuQ=;
        b=Ddwuh63LRc/WO3zEVCoZK8zZbOjSdCEoyomNj8yKdfC2gT+ttcEre6PSzKGuqbo4FI
         6WjqU7sEteDsCbWmXKryEgHYpst/xlj1QMlX48HUlJKp2Qmyie6EwMt0yIaSBQQgCRo3
         uudfaC1F0ANnekVVOdkS8S2HrInOE/hcp9rxDL0Wh3ExxU21ARO3uYtvc7OXxiLCJvrL
         rKIqOTgG2Ud1FSBxcyXOfcweP9qVE6gaPFwuqREsebLpv4+E/0zziZrBt8JFUqCpXIs5
         OdvvkFkjVJN9N5iBAHdSlQX/mbe2WlTwfny+G7d5uJC/Ym21txOkB7lcu2QOKa61lyQe
         b3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ZOENA4fb4EEXgEYRLEyRuU6pSdeEZsrgxKHg8LuXbuQ=;
        b=H5+9ofOP1OgCpYSHojPfzZc9r/ldV2y8Ma40dZG7RRvfY7PmJSYEilKlyEkjh57SZt
         MlmsvHV94L5XMkttHxTRR7WvzIrHDc525F5RFyQeMLeg1mENaSsYZbUGgYjJJvu8fLNl
         NzpkSXWiIWaqh8E8JcOXA+/CjCq8uiUPhsQTcjdoIlXFE2/fVGr4pmUCvIC3dG165Zm2
         IURyGQnbIJDbbeCHy4ZcEXkZsmfmpXjWQIiO+vEiPSZGIzAQqiTQIOTYCz38crWORwWk
         synzyaZhNkCxTFFnnmxbbkl63a9HdCnh3spVb+9mARlgWilYUDY05QFKvGGU0oKyBqkl
         gjIg==
X-Gm-Message-State: AOAM531/B925YnijOSGHDzIw3mzcmMM7x0RNNuSe0pCzECI1BTwZGTzq
        m+JIutRNxcYj/yQcl7O6Exo=
X-Google-Smtp-Source: ABdhPJzEpa7JC9+RXFP9xO6nP+xFMihZdJyf5IT0CSHdbzIAx0WrqD+6/ox7qbO3ZTnF0ZYfz5qPfQ==
X-Received: by 2002:a05:6402:888:: with SMTP id e8mr12740291edy.51.1615540084823;
        Fri, 12 Mar 2021 01:08:04 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l10sm2561889edr.87.2021.03.12.01.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:08:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 17/37] hooks: allow callers to capture output
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-18-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-18-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 10:08:04 +0100
Message-ID: <874khghh8r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> Some server-side hooks will require capturing output to send over
> sideband instead of printing directly to stderr. Expose that capability.

So added here in 17/37 and not used until 30/37. As a point on
readability (this isn't the first such patch) I think it would be better
to just squash those together with some "since we now need access to
consume_sideband in hooks, do that ...".

If there's a much larger API it makes sense to do it as another step...

>  hook.c | 3 ++-
>  hook.h | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/hook.c b/hook.c
> index e16b082cbd..2322720ffe 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -256,6 +256,7 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
>  	o->dir = NULL;
>  	o->feed_pipe = NULL;
>  	o->feed_pipe_ctx = NULL;
> +	o->consume_sideband = NULL;
>  }
>  
>  void run_hooks_opt_init_async(struct run_hooks_opt *o)
> @@ -434,7 +435,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
>  				   pick_next_hook,
>  				   notify_start_failure,
>  				   options->feed_pipe,
> -				   NULL,
> +				   options->consume_sideband,
>  				   notify_hook_finished,
>  				   &cb_data,
>  				   "hook",
> diff --git a/hook.h b/hook.h
> index ecf0228a46..4ff9999b04 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -78,6 +78,14 @@ struct run_hooks_opt
>  	feed_pipe_fn feed_pipe;
>  	void *feed_pipe_ctx;
>  
> +	/*
> +	 * Populate this to capture output and prevent it from being printed to
> +	 * stderr. This will be passed directly through to
> +	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
> +	 * for an example.
> +	 */
> +	consume_sideband_fn consume_sideband;
> +
>  	/* Number of threads to parallelize across */
>  	int jobs;

...but this scaffolding is rather trivial.
