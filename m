Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB34FC433E9
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF93464E57
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBKTeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhBKTd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:33:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8BC061574
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:33:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q2so8188788edi.4
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y598Q6ThPMwF6ZjQhQ6KWvYRXUzt2bt1OBDnzee2wmE=;
        b=aQT0aHk9UIr1xzYHixgnbFN0AhHcJYPkD0yzfI33Bwd3wWdEC22R41g9Ez9A2hYahL
         iXBPvyEza2krgQEJ+8Xw2PCo3uHqCAnSH+cvqfFfJqYu+pr7BhpvOXnng4vO/BHVkSdc
         Av3o2+hp2+RLLoDNsuYM6HuEblfSiCPm8zsSlCjQnzYdntS4nKfXkZD7MV8eQhS4xBFM
         iyIa9z9Ap+86kLRZ+4bNJY2OnjvykfzlBKOJf2J2hXnEoJFIyMks/sPwBBZY239ibyu2
         CI6Bo27vpWPtuF1CUgauWYDmklawBG6woqHGJecrovTxeNEwHE2dJnYt86CUtEnIcKfJ
         jMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y598Q6ThPMwF6ZjQhQ6KWvYRXUzt2bt1OBDnzee2wmE=;
        b=BYRns5Q/ovS9u6Pc6lqMaeOeTZAjsHYQf/yJPkMOBHUX/BcrndZkWPNDbABW2dB0pm
         CpGVOGXk8cGtkdii0ott3gv7exIHpYRsgw7QSX6OkolVSo4/n2zAiLUWnQSYaftJsnYC
         XbC+gY979PEY1KDgsonOnkWviglgX4/YHl0uEyQ+J1+DuOa0pd2nGsZoQyW2ScCIwL1I
         9RdM/Qic2l1B8E8/tsjUxy0uW9pa4u+IS9e87Fg33sjsMfFFjlW1JCb/8fWHTZBC47y+
         h6rDAM/CV6FACRqPQXsgOkdCKLpkrRmAEMjqDIlDFaSWKz/ydy1t0uyBvYCIy0vilv2I
         TnRg==
X-Gm-Message-State: AOAM530L9FC4ekfmDkA5yuTMJDPnXZQOlx/eo4fmbMEK/BEqXc7PGXO6
        V+IMTQpmWh6Rv6+HO5UAy2c=
X-Google-Smtp-Source: ABdhPJxpmV7f+F75dLhQ+L29jiIwnu+ccdpxZMmy3f9p+kFNZyDkX9v0ChPzunHnSShYvaaT/kJkyg==
X-Received: by 2002:a05:6402:364:: with SMTP id s4mr9778316edw.98.1613071995884;
        Thu, 11 Feb 2021 11:33:15 -0800 (PST)
Received: from szeder.dev (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id i13sm5147737ejj.2.2021.02.11.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:33:15 -0800 (PST)
Date:   Thu, 11 Feb 2021 20:33:14 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 2/9] midx: allow marking a pack as preferred
Message-ID: <20210211193314.GG1015009@szeder.dev>
References: <cover.1612998106.git.me@ttaylorr.com>
 <4a358d57cf6e834cd1756e70bf713d4d104f321e.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a358d57cf6e834cd1756e70bf713d4d104f321e.1612998106.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 06:02:42PM -0500, Taylor Blau wrote:
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index eb0caa0439..dd14eab781 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -9,7 +9,8 @@ git-multi-pack-index - Write and verify multi-pack-indexes
>  SYNOPSIS
>  --------
>  [verse]
> -'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress] <subcommand>
> +'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
> +	[--preferred-pack=<pack>] <subcommand>
>  
>  DESCRIPTION
>  -----------
> @@ -27,6 +28,14 @@ OPTIONS
>  	Turn progress on/off explicitly. If neither is specified, progress is
>  	shown if standard error is connected to a terminal.
>  
> +--preferred-pack=<pack>::
> +	When using the `write` subcommand, optionally specify the
> +	tie-breaking pack used when multiple packs contain the same
> +	object. Incompatible with other subcommands, including `repack`,

I think this shouldn't be an option of the 'git multi-pack-index'
command but an option of its 'write' subcommand.

