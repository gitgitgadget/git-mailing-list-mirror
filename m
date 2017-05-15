Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EFA201A4
	for <e@80x24.org>; Mon, 15 May 2017 03:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdEODSg (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 23:18:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51658 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdEODSg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 23:18:36 -0400
Received: (qmail 18930 invoked by uid 109); 15 May 2017 03:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 03:18:34 +0000
Received: (qmail 12735 invoked by uid 111); 15 May 2017 03:19:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 23:19:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 May 2017 23:18:31 -0400
Date:   Sun, 14 May 2017 23:18:31 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Hagins <hagins.josh@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] config: complain about --local outside of a git repo
Message-ID: <20170515031831.c4wrhgm7gky3dldw@sigill.intra.peff.net>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
 <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
 <CANuW5x2-gzHuPN9ox8hEgNUiTsEKeAqeZQXZZ=SMFbsfabXd1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANuW5x2-gzHuPN9ox8hEgNUiTsEKeAqeZQXZZ=SMFbsfabXd1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 14, 2017 at 08:31:54PM -0400, Josh Hagins wrote:

> For context, the "user.name" bit was purely notional; I just wanted to
> give a sample reproduction. Where I've actually been running into this
> in real life is with oh-my-git, a GitHub-themed Powerline bash prompt:
> https://github.com/arialdomartini/oh-my-git/blob/42c11f08540949b75bd513e6880a4ce6824a2bcc/base.sh#L52.
> 
> Since this command is invoked every time the prompt is build, I see
> the error message after every single command I run outside of a Git
> repository. While this is more indicative of a code smell in
> oh-my-git, I figured that, as you said, BUG assertions should never
> get hit in the wild. Thanks for the patch!

Ah, thanks for the context. That makes a lot more sense. I do think
oh-my-git should just drop the "--local", which will cause git-config to
follow the usual precedence rules (and it will skip repo-level config
automatically when we are not in a repo).

Since the oh-my-git code only looks for "false", nobody would ever need
to default the value to true in their ~/.gitconfig. But respecting the
usual config rules would mean you could set it to "false" in
~/.gitconfig to turn it off everywhere, but then opt back into it for
specific repos by setting it to "true" there. Probably not a use case
anybody cares that much about, but it's how "git config" was meant to be
used. :)

Anyway, thanks again for reporting the BUG assertion. I'm glad to be
weeding out more cases.

-Peff
