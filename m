Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2831F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 07:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfJMHPC (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 03:15:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:46882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727738AbfJMHPC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 03:15:02 -0400
Received: (qmail 5904 invoked by uid 109); 13 Oct 2019 07:15:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Oct 2019 07:15:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15872 invoked by uid 111); 13 Oct 2019 07:17:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Oct 2019 03:17:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Oct 2019 03:15:01 -0400
From:   Jeff King <peff@peff.net>
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     James Coglan <jcoglan@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Improve the readability of log --graph output
Message-ID: <20191013071500.GA30652@sigill.intra.peff.net>
References: <pull.383.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 09:13:42AM -0700, James Coglan via GitGitGadget wrote:

> A final addition to that set of changes fixes the coloring of dashes that
> are drawn next to octopus merges, in a manner compatible with all these
> changes. The early commits in this set are refactorings that make the
> functional changes easier to introduce.

As somebody who has pondered the octopus coloring code (for an
embarrassingly long time considering that it still has some bugs!), let
me just say thank you for taking this on. :)

Moreover, I'll echo Dscho's comments elsewhere on the quality of this
series. It's a tricky topic to explain, and the way you've broken it up,
along with the commit messages, comments, and diagrams made it much
easier to follow.

Others have already commented on things I saw while reading it, so I'll
just add a few more thoughts.

> This series of patches are designed to improve the output of the log --graph
> command; their effect can be summed up in the following diagram:
> 
>     Before                    After
>     ------                    -----
> 
>     *
>     |\
>     | *                       *
>     | |\                      |\
>     | | *                     | *
>     | | |                     | |\
>     | |  \                    | | *
>     | *-. \                   | * |
>     | |\ \ \                  |/|\|
>     |/ / / /                  | | *
>     | | | /                   | * |
>     | | |/                    | |/
>     | | *                     * /
>     | * |                     |/
>     | |/                      *
>     * |
>     |/
>     *

I wondered if anybody would prefer the sparseness of the "before"
diagram, and if that would merit having two modes that could selected at
runtime. I'm not sure I'd want to carry the code for both types, though;
it seems like a recipe for the non-default output format to accrue a
bunch of bugs (since the graph code has proven itself to be a magnet for
off-by-ones and other weirdness).

Diffing the output of "git diff --color --graph --oneline" on git.git
both before and after your patch, the changes all look generally
positive to me. The graph above is pretty dense, but that's not really
what real-world graphs look like; it was designed to show off the
changes.

That plus the fact that you're fixing real bugs (like the octopus
coloring) makes me inclined to just move to your suggested output.

-Peff
