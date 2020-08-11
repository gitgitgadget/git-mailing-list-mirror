Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83EC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060C92076B
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgHKEzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:55:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:54790 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgHKEzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 00:55:10 -0400
Received: (qmail 26358 invoked by uid 109); 11 Aug 2020 04:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Aug 2020 04:55:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13123 invoked by uid 111); 11 Aug 2020 04:55:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Aug 2020 00:55:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Aug 2020 00:55:09 -0400
From:   Jeff King <peff@peff.net>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
Message-ID: <20200811045509.GA81227@coredump.intra.peff.net>
References: <20200808213457.13116-1-me@pluvano.com>
 <20200809230436.2152-1-me@pluvano.com>
 <20200810100249.GC37030@coredump.intra.peff.net>
 <20200811041728.GA1748@pluvano.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811041728.GA1748@pluvano.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:17:28AM +0000, Emma Brooks wrote:

> On 2020-08-10 06:02:49-0400, Jeff King wrote:
> > There was a little discussion in response to v1 on whether we could
> > reuse the existing C mailmap code:
> > 
> >   https://lore.kernel.org/git/20200731010129.GD240563@coredump.intra.peff.net/
> > 
> > Did you have any thoughts on that?
> 
> I think it's probably not worth the effort to make the necessary changes
> to "rev-list --header" Junio mentioned, just for gitweb.

Yeah, I agree that probably doesn't make sense to change "rev-list
--header". I wonder if git could be using "rev-list --format" instead,
though, and asking for the specific things it wants. That could improve
more than just this case, too (e.g., the C code would be parsing and
normalizing author/committer idents, which could make handling of badly
formatted ones more consistent with other Git tools).

It may be a big change, though. I don't know the gitweb code very well.

> I agree it's a bit worrisome to have a second parser that could
> potentially behave slightly differently than the main implementation.
> What if we added tests for gitweb's mailmap parsing based on the same
> cases used for Git itself?

That would certainly help, though I don't know how easy it would be to
replicate all of the tests in a maintainable way.

-Peff
