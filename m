Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547CBC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 03:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19829239EB
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 03:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgI1DTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 23:19:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:42874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgI1DTW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 23:19:22 -0400
Received: (qmail 2621 invoked by uid 109); 28 Sep 2020 03:19:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2020 03:19:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3619 invoked by uid 111); 28 Sep 2020 03:19:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 23:19:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 23:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 5/8] shortlog: de-duplicate trailer values
Message-ID: <20200928031921.GB3059492@coredump.intra.peff.net>
References: <20200927083933.GA2222823@coredump.intra.peff.net>
 <20200927084007.GE2465761@coredump.intra.peff.net>
 <xmqqh7rjnf42.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7rjnf42.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 01:23:25PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The current documentation is vague about what happens with
> > --group=trailer:signed-off-by when we see a commit with:
> >
> >   Signed-off-by: One
> >   Signed-off-by: Two
> >   Signed-off-by: One
> >
> > We clearly should credit both "One" and "Two", but should "One" get
> > credited twice? The current code does so, but mostly because that was
> > the easiest thing to do.
> 
> I thought that "the current documentation" as of step 4/8 were quite
> clear about double counting ;-).

It was clear to me that the commit would be counted at least twice: once
for the "one" bucket and once for the "two" bucket, but not that it
would count twice for the "two" bucket. Or at least, I didn't think of
this issue at all back when I wrote the original patch long ago, and
only noticed the problem when I revisited it. :)

Anyway, I think the semantics at the end of the series are quite
sensible.

-Peff
