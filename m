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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D936C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F011060D07
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 08:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbhGPJCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbhGPJCs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 05:02:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB7EC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:59:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k27so11983962edk.9
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SHBVCICo0x0mF8AIMo7ORxqRPRUjJs7vbFZ/iKfhs1E=;
        b=UVl4LaPvVyqSdxlRYKLmiONxPa31fh5kvdew0bEbX/JlcSeO83Ldu6lgzltMFIBX58
         3BnJJrSRUSLhgqioxcFakZM4gwUrT/FKA3juBvgAHoF65X6hb4mEyxnLXDepe9C2bplg
         KbGuV250rnKPs+7SIpHqh8N/GJJhIF9bo/rD98iuDAyGKLeHWllluqpsOhyJAuxtZBBd
         1zgeRZLll6qC985QOGPgCeKrDpkicKkq/ImGpjjxT3AiHtYQTwmcDyJNEG6InXNlJfAS
         hBSCHWQ61aKlFN7hCQ2SlVNLrcRhbSnI4GlCvV6c1MUYzDXd2goyxuBhILTR5tMnBCGb
         WoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SHBVCICo0x0mF8AIMo7ORxqRPRUjJs7vbFZ/iKfhs1E=;
        b=eS6Mz10w15A6OGu/oXGqd29/fhKzgbc0h/iKG7Djchy4V1TgnMEXlPmvG/LQBqGIJ3
         kvzYvOWyjLZ1/p8Vlr7kHFtRdkpIzvGNgibKWP1ZdHNDGI+hvv2DYixzIhjkaDxz1kDQ
         BUiCChDxs6pfPZWp6o7K61tHsr+4q3QjyW5L+VqYPoxMbDwlt3HimLYl6LoaIKxYB/mb
         AItGFwLXRF5jt/6oavJxrokMFE+FjcZkR4TYr8rvpCapTWBAvErTMVBFCOwT7afhrQ4v
         +tsNeUF8oFIDYmu4WWQCPalH5LHfCxugy2/A1FQEDwk+UMoFSVx9HbQ9ZYCssbXu+ahX
         iZHA==
X-Gm-Message-State: AOAM533lnHq77SmPG+wAb0hLhfVyaUl3mtHZcMXnR+JSgGA7kcOgnbWW
        8wCmvsUkxNQrplRcp+PJRRQ=
X-Google-Smtp-Source: ABdhPJwEuHWb4J/zjSzvvyreoIf3PhXgzlJBgJieYuIGvzcR/Ggf4NbDw71NR+NQNe02C7NzTe2eSA==
X-Received: by 2002:aa7:d8c6:: with SMTP id k6mr13252987eds.374.1626425990575;
        Fri, 16 Jul 2021 01:59:50 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n3sm3475031edd.53.2021.07.16.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:59:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/9] hook: treat hookdir hook specially
Date:   Fri, 16 Jul 2021 10:58:34 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-5-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210715232603.3415111-5-emilyshaffer@google.com>
Message-ID: <87lf66y6pd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Emily Shaffer wrote:

> Soon, we will allow users to specify hooks using the config. These
> config-specified hooks may require different child_process options than
> hook executables in the gitdir. So, let's differentiate between hooks
> coming from the gitdir and hooks coming from the config.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  hook.c | 3 ++-
>  hook.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hook.c b/hook.c
> index 19138a8290..3a588cb055 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -117,6 +117,7 @@ struct list_head* hook_list(const char* hookname)
>  		struct hook *to_add = xmalloc(sizeof(*to_add));
>  		to_add->hook_path = hook_path;
>  		to_add->feed_pipe_cb_data = NULL;
> +		to_add->from_hookdir = 1;
>  		list_add_tail(&to_add->list, hook_head);
>  	}
>  
> @@ -200,7 +201,7 @@ static int pick_next_hook(struct child_process *cp,
>  	cp->dir = hook_cb->options->dir;
>  
>  	/* add command */
> -	if (hook_cb->options->absolute_path)
> +	if (run_me->from_hookdir && hook_cb->options->absolute_path)
>  		strvec_push(&cp->args, absolute_path(run_me->hook_path));
>  	else
>  		strvec_push(&cp->args, run_me->hook_path);
> diff --git a/hook.h b/hook.h
> index 586ddf40bb..60389cd8cd 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -22,6 +22,8 @@ struct hook {
>  	/* The path to the hook */
>  	const char *hook_path;
>  
> +	unsigned from_hookdir : 1;
> +
>  	/*
>  	 * Use this to keep state for your feed_pipe_fn if you are using
>  	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.

The "from_hookdir" looks like it isn't used until 6/9, and maybe the
absolute_path change too? In any case this seems like a carried-forward
rebase of
https://lore.kernel.org/git/20210311021037.3001235-5-emilyshaffer@google.com/
or some version thereof.

At this point I tihnk it would be way better to squash this and other
such changes that basically add a field to a struct that isn't used yet
into whatever commit use/need them.
