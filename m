Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B978D1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 21:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbeBSV3k (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 16:29:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:57308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753624AbeBSV3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 16:29:39 -0500
Received: (qmail 5322 invoked by uid 109); 19 Feb 2018 21:29:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Feb 2018 21:29:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7793 invoked by uid 111); 19 Feb 2018 21:30:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Feb 2018 16:30:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Feb 2018 16:29:37 -0500
Date:   Mon, 19 Feb 2018 16:29:37 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
Message-ID: <20180219212937.GB9748@sigill.intra.peff.net>
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
 <20180214215637.6462-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214215637.6462-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:56:37PM +0100, Martin Ågren wrote:

> Here's what a list of known leaks might look like. It feels a bit
> awkward to post a known-incomplete list (I don't run all tests). Duy
> offered to pick up the ball if I gave up, maybe you could complete and
> post this as your own? :-? Even if I (or others) can't reproduce the
> complete list locally, regressions will be trivial to find, and newly
> leak-free tests fairly easy to notice.

I didn't think about that when I posted my scripts. In general, it's OK
to me if you miss a script when you generate the "leaky" list. But if
you skip it, you cannot say whether it is leaky or not, and should
probably neither add nor remove it from the known-leaky list. So I think
the second shell snippet needs to become a little more clever about
skipped test scripts.

Even that isn't 100% fool-proof, as some individual tests may be skipped
or not skipped on various platforms. But it may be enough in practice
(and eventually we'd have no known-leaky tests, of course ;) ).

Or alternatively, we could just not bother with checking this into the
repository, and it becomes a local thing for people interested in
leak-testing. What's the value in having a shared known-leaky list,
especially if we don't expect most people to run it.

I guess it lets us add a Travis job to do the leak-checking, which might
get more coverage. So maybe if we do have an in-repo known-leaky, it
should match some canonical Travis environment. That won't give us
complete coverage, but at this point we're just trying to notice
low-hanging fruit.

-Peff
