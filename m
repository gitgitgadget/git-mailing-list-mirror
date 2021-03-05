Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA45C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C287E650A0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCEXUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:20:10 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:50467 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEXTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 18:19:52 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 6E4D33B25A8;
        Fri,  5 Mar 2021 23:06:57 +0000 (UTC)
X-Originating-IP: 50.39.163.217
Received: from localhost (unknown [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3183DFF802;
        Fri,  5 Mar 2021 23:06:33 +0000 (UTC)
Date:   Fri, 5 Mar 2021 15:06:31 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: A note on the 5.12-rc1 tag
Message-ID: <YEK5d+8TSqS/rdMu@localhost>
References: <CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com>
 <YEFIXFyP5tWrPDMw@localhost>
 <CAP8UFD07ezNOXU5Q3RZAHOJGMjuaJY-R=x=hhQcQvYOAKzKF2g@mail.gmail.com>
 <xmqq8s71bhfm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8s71bhfm.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 10:10:05AM -0800, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> >> (git notes would be nice for this, but they're hard to share reliably;
> >> the above mechanism to accumulate entries from a file in the repo seems
> >> simpler. I can imagine other possibilities.)
> >
> > If the notes are created automatically from the `/.git-bisect-skip`
> > files and stored in `refs/notes/skip`, then they might not need to be
> > shared. If people already share notes, they would just need to stop
> > sharing those in `refs/notes/skip`.
> 
> Ehh, doesn't Josh _want_ to share them, though?  I do not know if a
> single "refs/notes/bisect-skip" notes would do, or you'd need one
> notes tree per the kind of bisection (iow, people may be chasing
> different set of bugs, and the commits that need to be skipped while
> chasing one bug may be OK to test while chasing another one), but I
> would imagine that for this particular use case of marking "these
> commits are dangerous to check out and build on", it does not depend
> on what you are bisecting to find at all, so sharing would be a
> sensible thing to do.
> 
> It is trivial for you to fetch the refs/notes/do-not--checkout notes
> tree from me and merge it into your refs/notes/do-not--checkout
> notes tree, I would think; "git notes merge" may have room for
> improvement, but essentially it would just want a union of two
> sets, no?

My primary concern about notes is that they require manual
action/configuration in order to share. I was looking for a solution
that would automatically protect anyone who pulled from linux.git
(directly or indirectly), without them having to specifically take a
separate step to sync this information.
