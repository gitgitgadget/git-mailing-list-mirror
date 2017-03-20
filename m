Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80BA620958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbdCTSNv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:13:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:47880 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932462AbdCTSNN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:13:13 -0400
Received: (qmail 13667 invoked by uid 109); 20 Mar 2017 18:12:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:12:49 +0000
Received: (qmail 4136 invoked by uid 111); 20 Mar 2017 18:13:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:13:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:12:45 -0400
Date:   Mon, 20 Mar 2017 14:12:45 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 00/20] Separate `ref_cache` into a separate module
Message-ID: <20170320181244.h5ce4rbadkharnki@sigill.intra.peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 05:33:05PM +0100, Michael Haggerty wrote:

> I've completed a draft of an epic 48-patch series implementing all of
> the above points on my GitHub fork [1] as branch
> `wip/mmap-packed-refs`. It dramatically speeds up performance and
> reduces memory usage for some tasks in repositories with very many
> packed references.

Having played a bit with the work-in-progress, I'm very excited about
the performance improvements.

> But the later parts of that series aren't completely polished yet, and
> such a large patch series would be indigestible anyway, so here I
> submit the first part...
> 
> This patch series extracts a `ref_cache` module out of
> `files_ref_cache`, and goes some way to disentangling those two
> modules, which until now were overly intimate with each other:
> [...]

I just read through it and didn't see anything objectionable. I had a
few questions, but I expect that most can be answered with an
explanation rather than a re-roll.

> Even after this patch series, the modules are still too intimate for
> my taste, but I think this is a big step forward, and it is enough to
> allow the other changes that I've been working on.

The resulting code looks like a big improvement in modularity to me. My
one complaint is that the virtual functions make it hard to dig through
the code. E.g., when looking at one patch I saw that we called
ref_iterator_peel(), and I wanted to know what that entailed. My editor
helpfully jumps straight to the definition, but of course it has nothing
useful; it's just a vtable wrapper. And I had to go dig up the name
"files_peel_ref()" manually.

I guess that's the price we pay for modularity.

-Peff
