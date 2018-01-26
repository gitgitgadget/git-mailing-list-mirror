Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237F91F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeAZSwy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:52:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:59120 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752228AbeAZSwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:52:54 -0500
Received: (qmail 16505 invoked by uid 109); 26 Jan 2018 18:52:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:52:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17590 invoked by uid 111); 26 Jan 2018 18:53:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:53:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:52:52 -0500
Date:   Fri, 26 Jan 2018 13:52:52 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/6] daemon: fix length computation in newline stripping
Message-ID: <20180126185251.GI27618@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
 <20180125005854.GF26850@sigill.intra.peff.net>
 <CAPig+cTR39UAbMmKnoi4fhU6EjQp=VGcd0J6=_rS3iD+aixJOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTR39UAbMmKnoi4fhU6EjQp=VGcd0J6=_rS3iD+aixJOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 04:38:20PM -0500, Eric Sunshine wrote:

> On Wed, Jan 24, 2018 at 7:58 PM, Jeff King <peff@peff.net> wrote:
> > When git-daemon gets a pktline request, we strip off any
> > trailing newline, replacing it with a NUL. Clients prior to
> > 5ad312bede (in git v1.4.0) would send: [...]
> >
> > Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> > @@ -196,5 +196,20 @@ test_expect_success 'daemon log records all attributes' '
> > +test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
> > +       {
> > +               printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
> 
> Do we care about the &&-chain here? (We'd notice if something went
> wrong in 'packetize' even without &&-chain since 'input' would likely
> end up with incorrect content, but still...)

Hmm, yeah. It almost certainly wouldn't matter, but I think it's a good
idea to keep up our &&-chains as a pro forma thing.

-Peff
