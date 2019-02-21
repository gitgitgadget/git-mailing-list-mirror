Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1501F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBUNt4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:49:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:52562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725820AbfBUNt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:49:56 -0500
Received: (qmail 20363 invoked by uid 109); 21 Feb 2019 13:49:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:49:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12496 invoked by uid 111); 21 Feb 2019 13:50:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:50:09 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:49:54 -0500
Date:   Thu, 21 Feb 2019 08:49:54 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 2/8] tests: always test fetch of unreachable with v0
Message-ID: <20190221134954.GC21406@sigill.intra.peff.net>
References: <20190211203011.GB9072@sigill.intra.peff.net>
 <20190214195825.125751-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214195825.125751-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 11:58:25AM -0800, Jonathan Tan wrote:

> > On Tue, Feb 05, 2019 at 04:21:16PM -0800, Jonathan Tan wrote:
> > 
> > > Some tests check that fetching an unreachable object fails, but protocol
> > > v2 allows such fetches. Unset GIT_TEST_PROTOCOL_VERSION so that these
> > > tests are always run using protocol v0.
> > 
> > I think this is reasonable, but just musing on a few things:
> > 
> >   1. Are we sure going forward that we want to retain this behavior? I
> >      feel like we discussed this on the list recently with no real
> >      conclusion, but I'm having trouble digging it up in the archive.
> 
> One such discussion is here:
> https://public-inbox.org/git/20181214101232.GC13465@sigill.intra.peff.net/

Thanks, that was what I was thinking of, though there doesn't seem to
have been much discussion in response. :)

> >   2. If it does change, is there any way we could automatically find
> >      spots like this that would then need to be undone? I cannot think
> >      of a good solution, and I don't think it's a show-stopper not to
> >      have one, but I thought I'd put it forward as a concept.
> 
> We can do so now either by "blaming" one and finding the originating
> commit, or by searching for "support fetching unadvertised objects" (I
> used the same comment everywhere in the commit [1] so that people can do
> this), but I don't know how to enforce this for future work. (We can add
> a special variable, but I think it's unnecessary and we can't enforce
> that people use that new special variable instead of
> GIT_TEST_PROTOCOL_VERSION anyway.)

Yeah, I think we can find them once we know they need fixing. I was more
wondering whether we would remember to do so. I.e., is there a way the
test suite could remind us when our assumptions change. I can't think of
an easy way to do so, though.

-Peff
