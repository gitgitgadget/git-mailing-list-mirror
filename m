Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E4C1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 22:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfBFWKL (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 17:10:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:35250 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbfBFWKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 17:10:11 -0500
Received: (qmail 28132 invoked by uid 109); 6 Feb 2019 22:10:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 22:10:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6211 invoked by uid 111); 6 Feb 2019 22:10:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 17:10:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 17:10:09 -0500
Date:   Wed, 6 Feb 2019 17:10:09 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        steadmon@google.com
Subject: Re: [PATCH 0/8] Resend of GIT_TEST_PROTOCOL_VERSION patches
Message-ID: <20190206221008.GB15378@sigill.intra.peff.net>
References: <cover.1549411880.git.jonathantanmy@google.com>
 <20190206213458.GC12737@sigill.intra.peff.net>
 <87ef8klh4g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ef8klh4g.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 10:52:15PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I wonder if it would be more obvious what's going on if we instead had a
> > prereq like:
> >
> >   test_expect_success !PROTO_V2 'ls-remote --symref' '
> >      ...
> >   '
> >
> > and just skipped those tests entirely (and in a way that appears in the
> > TAP output).
> >
> > I think it would also future-proof us a bit for v2 becoming the default
> > (i.e., when GIT_TEST_PROTOCOL_VERSION being blank does mean "use v2").
> >
> > I dunno. It probably doesn't matter all that much, so it may not be
> > worth going back and changing at this point. Just a thought.
> 
> So far we've had the convention that these GIT_TEST_* variables,
> e.g. the one for the commit graph, work the same way. Thus we guarantee
> that we get (in theory) 100% coverage even when running the tests in
> this special mode. I think it's better to keep it as-is.

But what's the point of that? Don't you always have to run the test
suite _twice_, once with the special variable and once without?
Otherwise, you are not testing one case or the other.

Or are you arguing that one might set many special variables in one go
(to prefer running the suite only twice, instead of 2^N times). In which
case we are better off running the test (as opposed to skipping it), as
it might use one of the _other_ special variables besides
GIT_TEST_PROTOCOL_VERSION.

I can buy that line of reasoning. It still doesn't cover all cases that
a true 2^N test would, but that clearly isn't going to be practical.

-Peff
