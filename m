Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969B71F463
	for <e@80x24.org>; Thu, 19 Sep 2019 22:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405126AbfISWtB (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 18:49:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54637 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389023AbfISWtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 18:49:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so185532wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0FEn9phAMJiYFgbi6tvsvdhJtiFvlPGFpIw85Iyb+ow=;
        b=bZr+Q47wglw1/uNz5v2rvQOzhTpwczmPtggemYFVGYjPOxi9mbuOeLt/0K3OJe+riJ
         XFRXJECpNnIFuEZln9DRE5lclSp3ptw/oeOulJPKbTAcTDZ09+c1HgQkGj5cYrcNSJlQ
         pSItpTM+P+KxgW2Yi3pBu76yYcbw8pzofodAB3yn3pSdOge32nGq3uTf5F6d+Ds9cZto
         LjthMEC3TPrVm37JraY8c66xn07xYMdmOpl51v3uTYLzZsTYI67gz2h4BrQKcag0G4/L
         4mNbuFlppsRLe5u68wcao1rSzIhe5XF4jkscBkP9MGe0chW1esFhTzrD5pFBUo9aotKG
         jnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0FEn9phAMJiYFgbi6tvsvdhJtiFvlPGFpIw85Iyb+ow=;
        b=VX5MKPyKLIvL6ANv/ewBBEcUhXSc1Wt/+QH65qpHXnr/olIklcKcb4MOj9wymNjVx4
         4cnPkYRq1F1B+mpKmGRplWoqwVsUkA45J2isbe/1V+1IRs9limNee+Kg32kUxp2zGIoA
         F5yT/x/YWW/zxi9pwHemBklAfvUV/+ALtlG6mDhaIkOyiVCimhGdeZnGwA2KeoXKMB0l
         Hp9wYvO23+KCJPPLM1siGwZzo+xfHjk7ztW9xNzNp4+8Z4E5oBc//q7/PiZypP/xBKYd
         aIowts0WGmXTF4mHCFvxNf6Ax076r2GzQfpJOPtzj1U8JyhLhxaphTPrumK3p1JZkLd+
         7mSA==
X-Gm-Message-State: APjAAAUHOi0o2UNQ37WpqjBmSQ7oKwpn81FpjzwdnPBqUGH3TDHvU9r8
        O/ayDoHwf4AzuSSIVO/z++A5Esee
X-Google-Smtp-Source: APXvYqzKg3+NY5HD9Yb9liJdQX6oVt7KoWZZErmsR3hStD7QzOo0KVYf7yZbFc9zkY3gKo9LKWNP1g==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr164439wmj.174.1568933340320;
        Thu, 19 Sep 2019 15:49:00 -0700 (PDT)
Received: from szeder.dev (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id o22sm112184wra.96.2019.09.19.15.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 15:48:59 -0700 (PDT)
Date:   Fri, 20 Sep 2019 00:48:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 15/15] name-rev: plug memory leak in name_rev()
Message-ID: <20190919224857.GD29845@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-18-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919214712.7348-18-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore this patch as well.

On Thu, Sep 19, 2019 at 11:47:12PM +0200, SZEDER Gábor wrote:
> The loop iterating over the parent commits in the name_rev() function
> contains two xstrfmt() calls, and their result is leaked if the parent
> commit is not processed further (because that parent has already been
> visited before, and this further visit doesn't result in a better name
> for its ancestors).
> 
> Make sure that the result of those xstrfmt() calls is free()d if the
> parent commit is not processed further.
> 
> This results in slightly but measurably lower memory usage: the
> avarage maximum resident size of 5 'git name-rev --all' invocations in
> 'linux.git' shrinks from 3256124kB to 319990kB, just about 2% less.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index f867d45f0b..d65de04918 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -139,6 +139,7 @@ static void name_rev(struct commit *start_commit,
>  			struct commit *parent = parents->item;
>  			const char *new_name;
>  			int generation, distance;
> +			const char *new_name_to_free = NULL;
>  
>  			parse_commit(parent);
>  			if (parent->date < cutoff)
> @@ -158,6 +159,7 @@ static void name_rev(struct commit *start_commit,
>  					new_name = xstrfmt("%.*s^%d", (int)len,
>  							   name->tip_name,
>  							   parent_number);
> +				new_name_to_free = new_name;
>  				generation = 0;
>  				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
>  			} else {
> @@ -171,6 +173,8 @@ static void name_rev(struct commit *start_commit,
>  						  from_tag))
>  				last_new_parent = commit_list_append(parent,
>  						  last_new_parent);
> +			else
> +				free((char*) new_name_to_free);
>  		}
>  
>  		*last_new_parent = list;
> -- 
> 2.23.0.331.g4e51dcdf11
> 
