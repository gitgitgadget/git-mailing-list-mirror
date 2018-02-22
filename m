Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F5F1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeBVUVy (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:21:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:33252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751334AbeBVUVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:21:53 -0500
Received: (qmail 30530 invoked by uid 109); 22 Feb 2018 20:21:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 20:21:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7454 invoked by uid 111); 22 Feb 2018 20:22:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 15:22:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 15:21:51 -0500
Date:   Thu, 22 Feb 2018 15:21:51 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222202150.GA23985@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222201940.GB23561@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 03:19:40PM -0500, Jeff King wrote:

> > To be clear, which of the following are you (most) worried about?
> > 
> >  1. being invoked with --help and spawning a pager
> >  2. receiving and acting on options between 'git' and 'upload-pack'
> >  3. repository discovery
> >  4. pager config
> >  5. alias discovery
> >  6. increased code surface / unknown threats
> 
> My immediate concern is (4). But my greater concern is that people who
> work on git.c should not have to worry about accidentally violating this
> principle when they add a new feature or config option.
> 
> In other words, it seems like an accident waiting to happen. I'd be more
> amenable to it if there was some compelling reason for it to be a
> builtin, but I don't see one listed in the commit message. I see only
> "let's make it easier to share the code", which AFAICT is equally served
> by just lib-ifying the code and calling it from the standalone
> upload-pack.c.

By the way, any decision here would presumably need to be extended to
git-serve, etc. The current property is that it's safe to fetch from an
untrusted repository, even over ssh. If we're keeping that for protocol
v1, we'd want it to apply to protocol v2, as well.

-Peff
