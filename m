Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53BAC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F15661058
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKCLpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 07:45:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:52110 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhKCLpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 07:45:25 -0400
Received: (qmail 5034 invoked by uid 109); 3 Nov 2021 11:42:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Nov 2021 11:42:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18564 invoked by uid 111); 3 Nov 2021 11:42:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 07:42:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 07:42:36 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix rewording with
 --committer-date-is-author-date
Message-ID: <YYJ1rA8F22SSBeNS@coredump.intra.peff.net>
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
 <YYG8aq85UmMMVW4l@coredump.intra.peff.net>
 <101071b2-0b7d-5ee8-ca81-171e08a1ffdf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <101071b2-0b7d-5ee8-ca81-171e08a1ffdf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 11:23:28AM +0000, Phillip Wood wrote:

> > That description makes sense, and the patch matches. Not being that
> > familiar with this area, my biggest question would be: are there are
> > other cases that would need the same treatment? And is there a way we
> > can make it easier to avoid forgetting such a case in the future?
> 
> I don't think there are any other cases (but then I thought that when I
> wrote the buggy patch...). The only time we change the authorship is if the
> user passes --committer-date-is-author-date or --reset-author-date. I agree
> it would be good to have a way to avoid this problem in the future but I
> haven't come up with an easy way to do that. One possibility would be to go
> back to always reading the author script. That would mean revisiting the
> changes to do_merge() in baf8ec8d3a so that it always writes the author
> script and .git/MERGE_MSG but removes them when fast-forwarding (the problem
> that baf8ec8d3a tried to solve was a left over .git/MERGE_MSG when
> do_merge() fast-forwarded) I don't want to do that in the rc window though.

I suspected the answers to my questions were "I hope so" and "not
really", which I think matches what you wrote. :)

If there isn't an easy way to make it more future-proof, then I'm
content that you've given it some thought and didn't find any other
cases. We can proceed from here with this fix, and be on the lookout for
any other cases that people report (on the plus side, the BUG() made it
quite obvious that there was a problem, rather than a subtle behavior
change).

> Thanks for your comments, are you happy for this to go in as is or should I
> look at simplifying the conditional?

I'm happy enough with it. I don't know what the plan is for the -rc
period, though. AFAICT the bug is in v2.33.1, so it's not technically a
v2.34-rc problem. It could wait for the next maint release.

-Peff
