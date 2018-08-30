Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D276D1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 06:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeH3K6Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 06:58:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726169AbeH3K6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 06:58:16 -0400
Received: (qmail 11232 invoked by uid 109); 30 Aug 2018 06:57:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 06:57:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24141 invoked by uid 111); 30 Aug 2018 06:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 02:57:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 02:57:35 -0400
Date:   Thu, 30 Aug 2018 02:57:35 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/9] worktree: generalize delete_git_dir() to reduce code
 duplication
Message-ID: <20180830065734.GA11944@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-4-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212026.21989-4-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 05:20:20PM -0400, Eric Sunshine wrote:

> prune_worktrees() and delete_git_dir() both remove worktree
> administrative entries from .git/worktrees, and their implementations
> are nearly identical. The only difference is that prune_worktrees() is
> also capable of removing a bogus non-worktree-related file from
> .git/worktrees.
> 
> Simplify by extending delete_git_dir() to handle the little bit of
> extra functionality needed by prune_worktrees(), and drop the
> effectively duplicate code from the latter.

Makes sense. The name "delete_git_dir()" is a little funny (I assume it
means "the git dir", not a worktree's git-dir), but that is not new (and
it's static in worktree.c, which helps).

Your patch maybe stretches that a little by deleting non-directories.
Maybe delete_from_worktrees() would be a better name. Probably not worth
a re-roll, though.

-Peff
