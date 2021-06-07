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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA9C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBB9600EF
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGTDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:03:41 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:41728 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFGTDl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:03:41 -0400
Received: by mail-wm1-f51.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so321426wmq.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BhWmxqt+t4P2Xqi4D4SYTOQuzPvzrQi0LC+ZivN4yl4=;
        b=IVi2gD/pEYaSDcPl/sgnbtr5ztPaP7TJqO15/9THGD3VjarTUk84oshwT8WmxJ7/ie
         tbwSIQrYa9EJGHQlXC0/AbjK5J1cRKROqmGHrrZKyvIS0LEB0O2NLXs/HyIRtxpxdnZ/
         9x6AA9XAhzX40+P14/myQGHJMNZ8MpM0PtWtRRwPaxWXnn/40jaRVi2K6ziQVtc+Vvgw
         egdQLV1cBDr2FJSXpMIPFI9Cyw/PZf+E3OqGCdma635O/adi4TPveoEbDHob27eoTPh6
         X8dpiBPceHOW6sUmdh+a/EFmDdgxb05eiVfpGVJ76mZJ+2QtL1zjeOYZj32O7nWtm+Ig
         p+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BhWmxqt+t4P2Xqi4D4SYTOQuzPvzrQi0LC+ZivN4yl4=;
        b=hYey1OIuMyq/bDE3Xkui7wlRpTXyc2ufKJu0RaWFyTSq0gM5ZZUvEu0/dMQPmtMiTF
         ZgMroOI2xf2G2hAl7kbz/uMZUx6RjnxIATx9fEfoh3+s/aVJuSPHzKX8XiuBu9CVsxfO
         tzArjhhxJAIQl7JKnw8N85p7DoGIMY85ZQWPVHdaCn7Zt1aIFNhsJ0mp2pa7jn5ZDkxE
         hEEFGKRWwsQ+xZVtTfecKGCw07Dyg0/A72g3BL3uTzhRUXF/xzNb9p34+4dA3eCsm5dp
         PL7s8OMRXfihZZ2y5LADfS0gamK2P7hhxzVD3/8UC++Ete4WsEIgPNHaUbMQWujc6qIO
         ttbw==
X-Gm-Message-State: AOAM533z35DMzRwHtmzIS6uEc76I9SPxwlFr9SJGqx4AMjyr/fqfk5Lk
        ePMvCUOKqogpI0K0Z7jKZosT0Oo0+FE=
X-Google-Smtp-Source: ABdhPJy6ojKHUpzxt10NXfhbqbm3HwfXFEbd4iwfbJAMNkRmGnsRD4BLl4DenRYxyNEyuN7Fe1YSVg==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr489571wms.175.1623092448960;
        Mon, 07 Jun 2021 12:00:48 -0700 (PDT)
Received: from szeder.dev (94-21-29-108.pool.digikabel.hu. [94.21.29.108])
        by smtp.gmail.com with ESMTPSA id l9sm14969777wme.21.2021.06.07.12.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 12:00:48 -0700 (PDT)
Date:   Mon, 7 Jun 2021 21:00:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 try2 3/4] completion: bash: fix for multiple dash
 commands
Message-ID: <20210607190046.GB6312@szeder.dev>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
 <20210606184726.1018460-4-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210606184726.1018460-4-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 06, 2021 at 01:47:25PM -0500, Felipe Contreras wrote:
> Otherwise commands like 'for-each-ref' are not completed.

I think you meant that options of commands like 'for-each-ref' are not
completed.  The command itself can be completed just fine:

  $ git for<TAB>
  for-each-ref      format-patch      

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 05606609f9..1feb2ee108 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -421,7 +421,7 @@ __gitcomp_builtin ()
>  	local incl="${2-}"
>  	local excl="${3-}"
>  
> -	local var=__gitcomp_builtin_"${cmd/-/_}"
> +	local var=__gitcomp_builtin_"${cmd//-/_}"
>  	local options
>  	eval "options=\${$var-}"
>  
> -- 
> 2.31.1.2.g0532ba4bf6
> 
