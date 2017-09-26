Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4C420A26
	for <e@80x24.org>; Tue, 26 Sep 2017 00:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966872AbdIZAUA (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:20:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:50050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965490AbdIZAT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:19:59 -0400
Received: (qmail 13919 invoked by uid 109); 26 Sep 2017 00:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Sep 2017 00:19:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31276 invoked by uid 111); 26 Sep 2017 00:20:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:20:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 20:19:57 -0400
Date:   Mon, 25 Sep 2017 20:19:57 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926001956.hgtdeklogvkirdxa@sigill.intra.peff.net>
References: <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
 <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
 <20170926001602.GO27425@aiede.mtv.corp.google.com>
 <20170926001732.GP27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926001732.GP27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 05:17:32PM -0700, Jonathan Nieder wrote:

> Jonathan Nieder wrote:
> > On Mon, Sep 25, 2017 at 08:09:13PM -0400, Jeff King wrote:
> 
> >> ENODATA is not too bad. On my glibc system it yields "No data available"
> >> from strerror(), which is at least comprehensible.
> >>
> >> We're still left with the question of whether it is defined everywhere
> >> (and what to fallback to when it isn't).
> >
> > So,
> >
> > #ifndef EUNDERFLOW
> > #ifdef ENODATA
> > #define ENODATA EUNDERFLOW
> > #else
> > #define ENODATA ESPIPE
> > #endif
> > #endif
> >
> > ?
> 
> Uh, pretend I said
> 
> #ifndef EUNDERFLOW
> # ifdef ENODATA
> #  define EUNDERFLOW ENODATA
> # else
> #  define EUNDERFLOW ESPIPE
> # endif
> #endif

Right, I think our mails just crossed but I'm leaning in this direction.
I'd prefer to call it SHORT_READ_ERRNO or something, though. Your
"#ifndef EUNDERFLOW" had me thinking that this was something that a real
platform might have, but AFAICT you just made it up.

-Peff
