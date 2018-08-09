Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327FC1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 14:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeHIQvq (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 12:51:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730453AbeHIQvq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 12:51:46 -0400
Received: (qmail 21219 invoked by uid 109); 9 Aug 2018 14:26:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 14:26:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9467 invoked by uid 111); 9 Aug 2018 14:26:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 10:26:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 10:26:36 -0400
Date:   Thu, 9 Aug 2018 10:26:36 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] chainlint: match arbitrary here-docs tags rather
 than hard-coded names
Message-ID: <20180809142636.GC1439@sigill.intra.peff.net>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com>
 <20180807082135.60913-2-sunshine@sunshineco.com>
 <20180808225011.GC3902@sigill.intra.peff.net>
 <CAPig+cR6=HjSo4HW8jPCDBQ0SsVqCw8o=cekVEPnSZZzsh2Tkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cR6=HjSo4HW8jPCDBQ0SsVqCw8o=cekVEPnSZZzsh2Tkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 01:58:05AM -0400, Eric Sunshine wrote:

> On Wed, Aug 8, 2018 at 6:50 PM Jeff King <peff@peff.net> wrote:
> > On Tue, Aug 07, 2018 at 04:21:31AM -0400, Eric Sunshine wrote:
> > > +# Swallowing here-docs with arbitrary tags requires a bit of finesse. When a
> > > +# line such as "cat <<EOF >out" is seen, the here-doc tag is moved to the front
> > > +# of the line enclosed in angle brackets as a sentinel, giving "<EOF>cat >out".
> >
> > Gross, but OK, as long as we would not get confused by a line that
> > actually started with <EOF> at the start.
> 
> It can't get confused by such a line. There here-doc swallower
> prepends that when it starts the swallowing process and removes it add
> the end. Even if a line actually started with that, it would become
> "<EOF><EOF>cmd" while swallowing the here-doc, and be restored to
> "<EOF>cmd" at the end. Stripping the "<EOF>" is done non-greedily, so
> it wouldn't remove both of them. Likewise, non-greedy matching is used
> for pulling the "EOF" out of the "<...>" when trying to match against
> the terminating "EOF" line, so there can be no confusion.

Thanks. I figured you probably had thought of that, but it seemed easier
to ask than to wade through the sed code (I do feel like a bad person to
give that answer, because IMHO one of the key things that makes open
source work is a willingness to dig in yourself rather than asking; but
I am making an exception for this sed code).

> Yeah, I was going with the tighter uppercase-only which Jonathan
> suggested[1], but I guess it wouldn't hurt to re-roll to allow
> lowercase too.
>
> [...]
>
> No. I've gotten so used to \EOF in this codebase that it didn't occur
> to me to even think about 'EOF', but a re-roll could add that, as
> well.

Thanks. I could take or leave such fixes, since I think our style
discourages both, so I'll leave it up to you whether you want to pursue
them.

-Peff
