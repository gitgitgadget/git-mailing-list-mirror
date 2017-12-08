Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C45D20C32
	for <e@80x24.org>; Fri,  8 Dec 2017 09:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbdLHJ7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 04:59:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:51898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753942AbdLHJzN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 04:55:13 -0500
Received: (qmail 31888 invoked by uid 109); 8 Dec 2017 09:55:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 09:55:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30421 invoked by uid 111); 8 Dec 2017 09:55:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 04:55:34 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 04:55:11 -0500
Date:   Fri, 8 Dec 2017 04:55:11 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        sbeller@google.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH] decorate: clean up and document API
Message-ID: <20171208095510.GA29626@sigill.intra.peff.net>
References: <20171208001424.81712-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208001424.81712-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 04:14:24PM -0800, Jonathan Tan wrote:

> Improve the names of the identifiers in decorate.h, document them, and
> add an example of how to use these functions.
> 
> The example is compiled and run as part of the test suite.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This patch contains some example code in a test helper.
> 
> There is a discussion at [1] about where example code for hashmap should
> go. For something relatively simple, like decorate, perhaps example code
> isn't necessary; but if we include example code anyway, I think that we
> might as well make it compiled and tested, so this patch contains that
> example code in a test helper.

I have mixed feelings. On the one hand, compiling and running the code
ensures that those things actually work. On the other hand, I expect you
can make a much clearer example if instead of having running code, you
show snippets of almost-code.

E.g.:

  struct decoration d = { NULL };

  add_decoration(&d, obj, "foo");
  ...
  str = lookup_decoration(obj);

pretty much gives the relevant overview, with very little boilerplate.
Yes, it omits things like the return value of add_decoration(), but
those sorts of details are probably better left to the function
docstrings.

Other than that philosophical point, the documentation you added looks
pretty good to me. Two possible improvements to the API we could do on
top:

  1. Should there be a DECORATION_INIT macro (possibly taking the "name"
     as an argument)? (Actually, the whole name thing seems like a
     confusing and bad API design in the first place).

  2. This is really just an oidmap to a void pointer. I wonder if we
     ought to be wrapping that code (I think we still want some
     interface so that the caller doesn't have to declare their own
     structs).

-Peff
