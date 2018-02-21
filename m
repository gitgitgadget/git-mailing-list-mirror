Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956511F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBUSZy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:25:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:59488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751712AbeBUSZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:25:53 -0500
Received: (qmail 6217 invoked by uid 109); 21 Feb 2018 18:25:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 18:25:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23390 invoked by uid 111); 21 Feb 2018 18:26:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 13:26:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 13:25:50 -0500
Date:   Wed, 21 Feb 2018 13:25:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
Message-ID: <20180221182550.GB4333@sigill.intra.peff.net>
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
 <20180214215637.6462-1-martin.agren@gmail.com>
 <20180219212937.GB9748@sigill.intra.peff.net>
 <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
 <xmqqa7w21dz7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7w21dz7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 08:53:16AM -0800, Junio C Hamano wrote:

> Even though keeping track of list of known-leaky tests may not be so
> interesting, we can still salvage useful pieces from the discussion
> and make them available to developers, e.g.  something like
> 
>     prove --dry --state=failed |
>     perl -lne '/^(t[0-9]{4})-.*\.sh$/ and print $1' | sort >$@+
>     if cmp >/dev/null $@ $@+; then rm $@+; else mv $@+ $@; fi
> 
> could be made into a target to stash away the list of failing tests
> after a test run?

Unfortunately there are some caveats in that snippet:

  1. You are using prove.

  2. You are using --state=save in the initial run.

I think we might be better off having the test scripts write to
test-results/*.counts even when run under a TAP harness, and then we can
have a consistent way to get the list of failed tests (we already have a
"make failed" that works this way).

-Peff
