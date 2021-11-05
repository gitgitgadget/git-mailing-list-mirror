Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF08DC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F3561037
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 23:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKEX27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 19:28:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54104 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhKEX27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 19:28:59 -0400
Received: (qmail 12795 invoked by uid 109); 5 Nov 2021 23:26:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 23:26:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23736 invoked by uid 111); 5 Nov 2021 23:26:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 19:26:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 19:26:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vipul Kumar <kumar+git@onenetbeyond.org>, git@vger.kernel.org
Subject: Re: List all commits of a specified file in oldest to newest order
Message-ID: <YYW9mfsyemUsBezG@coredump.intra.peff.net>
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
 <YYTorS1DiuTXv0/V@coredump.intra.peff.net>
 <xmqq7ddmxwtc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ddmxwtc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 11:49:03AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As a workaround, you can get what you want by two separate traversals:
> > one to collect the commits via --follow, and then another to actually
> > show them (but without doing any further walking). Like:
> >
> >   git log --follow --format=%H -- $your_file |
> >   git log --stdin --no-walk --reverse [--oneline, -p, etc]
> 
> We learn new things every day.
> 
> Knowing the implementation, it is sort of obvious (we push the
> objects into the pending list, populate the revs.commits in
> prepare_revision_walk() from the pending list in order,
> get_revision() first reverses the revs.commits and then gives out
> the elements), but I didn't know the combination of "--no-walk" and
> "--reverse" did something sensible ;-)

I admit that I did not know if it would work either until I tried it
earlier today. ;)

-Peff
