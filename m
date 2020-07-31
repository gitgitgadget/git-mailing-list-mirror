Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C427C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDED206DA
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGaXJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:09:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:44616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbgGaXI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 19:08:59 -0400
Received: (qmail 27421 invoked by uid 109); 31 Jul 2020 23:08:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 23:08:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2699 invoked by uid 111); 31 Jul 2020 23:08:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 19:08:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 19:08:58 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200731230858.GA1461090@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <20200729201002.GA2989059@coredump.intra.peff.net>
 <871rku3soc.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rku3soc.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 12:41:39AM +0300, Sergey Organov wrote:

> > Here's a re-roll taking into account the discussion so far:
> >
> >   - the escape hatch option name is flipped to "--no-diff-merges" (with
> >     "--diff-merges" matching "-m")
> 
> Rather than being just a synonym for -m, is there a chance for
> "--diff-merges" implementation to be turned to output diff to the first
> parent only, no matter if --first-parent is active or not?
>
> Alternatively, may it have a parameter such as "-m parent-number" of
> "git cherry-pick" being set to "1" by default?

Yes, I agree that would be a useful feature, but I don't think it needs
to be part of this series. It could be implemented as --diff-merges=1 to
show only the one against the first parent, or as its own option. But we
can add that on top.

> This -m output of diffs to all the parents is in fact primary source of
> confusion for me, even over all these mind-blowing inter-dependencies
> between --first-parent, --cc, -c, -m, -p and what not. Who ever needs
> these (potentially huge) diffs against other parents, anyway?

I've used "-m" second-parent diffs occasionally for hunting down
mismerges, etc, but I agree that most of the time you just want to see
the diff against the first parent.

> Introduction of this new option is a great opportunity for improvement
> that would be a pity to miss.

Adding an optional value to the flag is something we can do later. We
would miss the opportunity for "--diff-merges" to default to
"--diff-merges=1", but I'm not sure I'd want to do that anyway. Having
it be consistent with "-m" seems less confusing to me, and it is already
too late to change that.

If we want an option that defaults to "1", we can give it a new name.
The only thing that is lost now is that --diff-merges would already be
taken. :) But I think I'd probably call such an option "--diff-parents"
or something like that anyway.

-Peff
