Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32151F461
	for <e@80x24.org>; Thu, 22 Aug 2019 17:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbfHVREg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 13:04:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:52632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731556AbfHVREg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 13:04:36 -0400
Received: (qmail 32629 invoked by uid 109); 22 Aug 2019 17:04:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Aug 2019 17:04:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22690 invoked by uid 111); 22 Aug 2019 17:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Aug 2019 13:05:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Aug 2019 13:04:35 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Charles Diza <chdiza@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: v2.22.1 and later regression wrt display of progress indicators
Message-ID: <20190822170435.GA26163@sigill.intra.peff.net>
References: <20190822141928.GA3163@323642-phi-gmno-clahs>
 <20190822160702.GD20404@szeder.dev>
 <20190822162907.GA17013@sigill.intra.peff.net>
 <20190822164032.GF20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822164032.GF20404@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 06:40:32PM +0200, SZEDER Gábor wrote:

> > Yes, we moved to v2.22.1 last night. I'll revert those commits on our
> > servers until we come up with a more permanent solution upstream.
> 
> I think it's sufficient to revert only 5b12e3123b (progress: use
> term_clear_line(), 2019-06-24).  I only mentioned cd1096b282 here
> because it better explains the reasons for having term_clear_line(),
> and an other patch depends on that function as well.

Yes, that's what we did. :) It's out now, so everybody should see the
fix.

> > One interesting bit: we have traditionally used \033[K on the _client_
> > side of the sideband demuxer. So I think in the "remote:" case we were
> > already handling this correctly, even before your patch.
> 
> Gah, I feared that the term "sideband multiplexer" will soon come up
> in this discussion...

It may open up some new options for us, though.

If we know on the server side that we are serving a remote request
(which is easy, and does not require client cooperation), can we assume
that the other side will show any sideband lines with its own
end-of-line clearing?

I'm not sure. Git does and always has (and even on a dumb terminal makes
a token effort at throwing some spaces in ;) ). But I'm not sure if
other clients do (and they of course might not even be displaying to a
terminal at all, if they're pulling sideband data into a GUI dialog or
similar).

-Peff
