Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17135C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 19:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjAKTBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 14:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjAKTB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 14:01:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2993D1D5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 11:01:23 -0800 (PST)
Received: (qmail 30556 invoked by uid 109); 11 Jan 2023 19:01:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Jan 2023 19:01:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7932 invoked by uid 111); 11 Jan 2023 19:01:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Jan 2023 14:01:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Jan 2023 14:01:22 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Preston Tunnell Wilson <prestontunnellwilson@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] githooks: discuss Git operations in foreign
 repositories
Message-ID: <Y78Hgj4jKga7vNo7@coredump.intra.peff.net>
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
 <pull.1457.v2.git.1673293508399.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1457.v2.git.1673293508399.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2023 at 07:45:08PM +0000, Eric Sunshine via GitGitGadget wrote:

> Recommended best-practice[1,2,3,4,5,6] for avoiding this problem is for
> the hook to ensure that Git variables are unset before invoking Git
> commands in foreign repositories or other worktrees:
> 
>     unset $(git rev-parse --local-env-vars)
> 
> However, this advice is not documented anywhere. Rectify this
> shortcoming by mentioning it in githooks.txt documentation.
> 
> [1]: https://lore.kernel.org/git/YFuHd1MMlJAvtdzb@coredump.intra.peff.net/
> [2]: https://lore.kernel.org/git/20200228190218.GC1408759@coredump.intra.peff.net/
> [3]: https://lore.kernel.org/git/20190516221702.GA11784@sigill.intra.peff.net/
> [4]: https://lore.kernel.org/git/20190422162127.GC9680@sigill.intra.peff.net/
> [5]: https://lore.kernel.org/git/20180716183942.GB22298@sigill.intra.peff.net/
> [6]: https://lore.kernel.org/git/20150203163235.GA9325@peff.net/

Boy, I'm like a broken record.

The patch here looks good to me. The problem is wider than just hooks,
but it seems like that's going to be a common place for people to get
caught by it. So certainly this is going in the right direction.

The other place I've run into it is writing a script meant to be run as
an external command. E.g., running this:

  git --git-dir=/some/path my-external-command

means that "my-external-command" is going to have $GIT_DIR set. If it
wants to operate on another repository it needs to take care to clear
that from the environment.

-Peff
