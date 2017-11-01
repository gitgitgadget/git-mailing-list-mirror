Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5067820281
	for <e@80x24.org>; Wed,  1 Nov 2017 07:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdKAHeR (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 03:34:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:42112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750808AbdKAHeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 03:34:16 -0400
Received: (qmail 30549 invoked by uid 109); 1 Nov 2017 07:34:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 07:34:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8339 invoked by uid 111); 1 Nov 2017 07:34:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 03:34:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 03:34:14 -0400
Date:   Wed, 1 Nov 2017 03:34:14 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Avoid rewriting "packed-refs" unnecessarily
Message-ID: <20171101073414.rwi426whpinv226l@sigill.intra.peff.net>
References: <cover.1509181545.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1509181545.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 11:16:00AM +0200, Michael Haggerty wrote:

> This reroll make some logically small changes to v1 [1] that are
> textually very big:
> 
> * Invert the sense of `is_packed_transaction_noop()` and rename it to
>   `is_packed_transaction_needed()`. This makes the logic easier to
>   follow and document.
> 
> * Add a big comment to that function, describing the cases when it
>   returns false positives and explaining why that isn't a problem.
> 
> * In the commit message for patch 02, gives a lot more information
>   about the regression that it is fixing. Thanks to Eric for the
>   suggestion.
> 
> These patches are also available as branch
> `avoid-rewriting-packed-refs` on my GitHub fork [2]. They now use
> `mh/packed-ref-transactions` as the base, since that is where Junio
> chose to apply v1.

This all makes sense to me. I agree that the "is_needed" logic-flip in
v2 makes it a little easier to think about.

Like Junio, I was thrown off at first by the HAVE_OLD check. Especially
since we would not ever set that flag for the transaction we care about
here.  But I think the crux of it is that the packed_ref store code
could in theory operate independently of the loose ref code, where we
feed it more exotic inputs. And what you've written here is
future-proofing against the more general case, even though it would not
be strictly necessary.

-Peff
