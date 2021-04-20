Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A5BC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C64A61363
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhDTKpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhDTKpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 06:45:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CBC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:44:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r20so7785334ejo.11
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=WaTU5nNp0d3tM7dubT9yAIGXIp3W9hWOHEDTTtdq5Qw=;
        b=NoBBsNkruK5yedPg09NYJGelYQwsQd11zrtCY33ehXBJfKFVFh2KZmikVCWasoKDd1
         3gJruLlPCB9i+d/iE177usHrVC2Srv7/n3IxSh4r+DEKAEWEBebIvUsq1kKpWaDj+tnr
         kUG14Vk3S/9m1snWD+VEBsIziUg9Cy3yZI13/TXdAYPx+qoUyKiCcdYqdnqr0lHjgITX
         /RFwPKFDKUqjNXts9KdWDBTV5EXcbktT/knVZGo3zr64CfG7zdylqXT6P0CgRxRbohPw
         w2U4E6YPrYy8m9PntdOxAtv0H+3qXFLiX+P7DIOCH5R95MKS7mQL9xPUSs96a51cDcfQ
         zjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=WaTU5nNp0d3tM7dubT9yAIGXIp3W9hWOHEDTTtdq5Qw=;
        b=bWsDsjiBxuWmIEOe/y8VDIhxtStTgbLP8Zu3CjLkeT37YErUfnaxUK2eqZMTRV5pty
         SeFJ6AcN2d1nNYeRi3hPLbmeGaw29wEsKjfq5061ExEvcwD1fbRriwY18ItUr06Bfi3o
         3D394zO5Of8g6LV2i8X7pAMT/hjvMN1hMT5Pk496ynF9WuCjj5FciNJk40E4/gLiecn6
         tRhGYEVyl4VCpTcyS0I8ZSxt/q6wKKxwA3fXuJlUT5VpdxRz3HFLjrUFTE5Ktb/jhy1R
         EattbvPNKbqVxB/8JeiWyPixnz/HwHPx/pUvQ6QMgWYKIEoqpz16mFYENpsgihhYbw9H
         t6ZQ==
X-Gm-Message-State: AOAM530hcuXvYVJXwXQojX9u04eVqM27eR1Y4Z1XvGAsS6ZR+T99YQ0z
        AiSBIK1AgxkyBU66X7M43X7hcVkz/ao=
X-Google-Smtp-Source: ABdhPJwfD7pxvr1JNx2SAoAj9Kcd+5hkazZNu1ESTz6zfDpiBr27wE4+mBH13j+xzY1KBcliAmOGrA==
X-Received: by 2002:a17:907:217b:: with SMTP id rl27mr26998231ejb.359.1618915486401;
        Tue, 20 Apr 2021 03:44:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z6sm12265847ejp.86.2021.04.20.03.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 03:44:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-completion.bash: consolidate cases in _git_stash()
References: <cover.1618910364.git.liu.denton@gmail.com>
 <4f8d015d54376af277883f57e8b4cf2c63ed8a03.1618910364.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <4f8d015d54376af277883f57e8b4cf2c63ed8a03.1618910364.git.liu.denton@gmail.com>
Date:   Tue, 20 Apr 2021 12:44:45 +0200
Message-ID: <877dkx44ma.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 20 2021, Denton Liu wrote:

> The $subcommand case statement in _git_stash() is quite repetitive.
> Consolidate the cases together into one catch-all case to reduce the
> repetition.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 30c9a97616..7bce9a0112 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3032,21 +3032,6 @@ _git_stash ()
>  	fi
>  
>  	case "$subcommand,$cur" in
> -	push,--*)
> -		__gitcomp_builtin stash_push
> -		;;
> -	save,--*)
> -		__gitcomp_builtin stash_save
> -		;;
> -	pop,--*)
> -		__gitcomp_builtin stash_pop
> -		;;
> -	apply,--*)
> -		__gitcomp_builtin stash_apply
> -		;;
> -	drop,--*)
> -		__gitcomp_builtin stash_drop
> -		;;
>  	list,--*)
>  		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
>  		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
> @@ -3054,8 +3039,8 @@ _git_stash ()
>  	show,--*)
>  		__gitcomp_builtin stash_show "$__git_diff_common_options"
>  		;;
> -	branch,--*)
> -		__gitcomp_builtin stash_branch
> +	*,--*)
> +		__gitcomp_builtin "stash_$subcommand"
>  		;;
>  	branch,*)
>  		if [ $cword -eq $((__git_cmd_idx+2)) ]; then
> @@ -3069,8 +3054,6 @@ _git_stash ()
>  		__gitcomp_nl "$(__git stash list \
>  				| sed -n -e 's/:.*//p')"
>  		;;
> -	*)
> -		;;
>  	esac
>  }

One might think that this introduces a logic error in "git stash
doesnotexist" now dispatching to a non-existing "stash_doesnotexist" or
something, bu tI see that earlier (omitted from context) in the function
there's an exhaustive lit of push/save/pop etc. which guards against
this, is is that correct?
