Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384161FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 12:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbcHNM0O (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 08:26:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:55017 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753246AbcHNM0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 08:26:14 -0400
Received: (qmail 28483 invoked by uid 109); 14 Aug 2016 12:26:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 12:26:13 +0000
Received: (qmail 8113 invoked by uid 111); 14 Aug 2016 12:26:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 08:26:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Aug 2016 08:26:11 -0400
Date:	Sun, 14 Aug 2016 08:26:11 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/8] xdl_change_compact(): rename some local variables
 for clarity
Message-ID: <20160814122610.mlg7qnptyngpdggy@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ea7d76b1a97f3ab8d83ed8ba7570c2bec1195501.1470259583.git.mhagger@alum.mit.edu>
 <20160804070604.ggxjqibryqtrwntn@sigill.intra.peff.net>
 <2a36b020-76a5-1ecd-de5c-1d2536847e07@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a36b020-76a5-1ecd-de5c-1d2536847e07@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 09:38:33PM +0200, Michael Haggerty wrote:

> On 08/04/2016 09:06 AM, Jeff King wrote:
> > On Thu, Aug 04, 2016 at 12:00:29AM +0200, Michael Haggerty wrote:
> > 
> >> * ix -> i
> >> * ixo -> io
> >> * ixs -> start
> >> * grpsiz -> groupsize
> > 
> > After your change, I immediately understand three of them. But what is
> > "io"?
> 
> The (pre-existing) convention in this function is that variable names
> dealing with the "other" file have a trailing "o"; e.g., (xdf, xdfo),
> (rchg, rchgo). There used to also be (i, io), the indexes tracking the
> current line number in the file and the other file. But I renamed "i".

Yeah, after reading the rest of the patches, the "o" prefix sort of
started to make sense.

> At first I was just going to add a comment for variable "io", but in
> trying to figure out its exact semantics I realized that this code is
> still pretty hard to follow. Part of the problem is that "the line in
> the other file corresponding to a line in the to-be-compacted file" is
> not a well-defined concept. In fact it is *groups of lines* that
> correlate with each other. So I totally refactored the function, using a
> 
>     struct group {
>             long start, end;
>     };
> 
> as a kind of a cursor used to iterate through the groups on both sides.
> I think the result is a lot easier to read, and while refactoring I
> found and fixed another bug in the pre-existing code :-O

That sounds like it would be nicer. And bug fixes are always good.

Don't kill yourself polishing up the function names, though (unless you
keep finding bugs. ;) ).

-Peff
