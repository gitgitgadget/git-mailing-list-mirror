Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4A9C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ABE2073D
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgAGOET (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:04:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:59070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727658AbgAGOET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:04:19 -0500
Received: (qmail 12526 invoked by uid 109); 7 Jan 2020 14:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 14:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31029 invoked by uid 111); 7 Jan 2020 14:09:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 09:09:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 09:04:17 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Bradley Smith <brad@brad-smith.co.uk>,
        Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>, git@vger.kernel.org
Subject: Re: Assertion in git log graphing [regression in v2.25]
Message-ID: <20200107140417.GA12242@coredump.intra.peff.net>
References: <CAHt=fUXTHc4JPsapvHKnw5vHhp2cBOYRNfdaSDWBUnKt8fWfeA@mail.gmail.com>
 <20200107114812.GE1073219@coredump.intra.peff.net>
 <5f956281-e861-f274-be43-95d99a625abb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f956281-e861-f274-be43-95d99a625abb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 08:25:59AM -0500, Derrick Stolee wrote:

> On 1/7/2020 6:48 AM, Jeff King wrote:
> > The assertion itself is quite old, so I wondered if it was even still
> > relevant. Removing it does produce a reasonable-looking graph:
> 
> As I'm digging into this case, and finding when the assertion is hit,
> I see that the issue is in the line further below your coloring issue:

Oh, you're right. I totally missed that.

So perhaps we have two bugs, or perhaps they have the same root cause.

> >   | | | | * dd068b4 Merge commit '8f076d8' into HEAD
> >   | |_|_|/| 
> >   |/| | |/  
> >   | | |/|   
> >   | |/| |   
> >   | * | | 8f076d8 5
> 
> What is output is actually this, above. But the logic that includes the
> assert is checking where the underscores end, and the shown underscores
> actually pass the check. The issue is that it seems like it really wants
> to show this:
> 
> >   | | | | * dd068b4 Merge commit '8f076d8' into HEAD
> >   | |_|_|/| 
> >   |/| |_|/  
> >   | |/| |   
> >   | * | | 8f076d8 5
> 
> Note that I dropped a line and compressed a slash into an underscore. It's
> on that line that this condition is being hit.

Hrm. I could see either being acceptable, but I do think the second one
is a bit easier to read. I'm not sure which was intended for this case.

-Peff
