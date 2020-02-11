Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F1C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55F020848
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBKRN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:13:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:57520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728078AbgBKRN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:13:58 -0500
Received: (qmail 8555 invoked by uid 109); 11 Feb 2020 17:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 17:13:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32068 invoked by uid 111); 11 Feb 2020 17:22:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 12:22:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 12:13:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
Message-ID: <20200211171357.GA2118476@coredump.intra.peff.net>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
 <20200210234427.GA632160@coredump.intra.peff.net>
 <a5622196-1978-2fe5-144f-99edc5516dd6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5622196-1978-2fe5-144f-99edc5516dd6@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 05:18:02PM +0100, René Scharfe wrote:

> And you could rename it to skip_header() to fix the issue that its name
> starts with cmp but its return value is the inverse of a cmp-style
> function.

Good suggestion.

> And it could take a char pointer instead of a strbuf, to reduce its
> dependencies and make it more widely useful -- but that might also be
> a case of YAGNI.

I didn't take this one because all of the callers have strbuf, and it
saves them from dereferencing.

> > -			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
> > +			strbuf_addstr(&sb, val);
> 
> That assumes the header value never contains NULs.  Valid?

I think so, but I pulled it out to a separate patch so that it could be
argued for explicitly.

> The repeated sequence cmp_header()+strbuf_add{,str}()+decode_header()
> makes me itchy.

Yeah, it's ugly and I factored it out in a new patch. But the
boilerplate and docstring ends up longer than the savings. ;)

-Peff
