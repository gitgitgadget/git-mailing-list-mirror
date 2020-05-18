Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA3EC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A872075F
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgERUIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:08:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:50204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726270AbgERUIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:08:13 -0400
Received: (qmail 21344 invoked by uid 109); 18 May 2020 20:08:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 20:08:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6193 invoked by uid 111); 18 May 2020 20:08:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 16:08:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 16:08:12 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] pkt-line: extern packet_length()
Message-ID: <20200518200812.GA63978@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <c2b9d033bb774d3bccb572802c3ae114cad8d830.1589816719.git.liu.denton@gmail.com>
 <20200518160425.GA42240@coredump.intra.peff.net>
 <CAPig+cQhZyyQ05B3xF1EkK0hpF8bXMbbPEJXGUdTkoZ5JaHO=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQhZyyQ05B3xF1EkK0hpF8bXMbbPEJXGUdTkoZ5JaHO=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 01:50:52PM -0400, Eric Sunshine wrote:

> On Mon, May 18, 2020 at 12:04 PM Jeff King <peff@peff.net> wrote:
> > On Mon, May 18, 2020 at 11:47:21AM -0400, Denton Liu wrote:
> > > Change the function parameter from a `const char *` to
> > > `const char linelen[4]`. Even though these two types behave identically
> > > as function parameters, use the array notation to semantically indicate
> > > exactly what this function is expecting as an argument.
> >
> > > +/*
> > > + * Convert a four hex digit packet line length header into its numeric
> > > + * representation. linelen should not be null-terminated.
> >
> > Minor nit, but it is perfectly fine if there is a NUL. Maybe "linelen
> > does not need to be..."?
> 
> I had the exact same reaction when reading "...should not be
> null-terminated", however, I'd prefer to drop mention of
> NUL-termination altogether since talking about it merely confuses the
> issue since it is quite clear both from the declaration (const
> char[4]) and the documentation "four hex digits" that 'linelen' is
> expected to contain exactly four hex digits and no NUL character(s).

Yeah, I think I have a slight preference for that, too.

> By the way, I find the argument name "linelen" highly confusing; every
> time I read it, I think it is an integral type, not a string or
> character array. I'd very much prefer to see it renamed to "s" (or
> something) or dropped altogether:
> 
>     int packet_length(const char[4]);

I think giving it _some_ name is useful. Maybe "const char
lenbuf_hex[4]".

-Peff
