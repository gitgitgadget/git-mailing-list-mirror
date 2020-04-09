Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7CDC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F157A206E9
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 23:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgDIXMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:12:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:38806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726734AbgDIXMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 19:12:54 -0400
Received: (qmail 22375 invoked by uid 109); 9 Apr 2020 23:12:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 23:12:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24003 invoked by uid 111); 9 Apr 2020 23:23:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 19:23:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 19:12:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Norbert Kiesel <nkiesel@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [git 2.26] stat counts reported by commit and log are different
Message-ID: <20200409231253.GA4180345@coredump.intra.peff.net>
References: <CAM+g_Nv4UqQNAuYyo5zsTsiomCe4ueoM6ZGU1aqAjLGV9+jQJg@mail.gmail.com>
 <20200409135959.GB3494212@coredump.intra.peff.net>
 <CAM+g_NuZ3pKAd80+HoR8-_0=N9wV28L-yyb1VhJhTbYH+RS0og@mail.gmail.com>
 <20200409224747.GA4173825@coredump.intra.peff.net>
 <xmqq8sj4mfq5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sj4mfq5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 03:55:30PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It might make sense to do so (and/or to make it possible to enable it by
> > config like we did for years with diff.renames). But it definitely is
> > way more expensive.
> > ...
> > So not quite as bad percentage-wise, but still pretty expensive. And for
> > not a huge benefit. There are ~261 impacted commits. You can see a
> > recent example with:
> >
> >   git show -B -M --stat --summary ce6521e44
> >
> > where we find that most of builtin/fmt-merge-msg.c was moved to
> > fmt-merge-msg.c. It's nice, but it's expensive enough that it probably
> > shouldn't be the default.
> 
> Not only that, it can cost correctness-wise.  Until this
> 
>   https://public-inbox.org/git/xmqqegqaahnh.fsf@gitster.dls.corp.google.com/
> 
> gets corrected, it is not advisable to enable -B and -M at the same
> time.

Ah, I forgot about that. I think the resulting diff might still be
useful for a human to read, but yeah, it cannot be applied (though even
there, it would be nice for it to make a little more clear to humans
what's happening with the destination file).

I wonder if we ought to remove -B from its use in status/commit, but I
guess there we are never generating a diff to apply, but rather one to
help humans understand what happened.

-Peff
