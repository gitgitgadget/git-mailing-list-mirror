Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13325C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 18:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjC3SR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjC3SRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 14:17:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320BEF93
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:17:19 -0700 (PDT)
Received: (qmail 29963 invoked by uid 109); 30 Mar 2023 18:17:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Mar 2023 18:17:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19896 invoked by uid 111); 30 Mar 2023 18:17:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Mar 2023 14:17:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Mar 2023 14:17:16 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     git@vger.kernel.org
Subject: Re: `git gc` says "unable to read" but `git fsck` happy
Message-ID: <20230330181716.GA3286761@coredump.intra.peff.net>
References: <jwvfs9nusjm.fsf-monnier+Inbox@gnu.org>
 <20230329233735.GD2314218@coredump.intra.peff.net>
 <jwvfs9mz9n7.fsf-monnier+Inbox@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jwvfs9mz9n7.fsf-monnier+Inbox@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2023 at 09:01:39AM -0400, Stefan Monnier wrote:

> > If it is the same problem (which would be a blob or maybe cached tree
> > missing in one of the worktree's index files), then probably you'd
> > either:
> >
> >   1. Accept the loss and blow away that worktree's index file (or
> >      perhaps even the whole worktree, and just recreate it).
> 
> Hmm... the problem is "that": I have about a hundred worktrees for
> this repository.
> But yes, I can just throw away all those `index` files, I guess.

If you try "git fsck" from the tip of master, it should identify the
worktree index that is the source of the problem, I think. You might
need to pass "--name-objects".

> >      (assuming that the file itself is still hanging around).
> > The original corruption bug itself (gc not taking into account worktree
> > index files) has been fixed for a while, so the theory is that this can
> > be lingering corruption from a repack by an older version of Git. But if
> > you have evidence to the contrary, we'd like to hear that, too. ;)
> 
> My suspicion is that the origin of the broken state is elsewhere (maybe
> a power failure?) because the problem appeared "simultaneously" (a few
> days apart, really) for two different repositories.

Hmm. I wouldn't expect that to happen specifically with this worktree
thing, but of course many bets are off with power failures.

-Peff
