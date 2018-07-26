Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69E81F597
	for <e@80x24.org>; Thu, 26 Jul 2018 06:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeGZIOF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 04:14:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:59716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726763AbeGZIOF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 04:14:05 -0400
Received: (qmail 20944 invoked by uid 109); 26 Jul 2018 06:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Jul 2018 06:58:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14114 invoked by uid 111); 26 Jul 2018 06:58:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 26 Jul 2018 02:58:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2018 02:58:40 -0400
Date:   Thu, 26 Jul 2018 02:58:40 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] automatically ban strcpy()
Message-ID: <20180726065840.GA27349@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
 <20180724092618.GA3288@sigill.intra.peff.net>
 <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 01:20:58PM -0400, Eric Sunshine wrote:

> On Tue, Jul 24, 2018 at 5:26 AM Jeff King <peff@peff.net> wrote:
> >   1. We'll only trigger with -Wimplicit-function-declaration
> >      (and only stop compilation with -Werror). These are
> >      generally enabled by DEVELOPER=1. If you _don't_ have
> >      that set, we'll still catch the problem, but only at
> >      link-time, with a slightly less useful message:
> >
> >      If instead we convert this to a reference to an
> >      undefined variable, that always dies immediately. But
> >      gcc seems to print the set of errors twice, which
> >      clutters things up.
> 
> The above does a pretty good job of convincing me that this ought to
> be implemented via an undefined variable rather than undefined
> function, exactly because it is the newcomer or casual contributor who
> is most likely to trip over a banned function, and almost certainly
> won't have DEVELOPER=1 set. The gcc clutter seems a minor point
> against the benefit this provides to that audience.

OK. I was on the fence, but it should be pretty trivial to switch. Let
me see if I can just make a replacement for patch 1, or if the whole
thing needs to be rebased on top.

-Peff
