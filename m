Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CF41F407
	for <e@80x24.org>; Sun, 10 Dec 2017 14:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdLJObW (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 09:31:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:53682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751633AbdLJObV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 09:31:21 -0500
Received: (qmail 29503 invoked by uid 109); 10 Dec 2017 14:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Dec 2017 14:31:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13618 invoked by uid 111); 10 Dec 2017 14:31:43 -0000
Received: from pool-96-236-18-62.albyny.fios.verizon.net (HELO sigill.intra.peff.net) (96.236.18.62)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 10 Dec 2017 09:31:43 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Dec 2017 09:31:19 -0500
Date:   Sun, 10 Dec 2017 09:31:19 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/7] git-compat-util: introduce skip_to_optional_arg()
Message-ID: <20171210143118.GB19453@sigill.intra.peff.net>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171209204013.10997-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 09, 2017 at 09:40:07PM +0100, Christian Couder wrote:

> The changes compared to v2 are:
> 
>   - s/_val/_arg/ in the name of the functions
>   - s/val/arg/ in the name of the third argument of the functions
>   - works with NULL as third argument of the functions

This whole series looks OK to me, but this third point made me wonder:
what would be the use of allowing NULL for the "arg" parameter?

I didn't see any use of this in the series, and I'm having trouble
figuring out how it would be useful. E.g., if I do:

  if (skip_to_optional_arg(arg, "--foo", NULL))
     ...

what can I do in "..."? I know we matched _some_ type of "--foo", but I
cannot know whether it was "--foo" or "--foo=bar", nor what "bar" is. It
could only be used by some kind of vague validator to say "well, at
least this looks like an option that I _could_ parse if I wanted to".

So I guess I don't mind it, as it does the most reasonable thing it can
when passed NULL, but I would be surprised if we ever actually exercise
the code path.

-Peff
