Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6151F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752893AbeCEU4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:56:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:47934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752040AbeCEU4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:56:30 -0500
Received: (qmail 19289 invoked by uid 109); 5 Mar 2018 20:56:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Mar 2018 20:56:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30002 invoked by uid 111); 5 Mar 2018 20:57:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Mar 2018 15:57:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2018 21:56:27 +0100
Date:   Mon, 5 Mar 2018 21:56:27 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Sam Kuper <sam.kuper@uclmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] add--interactive: detect bogus diffFilter output
Message-ID: <20180305205626.GD5953@sigill.intra.peff.net>
References: <20180303055715.GH27689@sigill.intra.peff.net>
 <20180303055849.GB15952@sigill.intra.peff.net>
 <xmqqsh9e8css.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh9e8css.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 12:53:07PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's important that the diff-filter only filter the
> > individual lines, and that there remain a one-to-one mapping
> > between the input and output lines. Otherwise, things like
> > hunk-splitting will behave quite unexpectedly (e.g., you
> > think you are splitting at one point, but it has a different
> > effect in the text patch we apply).
> >
> > We can't detect all problematic cases, but we can at least
> > catch the obvious case where we don't even have the correct
> > number of lines.
> 
> Will queue.  We could probably also make sure that each of the
> corresponding line pair begins with the same '-/ /+' letter, but we
> need to draw a line and stop somewhere, and I think the number of
> lines is probably a good enough place.

I think that would break things like diff-so-fancy, which actually
removes the -/+ in favor of pure coloring (not something I care for
myself, but it seems a legitimate use case). So it's probably best not
to look at the content, not just from a "we can only go so far"
perspective but also because we actively don't know what the filter's
output is supposed to look like.

-Peff
