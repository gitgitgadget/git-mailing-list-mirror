Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A4F207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 05:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980486AbdDYF6X (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 01:58:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:39567 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759974AbdDYF6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 01:58:22 -0400
Received: (qmail 26122 invoked by uid 109); 25 Apr 2017 05:58:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 05:58:19 +0000
Received: (qmail 2055 invoked by uid 111); 25 Apr 2017 05:58:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 01:58:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Apr 2017 01:58:17 -0400
Date:   Tue, 25 Apr 2017 01:58:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Miguel Torroja <miguel.torroja@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] fast-export: deletion action first
Message-ID: <20170425055817.codq2q3fd54uebfx@sigill.intra.peff.net>
References: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
 <20170425032927.74btvfcexbdq4rmz@sigill.intra.peff.net>
 <xmqqfugxw1us.fsf@gitster.mtv.corp.google.com>
 <20170425044641.sx5uoql4oiug6iq7@sigill.intra.peff.net>
 <xmqqy3upuk4o.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3upuk4o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 10:33:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Anyway. I don't think Miguel's patch needs to solve all of the lingering
> > rename cases. But I am curious whether it makes some rename cases worse,
> > because the depth-sorting was kicking in before and making them work.
> 
> I agree with you on both counts, and I care more about the second
> sentence, not just "am curious", but "am worried".  I am not sure
> that this patch is safe---it looked more like robbing peter to pay
> paul or the other way around.  Fixing for one class of breakage
> without regressing is one thing and it is perfectly fine to leave
> some already broken case broken with such a fix.  Claiming to fix
> one class and breaking other class that was happily working is quite
> different, and that is where my "Wait, we also allow renames?" comes
> from.

Yeah, I don't disagree. I am just curious first, then worried second. :)

If I had to choose, though, I'd rather see the order be reliable for the
no-renames case. IOW, if we must rob one peter, I'd rather it be the
renames, which already have tons of corner cases (and which I do not
think can be plugged for a reader which depends on the order of the
entries; the dependencies can be cycles).

Of course if we can make it work correctly in all of the non-cyclical
cases, all the better.

-Peff
