Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815F81F453
	for <e@80x24.org>; Fri,  3 May 2019 17:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfECRpG (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 13:45:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726480AbfECRpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 13:45:05 -0400
Received: (qmail 727 invoked by uid 109); 3 May 2019 17:45:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 May 2019 17:45:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12901 invoked by uid 111); 3 May 2019 17:45:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 May 2019 13:45:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2019 13:45:03 -0400
Date:   Fri, 3 May 2019 13:45:03 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190503174503.GA8242@sigill.intra.peff.net>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503144211.GH14763@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 04:42:11PM +0200, SZEDER Gábor wrote:

> > Since you *could* include it, I now assume that Coccinelle does not need
> > to follow the `#include`s (otherwise, it would have complained about not
> > finding the `windows.h` header in your setup).
> 
> We invoke Coccinelle/spatch with the '--all-includes' option, see the
> SPATCH_FLAGS make variable.  And it does indeed include header files:
> I've seen it find something to transform in 'cache.h', and then the
> resulting 'contrib/coccinelle/<whatever>.cocci.patch' included the
> exact same transformation as many times as the number of files
> including 'cache.h'... which is a lot :)

I think spatch is smart enough not to hit the same header multiple
times. But the problem is that we invoke it once per file, so it
actually processes cache.h many times. That's slow, but also produces
bogus patches.

Jacob Keller's patches to collapse this to a single invocation do fix it
(and I've used them selectively in the past rather than cleaning up the
resulting patch manually ;) ).

Sort of tangential to your point, I guess, but it might be a topic to
revisit.

-Peff
