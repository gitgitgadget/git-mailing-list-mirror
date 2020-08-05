Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D339C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1611B2075A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aVfPp6wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHEUta (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHEUt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:49:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E970CC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 13:49:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h7so42989705qkk.7
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PoFGybxDAR5aGH6Iv7M8nKR1nHqTVwDKvCf/IVq+0+o=;
        b=aVfPp6wpKtv9Y9ASh0RzvYL/Q89q/45QrPjjupWOJJqahFlRKnH+JJM/hsWRpJ90K+
         povQnxkVk7p0FObR/Iskc1HTT9KKskq/U5vWaS9RVH73zmQzwtLiJLcsDlaX46IzVgJR
         bpbmXwk3tJ566omUAcqyPXSupGPnyOyX0DUOfV1+p+KSwLOCyFaU63nHkj7Gjl1U6RW5
         c0I+CohyR0RGxIOaA/Za4NAJ0PZIjcMGrjqXZs1292+/HbCcxtJLB9Qry1HcWCyarwYC
         acmTfOl7JtZ/7povDnJvQFQD6NFUiqE235cXQr/9GoslO1zGJpW5hxHaHtNBsqO94JEL
         XVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PoFGybxDAR5aGH6Iv7M8nKR1nHqTVwDKvCf/IVq+0+o=;
        b=Q8hc5FhBbR6aVmny/ls0S6oDGY2uGb8Skb2F9CcJRLl+laEpTWYfwoIwPzLCL95onx
         ZGo4LYHuRLVC7BDP1eeHpv7etQ3zCCDm+TuCV5YVp9rUd8tcNSNtiRRXNMuEIJFdDfcf
         9z+NCIvCAHee3lqIFWtumWMICP6nICBDzFgv0H3UwSr+u5/flTjD90xHWyUsBH9Uq+dp
         yvBO9glpkmcgPA+6qkEqQ3Cb+UAoWHGpySXxl8rAw50Jodlvek+4V+6KD2wFjW5Poq9f
         TNbQGGhnY5yRFYZmpichuVsarfuKqy7mG8ZPy1OsThmgTzQO0palZFRiF2wOCLAiwHaD
         iXvw==
X-Gm-Message-State: AOAM530xexfoRghH2JblRqWLhVmfenkVmap5hFU87tvhxlH88Evtr83p
        IFoNUwUPpmjwNLA7RZ7N7E5/ig==
X-Google-Smtp-Source: ABdhPJyoNeqCqYeK2OO+8CIbg03hbRUa9WTRJCU/HBwQcm9YxX4ozP3t1+v5c0B0gcWCDUj5Z+FRJg==
X-Received: by 2002:a05:620a:2230:: with SMTP id n16mr5480594qkh.268.1596660566785;
        Wed, 05 Aug 2020 13:49:26 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id p123sm2409589qkd.26.2020.08.05.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 13:49:25 -0700 (PDT)
Date:   Wed, 5 Aug 2020 16:49:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] t7401: modernize style
Message-ID: <20200805204924.GF9546@syl.lan>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-2-shouryashukla.oo@gmail.com>
 <20200805193755.GA2650@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805193755.GA2650@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 03:37:55PM -0400, Denton Liu wrote:
> Hi Shourya,
>
> On Wed, Aug 05, 2020 at 11:19:18PM +0530, Shourya Shukla wrote:
> > The tests in 't7401-submodule-summary.sh' were written a long time ago
> > and have some violations with respect to our CodingGuidelines such as
> > incorrect spacing in usages of the redirection operator and absence
> > of line feed between statements in case of the '|' (pipe) operator.
>
> I'm not aware of anywhere in CodingGuidelines that says you can't have
> the pipe operator on a single line. I assume you're referring to the
> part that reads
>
> 	If a command sequence joined with && or || or | spans multiple
> 	lines, put each command on a separate line and put && and || and
> 	| operators at the end of each line, rather than the start.
>
> Note that says "If a command sequence [...] spans multiple lines", which
> doesn't apply in our case.
>
> > Update it to match the CodingGuidelines.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> >  t/t7401-submodule-summary.sh | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> > index 9bc841d085..4439fb7c17 100755
> > --- a/t/t7401-submodule-summary.sh
> > +++ b/t/t7401-submodule-summary.sh
> > @@ -16,12 +16,13 @@ add_file () {
> >  	owd=$(pwd)
> >  	cd "$sm"
> >  	for name; do
> > -		echo "$name" > "$name" &&
> > +		echo "$name" >"$name" &&

This change is good.

> >  		git add "$name" &&
> >  		test_tick &&
> >  		git commit -m "Add $name"
> >  	done >/dev/null
> > -	git rev-parse --verify HEAD | cut -c1-7
> > +	git rev-parse --verify HEAD |
> > +	cut -c1-7
>
> For the reason above, I disagree with this change as-is. However, one
> useful thing that you can do here is breaking the pipe up entirely. We
> want to avoid is having a git command in the upstream of a pipe. This is
> because the return code of a pipe comes from the last command executed
> so if the rev-parse fails, its return code is swallowed and we have no
> way of knowing.
>
> You could break the pipe up by storing the output of the rev-parse in an
> intermediate file and then have cut read from that file.

This is a good suggestion (I was preparing to write an email to say the
same thing, but I'm glad that I checked Denton's response before doing
so). Something like:

	git rev-parse --verify HEAD >out &&
	cut -c1-7 out

would suffice and be in good style.

Thanks,
Taylor
