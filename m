Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB590202BB
	for <e@80x24.org>; Fri,  8 Mar 2019 02:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCHCwj (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 21:52:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:43346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726275AbfCHCwj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 21:52:39 -0500
Received: (qmail 22899 invoked by uid 109); 8 Mar 2019 02:52:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Mar 2019 02:52:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29601 invoked by uid 111); 8 Mar 2019 02:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 21:52:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 21:52:37 -0500
Date:   Thu, 7 Mar 2019 21:52:37 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Joey Hess <id@joeyh.name>
Subject: Re: [PATCH] convert: avoid malloc of original file size
Message-ID: <20190308025237.GA12304@sigill.intra.peff.net>
References: <20190307195657.GA29776@sigill.intra.peff.net>
 <xmqqa7i6kvgf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7i6kvgf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 08, 2019 at 10:26:24AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As discussed there, I do think this only solves half the problem, as the
> > smudge filter has the same issue in reverse. That's more complicated to
> > fix, and AFAIK nobody is working on it. But I don't think there's any
> > reason not to pick up this part in the meantime.
> 
> Yeah, I agree that the reverse direction shares the same issue.
> 
> I am not sure 0 is a good initial value in this direction, either;
> I'd rather clip to min(len, core.bigfilethreshold) or something like
> that, to avoid regressing the more normal use cases.

That was my initial thought, too, but Joey's benchmarks show that it
doesn't seem to make a big difference either way. In his numbers it did
get measurable for a 1GB file, but we'd still not use "hint == len" in
that case (we'd probably do one or two doublings to get there).

I also think running a real (non-condensing) filter on a 1GB file is
already a pretty unlikely corner case.

> But let's queue this and see what happens.

Sounds good to me.

-Peff
