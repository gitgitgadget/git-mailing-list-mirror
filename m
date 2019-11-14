Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F369A1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKNGlj (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:41:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:47170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725601AbfKNGlj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:41:39 -0500
Received: (qmail 22391 invoked by uid 109); 14 Nov 2019 06:41:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 06:41:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1305 invoked by uid 111); 14 Nov 2019 06:45:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 01:45:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 01:41:37 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Marius Raht <mariusraht@gmail.com>, git@vger.kernel.org
Subject: Re: Feature Request: Check if commit is existent via http-protocol
Message-ID: <20191114064137.GF10643@sigill.intra.peff.net>
References: <c5147250-4af2-0e98-db6e-20602a38fba4@gmail.com>
 <20191114025244.GC9216@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114025244.GC9216@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 02:52:44AM +0000, brian m. carlson wrote:

> Git supports a massive number of ways to query data, and there's just no
> way to efficiently and securely support all of those methods natively
> over an API.  In fact, some operations Git can perform are potentially
> expensive, and exposing an API to perform those is a security problem
> (due to DoS attacks).
> 
> Some of that functionality is available in various Git hosting solutions
> through their own APIs, but as far as I'm aware, there aren't any which
> perform this operation (which is essentially "git merge-base
> --is-ancestor").  If you want this functionality in a particular
> platform, I'd encourage you to reach out to the provider of that
> platform to ask them if they'd implement it.  However, I don't think
> we're likely to implement it in Git's HTTP protocol.
> 
> Other contributors are welcome to chime in if anything I said seems
> incorrect or off base.

I think that's all accurate.

There's nothing to say we _couldn't_ provide a richer set of commands
via Git's protocol. There are already uncommon ones like upload-archive.
And people have talked about being able to offload git-grep requests to
a server.

But it really opens a can of worms in terms of which operations to
support, how to handle load, etc. The strategy so far for Git itself has
been to keep servers relatively dumb, and clients interested in doing
queries should clone and then do what they want locally. That's not the
most efficient thing for clients that want to do one-off queries, but it
keeps the boundaries clean. Even if we did implement more server-side
operations, they'd almost certainly be disabled by default.

-Peff
