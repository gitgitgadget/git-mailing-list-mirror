Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E34E1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 18:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbcLOS4e (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 13:56:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:57144 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753044AbcLOS4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 13:56:34 -0500
Received: (qmail 14006 invoked by uid 109); 15 Dec 2016 18:56:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 18:56:33 +0000
Received: (qmail 4524 invoked by uid 111); 15 Dec 2016 18:57:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 13:57:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 13:56:30 -0500
Date:   Thu, 15 Dec 2016 13:56:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
Message-ID: <20161215185630.xxeimack63wqwv2e@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
 <xmqqlgvhuj82.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgvhuj82.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 10:42:53AM -0800, Junio C Hamano wrote:

> > +		sprintf((char *)p, "%d", ++count);
> 
> Do we know the area pointed at p (which is inside buf) long enough
> not to overflow?  If the original were 9 and you incremented to get
> 10, you would need one extra byte.

Even if it is enough, I'd ask to please use xsnprintf(). In the off
chance that there's a programming error, we'd get a nice die("BUG")
instead of a buffer overflow (and it makes the code base easier to audit
for other overflows).

-Peff
