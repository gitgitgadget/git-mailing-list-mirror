Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EC82095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbdCURei (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:34:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:48723 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932606AbdCURdm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:33:42 -0400
Received: (qmail 8321 invoked by uid 109); 21 Mar 2017 17:33:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 17:33:39 +0000
Received: (qmail 16689 invoked by uid 111); 21 Mar 2017 17:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 13:33:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 13:33:35 -0400
Date:   Tue, 21 Mar 2017 13:33:35 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick --message?
Message-ID: <20170321173335.n56veklbh4iginoa@sigill.intra.peff.net>
References: <20170321160520.GA15550@inner.h.apk.li>
 <20170321170005.35ryjh4pr3jvvmx3@sigill.intra.peff.net>
 <20170321170734.GI28331@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321170734.GI28331@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 06:07:34PM +0100, Andreas Krey wrote:

> > There's "cherry-pick --edit".
> 
> Yes, but. I'm in a toolchain, not a user. I'm a command that let
> the user cherry-pick specific things, and I need to edit out the things
> that made the original commit eligible to be picked in the first place.
> 
> Can't quite rely on the tool's user to do that. :-(
> 
> I'm not familiar with the plumbing to know where to look there.

You can do:

  GIT_EDITOR='sed -i d/^PROP:/' git cherry-pick --edit

but if there's a conflict, the user has resume it with that environment
variable set. If you can rely on the user using your tool, that might
work. If they might run arbitrary git commands, then no.

Probably "format-patch | sed | am -3" is your best bet if you want to
modify the patches in transit _and_ have the user just use normal git
tools.

-Peff
