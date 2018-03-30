Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E9C1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeC3RX0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 13:23:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:48908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751215AbeC3RX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 13:23:26 -0400
Received: (qmail 20905 invoked by uid 109); 30 Mar 2018 17:23:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 17:23:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29956 invoked by uid 111); 30 Mar 2018 17:24:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 13:24:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 13:23:24 -0400
Date:   Fri, 30 Mar 2018 13:23:24 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] set_work_tree: use chdir_notify
Message-ID: <20180330172324.GB18648@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net>
 <20180328174215.GC16274@sigill.intra.peff.net>
 <CACsJy8CAjb4zdAgD5H9OZOAoHdrRFzGm9gaL8Wbna+GXJJCW4Q@mail.gmail.com>
 <20180329175007.GC31833@sigill.intra.peff.net>
 <CACsJy8CdqpNOw+zdMyugX-902Z=gLNij5_xcmE4jGLRBTqiO1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CdqpNOw+zdMyugX-902Z=gLNij5_xcmE4jGLRBTqiO1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 08:01:33PM +0200, Duy Nguyen wrote:

> > I do kind of like that. I'm reasonably happy with the chdir_notify()
> > interface, but it would be nicer still if we could get rid of it in the
> > first place. It's true that we _could_ chdir from other places, but
> 
> There's another place we do, that I should mention and keep
> forgetting. Our run-command.c code allows to switch cwd, and if
> $GIT_DIR and stuff is relative then we should reparent them too just
> like we do with setup_work_tree(). Your chdir-notify makes it super
> easy to support that, we just need to move the prep_childenv() down
> below chdir(). But since nobody has complaint, I suppose that feature
> is not really popular (or at least not used to launch another git
> process anyway)

Yeah, I hadn't really considered that, since it would only matter for
environment variables, not for internal strings (which are all about to
get thrown out due to execve anyway). And my patch was just focusing on
that.

But I also wonder if rewriting the environment variables would matter
here. If we're going to chdir for a child, we'd generaly be clearing
repo-related env anyway.

-Peff
