Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71BDE20958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbdCTSzk (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:55:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:47957 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756094AbdCTSz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:55:26 -0400
Received: (qmail 16640 invoked by uid 109); 20 Mar 2017 18:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 18:55:22 +0000
Received: (qmail 4842 invoked by uid 111); 20 Mar 2017 18:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 14:55:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 14:55:18 -0400
Date:   Mon, 20 Mar 2017 14:55:18 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 2/3] stash: make push -p -q --no-keep-index quiet
Message-ID: <20170320185518.nspfukazbgmhzybd@sigill.intra.peff.net>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170319202351.8825-3-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170319202351.8825-3-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 08:23:50PM +0000, Thomas Gummerer wrote:

> Currently when using "git stash push -p -q --no-keep-index", the -q flag
> is not passed to the git reset which is executed when --no-keep-index is
> also passed in.  This means that git stash is somewhat verbose in this
> mode even when the -q flag is passed in.  This was always the case since
> "git stash save -p" was introduced in dda1f2a5 ("Implement 'git stash
> save --patch'", 2009-08-13).
> 
> Properly pass the -q flag on to git reset, to make "git stash push -p
> -q" as quiet as it should be.

Yeah, this is an obvious bug-fix. Though given my earlier response to
Junio, I wonder if we should just be doing "reset -q" unconditionally
for most of these calls.

I guess this one does say more than just "HEAD is at..."; it mentions
the files that you _didn't_ pick. Though that now makes it inconsistent
with the pathspec case, especially if you do:

  git stash push -p --no-keep-index -- one

which will mention "two" as remaining with unstaged changes.

-Peff
