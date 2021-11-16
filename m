Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9A7C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E744B61AFD
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhKPUc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 15:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKPUc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 15:32:57 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7CFC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:29:59 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h2so417354ili.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o8xjHKThzxyOLsyUWwdZpp8rp7KTOKnIaoq9sAApPbU=;
        b=oLvqOK88H508Z10fXfSw+RmZM+Ls6Ek2Mr4tSvEFGJOHPaeI8BugO7iYM6nMBz8oTW
         9Rrv47bs5vie04wwXkHWbJcGupt7JnP1PCe5y7ENYu+rdExr5d9wdIu7sqD/hUiDC5Nb
         L577smlJ5tLlo8/CcUBMCfvoofUDrdneWmR5g/OoYV8LWWCHq55sqXHi5HOHaIY5xv71
         SEQtVOHRB50Z5ProZP2VrYtpWHuM3DKDouiNHssGEhvIE7sSYysdGLWaY0q87OLRy2hD
         UreeK4e2unK24lP9YWU3hi6Ka+fmhK4lKPwxtzzqA0+2g2zYy1dPTD7M/qfx7ReFUII3
         BqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o8xjHKThzxyOLsyUWwdZpp8rp7KTOKnIaoq9sAApPbU=;
        b=vYMr7EHgSzklgANYPJLcckZB0h31I64LS7wvMPPNGAXisqch3o9u1clz4iS7ktgKSU
         ipUcWrL0A84wLP/aITbAe4PK2YB43ZbvGllpnmKoTgfahF9REii/KRMJAKuwThvumm5s
         9EUud/2MfGi60n6DlrMWNmCv/ZNJmRooKfTPAFLC0P40Ez7k+/BjgexLF0CVh5f0sxNw
         Qwr2mjFe//5jGPkE3gWIH3ZQjlcTfnA5D9ajMDnzYsc2dZGHl8ZroHikhv0Xw2ib4i33
         Hpw/lToWIl6p021RGiTAPeof9ceXDxC9brLjfGB3eJtlQBSKKvQ+6t81UCsBSaD0VPdt
         zliA==
X-Gm-Message-State: AOAM530xY+NPrSpPcLYJcy82Lxy/cAtaJJmHKgzZ+M4y70GIhJP9tef1
        VGc8OI8ZZY+0iTqrYlIP/xo5uPh6BriLD+qS
X-Google-Smtp-Source: ABdhPJwNKgcBr8t1wuUVQmSOjeTJXIrKEyAojCGukngwmeFAe2YIZz3cM+gNH3p65PuRUtpFJzaIXg==
X-Received: by 2002:a92:c244:: with SMTP id k4mr6586720ilo.293.1637094599236;
        Tue, 16 Nov 2021 12:29:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a25sm10330812ioa.24.2021.11.16.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 12:29:59 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:29:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: New-ish warning in refs.c with GCC (at least 11.2) under -O3
Message-ID: <YZQUxkYI3TES3vDo@nand.local>
References: <211115.86a6i5s4bn.gmgdl@evledraar.gmail.com>
 <YZLhrSoTzrC7wcQo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZLhrSoTzrC7wcQo@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 05:39:41PM -0500, Jeff King wrote:
> So something like the patch at the end of this email works (compiles
> with -O3 and passes the tests), but I think it is just making things
> more confusing.

I can absolutely understand and am sympathetic to the reasons that
your patch would be making things more brittle. In some sense, it makes
spots like these a little easier to read:

> -			&update->new_oid, &update->old_oid,
> +			update->flags & REF_HAVE_NEW ? &update->new_oid : NULL,
> +			update->flags & REF_HAVE_OLD ? &update->old_oid : NULL,

But I think forcing that burden on every caller is what makes the
overall approach worse.

So it's too bad that we even have this problem in the first place, since
GCC's warning is clearly a false positive. But I would be OK with the
bandaid you propose here:

> I think an assertion similar to what you have above is a better bet,
> but perhaps written more simply as:
>
>   if (flags & REF_HAVE_NEW) {
> 	/* silence gcc 11's over-eager compile-time analysis */
> 	if (!new_oid)
> 		BUG("REF_HAVE_NEW set without passing new_oid");
> 	oidcpy(&update->new_oid, new_oid);
>   }

Thanks,
Taylor
