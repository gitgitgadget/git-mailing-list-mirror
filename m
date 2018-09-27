Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F891F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeI1Bzw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:55:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:34024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728213AbeI1Bzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:55:51 -0400
Received: (qmail 9677 invoked by uid 109); 27 Sep 2018 19:36:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 19:36:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4409 invoked by uid 111); 27 Sep 2018 19:35:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 15:35:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 15:35:59 -0400
Date:   Thu, 27 Sep 2018 15:35:59 -0400
From:   Jeff King <peff@peff.net>
To:     Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180927193559.GB6950@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
 <20180927192804.GA27163@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927192804.GA27163@rigel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 08:28:04PM +0100, Rafael Ascensão wrote:

> On Thu, Sep 27, 2018 at 02:17:08PM -0400, Jeff King wrote:
> > Do we want to limit this to git-branch, though? Ideally any output you
> > get from git-branch could be replicated with for-each-ref (or with
> > a custom "branch --format").
> > 
> > I.e., could we have a format in ref-filter that matches HEAD, but
> > returns a distinct symbol for a worktree HEAD? That would allow a few
> > things:
> 
> I was going to suggest using dim green and green for elsewhere and here
> respectively, in a similar way how range-diff uses it to show different
> versions of the same diff.

Yeah, I think that's reasonable, and would be enabled by the %(worktree)
placeholder I showed. Just like we do something like:

  %(if)%(HEAD)%(then)* %(color:green)%(else)  %(end)

now, we could do:

  %(if)%(HEAD)%(then)* %(color:bold green)
  %(else)%(if)%(worktree)%(then)+ %(color:green)
  %(else)  %(end)%(end)

(respecting the user's color config, of course, rather than hard-coded
colors).

Trying that out, though, I'm not sure if we properly support nested
if's. That might be a bug we have to fix first.

> But if we're open to change how branches are displayed maybe a config
> option like branch.format (probably not the best name choice) that can
> be set to the 'for-each-ref --format' syntax would be way more flexible.

We have that already, don't we?

> I think the different symbol and dimmed color would be a nice addition,
> but I am leaning towards giving the user the ultimate choice on how they
> want to format their output. (Maybe with dimmed plus symbol as default).

Definitely.

-Peff
