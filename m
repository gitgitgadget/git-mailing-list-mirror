Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05981F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeCEU23 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:28:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:47854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753213AbeCEU2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:28:18 -0500
Received: (qmail 17980 invoked by uid 109); 5 Mar 2018 20:28:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Mar 2018 20:28:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29780 invoked by uid 111); 5 Mar 2018 20:29:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Mar 2018 15:29:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2018 21:28:13 +0100
Date:   Mon, 5 Mar 2018 21:28:13 +0100
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180305202813.GA5953@sigill.intra.peff.net>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-14-bmwill@google.com>
 <20180303044338.GD27689@sigill.intra.peff.net>
 <20180305182155.GB72475@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305182155.GB72475@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 10:21:55AM -0800, Brandon Williams wrote:

> > Hmm, so this would accept stuff like "refs/heads/*/foo" but quietly
> > ignore the "/foo" part.
> 
> Yeah that's true...this should probably not do that.  Since
> "refs/heads/*/foo" violates what the spec is, really this should error
> out as an invalid pattern.

Yeah, that would be better, I think.

> > It also accepts "refs/h*" to get "refs/heads" and "refs/hello".  I think
> > it's worth going for the most-restrictive thing to start with, since
> > that enables a lot more server operations without worrying about
> > breaking compatibility.
> 
> And just to clarify what do you see as being the most-restrictive case
> of patterns that would should use?

I mean only accepting "*" at a "/" boundary (or just allowing a trailing
slash to imply recursion, like "refs/heads/", or even just always
assuming recursion to allow "refs/heads").

-Peff
