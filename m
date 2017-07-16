Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC5220357
	for <e@80x24.org>; Sun, 16 Jul 2017 10:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdGPKbf (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 06:31:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:41964 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751048AbdGPKbe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 06:31:34 -0400
Received: (qmail 24297 invoked by uid 109); 16 Jul 2017 10:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:31:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24540 invoked by uid 111); 16 Jul 2017 10:31:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 06:31:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 06:31:32 -0400
Date:   Sun, 16 Jul 2017 06:31:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add MOVE_ARRAY
Message-ID: <20170716103132.z36audbi7wxot7e6@sigill.intra.peff.net>
References: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec78a849-36e4-4b1d-1ad6-46dcc39a1396@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 15, 2017 at 09:36:20PM +0200, René Scharfe wrote:

> Similar to COPY_ARRAY (introduced in 60566cbb58), add a safe and
> convenient helper for moving potentially overlapping ranges of array
> entries.  It infers the element size, multiplies automatically and
> safely to get the size in bytes, does a basic type safety check by
> comparing element sizes and unlike memmove(3) it supports NULL
> pointers iff 0 elements are to be moved.
> 
> Also add a semantic patch to demonstrate the helper's intended usage.

If we have COPY_ARRAY(), I think it's foolish not to provide the
matching MOVE_ARRAY().  If it were just the "if (n)", I might say we
could just do this inline in the few calls that care.  But I really like
the size safety.

I agree with your comments elsewhere that we don't need to worry about
the case where one of the arrays is NULL but the size is not zero.
That's a flat-out bug.

-Peff
