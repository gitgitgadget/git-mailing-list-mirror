Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2440209B6
	for <e@80x24.org>; Tue,  5 Sep 2017 21:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753708AbdIEVvA (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:51:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:57916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753258AbdIEVu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:50:59 -0400
Received: (qmail 7450 invoked by uid 109); 5 Sep 2017 21:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 21:50:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17325 invoked by uid 111); 5 Sep 2017 21:51:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 17:51:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 17:50:56 -0400
Date:   Tue, 5 Sep 2017 17:50:56 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: attempt to trim too many characters
Message-ID: <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 02:39:05PM -0700, Linus Torvalds wrote:

> I just got this with
> 
>    gitk --bisect
> 
> while doing some bisection on my current kernel.
> 
> It happens with "git rev-parse --bisect" too, but interestingly, "git
> log --bisect" works fine.
> 
> I have not tried to figure out anything further, except that it was
> introduced by commit b9c8e7f2f ("prefix_ref_iterator: don't trim too
> much") and it happens with
> 
>    iter->iter0->refname = "refs/bisect/bad"
>    iter->trim = 15
> 
> (where 15 is also the same as the length of that refname).
> 
> Not having time to chase this down any more, since I'm busy with the
> merge window (and that annoying bisect)

What version of git are you running? This should be fixed by 03df567fbf
(for_each_bisect_ref(): don't trim refnames, 2017-06-18) which is in
v2.14.

More discussion at

  https://public-inbox.org/git/cover.1497792827.git.mhagger@alum.mit.edu/

-Peff
