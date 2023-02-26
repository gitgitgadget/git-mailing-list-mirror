Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D96C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 10:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBZK3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 05:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZK3e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 05:29:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42623269A
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 02:29:33 -0800 (PST)
Received: (qmail 28680 invoked by uid 109); 26 Feb 2023 10:29:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Feb 2023 10:29:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29428 invoked by uid 111); 26 Feb 2023 10:29:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Feb 2023 05:29:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 26 Feb 2023 05:29:29 -0500
From:   Jeff King <peff@peff.net>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] rebase -i: match whole word in is_command()
Message-ID: <Y/s0iV5cS9fJ2ONl@coredump.intra.peff.net>
References: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
 <b050e7c1a4daf6c65aa9b2b6f44248d7b403918e.1677185702.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b050e7c1a4daf6c65aa9b2b6f44248d7b403918e.1677185702.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 08:55:00PM +0000, Phillip Wood via GitGitGadget wrote:

> Fix this by ensuring the match is follow by whitespace or the end of the
> string as we already do for abbreviated commands. The (*bol = p) at the
> end of the condition is a bit cute for my taste but I decided to leave
> it be for now. Rather than add new tests the existing tests for bad
> commands are adapted to use a bad command name that triggers the prefix
> matching bug.

FWIW, coverity complained about the (*bol = p) assignment in the
conditional, since "p" must be non-NULL at this point.

So this is email is a combination of:

  - a data point that it is not just you that finds it a bit cute (in
    case you do want to change it later); and

  - a hearty thank you for mentioning it in the commit message, since
    just looking at the code left me scratching my head at whether this
    was a bug.

-Peff
