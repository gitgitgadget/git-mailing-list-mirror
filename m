Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F4EC4727C
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB493207F7
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 13:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgJANyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 09:54:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:46552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbgJANyT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 09:54:19 -0400
Received: (qmail 31732 invoked by uid 109); 1 Oct 2020 13:54:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Oct 2020 13:54:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7494 invoked by uid 111); 1 Oct 2020 13:54:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Oct 2020 09:54:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Oct 2020 09:54:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
Message-ID: <20201001135417.GA3145610@coredump.intra.peff.net>
References: <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
 <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
 <20200929003000.GA898702@coredump.intra.peff.net>
 <xmqqwo0difdh.fsf@gitster.c.googlers.com>
 <20200929004448.GD898702@coredump.intra.peff.net>
 <xmqqsgb1ier6.fsf@gitster.c.googlers.com>
 <20200929030043.GA905754@coredump.intra.peff.net>
 <xmqqeemigawq.fsf@gitster.c.googlers.com>
 <20200930223913.GB1908000@coredump.intra.peff.net>
 <xmqq5z7ug9gk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5z7ug9gk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 03:56:27PM -0700, Junio C Hamano wrote:

> > Other than those nits, I think the series is OK.
> 
> Sure.  But credential-store side is also iffy; it is not like they
> want CRLF on data lines (if they want CR in data, that needs to be
> encoded).  The only reason I can think of that the change to
> "-store" makes any difference is when people edit it, but the file
> is not designed to be manually edited, so even that part of the
> series needs a better justification.  It's not like "We want to be
> compatible" without "why it is better to be compatible" is a good
> rationale, when we define the file format not to be manually edited
> in the first place.

Yeah, I agree that just teaching git-credential's stdin to handle CR
would be an OK stopping point. I don't have a strong opinion on
credential-store's on disk format. At least allowing CRLF there is
_plausibly_ useful, unlike credential-cache--daemon's pipe. And I doubt
that making the change would hurt anybody.

-Peff
