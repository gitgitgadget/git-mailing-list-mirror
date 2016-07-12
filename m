Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513661FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbcGLPvr (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:51:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:43548 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753623AbcGLPvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:51:45 -0400
Received: (qmail 8921 invoked by uid 102); 12 Jul 2016 15:51:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:51:45 -0400
Received: (qmail 3986 invoked by uid 107); 12 Jul 2016 15:52:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:52:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 11:51:41 -0400
Date:	Tue, 12 Jul 2016 11:51:41 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
Message-ID: <20160712155141.GA5967@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1607090928500.6426@virtualbox>
 <20160709140931.GA3185@x>
 <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
 <alpine.DEB.2.20.1607101255300.6426@virtualbox>
 <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox>
 <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607121243470.6426@virtualbox>
 <20160712152646.GF613@sigill.intra.peff.net>
 <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 05:46:12PM +0200, Duy Nguyen wrote:

> I'm not opposed to letting one worktree see everything, but this move
> makes it harder to write new scripts (or new builtin commands, even)
> that works with both single and multiple worktrees because you refer
> to one ref (in current worktree perspective) differently. If we kill
> of the main worktree (i.e. git init always creates a linked worktree)
> then it's less of a problem, but still a nuisance to write
> refs/worktree/$CURRENT/<something> everywhere.

True. I gave a suggestion for the reading side, but the writing side
would still remain tedious.

I wonder if, in a worktree, we could simply convert requests to read or
write names that do not begin with "refs/" as "refs/worktree/$CURRENT/"?
That makes it a read/write-time alias conversion, but the actual storage
is just vanilla (so the ref storage doesn't need to care, and
reachability just works).

The trickiest thing, I think, is FETCH_HEAD, which is not really a
ref (because it may have a bunch of values, and contain extra
information).

-Peff
