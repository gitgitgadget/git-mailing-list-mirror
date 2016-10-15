Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDF720988
	for <e@80x24.org>; Sat, 15 Oct 2016 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbcJORxm (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 13:53:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:57919 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753284AbcJORxl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 13:53:41 -0400
Received: (qmail 2972 invoked by uid 109); 15 Oct 2016 17:46:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 17:46:59 +0000
Received: (qmail 18358 invoked by uid 111); 15 Oct 2016 17:47:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 13:47:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Oct 2016 13:46:56 -0400
Date:   Sat, 15 Oct 2016 13:46:56 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
Message-ID: <20161015174656.fmgk3le2b34nnjpx@sigill.intra.peff.net>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
 <cover.1476120229.git.johannes.schindelin@gmx.de>
 <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
 <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
 <20161015171926.qgtvrjcaqwb436hx@sigill.intra.peff.net>
 <d9f4f658-94fb-cb9e-7da8-3a2fac120a9e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9f4f658-94fb-cb9e-7da8-3a2fac120a9e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2016 at 07:40:15PM +0200, Torsten Bögershausen wrote:

> > I wonder if:
> > 
> >   if ((int)command < ARRAY_SIZE(todo_command_strings))
> > 
> > silences the warning (I suppose size_t is probably an even better type,
> > though obviously it does not matter in practice).
> > 
> Both do (silence the warning)
> 
> enum may be signed or unsigned, right ?
> So the size_t variant seams to be a better choice

Good catch. It technically needs to check the lower bound, too. In
theory, if somebody wanted to add an enum value that is negative, you'd
use a signed cast and check against both 0 and ARRAY_SIZE(). In
practice, that is nonsense for this case, and using an unsigned type
means that any negative values become large, and the check catches them.

-Peff
