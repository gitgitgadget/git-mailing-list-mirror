Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6BE206A7
	for <e@80x24.org>; Wed, 24 Aug 2016 19:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756067AbcHXTMn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 15:12:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:60696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754513AbcHXTMm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 15:12:42 -0400
Received: (qmail 19252 invoked by uid 109); 24 Aug 2016 19:12:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 19:12:41 +0000
Received: (qmail 6179 invoked by uid 111); 24 Aug 2016 19:12:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 15:12:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 15:12:38 -0400
Date:   Wed, 24 Aug 2016 15:12:38 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160824191238.taeodwd2hz7q55gv@sigill.intra.peff.net>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <20160824184938.GB8578@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160824184938.GB8578@whir>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 06:49:38PM +0000, Eric Wong wrote:

> > > Given that public-inbox provides an NNTP interface, couldn't the ARTICLE
> > > <message-id> NNTP command be used to easily retrieve the messages in a
> > > given patch series (at least compared to POP or IMAP).  Perhaps
> > > git-send-email could be modified to include the message-id value of each
> > > patch in the series that it sends to the mailing list and include it in
> > > the cover letter.
> 
> I think that makes sense; perhaps an X-Git-Followups: header
> from send-email which lists the child Message-IDs the same way
> References: does for ancestors.  (perhaps there's already a
> standardized header for listing children)

I think that's harder to adapt to some workflows, since it implies
generating all of the message-ids ahead of time (whereas if you are
feeding the messages into an existing MUA, it may generate them on the
fly as it sends).

> I thought about allowing a giant MIME message with all the
> patches attached, too but that won't work for a large patch
> series due to size limits along various SMTP hops.
> Compression might make spam filters unhappy, too.

This was a problem faced by binary groups on Usenet, which had to split
large files across many messages.

It has been a long time since I've dealt with those, but I think the
state of the art involved using "1/20", "2/20", etc in the subjects to
piece together the original. There may also have been header or body
content that included a unique id, so you always knew which messages
were part of a set.

They also used things like forward error correction to handle dropped
messages, but I don't think we need to go that far.

So parsing the "PATCH 1/20" headers sounds hacky, but I think it has
worked for years in other communities.

-Peff
