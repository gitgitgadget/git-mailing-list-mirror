Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E7AC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiLLU5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 15:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiLLU47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 15:56:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658955A8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:56:58 -0800 (PST)
Received: (qmail 6430 invoked by uid 109); 12 Dec 2022 20:56:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Dec 2022 20:56:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29612 invoked by uid 111); 12 Dec 2022 20:55:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Dec 2022 15:55:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Dec 2022 15:55:42 -0500
From:   Jeff King <peff@peff.net>
To:     "Joshua J. Kugler" <joshua@azariah.com>
Cc:     git@vger.kernel.org
Subject: Re: includeIf appears to not be working
Message-ID: <Y5eVTrK2CO0h5BPl@coredump.intra.peff.net>
References: <8316344.DvuYhMxLoT@hosanna>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8316344.DvuYhMxLoT@hosanna>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 11:19:41AM -0900, Joshua J. Kugler wrote:

> Contents of ~/.gitconfig (truncated):
> 
> [user]
>         name = Joshua Kugler
>         email = joshua@personal.com
> [includIf "gitdir:~/repos/work/"]
>         path = ~/repos/work/gitconfig

Maybe a dumb question, but is this cut-and-paste verbatim? If so, then
perhaps s/includ/include/ would help?

With that change, your example works for me.

> Like I said, I've set this up before, and had it working. I don't know what 
> I'm doing differently/wrong...but would be happy to be told so.

If it's not the typo, then possibly there are symlinks involved? We'll
run realpath() on the repository directory before matching, so your
pattern needs to take that into account.

> Is there a debug command which can show if the gitdir is/isn't
> matching like I thought it should?  What other command output could
> help debug this?

No, there's no debug/tracing code for this feature. You'd have to run it
under gdb (break on the include_by_gitdir function).

-Peff
