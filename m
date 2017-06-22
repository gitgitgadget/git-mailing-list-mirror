Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99B6020802
	for <e@80x24.org>; Thu, 22 Jun 2017 23:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753827AbdFVXSr (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:18:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753772AbdFVXSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:18:46 -0400
Received: (qmail 31113 invoked by uid 109); 22 Jun 2017 23:18:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 23:18:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7070 invoked by uid 111); 22 Jun 2017 23:18:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 19:18:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 19:18:44 -0400
Date:   Thu, 22 Jun 2017 19:18:44 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Move unquote_path() from git-add--interactive.perl
 to Git.pm
Message-ID: <20170622231844.d3fdo6c367h3ldve@sigill.intra.peff.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170622102622.26147-1-phillip.wood@talktalk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 11:26:17AM +0100, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> I'm using this in some scripts and it would be more convenient to have
> it available from Git.pm rather than copying and pasting it each time
> I need it. I think it should be useful to other people using Git.pm as
> well. It is not uncommon to get a quoted path back from a command that
> needs to be passed on the commandline of another command. While one
> can use -z in many cases, that leaves the problem of having to quote
> the path when printing it in error messages etc.

Grepping around the calls to unquote_path in add--interactive, I
definitely think many of them ought to be using "-z". But I don't think
that's a reason not to make unquote_path() more widely available. It
_is_ generally useful.

The changes look sane to me. My biggest question is how add--interactive
handles the exceptions thrown by the refactored function on error. Since
these paths are coming from Git, it should be something never comes up,
right? So failing hard is probably the best thing to do.

-Peff
