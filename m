Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C3FC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6953922B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XxuNdLrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHDUIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgHDUIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 16:08:52 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E7EC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 13:08:52 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s23so31948256qtq.12
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AenAg/Yh+UllzGWK/YQ0xfhYvNRQ0HWSHlUUAtO3vjA=;
        b=XxuNdLrP3SUj4zwM2bMSOc99P26aGWruyGG7RabMlheXbDjLN+jUhrG0q6rldvjwZ5
         riYX2j1I1pDKXQ9shvzgtTLAkp2Ddbfr7WrmlWZz3vcrU0c6mVpjZU669/wXxiRYwbIQ
         3E1Z1Xrz9Jj8lnhhLHz7y+sodLwkyA7CGKlNybbpfiSVtzeCtMGcEc+OjiPy5dEFGGPh
         JorfSzTwnt2KxbFdOIFQVCp8ZgFVX/pA5hRSV3VcAX/LUxKKDZZ4yotvLPCxBt54K6LZ
         aeyAYDelJem9PpSQirEqFdsaxGdhACFR/PRV09lD73odfyUkO12tDhblToTcHJJfWfKB
         xeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AenAg/Yh+UllzGWK/YQ0xfhYvNRQ0HWSHlUUAtO3vjA=;
        b=oqvYo4Rj2CnAoAcYiiQ8escMB7jiVlfqK4MDrYtZj3Q3vY9ryRrHPeCvQoiJC+6x2D
         FoVTirWMjTVBcn4nqEl1vRC0Q7gd7u1sIwe3Bfu6EJ615A/sEEl8IMzQn1vjzld7xi5O
         d36k6YNToOFgT25aIEk6r20Xdcr/ClVUCbcDO2jiccJ7YMtID3tP221eWFSpNBYsTDYY
         RSVkjnTKOsQXua560xhjTXGR3ChIJcjCogA0PMmYLqYRCsGKqd4ZlQ/eZcJD7mLtD4TD
         pfP5nMDBg0Dc9vZOkTFREGdldHag+zABwmhWUBQjLAS0VrEIFrxLWZHdjHUZVhbE3Hcq
         gNfQ==
X-Gm-Message-State: AOAM5328iKxIVbJB0SGYyfmJArAVwsYFJCw3KIw40is9EksRMMp0FO/t
        DGFEiXrNMwtTkiAzzliLLVXk9Q==
X-Google-Smtp-Source: ABdhPJyeeTxx6DymmUssDqGkHRRvlPd3d0gY9IVbOHIwSVVdPKtM4b/n91U/W7VjXAh9rPtqlMhO5g==
X-Received: by 2002:ac8:5241:: with SMTP id y1mr23494862qtn.102.1596571731750;
        Tue, 04 Aug 2020 13:08:51 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4176:744b:cf1a:a7e1])
        by smtp.gmail.com with ESMTPSA id b131sm22530185qkc.121.2020.08.04.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:08:50 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:08:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 01/10] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <20200804200849.GB89277@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <08479793c1274d5ee0f063578bb0f4d93c910fa9.1596480582.git.me@ttaylorr.com>
 <20200804072417.GA183951@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804072417.GA183951@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 03:24:17AM -0400, Jeff King wrote:
> On Mon, Aug 03, 2020 at 02:57:09PM -0400, Taylor Blau wrote:
>
> > diff --git a/revision.c b/revision.c
> > index 6de29cdf7a..e244beed05 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -684,7 +684,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
> >  	if (!revs->repo->objects->commit_graph)
> >  		return;
> >
> > -	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
> > +	revs->bloom_filter_settings = get_bloom_filter_settings(revs->repo);
> >  	if (!revs->bloom_filter_settings)
> >  		return;
>
> I think you could get rid of the revs->repo->objects->commit_graph check
> above now, as get_bloom_filter_settings() would return NULL if there is
> no commit_graph at all.

Yep, that's right -- and good catch. This used to not be the case (or if
it was, relying on it was more fragile) when
'get_bloom_filter_settings()' took a commit-graph instead of a
repository, but now it's no longer necessary.

Thanks.

> -Peff

Taylor
