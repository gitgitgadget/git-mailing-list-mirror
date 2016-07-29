Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448F01F955
	for <e@80x24.org>; Fri, 29 Jul 2016 15:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbcG2PuU (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 11:50:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:51054 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751604AbcG2PuR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 11:50:17 -0400
Received: (qmail 30288 invoked by uid 102); 29 Jul 2016 15:50:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 11:50:16 -0400
Received: (qmail 2385 invoked by uid 107); 29 Jul 2016 15:50:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 11:50:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 11:50:12 -0400
Date:	Fri, 29 Jul 2016 11:50:12 -0400
From:	Jeff King <peff@peff.net>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
Message-ID: <20160729155012.GA29773@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 05:37:08PM -0700, Linus Torvalds wrote:

> > and then to sprinkle calls liberally through builtin-ified programs when
> > they move from one unit of work to the next.
> 
> Maybe we can just add it to the end of commit_tree_extended(), and
> just say "the cache is reset between commits".
> 
> That way there is no sprinking in random places.

Hmm, yeah, that might work. As you mentioned, there are cases where we
really do want the timestamps to match (especially between author and
committer). So we would not want this reset to kick in where callers
would not want it.

So I'm trying to play devil's advocate and think of a case where
somebody would not want the time reset after creating a commit.

One obvious impact would be reflog entries, since we would reset the
time between the object creation and the ref write (so your reflog entry
would sometimes be a second or more after the commit time it writes).
I'm not sure how much anybody _cares_ about that; they're much less
intimate than author/committer times.

-Peff
