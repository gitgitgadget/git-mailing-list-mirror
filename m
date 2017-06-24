Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E0020401
	for <e@80x24.org>; Sat, 24 Jun 2017 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755135AbdFXUgn (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 16:36:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:52090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754937AbdFXUgn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 16:36:43 -0400
Received: (qmail 25979 invoked by uid 109); 24 Jun 2017 20:36:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 20:36:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25247 invoked by uid 111); 24 Jun 2017 20:36:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 16:36:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 16:36:40 -0400
Date:   Sat, 24 Jun 2017 16:36:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        tboegi@web.de, e@80x24.org, ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 5/5] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170624203640.qomgbsakrgseungl@sigill.intra.peff.net>
References: <20170601082203.50397-1-larsxschneider@gmail.com>
 <20170601082203.50397-6-larsxschneider@gmail.com>
 <20170624141941.usy2pyhid3jrf3ku@sigill.intra.peff.net>
 <A8FAEFDC-1ADA-4355-80DC-069A739F829C@gmail.com>
 <xmqq37ap9q2i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37ap9q2i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 11:51:49AM -0700, Junio C Hamano wrote:

> >>  if ((CAP_DELAY & entry->supported_capabilities) &&
> >>      dco && dco->state == CE_CAN_DELAY))
> >
> > Agreed!
> 
> Why wasn't this caught earlier?  I thought this is something gcc warns about.

I thought so, too. If it warned about:

  if (A & B)

that would probably be too annoying. But:

  if (A & B && C)

is much more questionable. I wonder if it used to exist and gcc dropped
it (or dropped it from -Wall). -Wlogical-op seems like the most likely
candidate, but it does not catch it (and it has a false positive in
handle_nonblock, or perhaps I just can't see the problem).

> >> The operator precedence is such that it works without them, so this is
> >> just a style question (I'd also usually put the flags field before the
> >> flag itself, but that's really getting into aesthetics).
> >
> > You mean (entry & CAP_DELAY) instead of (CAP_DELAY & entry)?
> 
> Peff is continuing his explanation why (A & B && C) is technically
> correct and preferring ((A & B) && C) is purely stylistic.  "A & B"
> binds tighter than "something && C" which means that (A & B && C)
> cannot be misinterpreted as (A & (B && C)).

I actually meant both. The bitwise operator binds tighter so it's OK
either way. But I would write "flags & MY_FLAG" and never "MY_FLAG &
flags".

-Peff
