Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710B81F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeCLXqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:46:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:54746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751333AbeCLXqx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:46:53 -0400
Received: (qmail 13956 invoked by uid 109); 12 Mar 2018 23:46:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Mar 2018 23:46:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19124 invoked by uid 111); 12 Mar 2018 23:47:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Mar 2018 19:47:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2018 19:46:51 -0400
Date:   Mon, 12 Mar 2018 19:46:51 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180312234651.GA2137@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180222093327.GA12442@sigill.intra.peff.net>
 <20180223214557.GF234838@google.com>
 <20180303043338.GC27689@sigill.intra.peff.net>
 <20180305184321.GC72475@google.com>
 <20180305205254.GC5953@sigill.intra.peff.net>
 <20180305213649.GF28067@aiede.svl.corp.google.com>
 <20180306062901.GA3522@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306062901.GA3522@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 06, 2018 at 07:29:02AM +0100, Jeff King wrote:

> > We want to do better (e.g. see [1]) but that's a bigger change than
> > the initial protocol v2.
> > 
> > As Brandon explained it to me, we really do want to use stateless-rpc
> > semantics by default, since that's just better for maintainability.
> > Instead of having two protocols, one that is sane and one that
> > struggles to hoist that into stateless-rpc, there would be one
> > stateless baseline plus capabilities to make use of state.
> 
> Yes, I think that would be a nice end-game. It just wasn't clear to me
> where we'd be in the interim.

After some more thinking about this, and a little chatting with Brandon
at the contrib summit, I'm willing to soften my position on this.

Basically I was concerned about this as a regression where git-over-ssh
would stop working in a few corner cases. And it would cease to be
available as an escape hatch for those cases where http wouldn't work.

But we may be OK in this "interim" period (before unified
stateful-negotiation bits are added back) because v2 would not yet be
the default. So the ssh cases can't regress without flipping the v2
switch manually, and any escape hatch would continue to work by flipping
back to v1 anyway.

So it's probably OK to continue experimenting in this direction and see
how often it's a problem in practice.

-Peff
