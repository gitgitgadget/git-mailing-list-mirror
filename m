Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3686BC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 09:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CDF613E9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 09:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhGPJUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhGPJUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 05:20:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A00BC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 02:17:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dp20so12217029ejc.7
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Uax2dx2rKC9T5cGG29fAQ4SAJ1EuQkNzXAMX7ZCjUJ4=;
        b=NvVoy8OUzwl0yW9Pu/znKnJaHOqdlRZhtIoq1C20nnOkq8roE0NUPVy9wn4mVKKKkX
         BjTvPEi2aC6jTcUkSKIazHGyYyf5654lAPcEkfz3skDDCBPvy8bIQtrAZkId1ggPD7IA
         fPTnfzXezfHaFevm25oFylw0h2eQBVJOv8YYIT7SPUeHIB25fLjHuumI2ojoKFVPNwrN
         gTqlcKQSFFYw/uObXC/M/IW5anXyb284ewLlIG5aHddaYt4Xsphieyvf2nn5c4NWm2Tp
         WtzUpA7y2pJxx1IiMTaxM7lC34lnEMZWlBRaJHQzjBWEPITKZ3aZEdxmKVwww9aqC8CY
         biqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Uax2dx2rKC9T5cGG29fAQ4SAJ1EuQkNzXAMX7ZCjUJ4=;
        b=ucem6kRIAC4WyoNhIa+OMx+800i1lMNNnb5nfWJGfmVw1QrFQfNTheOxq/3kpQALCB
         ScdVWtGVRtV98MY33w1HdN2BD+2svJQH4HftKj9saA0rTxk2gF6mQ2GGjKcuTPcWW0c6
         9ApREi+vnemT7oo8RMIP7A/jGtyHBQ2SIO/MntGT3FIec5+yxD78c3FxmrysVYP3W4y0
         3yj32f5bEtzNBU7uCHttDQaPomyInWoXRVueVgXgt+s3MrZd8fxeM1Hm8961tbPJ6Vva
         O9DBx9n+aRBhXWCftE8Huz/H/gLzk0B4ZxHe5EGBkCIflqklGLvEctkPYvP7OZy6X5zO
         l4zQ==
X-Gm-Message-State: AOAM532eKSgMuEwxvT78PVg5cMu87tKZqzYiyqYysCeIJJP5yohGHiL2
        eufpr7BhLkt9W2vSuSAon3M=
X-Google-Smtp-Source: ABdhPJxCf+h2kp1iVpSMtyc/9AvVAhmZ/F/ENzfJcMfgwgt70sWJHB8eKZCrH86vDXjlhM6jfZs2Kw==
X-Received: by 2002:a17:906:838f:: with SMTP id p15mr10881871ejx.300.1626427034657;
        Fri, 16 Jul 2021 02:17:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t15sm2671009ejf.119.2021.07.16.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:17:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Date:   Fri, 16 Jul 2021 11:13:42 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-9-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210715232603.3415111-9-emilyshaffer@google.com>
Message-ID: <87fswey5wd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Emily Shaffer wrote:

> To enable fine-grained options which apply to a single hook executable,
> and to make it easier for a single executable to be run on multiple hook
> events, teach "hookcmd.<alias>.config". These can be configured as
> follows:
> [...]
> diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> index a97b980cca..5b35170664 100644
> --- a/Documentation/config/hook.txt
> +++ b/Documentation/config/hook.txt
> @@ -3,6 +3,11 @@ hook.<command>.command::
>  	executable on your device, a oneliner for your shell, or the name of a
>  	hookcmd. See linkgit:git-hook[1].
>  
> +hookcmd.<name>.command::
> +	A command to execute during a hook for which <name> has been specified
> +	as a command. This can be an executable on your device or a oneliner for
> +	your shell. See linkgit:git-hook[1].
> +
> [...]
> +Global config
> +----
> +  [hook "post-commit"]
> +    command = "linter"
> +    command = "~/typocheck.sh"
> +
> +  [hookcmd "linter"]
> +    command = "/bin/linter --c"
> +----
> +
> +Local config
> +----
> +  [hook "prepare-commit-msg"]
> +    command = "linter"
> +  [hook "post-commit"]
> +    command = "python ~/run-test-suite.py"
> +----
> +
> +With these configs, you'd then run post-commit hooks in this order:
> +
> +  /bin/linter --c
> +  ~/typocheck.sh
> +  python ~/run-test-suite.py
> +  .git/hooks/post-commit (if present)
> +
> +and prepare-commit-msg hooks in this order:
> +
> +  /bin/linter --c
> +  .git/hooks/prepare-commit-msg (if present)
>  

I still have outstanding feedback on the fundamental design
here. I.e. why is this not:

    hook.<name>.event = post-commit
    hook.<name>.command = <path>

See:

https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/

As noted there I don't see why not, and more complexity results from the
design choice of doing it the way you're proposing. I.e. we can't
discover hooks based on config prefixes, and we end up sticking full FS
paths in config keys.
