Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E931FCC7
	for <e@80x24.org>; Fri, 10 Feb 2017 00:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbdBJAkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 19:40:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:52691 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751983AbdBJAkg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 19:40:36 -0500
Received: (qmail 15974 invoked by uid 109); 10 Feb 2017 00:40:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 00:40:36 +0000
Received: (qmail 21333 invoked by uid 111); 10 Feb 2017 00:40:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 19:40:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Feb 2017 19:40:33 -0500
Date:   Thu, 9 Feb 2017 19:40:33 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] Store submodules in a hash, not a linked list
Message-ID: <20170210004033.cgqmovhvoylad5cf@sigill.intra.peff.net>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <20170209195812.dbbmko4sas3wtdy5@sigill.intra.peff.net>
 <9ba16176-b388-4c70-a479-fda4c9244e67@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ba16176-b388-4c70-a479-fda4c9244e67@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 10:23:35PM +0100, Michael Haggerty wrote:

> >> So push the submodule attribute down to the `files_ref_store` class
> >> (but continue to let the `ref_store`s be looked up by submodule).
> > 
> > I'm not sure I understand all of the ramifications here. It _sounds_ like
> > pushing this down into the files-backend code would make it harder to
> > have mixed ref-backends for different submodules. Or is this just
> > pushing down an implementation detail of the files backend, and future
> > code is free to have as many different ref_stores as it likes?
> 
> I don't understand how this would make it harder, aside from the fact
> that a new backend class might also need a path member and have to
> maintain its own copy rather than using one that the base class provides.

Probably the answer is "I'm really confused".

But here's how my line of reasoning went:

  Right now we have a main ref-store that points to the submodule
  ref-stores. I don't know the current state of it, but in theory those
  could all use different backends.

  This seems like it's pushing that submodule linkage down into the
  backend.

But I think from your response that the answer is no, the thing that is
being pushed down is not the right way for the main ref store and the
submodules to be linked. In fact, there is no reason at all for the
main ref store to know or care about submodules. Anybody who wants to
know about a submodule's refs should ask the hashmap.

-Peff
