Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0EB41FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbcFPJsU (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:48:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:55547 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754022AbcFPJsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:48:18 -0400
Received: (qmail 10529 invoked by uid 102); 16 Jun 2016 09:48:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:48:18 -0400
Received: (qmail 14560 invoked by uid 107); 16 Jun 2016 09:48:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:48:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:48:16 -0400
Date:	Thu, 16 Jun 2016 05:48:16 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Brian Lalor <blalor@bravo5.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: bug: compactionheuristic config var case issue
Message-ID: <20160616094815.GH15851@sigill.intra.peff.net>
References: <8C006106-EED2-48B5-B9A5-6FCEB64597C1@bravo5.org>
 <CACsJy8Dp_s9avkkA4x=EfTjkObBNF8sB3zhkdgXmjkipDNdvNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8Dp_s9avkkA4x=EfTjkObBNF8sB3zhkdgXmjkipDNdvNw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 15, 2016 at 07:33:31PM +0700, Duy Nguyen wrote:

> On Wed, Jun 15, 2016 at 5:39 PM, Brian Lalor <blalor@bravo5.org> wrote:
> > I’m very happy to see the new compaction heuristic option; it’s the way I always thought diffs should read!
> >
> > The config option in the documentation references
> > “diff.compactionHeuristic”, but diff.c does a case-sensitive
> > comparison on “diff.compactionheuristic” (note the case of the “h”
> > in “heuristic”)
> 
> I think this misled you. All configuration variable names are
> lower-cased before they reach that strcmp() call, the whole picture is
> more like strcmp(tolower(var), "diff.compactionheuristic"), which I
> believe is correct.

Yep, that is correct. Config keys are case-insensitive (except for the
middle portion "Y" of a key like "X.Y.Z"), and the downcasing happens
before they even hit the config callbacks.

> > and `git diff` does not honor the config.  Confusingly, `git config
> > diff.compactionheuristic` returns true when diff.compactionHeuristic
> > is set in ~/.gitconfig.  When diff.compactionheuristic is set to
> > true in ~/.gitconfig, the desired behavior is achieved.

Brian, do you have a case you can share where it is not working as
expected?

Config isn't enabled automatically for plumbing commands like diff-tree.
So some commands may not respect it, but "git diff" definitely should.

-Peff
