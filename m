Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF3BC2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732F4221FE
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvKE5Wz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKLKCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKLKCK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 05:02:10 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A2C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 02:02:08 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id t11so5429646edj.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pl4SEyAiNhLxM3F0NOHVo8DZzKWITAnGcCBtzqiybJI=;
        b=HvKE5Wz3Ho4n5dBxXy7B6FMfkGY2UvBS3/wj2wYMvgfYP04XT8QaXTyyP7ByYwk/OQ
         SdyiO+1aHrqRu5JGeYUcFlTpKR4j/7eZ81+ICpqjPAVoiUlwwV+pNlXHciZ6pMvxvxCs
         1krbeQAc6wAN7V/D5zHTB+Dk5gVoLnzH1nw9lqOU8k4Bk04d7fJgM4j+65IrrOpyxiiB
         F+sgyQqdwJdjOdJz0au+5usicvQ3IuRKsBSUivtEAK9H7Kgp1I+Byfny1h9/F90F2Sqk
         0mxrZCpir6OIZPac941Zv45+Zko5I4d5OD4xZfme1gMqwrKEY1VJewwwZYEbY5Fmk9DC
         mgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pl4SEyAiNhLxM3F0NOHVo8DZzKWITAnGcCBtzqiybJI=;
        b=JICKRBFqZsnsJvTdGCyg8o5M4qwwouEHy28MWnKQt0IKc+BUgNACyfLLknX6KN4tmj
         ZcH7yyiy6iZqJ63ErSqPp3pwgnFIrdJxKe/bxaEk6N8l+mHLjmItGcRz3FwIsJdKx5aU
         AId2G+RW1sR/nwOjQ8rumiLHCPtBb4i1pkV4GWJhjj814RjdRirCHzaL7iII6SC/WuaH
         1eAvt1vuJIRy/vM/jQ2Hb8LlK0AmP6azgps4MDalLjJh2vB/4M/6aGItxgIh+VGPAmLX
         SYsEF75OtwuG0HLM0K2CyfirQV16lBtgdENCGUXY2up/+NkIef/iquyRgpM4o6jJVP8H
         z7IQ==
X-Gm-Message-State: AOAM531ie0dkfy6Zt8SVsmzifb8R8y/2nVhbDZyVxN0TiZOwihCsEebM
        FyWTFnyCsM/9cMdPE6rYRdSoaf4G1jA=
X-Google-Smtp-Source: ABdhPJxHdHkmpOMb5xlmGk0QCa9KiqYXkhwPGIeOxPD2yPW7HP4F/ay4YAk6hcEokN4OUqD3i6k1yA==
X-Received: by 2002:aa7:cb02:: with SMTP id s2mr4100557edt.211.1605175327431;
        Thu, 12 Nov 2020 02:02:07 -0800 (PST)
Received: from szeder.dev (94-21-58-64.pool.digikabel.hu. [94.21.58.64])
        by smtp.gmail.com with ESMTPSA id f18sm2111910edt.32.2020.11.12.02.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 02:02:06 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:02:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] completion: bash: check for alias loop
Message-ID: <20201112100204.GC4270@szeder.dev>
References: <20201110020343.548848-1-felipe.contreras@gmail.com>
 <20201110020343.548848-3-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110020343.548848-3-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 08:03:43PM -0600, Felipe Contreras wrote:
> We don't want to be stuck in an endless cycle.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index eb00d9ba22..ce0dc1e0f8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1121,11 +1121,16 @@ __git_pretty_aliases ()
>  # __git_aliased_command requires 1 argument
>  __git_aliased_command ()
>  {
> -	local cur=$1 last word cmdline
> +	local cur=$1 list word cmdline
>  
>  	while [[ -n "$cur" ]]; do
> +		if [[ "$list" == *"$cur "* ]]; then

I suspect the right hand side should be *" $cur "* ...

> +			# loop detected
> +			return
> +		fi
> +
>  		cmdline=$(__git config --get "alias.$cur")
> -		last=$cur
> +		list="$cur $list"

... and this should be list=" $cur $list", because otherwise a partial
match is possible and would be mistaken for a loop (though I didn't
actually test whether that's indeed the case).

>  		cur=
>  
>  		for word in $cmdline; do
> @@ -1149,7 +1154,7 @@ __git_aliased_command ()
>  		done
>  	done
>  
> -	cur=$last
> +	cur="${list%% *}"
>  	if [[ "$cur" != "$1" ]]; then
>  		echo "$cur"
>  	fi
> -- 
> 2.29.2
> 
