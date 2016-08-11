Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3EEF2018E
	for <e@80x24.org>; Thu, 11 Aug 2016 04:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcHKEQJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 00:16:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:53373 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738AbcHKEQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 00:16:07 -0400
Received: (qmail 15298 invoked by uid 109); 11 Aug 2016 04:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 04:16:06 +0000
Received: (qmail 6175 invoked by uid 111); 11 Aug 2016 04:16:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 00:16:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 00:16:03 -0400
Date:	Thu, 11 Aug 2016 00:16:03 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] xdl_change_compact(): fix compaction heuristic to
 adjust io
Message-ID: <20160811041603.xtkagaluyntawwue@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
 <20160804072705.a53mospcccksiz4e@sigill.intra.peff.net>
 <7dea0a1e-a1b4-efe4-c86d-152f6c96604a@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dea0a1e-a1b4-efe4-c86d-152f6c96604a@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 06:58:06PM +0200, Michael Haggerty wrote:

> > And it looks like rchgo[io] always ends the loop on a 0. So it seems
> > like we would just hit that condition again.
> 
> Correct...in this loop. But there is another place where `io` is
> incremented unconditionally. In the version before my changes, it is via
> the preincrement operator in this while statement conditional:
> 
> https://github.com/mhagger/git/blob/a28705da929ad746abcb34270947f738549d3246/xdiff/xdiffi.c#L502
> 
> After my changes, the unconditional increment is more obvious because I
> took it out of the while condition:
> 
> https://github.com/mhagger/git/blob/39a135da93834fd72ee923d95d0cebfe525dfe7a/xdiff/xdiffi.c#L541
> 
> (BTW, I think this is a good example of how patch 2/8 makes the code
> easier to reason about.)

Ah, yeah, I totally missed that case (and I agree the code after your
2/8 makes it much more obvious).

> I didn't do the hard work to determine whether `io` could *really* walk
> off the end of the array, but I don't see an obvious reason why it
> *couldn't*.

Yeah, I'm in agreement.

-Peff
