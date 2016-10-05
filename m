Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472F520986
	for <e@80x24.org>; Wed,  5 Oct 2016 03:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbcJEDyv (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 23:54:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:52584 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbcJEDyv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 23:54:51 -0400
Received: (qmail 14639 invoked by uid 109); 5 Oct 2016 03:54:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 03:54:50 +0000
Received: (qmail 13418 invoked by uid 111); 5 Oct 2016 03:55:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.250)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 23:55:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 23:54:47 -0400
Date:   Tue, 4 Oct 2016 23:54:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 18/18] alternates: use fspathcmp to detect duplicates
Message-ID: <20161005035447.xdnmilecg6p2uqrp@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
 <20161005023455.GA6215@pug.qqx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161005023455.GA6215@pug.qqx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 10:34:55PM -0400, Aaron Schrab wrote:

> At 16:36 -0400 03 Oct 2016, Jeff King <peff@peff.net> wrote:
> > On a case-insensitive filesystem, we should realize that
> > "a/objects" and "A/objects" are the same path.
> 
> The current repository being on a case-insensitive filesystem doesn't
> guarantee that the alternates are as well.
> 
> On the other hand, I suspect that people who use a case-insensitive
> filesystem would be less likely to use names which differ only by case.

True. I don't think we actually have enough information to make the
correct comparison (not only that, but I think that fspathcmp() can
sometimes be fooled by a path which is only partially case-insensitive
due to a case-insensitive filesystem mounted on a case-sensitive one).

Still, I think in practice this is likely to do more good than harm, as
I'd guess that being on a single filesystem is the common case.

-Peff
