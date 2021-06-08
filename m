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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A850C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F766124C
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFHFE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:04:26 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45872 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHFEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 01:04:23 -0400
Received: by mail-wr1-f51.google.com with SMTP id z8so19953627wrp.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6j5uU/LSofSOfCKgbuY1h0ZA450I4StT9/Y3zo3bV9g=;
        b=SDucbUJAQi/mbIRj68Kwxe9MDUqq+13q7jPsxziWLpcboyFOPGvONIKs9OxzgTkIff
         cFLunYidphKPW3M7tpNimmB/NuO/B59XajjOyyYNfA4EIgpoxpp29lcVQhXKcBYqS2cb
         GHPcI1DCUwG4sXms7JKry0ZOTvzSgOl0cH00A2MxK5zxuUWFKi3ZJdgg7bACxilLsZTm
         B5f7CYNyWxXfkpO/fOh9S4YSYa5OhoRlcAUXeSjxVVAwqQjiKT45w4e14jMzg7SCCpZl
         SqhUUVmSdttYa6Knn5GqPUune543M/N+k35bipGFzL+SbEvjYLeJX8bYK3+VPoTDUdo6
         3Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6j5uU/LSofSOfCKgbuY1h0ZA450I4StT9/Y3zo3bV9g=;
        b=qcaKjPg+u2TUeALAizLb3WtllEzZca1KhYJ6Jw4yZENI1IPSi9SrqDVCnPw5U3113J
         y4tuGLcm662m3X9okOFiXulAfRA/G+sTpOLDpncI8U8D7P1bEZO6SYdaaN70pqSS9hB3
         PluE5TOwQRJRWvJr163arSen0fh7Ma3pEWc7PzvdCgLNa1fffjtbWuelloagfkKljne4
         4ofMsc3oAHKtHNS3I8a3ywdA3+b9gW5YYPMy6YBldlBt2xkNrztwsHG3iGqy9rl9xz8B
         hkAfSCDr3DBWr1tytRUJ5SeqBGdhKLda7mcOzBxOu4BF8Q5g4MHdySsO+a2xVz3XG39+
         GJvw==
X-Gm-Message-State: AOAM530BbdypPKw/mIP9qtVoEC0tIbKHbDw6Xb/DTlB9H263YctwxMeU
        3Rug6i1KGAoZXcXSS8sgOAU=
X-Google-Smtp-Source: ABdhPJyvq2gnX3y5CkyO9x5ZqAmwkGaCMEaIq0BexU8cNKhTLsaxg4NwExdpYxgyU1nUCfEybsT7Xw==
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr19873258wrw.11.1623128477608;
        Mon, 07 Jun 2021 22:01:17 -0700 (PDT)
Received: from szeder.dev (94-21-29-108.pool.digikabel.hu. [94.21.29.108])
        by smtp.gmail.com with ESMTPSA id s1sm1467881wmj.8.2021.06.07.22.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:01:17 -0700 (PDT)
Date:   Tue, 8 Jun 2021 07:01:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: zsh: trivial improvement
Message-ID: <20210608050115.GC6312@szeder.dev>
References: <20210608023807.907883-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608023807.907883-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 09:38:07PM -0500, Felipe Contreras wrote:
> $words has basically all the words we need, except the first one: git.
> 
> Lets simply add that instead of passing the original, which contains
> options we don't want to pass downstream (like --git-dir).

In our Bash completion script $words contains all words of the current
command on the command line, including 'git -C tmp -c foo.bar=baz'.

Why should zsh completion behave differently?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.zsh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index cac6f61881..50f89145f3 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -219,9 +219,6 @@ __git_zsh_main ()
>  {
>  	local curcontext="$curcontext" state state_descr line
>  	typeset -A opt_args
> -	local -a orig_words
> -
> -	orig_words=( ${words[@]} )
>  
>  	_arguments -C \
>  		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
> @@ -261,7 +258,7 @@ __git_zsh_main ()
>  
>  		(( $+opt_args[--help] )) && command='help'
>  
> -		words=( ${orig_words[@]} )
> +		words=( git ${words[@]} )
>  
>  		__git_zsh_bash_func $command
>  		;;
> -- 
> 2.32.0.2.g41be0a4e50
> 
