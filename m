Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E97C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD322184D
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgI2Aou (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:44:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:43914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgI2Aou (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:44:50 -0400
Received: (qmail 6958 invoked by uid 109); 29 Sep 2020 00:44:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2020 00:44:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13658 invoked by uid 111); 29 Sep 2020 00:44:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2020 20:44:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Sep 2020 20:44:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
Message-ID: <20200929004448.GD898702@coredump.intra.peff.net>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
 <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
 <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
 <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
 <20200929003000.GA898702@coredump.intra.peff.net>
 <xmqqwo0difdh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo0difdh.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 05:41:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think that:
> >
> >   - we'd never write a raw CR ourselves, as we'd urlencode the character
> >
> >   - if somebody did put in a raw CR manually like:
> >
> >       https://example.com\r\n
> >
> >     then we'd currently fail to match "example.com". Which is probably
> >     not what they wanted. I suspect that \r in a hostname is bogus
> >     anyway (certainly curl will complain about it).
> 
> I may be misremembering, but an argument I recall against the kind
> of change we are dicussing now was that we ignore such an entry
> right now, and the user may have added an entry for the host anew,
> possibly with a more recent password.  Changing the parsing to
> ignore CR would silently resurrect such a stale entry that the user
> has written off as unused, and depending on the order of entries in
> the file, a site that used to work may start failing suddenly.

Yeah, that is probably what would happen. I have to admit that it's such
an obscure case that I'm not sure I really care. It's unlikely in
practice, and if somebody did report such a case, I think my first
response would be "well, why did you have a broken entry stuck in your
file?".

> I still don't see why we need to touch the cache-daemon, though.

Yeah, I touched on that more in another response.

-Peff
