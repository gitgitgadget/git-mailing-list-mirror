Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD9C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BCA610CD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbhHXPHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbhHXPHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:07:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCBC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:06:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i6so32206870edu.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dBdajKryP2pTHEIVeSZO6HEWiS4uEv22sCp/SMKBSE4=;
        b=HrIGJHHqvQQo+K61rYdZJws66tVdsQCCgFjyxWx3JoM7Tvcw8t4TA/1hj0lBr4N6aN
         GPm+G99EBakEIJhJXTYCgADS/KI3t8ernfDzYMMPQpy+ztjdWcXu74ax6XuuSF3RdrG0
         /9TCfAfaw/rZ65h+FrI398STdJh39MMhdvtf26I799LfRFwcCSVwvaFAPKqKVzgPPpQ/
         VPsFiJmCs0IcCIpdpdstwMsu7r7wCzgCvGXEae1tSsRzF6e06HA2T4NnFGkBsWRn9Bpo
         1kMTf2Ysli9RmLDyi6wO9rmrZ3C/RoGKxik1cS/L0VmOeDn/jevQy3PzrEvwGLWL/u3d
         w0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dBdajKryP2pTHEIVeSZO6HEWiS4uEv22sCp/SMKBSE4=;
        b=khUg28ZSLAL+ZXxhS+zJtPYUtDNRilRuszhZwPrrFfttBEQh+8EBumLleABB5L1dQM
         L+nzIVOWh+66wiZVNEur5jGwjSG2KB33BdvqcO0/encmvMjjCy9cmitAhlDu5/DsiGhv
         aQWS/tX8rMAdzcmMURjYjkBBCEY+JX6RjFlsdzUt3Sig48BPQVFcQcaAwBH230ZQzXf7
         xMQ/BR9X2OX0xc0c0xI/qIm2Fw/H+b5ilfz8Zz08BBTeb/fcGjiJ1uSpis0z1Ojni5T7
         kdGLLxzWYgjGAT1uGrJpzG3Q0Bbp2yVlWZzCj/pD5plKQ77TGU6edBnoMW4srjtCS6rM
         wSAQ==
X-Gm-Message-State: AOAM532hpxMS3D0zSLMvpnG8J6zSnRf8qKfixqyg0lYOQOVLWhlGWMrj
        TlyrYnaY/gZ2/wKfAXh9Ohw=
X-Google-Smtp-Source: ABdhPJzEqFINn4uo3tAamuMFEIyrhnf2CKr/XrgV4wWLeF259zbrqUuHvP7K4ESD3/mRDq3oaie6mw==
X-Received: by 2002:a05:6402:2794:: with SMTP id b20mr45134035ede.126.1629817590220;
        Tue, 24 Aug 2021 08:06:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f5sm9408174ejj.45.2021.08.24.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:06:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/6] hook: allow parallel hook execution
Date:   Tue, 24 Aug 2021 17:01:09 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-3-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-3-emilyshaffer@google.com>
Message-ID: <87wnoaevbe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> -'git hook' run [--to-stdin=<path>] [--ignore-missing] <hook-name> [-- <hook-args>]
> +'git hook' run [--to-stdin=<path>] [--ignore-missing] [(-j|--jobs) <n>]
> +	<hook-name> [-- <hook-args>]

As an aside I wondered if it shouldn't be [[-j|--jobs] <n>], but grepped
around and found that (x|y|z) means a mandatory pick of x, y or z, but
[x|y|z] means that, plus possibly picking none, I think.

So this is fine, just something I wondered about...

> +-j::
> +--jobs::
> +	Only valid for `run`.
> ++
> +Specify how many hooks to run simultaneously. If this flag is not specified, use
> +the value of the `hook.jobs` config. If the config is not specified, use the

s/use the value/uses the value/

Also we usually say "of the XYZ config, see linkgit:git-config[1]", or
something to that effect when we mention config variables. Perhaps we
should do the same here.

> +number of CPUs on the current system. Some hooks may be ineligible for
> +parallelization: for example, 'commit-msg' intends hooks modify the commit
> +message body and cannot be parallelized.

Not something that *needs* to happen in this series, but I wonder if we
shouldn't have per-type config here too, so users could force it even
for those hook types if they want.

> -#define RUN_HOOKS_OPT_INIT { \
> -	.env = STRVEC_INIT, \
> -	.args = STRVEC_INIT, \
> -}
> -
>  /*
>   * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
>   * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
> @@ -111,6 +113,18 @@ struct hook_cb_data {
>  	int *invoked_hook;
>  };
>  
> +#define RUN_HOOKS_OPT_INIT_SERIAL { \
> +	.jobs = 1, \
> +	.env = STRVEC_INIT, \
> +	.args = STRVEC_INIT, \
> +}
> +
> +#define RUN_HOOKS_OPT_INIT_PARALLEL { \
> +	.jobs = 0, \
> +	.env = STRVEC_INIT, \
> +	.args = STRVEC_INIT, \
> +}
> +

Ditto earlier comments about whitespace churn, i.e. I can just move this
around in the base topic, so the diff here is the change/addition, not
also moving things around.
