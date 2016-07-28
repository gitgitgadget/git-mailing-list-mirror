Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDC61F858
	for <e@80x24.org>; Thu, 28 Jul 2016 13:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245AbcG1Nf3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 09:35:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:50366 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756885AbcG1Nf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 09:35:27 -0400
Received: (qmail 17684 invoked by uid 102); 28 Jul 2016 13:35:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 09:35:26 -0400
Received: (qmail 25429 invoked by uid 107); 28 Jul 2016 13:35:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 09:35:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 09:35:23 -0400
Date:	Thu, 28 Jul 2016 09:35:23 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
Message-ID: <20160728133523.GB21311@sigill.intra.peff.net>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
 <20160727013251.GA12159@sigill.intra.peff.net>
 <5FE50D2C-5D97-4523-9BE2-88745B3F83EA@gmail.com>
 <20160727181148.GC32219@sigill.intra.peff.net>
 <9AB58AFB-7533-4897-8497-187C6D1239C8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9AB58AFB-7533-4897-8497-187C6D1239C8@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 02:10:12PM +0200, Lars Schneider wrote:

> > I think that's orthogonal. I just mean that using zero for success puts
> > you in our usual style, and then accumulating errors can be done with
> > "|=".
> 
> Ah. I guess I was misguided by the way errors are currently handled
> in `apply_filter` (success = 1; failure = 0):
> https://github.com/git/git/blob/8c6d1f9807c67532e7fb545a944b064faff0f70b/convert.c#L437-L479
> 
> I wouldn't like if the different filter protocols would use different
> error exit codes. Would it be OK to adjust the existing `apply_filter`
> function in a cleanup patch?

Ah, I see.

I think those return codes are a little different. They are not "success
or error", but "did convert or did not convert" (or "would convert" when
no buffer is given). And unless the filter is required, we quietly turn
errors into "did not convert" (and if it is, we die()).

So I'm not sure if changing them is a good idea. I agree with you that
it's probably inviting confusion to have the two sets of filter
functions have opposite return codes. So I think I retract my
suggestion. :)

-Peff
