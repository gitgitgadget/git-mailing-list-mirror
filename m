Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06736207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbcJCWkc (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:40:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:51613 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbcJCWkb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:40:31 -0400
Received: (qmail 26069 invoked by uid 109); 3 Oct 2016 22:40:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 22:40:31 +0000
Received: (qmail 31531 invoked by uid 111); 3 Oct 2016 22:40:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 18:40:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 18:40:28 -0400
Date:   Mon, 3 Oct 2016 18:40:28 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
Message-ID: <20161003224028.ksvwaplxe7a3vtwv@sigill.intra.peff.net>
References: <20161001001937.10884-1-gitster@pobox.com>
 <20161001001937.10884-4-gitster@pobox.com>
 <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
 <CA+55aFydV+9c3-5C03XUj7v_wGJF5NyJNaP6742zLVgZs410FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFydV+9c3-5C03XUj7v_wGJF5NyJNaP6742zLVgZs410FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 03:34:03PM -0700, Linus Torvalds wrote:

> On Mon, Oct 3, 2016 at 3:27 PM, Jeff King <peff@peff.net> wrote:
> >
> > +       if (len < 0) {
> > +               unsigned long count = approximate_object_count();
> > +               len = (msb(count) + 1) / 2;
> > +               if (len < 0)
> > +                       len = FALLBACK_DEFAULT_ABBREV;
> > +       }
> 
> that second "if (len < 0)" should probably be testing against
> FALLBACK_DEFAULT_ABBREV, not zero. Or at the very least
> MINIMUM_ABBREV. Because a two-character abbreviation won't even be
> recognized, even if the git project is very small indeed.

Oops, yes, clearly it should be FALLBACK_DEFAULT_ABBREV. What is there
would not even pass the tests (it _does_ work on linux.git, of course,
because it is much too large for that code to be triggered).

-Peff
