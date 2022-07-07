Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A352DC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiGGScV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiGGScH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:32:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940985C96B
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:30:00 -0700 (PDT)
Received: (qmail 6406 invoked by uid 109); 7 Jul 2022 18:29:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 18:29:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3333 invoked by uid 111); 7 Jul 2022 18:29:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 14:29:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 14:29:16 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t0301-credential-cache test failure on cygwin
Message-ID: <Yscl/Jx4g74RwkCK@coredump.intra.peff.net>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 07, 2022 at 04:17:08PM +0100, Ramsay Jones wrote:

> Also, I would like to understand why the code is written as it is
> currently. I'm sure there must be a good reason - I just don't know
> what it is! I suspect (ie I'm guessing), it has something to do with
> operating in a high contention context [TOCTOU on socket?] ... dunno. ;-)

By the way, I was slightly surprised you did not find the explanation in
the commit history. A blame[1] of credential-cache--daemon.c shows that
the comment was added by 7d5e9c9849 (credential-cache--daemon: clarify
"exit" action semantics, 2016-03-18) which mentions the race in the
tests. And then searching for that commit message in the list yields the
thread I linked earlier with more context[2].

I mention this not as a criticism, because your digging for backstory
was otherwise quite thorough. It's only _because_ it was so thorough
that I was surprised you didn't find that commit. ;) So I offer it only
as a suggestion for future digging.

-Peff

[1] Likewise this works:

       git log --follow -S'important that we clean up' builtin/credential-cache--daemon.c

    but the --follow is necessary because of the rename when it became a
    builtin. It's cool that "blame" handles this seamlessly. :)

[2] Finding the original patch on the list is my go-to trick when a
    commit message hasn't sufficiently explained things. I know Junio
    was for a while (is still?) kept a git-notes mapping of commits to
    emails. In practice, I usually just do a manual search for a few
    unique-looking phrases from the commit message. That should be
    pretty easy with lore these days, though I do it with a local
    archive indexed by notmuch.

-Peff
