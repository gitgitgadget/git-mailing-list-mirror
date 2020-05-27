Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D1C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487F2207CB
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbgE0Rby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:31:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:57692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgE0Rby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:31:54 -0400
Received: (qmail 22956 invoked by uid 109); 27 May 2020 17:31:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 17:31:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5473 invoked by uid 111); 27 May 2020 17:31:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 13:31:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 13:31:52 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        =?utf-8?B?J1JlbsOp?= Scharfe' <l.s.r@web.de>,
        'Dana Dahlstrom' <dahlstrom@google.com>, git@vger.kernel.org
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
Message-ID: <20200527173152.GA4019609@coredump.intra.peff.net>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
 <ad267e83-eea0-bb78-d88c-a37a28d04dbe@web.de>
 <xmqqimglqpga.fsf@gitster.c.googlers.com>
 <20200527065210.GC4005121@coredump.intra.peff.net>
 <xmqqimghmlgk.fsf@gitster.c.googlers.com>
 <022e01d6343e$d6c045b0$8440d110$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <022e01d6343e$d6c045b0$8440d110$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 11:52:28AM -0400, Randall S. Becker wrote:

> On May 27, 2020 11:44 AM, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Sun, May 24, 2020 at 09:15:33AM -0700, Junio C Hamano wrote:
> > >
> > >> So, should we allow a random upstream & start-point combination?  It
> > >> appears to me that as long as they share _some_ common ancestory, it
> > >> may make sense.
> > >
> > > But wouldn't just about any two tips in a repository share some common
> > > ancestry?
> > 
> > Yes, we are on the same page; the above was my round-about way to say
> > that it does not look useful to restrict the allowed combination in order to
> > give us some safety.
> 
> I have seen some strange ones, as part of migrating from other SCM
> solutions to git, where there were two completely unrelated histories
> - at least temporarily until stitched together towards the end of the
> migration. I don't think the assumption about common ancestry holds
> generally. I might have misunderstood, though.

No, I don't think you've misunderstood. It does happen, and there's even
an example in git.git. Doing:

  git checkout -b new-branch --track=origin/todo origin/master

would be nonsense. But it's a rare enough case that I don't think it's
worth worrying too much about. Plus it's pretty easy to undo, or at
least no harder than lots of other mistakes (e.g., trying to rebase on
the wrong branch).

-Peff
