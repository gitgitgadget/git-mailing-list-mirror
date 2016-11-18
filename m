Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611C71FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 17:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbcKRRI7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 12:08:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:44828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752959AbcKRRI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 12:08:58 -0500
Received: (qmail 14829 invoked by uid 109); 18 Nov 2016 17:08:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Nov 2016 17:08:58 +0000
Received: (qmail 2766 invoked by uid 111); 18 Nov 2016 17:09:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Nov 2016 12:09:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Nov 2016 09:08:55 -0800
Date:   Fri, 18 Nov 2016 09:08:55 -0800
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "spearce@spearce.org" <spearce@spearce.org>
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161118170855.22p3vhcocdxgmpy4@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <20161115004426.unheihlmftlw6ex7@sigill.intra.peff.net>
 <xmqqa8d1v9lo.fsf@gitster.mtv.corp.google.com>
 <20161115035844.e6ehuy7uigqinbnv@sigill.intra.peff.net>
 <xmqqzil0tza6.fsf@gitster.mtv.corp.google.com>
 <20161118170147.g7nbkxpyihwkk6fw@sigill.intra.peff.net>
 <764305554fa74779ad5fb956aa2b658a@EXMBNJE7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <764305554fa74779ad5fb956aa2b658a@EXMBNJE7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2016 at 05:04:59PM +0000, David Turner wrote:

> > So I don't feel like we have a good patch for the general case yet,
> > and I'm probably not going to get around to implementing it anytime
> > soon. 
> 
> I'm confused -- it sounds like your patch actually does work (that is,
> that Junio's failure was not caused by your patch but by the absence
> of our patches). And your patch handles more cases than mine.  So we
> should probably use it instead of mine.

No, mine passes the vanilla test suite, but fails with GIT_TEST_LONG.
If the want/have negotiation takes multiple rounds, the intermediate
rounds don't end on a flush packet, and my patch causes remote-curl to
complain that the response was truncated.

I think you could fix it by teaching remote-curl that the final packet
must be a flush _or_ contain an ACK/NAK, but I didn't try it. That's
getting a bit invasive and brittle.

-Peff
