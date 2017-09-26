Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F920202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 00:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966719AbdIZAJR (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:09:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:50004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966079AbdIZAJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:09:15 -0400
Received: (qmail 13296 invoked by uid 109); 26 Sep 2017 00:09:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Sep 2017 00:09:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30989 invoked by uid 111); 26 Sep 2017 00:09:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:09:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 20:09:13 -0400
Date:   Mon, 25 Sep 2017 20:09:13 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 05:06:58PM -0700, Stefan Beller wrote:

> >> If you are okay with the too-long/too-short confusion in EOVERFLOW, then
> >> there is EMSGSIZE:
> >>
> >>       Message too long
> >
> > I don't really like that one either.
> >
> > I actually prefer "0" of the all of the options discussed. At least it
> > is immediately clear that it is not a syscall error.
> >
> > -Peff
> 
> After reading this discussion from the sideline, maybe
> 
>   ENODATA         No message is available on the STREAM head read
> queue (POSIX.1)
> 
> is not too bad after all. Or
> 
>   ESPIPE          Invalid seek (POSIX.1)
> 
> Technically we do not seek, but one could imagine we'd seek there
> to read?

ENODATA is not too bad. On my glibc system it yields "No data available"
from strerror(), which is at least comprehensible.

We're still left with the question of whether it is defined everywhere
(and what to fallback to when it isn't).

-Peff
