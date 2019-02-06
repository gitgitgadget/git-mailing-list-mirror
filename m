Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98AC1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBFSzW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:55:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:34884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726960AbfBFSzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:55:22 -0500
Received: (qmail 10891 invoked by uid 109); 6 Feb 2019 18:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 18:55:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4318 invoked by uid 111); 6 Feb 2019 18:55:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 13:55:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 13:55:20 -0500
Date:   Wed, 6 Feb 2019 13:55:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190206185520.GD10231@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
 <20190204233444.GC2366@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
 <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 10:45:35AM -0800, Junio C Hamano wrote:

>  - Perhaps find the fork point, run tests to find known breakages
>    and exclude them?  This would simply be not practical, as it
>    doubles the number of tests run, for individual topic branches
>    because there are an order of magnitude more of them than the
>    primary integration branches.

I think this can be limited to the tests that failed, which makes things
much faster. I.e., we run the tests at the tip of topic X and see that
t1234 fails. We then go back to the fork point and we just need to run
t1234 again. If it succeeds, then we blame X for the failure. If it
fails, then we consider it a false positive.

You do pay the price to do a full build at the fork point, but in my
experience that is much quicker than the tests.

-Peff
