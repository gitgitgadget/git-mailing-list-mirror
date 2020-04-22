Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB546C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E7520882
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="l5+TA20T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDVUmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUmz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:42:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E9C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:42:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so1732175pfg.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XNPG0ij/+1AWVbiQeBpIu3GtnbiFR5UF5CBBkCGvmNc=;
        b=l5+TA20TJbZ1iJ7O1vMvSydPdjlxBb0OTRrMY2VtM7AhLE4vKK+ipLGJPJeVbCtZEG
         lIMWZ2Uj1qdKB+AtOGNpwXgcMXeYf3Y50I16GGRvhJr9DZb2i7naMDD3NUBvKlEWznSp
         +RLyi+QzGs6GxtNTJaVnkHb2IHVRGO+iJWP630ajt7sWxf0LfnncQR4yzHpEqNyGi3eh
         e4OtnzOSEroom8L0F03pZDikbqIKohTSgpFiinzlg9Lq5uYksYWUtR/SOC7T+XkFwAEI
         2Mf9+LcY/FPMLDnyEejdI3i4T3eUt9MfDiJy1J/0vTTUuBZA/WP4HGH8rKdLSj9h0//X
         apCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNPG0ij/+1AWVbiQeBpIu3GtnbiFR5UF5CBBkCGvmNc=;
        b=o3HaiFTjuzY95P/JBm+6BF6Wk6VQtYOm78WFrZc80R2Mtj2tDDs501Je9jwRVc6tz+
         H9OPl9GvsfdD94zLEIKp7ZxtAb5pFS9WE4FYN36gELi4Im3zGcKtE/d4MC/Sg33O/O79
         jTyMEZXcAEC+MYWUQc3YMQvrlWo8PvBexNN3MYJCG7QbfiLDA2iJpcpCO8IoLjzcHDat
         nk7FT2UMcR70RKLO3Z/DaHCl6JonuhIkOsRFu14Eq+F0g8ROoTZ4OTdgEwZ7khoKqlUd
         SGkiOTZMbP1OweqiOA/mW9OiTbnmRSMYmQOaj4ziKys8DEduCNB1mp6USQRvZwyfjzsb
         +2OA==
X-Gm-Message-State: AGi0PuY43dBRF0wNniQr/gb/o/ULLVzoLJQabe2KP10rxYStk2OQ8kBg
        8AFEFUeNy1MAwrkp5GI+hNYw2A==
X-Google-Smtp-Source: APiQypIgILlFvDd2BeKU/qvUI7fH/p9ms8qiQQQ9/hVdxa9P4KEVHxJf3Bj0qT+Ydn36O7Lt0SEuhA==
X-Received: by 2002:a63:1c1:: with SMTP id 184mr864110pgb.203.1587588174418;
        Wed, 22 Apr 2020 13:42:54 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j26sm363852pfr.215.2020.04.22.13.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:42:53 -0700 (PDT)
Date:   Wed, 22 Apr 2020 14:42:52 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200422204252.GB4850@syl.local>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
 <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com>
 <20200417174030.GB2103@syl.local>
 <20200417180645.GJ1739940@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417180645.GJ1739940@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 17, 2020 at 02:06:45PM -0400, Jeff King wrote:
> On Fri, Apr 17, 2020 at 11:40:30AM -0600, Taylor Blau wrote:
>
> > > What do you think about something like:
> > >
> > > [promisorFilter "noBlobs"]
> > >         type = blob:none
> > >         uploadpack = true # maybe "allow" could also mean "true" here
> > >         ...
> > > ?
> >
> > I'm not sure about introducing a layer of indirection here with
> > "noBlobs". It's nice that it could perhaps be enabled/disabled for
> > different builtins (e.g., by adding 'revList = false', say), but I'm not
> > convinced that this is improving all of those cases, either.
>
> Yeah, I don't like forcing the user to invent a subsection name. My
> first thought was to suggest:
>
>   [promisorFilter "blob:none"]
>   uploadpack = true
>
> but your tree example shows why that gets awkward: there are more keys
> than just "allow this".
>
> > One thing that I can think of (other than replacing the '.' with another
> > delimiting character other than '=') is renaming the key from
> > 'uploadPack' to 'uploadPackFilter'. I believe that this was suggested by
>
> Yeah, that proposal isn't bad. To me the two viable options seem like:
>
>  - uploadpack.filter.<filter>.*: this has the ugly fake multilevel
>    subsection, but stays under uploadpack.*
>
>  - uploadpackfilter.<filter>.*: more natural subsection, but not grouped
>    syntactically with other uploadpack stuff
>
> I am actually leaning towards the second. It should make the parsing
> code less confusing, and it's not like there aren't already other config
> sections that impact uploadpack.

Me too.

> > > > For reference, the patch I was thinking of was this:
> > > >
> > > >   https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/
> > >
> > > Are you using the patches in this series with or without something
> > > like the above patch? I am ok to resend this patch series including
> > > the above patch (crediting Szeder) if you use something like it.
> >
> > We're not using them, but without them we suffer from a problem that if
> > we can get a SIGPIPE when writing the "sorry, I don't support that
> > filter" message back to the client, then they won't receive it.
> >
> > Szeder's patches help address that issue by catching the SIGPIPE and
> > popping off enough from the client buffer so that we can write the
> > message out before dying.
>
> I definitely think we should pursue that patch, but it really can be
> done orthogonally. It's an existing bug that affects other instances
> where upload-pack returns an error. The tests can work around it with
> "test_must_fail ok=sigpipe" in the meantime.

Yes, I agree. My main hesitation is that it would be uncouth of me to
send a patch that includes 'test_must_fail ok=sigpipe' to the list, but
if you (and others) feel that this is an OK intermediate step (given
that we can easily remove it once SZEDER's patch lands), then I am OK
with it, too.

And I see that Christian already posted such a patch to the list.

> -Peff

Thanks,
Taylor
