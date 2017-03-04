Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951F52013E
	for <e@80x24.org>; Sat,  4 Mar 2017 08:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdCDIpv (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 03:45:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:38584 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750721AbdCDIpv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 03:45:51 -0500
Received: (qmail 26507 invoked by uid 109); 4 Mar 2017 08:45:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 08:45:49 +0000
Received: (qmail 4899 invoked by uid 111); 4 Mar 2017 08:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 03:45:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Mar 2017 03:45:47 -0500
Date:   Sat, 4 Mar 2017 03:45:47 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jann Horn <jannh@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v2] http: inform about alternates-as-redirects behavior
Message-ID: <20170304084547.4mg4beudseznaw72@sigill.intra.peff.net>
References: <20170304013504.GA27183@untitled>
 <20170304031314.32bta4prahf7pfp7@sigill.intra.peff.net>
 <20170304065548.GA20734@whir>
 <20170304074140.mzgs27jp2jer4mlv@sigill.intra.peff.net>
 <20170304083645.GA24694@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304083645.GA24694@whir>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2017 at 08:36:45AM +0000, Eric Wong wrote:

> I also think the security implications for relative alternates
> on the same host would not matter, since the smart HTTP will
> take them into account on the server side.

It depends on the host whether all of the repos on it have the same
security domain or not. A site like github.com hosts both public and
private repositories, and you do not want a public repo redirecting to
the private one to get objects.

Of course, that depends on untrusted users being able to configure
server-side alternates, which GitHub certainly would not let you do. I
would hope other multi-user hosting sites behave similarly (most hosting
sites do not seem to allow dumb http at all).

> Perhaps we give http_follow_config ORable flags:
> 
> 	HTTP_FOLLOW_NONE = 0,
> 	HTTP_FOLLOW_INITIAL = 0x1,
> 	HTTP_FOLLOW_RELATIVE = 0x2,
> 	HTTP_FOLLOW_ABSOLUTE = 0x4,
> 	HTTP_FOLLOW_ALWAYS = 0x7,
> 
> With the default would being: HTTP_FOLLOW_INITIAL|HTTP_FOLLOW_RELATIVE
> (but I suppose that's a patch for another time)

I don't have a real problem with breaking it down that way, if somebody
wants to make a patch. Mostly the reason I didn't do so is that I don't
think http-alternates are in common use these days, since smart-http is
much more powerful.

> ----------8<-----------
> From: Eric Wong <e@80x24.org>
> Subject: [PATCH] http: inform about alternates-as-redirects behavior

This v2 looks fine to me.

-Peff
