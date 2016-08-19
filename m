Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAAE1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 14:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754831AbcHSOo0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 10:44:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:58134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754491AbcHSOoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 10:44:25 -0400
Received: (qmail 2190 invoked by uid 109); 19 Aug 2016 14:44:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 14:44:24 +0000
Received: (qmail 26118 invoked by uid 111); 19 Aug 2016 14:44:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 10:44:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 10:44:22 -0400
Date:   Fri, 19 Aug 2016 10:44:22 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
Message-ID: <20160819144422.kkbskkthozfwfezp@sigill.intra.peff.net>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
 <xmqqbn0q6m4v.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608191450500.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608191450500.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 02:59:32PM +0200, Johannes Schindelin wrote:

> > The only thing that somewhat is worrysome is what would happen to
> > %(rest).
> 
> What would happen is that it would print out the path, as it is exactly
> that "rest" field that is used in the implementation, piggybacking on that
> very nice feature.

Good, that is what I would expect to happen.

> Of course, this means that you simply cannot send "SHA-1 path rest" to
> cat-file --batch and expect that to work. Should anybody need that in the
> future, they can give it a try themselves to patch cat-file.

Right. The real motivation for %(rest) was to accept "git rev-list
--objects" format, so you can do stuff like:

  git rev-list --objects --all |
  git cat-file --batch-check='%(objectsize) %(rest)' |
  sort -rn |
  head

to get the paths of the largest objects. So the fact that "%(rest)" will
be the filename in this case is almost certainly the most useful default
(and if somebody really wants something else, they can try to figure out
other semantics later).

-Peff
