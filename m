Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A88C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBC760F35
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhHPQ5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:57:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:48598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhHPQ5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:57:37 -0400
Received: (qmail 20710 invoked by uid 109); 16 Aug 2021 16:57:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 16:57:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16127 invoked by uid 111); 16 Aug 2021 16:57:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 12:57:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 12:57:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
Message-ID: <YRqY4Tw4YxbepuFg@coredump.intra.peff.net>
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
 <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
 <20210813180056.ctzivmakj4bj5apa@nitro.local>
 <xmqq35rbtx84.fsf@gitster.g>
 <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
 <YRqQJTyBW6j6b2pW@coredump.intra.peff.net>
 <xmqq4kbps58l.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kbps58l.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 09:51:06AM -0700, Junio C Hamano wrote:

> >> tls -> starttls
> >> ssl -> smtps
> >> 
> >> This way we don't have to change anything, and "smtps" is a valid way to refer
> >> to smtp over ssl (e.g. see /etc/services for 465/tcp).
> >
> > FWIW, those options make quite a bit of sense to me (and I agree the
> > transition to them would be easy).
> 
> Back when we had the original discussion in April [*], I think we
> found one small glitch that we need to solve before we can start
> introducing aliases---setting the variable to unknown value (imagine
> you set it to 'starttls' and then run a version of Git that does not
> know it yet) does not make Git barf but silently ignore.
> 
> And that needs to be changed to die, and versions of Git with such a
> change, without any alias added, should be allowed to spread to
> eradicate the "silently ignore" version, before we can safely start
> adding aliases.

This is certainly unfortunate, but IMHO is not a hard requirement for
adding new values. This is no different than a case where we add a new
config option, but old versions of Git quietly ignore it.

In other words, I would suggest to tighten this as the values are added,
but not worry about having a "spreading" period.

-Peff
