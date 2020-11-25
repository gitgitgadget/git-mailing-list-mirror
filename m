Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E8C5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212C720637
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brwahXB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgKYIsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKYIsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 03:48:09 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9859CC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 00:48:09 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so1814669ejb.13
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 00:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q536LUhhiIqaPUyMaE7qL3NmhXYVaYokt0eEgPDNwhI=;
        b=brwahXB2QVPLzfdtkbs++FYjh/apCCr+yC1/Fx6cqW/jiSRaiJh5AjhJZFg2YiQJcV
         VZXbE9xV8Asqt27hF6qDC/k9UOL9jqBeFNL2qAnq2IbWVACxpDgBTTXNlpHekKhxXy2u
         WY7cKc42jd3LjWNt3IlSFQutv8E72AJbk+29oLrxmuIQZx/CgvUlV36sA1BCWvRtDnYD
         L4JYk78Vxs+4zUuRbs3luv5d+Y2X7i9azYW/glNS2mmMwzcC6Cnny2zP97A1rsiSebyZ
         lWxtaXGe/L9u8426PZM+tdNgPYmvrhhJjiQ48Qp10uX+qgE+76bGZKsHj+1hd/eG0qjV
         OW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q536LUhhiIqaPUyMaE7qL3NmhXYVaYokt0eEgPDNwhI=;
        b=OU7yc9zQP4l2dIv+eOVI1aWwv2+ei+7Frr0Ek+iA/jAYLU2QY56xU33lNUVBiN5zwG
         IQEnWEPCV9N0I5oJeeYtoFAVF0clD/69hs6r9fn/etXzCBUC/MxnZ1M64AsID645ooDK
         KfVMmdaZ/tOkJ74FQ0m/p/1156B9mM+feUzwkalfz5wt7nYb7UvrC+VwO8oEoEEE6S8q
         FNH92w2kZd7ZjAeqZvQaDEPJAGI6ZNeork8dWGIUL4wEqyqDRSW2HTO17A94LrREyphS
         qEOI+ROcgFA78C3Fo1+GwBKAtzTa6umaAbjbH3Xu/udllA00J/6kBvfqXzZe9/7bLGS4
         lR3A==
X-Gm-Message-State: AOAM533sczfxvcUDupraYj9e6CHkfDJuSnj15nUE+v5UzXBrnEGSTG0+
        WKJX1y7HBMpISuN+FSiOjkw=
X-Google-Smtp-Source: ABdhPJzHEhWCkY+dYD1dGcMOot9RBigN1qWYPPnzcSVnU5X0yBccBaN3LZNmazqbkdfdwXxdSl/7yA==
X-Received: by 2002:a17:906:57ca:: with SMTP id u10mr2167338ejr.389.1606294088395;
        Wed, 25 Nov 2020 00:48:08 -0800 (PST)
Received: from szeder.dev (78-131-14-45.pool.digikabel.hu. [78.131.14.45])
        by smtp.gmail.com with ESMTPSA id d1sm795926eje.82.2020.11.25.00.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2020 00:48:07 -0800 (PST)
Date:   Wed, 25 Nov 2020 09:48:14 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/26] completion: bash: fix prefix detection in
 branch.*
Message-ID: <20201125084814.GE8396@szeder.dev>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
 <20201110212136.870769-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110212136.870769-2-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 03:21:11PM -0600, Felipe Contreras wrote:
> Otherwise we are completely ignoring the --cur argument.
> 
> The issue can be tested with:
> 
>   git clone --config=branch.<tab>
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 7c81e4ba49..b866b68b3c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2615,8 +2615,8 @@ __git_complete_config_variable_name ()
>  		return
>  		;;
>  	branch.*)
> -		local pfx="${cur%.*}."
> -		cur_="${cur#*.}"
> +		local pfx="${cur_%.*}."
> +		cur_="${cur_#*.}"

Indeed, somehow this case was only half-converted in 5af9d5f6c8
(completion: complete config variables and values for 'git clone
--config=', 2019-08-13), thanks.

>  		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
>  		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
>  		return
> -- 
> 2.29.2
> 
