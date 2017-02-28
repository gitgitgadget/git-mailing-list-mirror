Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC71202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdB1Vi5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:38:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:36046 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751601AbdB1Vix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:38:53 -0500
Received: (qmail 21401 invoked by uid 109); 28 Feb 2017 20:37:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 20:37:04 +0000
Received: (qmail 30488 invoked by uid 111); 28 Feb 2017 20:37:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 15:37:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 15:37:02 -0500
Date:   Tue, 28 Feb 2017 15:37:02 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Typesafer git hash patch
Message-ID: <20170228203701.zwboxazcbnp4gaey@sigill.intra.peff.net>
References: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
 <20170228202633.3pxbrnrhot7syiae@sigill.intra.peff.net>
 <20170228203312.jc7gia7f44goqjmj@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228203312.jc7gia7f44goqjmj@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 08:33:13PM +0000, brian m. carlson wrote:

> On Tue, Feb 28, 2017 at 03:26:34PM -0500, Jeff King wrote:
> > Yeah, a lot of brian's patches have been focused around the fixing the
> > related size assumptions. We've got GIT_SHA1_HEXSZ which doesn't solve
> > the problem, but at least makes it easy to find. And a big improvement
> > in the most recent series is a parse_oid() function that lets you parse
> > object-ids left-to-right without knowing the size up front. So things
> > like:
> > 
> >   if (len > 82 &&
> >       !get_sha1_hex(buf, sha1_a) &&
> >       get_sha1_hex(buf + 41, sha1_b))
> > 
> > becomes more like:
> > 
> >   if (parse_oid(p, oid_a, &p) && *p++ == ' ' &&
> >       parse_oid(p, oid_b, &p) && *p++ == '\n')
> 
> What I could do instead of using GIT_SHA1_HEXSZ is use GIT_MAX_HEXSZ for
> things that are about allocating enough memory and create a global (or
> function) for things that only care about what the current hash size is.
> That might be a desirable approach.  If other people agree, I can make a
> patch to do that.

I was going to say "don't worry about it, and focus on converting to
constants at all for now". But I guess while you are doing that, it does
not hurt to split the MAX_HEXSZ cases out. It will save work in sorting
them later.

-Peff
