Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E62DC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F83760ED4
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbhH3SRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:17:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:34052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238150AbhH3SQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:16:59 -0400
Received: (qmail 489 invoked by uid 109); 30 Aug 2021 18:16:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 18:16:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8884 invoked by uid 111); 30 Aug 2021 18:16:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 14:16:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 14:16:04 -0400
From:   Jeff King <peff@peff.net>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     git@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <YS0gZNRqz72hs/a5@coredump.intra.peff.net>
References: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 07:11:49PM +0300, Kirill A. Shutemov wrote:

> I've stepped on a problem after upgrading git to v2.33.0. git fetch-pack
> fails with an error:
> 
>         fetch-pack: unexpected disconnect while reading sideband packet
> 
> It only happens when I access git.kernel.org over git:// (github over
> git:// works fine) and if there's a gitproxy configured.
> 
> For test I used a dummy gitproxy:
> 
>         #!/bin/sh -efu
>         socat - "TCP:$1:$2"
> 
> It is enough to trigger the issue.
> 
> I'm not sure if it's kernel.org problem or git problem.
> 
> Has anybody else stepped on the issue? Any clues?

I can't reproduce the problem here, using core.gitproxy with a script
identical to what you showed above. I tried both cloning, and fetching
via both git-fetch and git-fetch-pack.

Can you show us a more complete example? What does the command that
fails look like? What's the repo state before you run it? At what part
of the conversation does it fail (before a pack is sent, during, or
after)?

If you can reproduce it at will and it fails on 2.33 but not earlier,
then bisecting might be helpful.

-Peff
