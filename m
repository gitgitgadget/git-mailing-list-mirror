Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC61AC2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 19:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B552071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 19:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAYTzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 14:55:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:44712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729246AbgAYTzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 14:55:16 -0500
Received: (qmail 19304 invoked by uid 109); 25 Jan 2020 19:55:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 19:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20177 invoked by uid 111); 25 Jan 2020 20:02:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 15:02:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 14:55:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] merge-recursive: silence -Wxor-used-as-pow warning
Message-ID: <20200125195515.GB5519@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
 <20200125053723.GA744673@coredump.intra.peff.net>
 <xmqq4kwjcupj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kwjcupj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 09:27:36AM -0800, Junio C Hamano wrote:

> > So let's keep the bit-flipping, but let's also put it behind a named
> > function, which will make its purpose a bit clearer. This also has the
> > side effect of suppressing the warning (and an optimizing compiler
> > should be able to easily turn it into a constant as before).
> 
> OK.  Now I see you named it flip_stage(), which is even better than
> "the-other-side" above.  Makes sense.
> 
> I still think ((2 + 3) - two_or_three_to_be_flipped) easier to
> reason about than the bit flipping, as the implementation detail,
> though.

Yeah, the existing one relies on the coincidence that the two stages
differ by a single bit (in another universe, they could well be stages
"3" and "4").

I don't overly care on the implementation either way, since it's now
hidden in the helper. I mostly chose the bit-flip to match the existing
code, but I'd be happy to change it. Other people who actually work on
merge-recursive may have other opinions, though.

-Peff
