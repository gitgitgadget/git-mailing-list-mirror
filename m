Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77550C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 07:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbiHTHEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245060AbiHTHEj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 03:04:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08A4B0D5
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 00:04:38 -0700 (PDT)
Received: (qmail 21300 invoked by uid 109); 20 Aug 2022 07:04:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 07:04:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9280 invoked by uid 111); 20 Aug 2022 07:04:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 03:04:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 03:04:37 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/6] log-tree: drop unused commit param in remerge_diff()
Message-ID: <YwCHhUGZvcRP9OQ2@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9O2RK7ahmw5ge7@coredump.intra.peff.net>
 <CABPp-BHvscxV+vVL-Tew2H4h8V_3bZpD0Qz9uEMwrV=X3zrYSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHvscxV+vVL-Tew2H4h8V_3bZpD0Qz9uEMwrV=X3zrYSg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 04:05:06PM -0700, Elijah Newren wrote:

> > This function has never used its "commit" parameter since it was added
> > in db757e8b8d (show, log: provide a --remerge-diff capability,
> > 2022-02-02).
> >
> > This makes sense; we already have separate parameters for the parents
> > (which lets us redo the merge) and the oid of the result tree (which we
> > can then diff against the remerge result).
> [...]
> 
> Yeah, looks like I could have just used commit instead of parents and
> oid, but since the calling code had those handy, I added them directly
> and forgot to remove commit.

That makes sense (the origin of these unused parameters are all
mini-mysteries, so it's very satisfying to me to hear a plausible
explanation).

I like using the broken-down parts as you ended up with. The sole caller
does have a commit, but one doesn't _need_ to have a commit to do a
remerge diff. You just need two tips and a proposed tree result. In
theory we could have a plumbing command which takes those individually.

-Peff
