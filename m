Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF50020248
	for <e@80x24.org>; Sat, 23 Feb 2019 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfBWNZL (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 08:25:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:55494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726269AbfBWNZL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 08:25:11 -0500
Received: (qmail 22594 invoked by uid 109); 23 Feb 2019 13:25:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Feb 2019 13:25:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4115 invoked by uid 111); 23 Feb 2019 13:25:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 23 Feb 2019 08:25:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2019 08:25:09 -0500
Date:   Sat, 23 Feb 2019 08:25:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        steadmon@google.com
Subject: Re: [PATCH 2/8] tests: always test fetch of unreachable with v0
Message-ID: <20190223132509.GC22403@sigill.intra.peff.net>
References: <20190211203011.GB9072@sigill.intra.peff.net>
 <20190214195825.125751-1-jonathantanmy@google.com>
 <20190221134954.GC21406@sigill.intra.peff.net>
 <xmqqimxbpn2p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimxbpn2p.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 12:47:42PM -0800, Junio C Hamano wrote:

> >> We can do so now either by "blaming" one and finding the originating
> >> commit, or by searching for "support fetching unadvertised objects" (I
> >> used the same comment everywhere in the commit [1] so that people can do
> >> this), but I don't know how to enforce this for future work. (We can add
> >> a special variable, but I think it's unnecessary and we can't enforce
> >> that people use that new special variable instead of
> >> GIT_TEST_PROTOCOL_VERSION anyway.)
> >
> > Yeah, I think we can find them once we know they need fixing. I was more
> > wondering whether we would remember to do so. I.e., is there a way the
> > test suite could remind us when our assumptions change. I can't think of
> > an easy way to do so, though.
> 
> Perhaps looking it a different way may help.  Instead of saying "v2
> will not protect unreachable objects, so this test must be run with
> v0", think of it like "Git ought to protect unreachable objects, so
> test with different versions of protocols to make sure all satisfy
> the requirement---for now, v2 is known to be broken, so write it
> with test_expect_failure".  IOW, have one test for each version,
> some of them may document a known breakage.

Ah, yeah, that would work. It means writing out the test twice, once for
each protocol version. But if we're explicitly expecting two different
behaviors, then that's exactly what we ought to be doing.

I'm still not sure if there's consensus on whether the v2 behavior is a
problem or not, though.

-Peff
