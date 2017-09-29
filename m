Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D49A20281
	for <e@80x24.org>; Fri, 29 Sep 2017 23:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbdI2XYQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 19:24:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:55026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752523AbdI2XYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 19:24:15 -0400
Received: (qmail 11200 invoked by uid 109); 29 Sep 2017 23:24:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 23:24:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9253 invoked by uid 111); 29 Sep 2017 23:24:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 19:24:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Sep 2017 19:24:13 -0400
Date:   Fri, 29 Sep 2017 19:24:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] oidmap: map with OID as key
Message-ID: <20170929232412.mmimg7srkjsypg2y@sigill.intra.peff.net>
References: <20170927221910.164552-1-jonathantanmy@google.com>
 <20170928004137.GD68699@google.com>
 <20170928104616.be61b394b50dc5193be275be@google.com>
 <20170928200556.grysihlj7cbzocfq@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1709292341280.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709292341280.40514@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:43:57PM +0200, Johannes Schindelin wrote:

> On Thu, 28 Sep 2017, Jeff King wrote:
> 
> > If you're planning on using an oidset to mark every object in a
> > 100-million-object monorepo, we'd probably care more. But I'd venture to
> > say that any scheme which involves generating that hash table on the fly
> > is doing it wrong. At at that scale we'd want to look at compact
> > mmap-able on-disk representations.
> 
> Or maybe you would look at a *not-so-compact* mmap()able on-disk
> representation, to allow for painless updates.
> 
> You really will want to avoid having to write out large files just because
> a small part of them changed. We learn that lesson the hard way, from
> having to write 350MB worth of .git/index for every single, painful `git
> add` operation.

Sure. I didn't mean to start designing the format. I just mean that if
the first step of the process is "read information about all 100 million
objects into an in-RAM hashmap", then that is definitely not going to
fly.

-Peff
