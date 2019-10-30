Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7470B1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfJ3U2h (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:28:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:34254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726585AbfJ3U2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:28:37 -0400
Received: (qmail 28707 invoked by uid 109); 30 Oct 2019 20:28:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Oct 2019 20:28:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23631 invoked by uid 111); 30 Oct 2019 20:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Oct 2019 16:31:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Oct 2019 16:28:35 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191030202835.GB29013@sigill.intra.peff.net>
References: <20191030183950.GA21277@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191030183950.GA21277@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 11:39:50AM -0700, Denton Liu wrote:

> It seems like everyone working on git.git has their own patch management
> system. Currently, I keep all of my branch-specific configurations
> (including CC lists) and patches in a worktree within the repo so that I
> can keep my configs synced around on different computers.
> 
> One thing that's missing about this setup is that I would like to
> version my branch descriptions as well since I use those to generate
> cover letters. Unfortunately, `git branch --edit-description` only
> operates on .git/config.
> 
> As a workaround, I rewrote `git branch --edit-description` as a
> shell-script that can operate on any config file but I feel like a more
> general solution should be warranted.
> 
> Would changing the option to `git branch --edit-description[=<config>]`
> make sense, where the `<config>` is optional but if it's specified,
> it'll operate on that file instead of the .git/config.

That makes sense to me (though I don't use branch descriptions myself).
I actually wish a lot of auto-written config (like branch.*.merge) was
written to a file besides .git/config, and then just included. It would
make it easier to keep your actual config file cleaner (I usually take
the opposite route and version-control my own config in a separate file
that I include from .git/config).

> Alternately, would it make sense to support a $GIT_CONFIG environment
> variable globally? That is, when $GIT_CONFIG is specified, git will
> read/write from $GIT_CONFIG instead of .git/config? It'd be a little
> heavy-handed for me to make the change just for this one use-case but
> perhaps people may find other uses for it?

We used to have such a thing, and it opened a lot of weird corner cases.
Just thinking about the case you mentioned: would people be confused if
"GIT_CONFIG=foo git branch --edit-description" doesn't respect
core.editor specified in .git/config?

-Peff
