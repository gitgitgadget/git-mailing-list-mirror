Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51AA220988
	for <e@80x24.org>; Sat, 15 Oct 2016 17:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbcJORTa (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 13:19:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:57892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbcJORT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 13:19:29 -0400
Received: (qmail 1433 invoked by uid 109); 15 Oct 2016 17:19:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 17:19:28 +0000
Received: (qmail 17892 invoked by uid 111); 15 Oct 2016 17:19:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 15 Oct 2016 13:19:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Oct 2016 13:19:26 -0400
Date:   Sat, 15 Oct 2016 13:19:26 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
Message-ID: <20161015171926.qgtvrjcaqwb436hx@sigill.intra.peff.net>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
 <cover.1476120229.git.johannes.schindelin@gmx.de>
 <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
 <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2016 at 07:03:46PM +0200, Torsten Bögershausen wrote:

> sequencer.c:633:14: warning: comparison of constant 2 with expression of type 'const enum todo_command' is always true [-Wtautological-constant-out-of-range-compare]
>         if (command < ARRAY_SIZE(todo_command_strings))
>             ~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
> 53f8024e (Johannes Schindelin   2016-10-10 19:25:07 +0200  633)         if (command < ARRAY_SIZE(todo_command_strings))
> 

Interesting. The compiler is right that this _should_ never happen, but
I think the patch is quite reasonable to be defensive in case the enum
happens to get a value outside of its acceptable range (which is
probably undefined behavior, but...).

I wonder if:

  if ((int)command < ARRAY_SIZE(todo_command_strings))

silences the warning (I suppose size_t is probably an even better type,
though obviously it does not matter in practice).

-Peff

