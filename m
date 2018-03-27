Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A051F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeC0QxQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:53:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:44902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753000AbeC0QxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:53:13 -0400
Received: (qmail 13358 invoked by uid 109); 27 Mar 2018 16:53:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Mar 2018 16:53:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31456 invoked by uid 111); 27 Mar 2018 16:54:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Mar 2018 12:54:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2018 12:53:11 -0400
Date:   Tue, 27 Mar 2018 12:53:11 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/13] nd/pack-objects-pack-struct updates
Message-ID: <20180327165311.GA15102@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180326151317.GA24425@sigill.intra.peff.net>
 <CACsJy8Br0+PGauEYLUarOFrq4bPbnE5u95XemzFyyn_riBZ_xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Br0+PGauEYLUarOFrq4bPbnE5u95XemzFyyn_riBZ_xA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 07:04:54PM +0200, Duy Nguyen wrote:

> >> +unsigned long oe_get_size_slow(struct packing_data *pack,
> >> +                            const struct object_entry *e)
> [...]
> > But short of that, it's probably worth a comment explaining what's going
> > on.
> 
> I thought the elaboration on "size" in the big comment block in front
> of struct object_entry was enough. I was wrong. Will add something
> here.

It may be my fault for reading the interdiff, which didn't include that
comment. I was literally just thinking something like:

  /*
   * Return the size of the object without doing any delta
   * reconstruction (so non-deltas are true object sizes, but
   * deltas return the size of the delta data).
   */

> > I see there's a one-off test for GIT_TEST_FULL_IN_PACK_ARRAY, which I
> > think is a good idea, since it makes sure the code is exercised in a
> > normal test suite run. Should we do the same for GIT_TEST_OE_SIZE_BITS?
> 
> I think the problem with OE_SIZE_BITS is it has many different code
> paths (like reused deltas) which is hard to make sure it runs. But yes
> I think I could construct a pack that executes both code paths in
> oe_get_size_slow(). Will do in a reroll.

OK. If it's too painful to construct a good example, don't worry about
it.  It sounds like we're unlikely to get full coverage anyway.

> > I haven't done an in-depth read of each patch yet; this was just what
> > jumped out at me from reading the interdiff.
> 
> I would really appreciate it if you could find some time to do it. The
> bugs I found in this round proved that I had no idea what's really
> going on in pack-objects. Sure I know the big picture but that's far
> from enough to do changes like this.

I didn't get to it today, but I'll try to give it a careful read. There
are quite a few corners of pack-objects I don't know well, but I think
at this point I may be the most expert of remaining people. Scary. :)

-Peff
