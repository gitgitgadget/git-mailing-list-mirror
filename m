Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB1C32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1333320678
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 09:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgAIJjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:39:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:60914 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729687AbgAIJjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 04:39:32 -0500
Received: (qmail 28018 invoked by uid 109); 9 Jan 2020 09:39:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Jan 2020 09:39:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16812 invoked by uid 111); 9 Jan 2020 09:45:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2020 04:45:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Jan 2020 04:39:31 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten Krah <krah.tm@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Broken branch after git commit - tracked files in staging area
 can't be removed with restore --staged, or commit or stash
Message-ID: <20200109093931.GA299671@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
 <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
 <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
 <20200108091119.GB87523@coredump.intra.peff.net>
 <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
 <20200108104008.GA2207365@coredump.intra.peff.net>
 <654cc7a58cf6947f91478411dd6a3f7f3473bc67.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <654cc7a58cf6947f91478411dd6a3f7f3473bc67.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 01:42:14PM +0100, Torsten Krah wrote:

> thanks for confirming those bugs and taking a look at my report itself
> even before I've put the small reproducer recipe.
> I don't need to take any other actions or create tickets somewhere else
> now to get those fixed, you're driving this from here, right?

Correct.

> Another question - how can I fix my broken original branch where this
> bug did hit me which is in that "bogus" state now to get back to the
> "original" commit made so I can remove my unwanted files with "git
> reset HEAD <files>" instead of git-restore in the meantime (tried your
> rm .git/index variant but after that I had files which were already in
> the branch shown as unversioned after that, so that did not work very
> well for me)?

You should be able to do:

  git checkout your-branch
  git reset --hard <original>

to go back to the state you were at (this is assuming you haven't built
more commits on top, of course), and then repeat your steps. That should
also clear out any breakage in the index, since "reset --hard" will
invalidate the cache-tree as necessary.

If you need to find the commit id of that original commit, try looking
in the reflog for your branch: git log -g your-branch

-Peff
