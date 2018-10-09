Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B3C1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbeJIKgM (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 06:36:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:46920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725759AbeJIKgM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 06:36:12 -0400
Received: (qmail 8151 invoked by uid 109); 9 Oct 2018 03:21:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 03:21:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10471 invoked by uid 111); 9 Oct 2018 03:20:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Oct 2018 23:20:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Oct 2018 23:21:24 -0400
Date:   Mon, 8 Oct 2018 23:21:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git log -S or -G
Message-ID: <20181009032124.GE6250@sigill.intra.peff.net>
References: <alpine.DEB.2.21.1810061712260.2402@hadrien>
 <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com>
 <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com>
 <alpine.DEB.2.21.1810070719200.2347@hadrien>
 <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 09, 2018 at 08:09:32AM +0900, Junio C Hamano wrote:

> Julia Lawall <julia.lawall@lip6.fr> writes:
> 
> >> Doing the same for -S is much harder at the machinery level, as it
> >> performs its thing without internally running "diff" twice, but just
> >> counts the number of occurrences of 'foo'---that is sufficient for
> >> its intended use, and more efficient.
> >
> > There is still the question of whether the number of occurrences of foo
> > decreases or increases.
> 
> Hmph, taking the changes that makes the number of hits decrease
> would catch a subset of "changes that removes 'foo' only---I am not
> interested in the ones that adds 'foo'".  It will avoid getting
> confused by a change that moves an existing 'foo' to another place
> in the same file (as the number of hits does not change), but at the
> same time, it will miss a change that genuinely removes an existing
> 'foo' and happens to add a 'foo' at a different place in the same
> file that is unrelated to the original 'foo'.  Depending on the
> definition of "I am only interested in removed ones", that may or
> may not be acceptable.

I think that is the best we could do for "-S", though, which is
inherently about counting hits.

For "-G", we are literally grepping the diff. It does not seem
unreasonable to add the ability to grep only "-" or "+" lines, and the
interface for that should be pretty straightforward (a tri-state flag to
look in remove, added, or both lines).

-Peff
