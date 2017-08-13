Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36BB208B8
	for <e@80x24.org>; Sun, 13 Aug 2017 04:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbdHMEjn (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 00:39:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:37272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750772AbdHMEjn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 00:39:43 -0400
Received: (qmail 11277 invoked by uid 109); 13 Aug 2017 04:39:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 04:39:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28384 invoked by uid 111); 13 Aug 2017 04:40:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Aug 2017 00:40:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Aug 2017 00:39:40 -0400
Date:   Sun, 13 Aug 2017 00:39:40 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while
 generating patches
Message-ID: <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170810183256.12668-2-kewillf@microsoft.com>
 <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
 <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
 <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 12, 2017 at 09:06:18AM +0100, Philip Oakley wrote:

> > > > + progress = start_progress_delay(_("Generating patches"), total, 0, 1);
> > > 
> > > I don't really have an opinion on a 1 second delay versus 2. I thought
> > > we used 2 pretty consistently, though grepping around I do see a couple
> > > of 1's. It probably doesn't matter, but just a curiosity.
> > 
> > Yeah, I also thought 2-second was what we used by default.  Perhaps
> > we would want to bring others in line?
> 
> <bikeshed> Surely the choice should depend on the purpose of the delay. IIRC
> the 1 second between patches on the formal 'sent' time was simply to ensure
> the patches had the right sequence. Delays for warnings and progress have
> different purposes, so I think it's more about the purpose than
> standardising the time (along with expectations [least surprise] if other
> messages are displayed).

I think you're confusing two unrelated things. There's a 1-second fake
time-advance on patches, but that's done by send-email, not
format-patch.

Here we're just talking about calls to start_progress_delay(), and how
long it waits before deciding that the operation is slow enough to show
progress. Blame, rename detection, and checkout use 1 second. Prune,
prune-packed, and connectivity checks all use 2 seconds. I doubt it
matters all that much, but presumably the purpose in all is "how long
before a user starts to wonder if things are actually happening", which
is probably command-independent.

-Peff
