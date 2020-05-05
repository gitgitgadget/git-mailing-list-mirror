Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49088C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5A520663
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgEESYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:24:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:38124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730258AbgEESYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:24:19 -0400
Received: (qmail 14308 invoked by uid 109); 5 May 2020 18:24:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 18:24:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 668 invoked by uid 111); 5 May 2020 18:24:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 14:24:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 14:24:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200505182418.GA66702@coredump.intra.peff.net>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 10:57:39AM -0700, Junio C Hamano wrote:

> Would it be too much hassle to use notes for a thing like this?
> Perhaps push out with refs/notes/skip-ci note attached to a commit
> you do not want to be built?  I have a feeling that it gives way
> overkill flexibility with little gain (probably too cumbersome to
> manage).

I think using notes would be a hassle. This config is really associated
with a branch, not a particular config (so you'd have to make sure they
propagate across rebases, etc).

But _if_ we can read from other refs in the repository, I would be very
happy if we parsed config out of refs/ci/branches or something. It feels
like that's something that ought to be possible, but I haven't quite
figured out a way to do it.

Really all we want is some kind of per-repo variable storage where the
values aren't baked into the tree. There is a "secrets" system that can
be used for this, though it kind of feels like an abuse of the concept.

> Does push into GitHub repository offer an ability to pass arbitrary
> push option, to which actions that trigger "on: push" event can
> react?

No, I don't think so.

-Peff
