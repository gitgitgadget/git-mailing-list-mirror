Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F3C55178
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4100B2222C
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504089AbgJ0U2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:28:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:39332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbgJ0U2B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:28:01 -0400
Received: (qmail 19083 invoked by uid 109); 27 Oct 2020 20:28:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 20:28:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22059 invoked by uid 111); 27 Oct 2020 20:28:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 16:28:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 16:27:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] fix error handling in checkout-index
Message-ID: <20201027202759.GA643305@coredump.intra.peff.net>
References: <20201027073000.GA3651896@coredump.intra.peff.net>
 <xmqq1rhjcwjk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rhjcwjk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 12:13:03PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > While working on another topic, I noticed that "git checkout-index --
> > path" does not propagate errors through its exit code. It has been that
> > way for so long that I almost wondered if it is intentional, but I'm
> > pretty sure it's not. A bit scary, though. :)
> 
> Quite honestly, at this point, I do not think the intention matters
> any more.  If somebody depends on the behaviour and wrote
> 
>     do some thing &&
>     git checkout-index -- $path_that_is_possibly_missing &&
>     do another thing &&
> 
> then this change _will_ be a regression, whether it was originally
> done this way on purpose or not.
> 
> I do not think it is the kind of regression that we should avoid,
> though.  I'd say that we should bite the bullet and fix it, as it
> should also be easy to fix/adjust such a collateral damage.  That
> would make the world a better place in the end.

Right, agreed with all of that. What I meant more with "intentional"
was: is there some really clever reason I was missing that it was done
this way in the first place? And I think the answer is "no", it was just
an oversight.

Whether it is OK to change a plumbing command's behavior is somewhat
orthogonal, but I agree it a bug fix and OK to do here.

-Peff
