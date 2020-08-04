Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D9C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53B0207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgHDWOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:14:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:48394 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHDWOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:14:41 -0400
Received: (qmail 6560 invoked by uid 109); 4 Aug 2020 22:14:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 22:14:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17122 invoked by uid 111); 4 Aug 2020 22:14:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 18:14:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 18:14:40 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200804221440.GC2022650@coredump.intra.peff.net>
References: <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
 <20200803180824.GA2711830@coredump.intra.peff.net>
 <874kpi47xj.fsf@osv.gnss.ru>
 <xmqqbljqrydm.fsf@gitster.c.googlers.com>
 <20200804200018.GB2014743@coredump.intra.peff.net>
 <877due1688.fsf@osv.gnss.ru>
 <20200804212201.GA2020725@coredump.intra.peff.net>
 <xmqq3652rs84.fsf@gitster.c.googlers.com>
 <878seuxdz8.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878seuxdz8.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 01:06:51AM +0300, Sergey Organov wrote:

> > For now, "off" is OK, but then we'll regret when "all" comes,
> > because "off" would not exactly sit opposite to "all".
> 
> IMHO, "off" does not need to be opposite for "all", as it suppresses
> diff output altogether. I read --diff-merge=off as "turn /off/ diff
> output for merge commits".
> 
> Besides, "all", that I don't like either, is among "c" and "cc", all 3
> being different versions of diffs against all the parents, no?

I think "all-parents" is much more descriptive than "all" (which might
make you think "all merges", but it has nothing to do with that). It
would make more sense if we later add the building to say "diff against
parent 1" or "diff against parents 1 and 3".

You might also consider whether "combined" is actually mutually
exclusive with parent selection. We have focused on which parents you'd
want to "-m" against. But in the most general case, you could ask for a
combined-diff between parents 1 and 3 of an octopus merge.

That's just coming from the angle of "what is the most general and
orthogonal set of features". I think the vast majority of what anyone
would want to do would be covered by doing a diff against only a single
parent, and then it would almost always be the first parent. And
certainly you'd need to add a bunch of code to the combined diff
machinery to make it support arbitrary sets of parents. So this probably
isn't that interesting a direction to go, at least for now. I'm just
raising the issue now because we'll be locked into the semantics of this
option, which may not be able to express the full set of what's possible
(so we'd be stuck adding another option later).

-Peff
