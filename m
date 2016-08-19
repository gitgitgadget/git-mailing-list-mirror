Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E54A1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 13:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbcHSNWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 09:22:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58076 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754820AbcHSNWR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 09:22:17 -0400
Received: (qmail 29322 invoked by uid 109); 19 Aug 2016 13:22:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 13:22:16 +0000
Received: (qmail 25161 invoked by uid 111); 19 Aug 2016 13:22:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 09:22:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 09:22:14 -0400
Date:   Fri, 19 Aug 2016 09:22:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
Message-ID: <20160819132213.njhymlc5diigonlj@sigill.intra.peff.net>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
 <20160818220530.2dcsag4qeitia4ao@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608191500470.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608191500470.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 03:09:19PM +0200, Johannes Schindelin wrote:

> > The object name can have spaces in it, too. E.g.:
> > 
> >   HEAD:path with spaces
> > 
> > or even:
> > 
> >   :/grep for this
> > 
> > (as was pointed out to me when I tried to turn on %(rest) handling by
> > default, long ago). How do those work with your patch?
> 
> They don't ;-)
> 
> And quite frankly, the documentation should make it clear to users that
> batch mode with --filters or --textconv won't work when the object name
> contains white space: it says that the object name is split from the path
> at the first white space character.

I think that is an obvious implication of the new documentation. I was
just concerned with a regression from the previous behavior.

> > It looks like the extra split isn't enabled unless one of those options
> > is selected. Since --filters is new, that's OK for backwards
> > compatibility. But --textconv isn't.
> 
> Except that it is okay, because --textconv *was not even supported in
> batch mode*. So there is no backwards compatibility that could be broken.

Ah, OK. I thought we handled "HEAD:path with spaces" there, but I see
that you cannot even specify "--textconv" with "--batch", because it
complains of the cmdmode.

So the new rule becomes "we split if we see %(rest), or --textconv, or
--filter", which is reasonable.

> Fixing %(rest) for object names containing spaces is distinctly outside
> the original intent, and certainly outside of my use case.

Yeah, I agree it is not necessary for this series (I was only
considering it as an option to fix the regression I now see doesn't
exist).

-Peff
