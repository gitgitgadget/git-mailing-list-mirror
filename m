Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F03B1F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeCaKUM (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:20:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:49918 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752885AbeCaKUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:20:09 -0400
Received: (qmail 7474 invoked by uid 109); 31 Mar 2018 10:20:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 31 Mar 2018 10:20:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3724 invoked by uid 111); 31 Mar 2018 10:21:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 31 Mar 2018 06:21:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Mar 2018 06:20:07 -0400
Date:   Sat, 31 Mar 2018 06:20:07 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 06/13] pack-objects: move in_pack out of struct
 object_entry
Message-ID: <20180331102007.GC32290@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-7-pclouds@gmail.com>
 <20180330204812.GE14782@sigill.intra.peff.net>
 <CACsJy8Dma-xrDcK1vQ-s4F+Dwt4oWOQ89yr33OPJdO1g0ryQWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Dma-xrDcK1vQ-s4F+Dwt4oWOQ89yr33OPJdO1g0ryQWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 06:51:10AM +0200, Duy Nguyen wrote:

> >> +#define IN_PACK(obj) oe_in_pack(&to_pack, obj)
> >
> > How come this one gets a macro, but the earlier conversions don't?
> >
> > I guess the problem is that oe_in_pack() is defined in the generic
> > pack-objects.h, but &to_pack is only in builtin/pack-objects.c?
> >
> > I wonder if it would be that bad to just say oe_in_pack(&to_pack, obj)
> > everywhere. It's longer, but it makes the code slightly less magical to
> > read.
> 
> Longer was exactly why I added these macros (with the hope that the
> macro upper case names already ring a "it's magical" bell). Should I
> drop all these macros? Some code becomes a lot more verbose though.

I'm on the fence. I agree that the macro screams "magical". I just
sometimes see a macro and think something really weird and
unfunction-like is going on. But really we're just replacing a default
parameter.

So I dunno. If you get rid of the macros and I look at it, I give even
odds that I'll say "yech, put them back!". :)

-Peff
