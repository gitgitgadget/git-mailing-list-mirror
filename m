Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075E61FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 12:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbdDLMxp (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 08:53:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:60610 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbdDLMxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 08:53:44 -0400
Received: (qmail 18503 invoked by uid 109); 12 Apr 2017 12:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 12:53:43 +0000
Received: (qmail 12106 invoked by uid 111); 12 Apr 2017 12:54:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 08:54:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Apr 2017 08:53:40 -0400
Date:   Wed, 12 Apr 2017 08:53:40 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
Message-ID: <20170412125340.do7m2pjyignw6fjh@sigill.intra.peff.net>
References: <20170409022128.21337-1-danny@dannysauer.com>
 <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
 <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
 <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net>
 <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 01:30:31PM +0700, Duy Nguyen wrote:

> On Tue, Apr 11, 2017 at 12:13 AM, Jeff King <peff@peff.net> wrote:
> > On Mon, Apr 10, 2017 at 07:01:00PM +0700, Duy Nguyen wrote:
> >> An alternative is, when you have found out you need to read .mailmap,
> >> you call setup_work_tree() then, which prepares the worktree for you
> >> (including moving back to cwd) or dies if worktree does not exist, or
> >> no-op if worktree has already been asked by somebody. Many commands do
> >> lazy worktree initialization this way.
> >
> > I think this is much more than just .mailmap, though. For instance, I
> > have noticed a similar problem with .gitattributes:
> 
> Urgh. assuming that we should not read .gitattributes if there's no
> worktree to read from (similar to the "defaults to .git" situation),
> how about
> 
>  - if mailmap stuff is requested, setup worktree, or die trying
>  - if worktree is detected, but setup code does not jump to it, do it
>  - if no worktree is detected, tell git-log to stop reading .gitattributes
> 
> We probablly want some "if no wotktree then die()" in .gitattributes
> and .gitignore code, just in case it's incorrectly and accidentally
> executed in exotic setup

I didn't check what we do with attributes when there is no worktree. The
behavior you describe above sounds right. But note that in my test we
_do_ have a worktree, but just look in the wrong location. So doing a
chdir to $GIT_WORK_TREE would just work.

-Peff
