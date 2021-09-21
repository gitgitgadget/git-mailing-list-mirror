Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C7C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB4461156
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhIUUmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:42:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:52062 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhIUUmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 16:42:09 -0400
Received: (qmail 6664 invoked by uid 109); 21 Sep 2021 20:40:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 20:40:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5270 invoked by uid 111); 21 Sep 2021 20:40:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 16:40:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 16:40:39 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUpDRyfYN8gBcTOh@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <YUoorS6UwA1DmwBm@coredump.intra.peff.net>
 <CAPUEspgrqxrhp-5diEenH+vevWi3QtxpjPqTwDuU5J-JHOXg9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspgrqxrhp-5diEenH+vevWi3QtxpjPqTwDuU5J-JHOXg9A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:14:21PM -0700, Carlo Arenas wrote:

> On Tue, Sep 21, 2021 at 12:48 PM Jeff King <peff@peff.net> wrote:
> > But certainly I found the behavior surprising. :) I'd guess it's because
> > HTTP/2 is sending some binary goo instead of text headers, and the names
> > we get are just coming from some lookup table? Or maybe I'm just showing
> > my ignorance of HTTP/2.
> 
> AFAIK headers in HTTP/2 MUST be lowercase as per the SPEC[1]
> 
> Carlo
> 
> [1] https://datatracker.ietf.org/doc/html/rfc7540#section-8.1.2

Yeah, I did some more reading and found that, too. From Daniel on
StackOverflow, no less:

  https://stackoverflow.com/questions/54067796/preserving-case-of-http-headers-with-curl

So it probably is reasonable to present them to the debug code in that
way. It is a bit weird that we may see them differently depending on
whether curl decided to use HTTP/1.1 or HTTP/2 under the hood, but
matching the on-the-wire format is probably the least-bad thing.

-Peff
