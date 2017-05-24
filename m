Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CA71FF30
	for <e@80x24.org>; Wed, 24 May 2017 14:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422923AbdEXOjw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 10:39:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57457 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422903AbdEXOjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 10:39:52 -0400
Received: (qmail 5996 invoked by uid 109); 24 May 2017 14:39:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 14:39:50 +0000
Received: (qmail 11540 invoked by uid 111); 24 May 2017 14:40:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 May 2017 10:40:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2017 10:39:48 -0400
Date:   Wed, 24 May 2017 10:39:48 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Hide decorations in git log
Message-ID: <20170524143948.orx2i26fobm7sd6n@sigill.intra.peff.net>
References: <CAHd499B+cyN=3XDqr7KgHSpyHLwi6bS=P_4beoS5fSkFhapAtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499B+cyN=3XDqr7KgHSpyHLwi6bS=P_4beoS5fSkFhapAtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 09:22:32AM -0500, Robert Dailey wrote:

> Is it possible to hide decorated refs in `git log` even if they are
> reachable from the refs I'm actually interested in seeing the logs of?

Sadly, no, there's no way to do this right now.

There was some discussion in this thread:

  http://public-inbox.org/git/20170119122630.27645-1-pclouds@gmail.com/T/#u

but no patches that do what you want.

Using the existing ref-selectors as discussed in that thread, it would
probably look something like:

  git log --oneline \
	--branches 'feature/*' --decorate-refs \
	--branches 'feature/*'

It sucks that you'd have to specify your refs twice (once to mark them
for decoration and once to use them as tips). But the flexibility would
let you do things like:

  git log --oneline \
	--branches 'feature/*' --decorate-refs \
	--tags --decorate-refs \
	HEAD

which decorates feature branches and tags, but only traverses from HEAD
(just as an example).

Anyway, none of that exists yet, so patches welcome.

-Peff
