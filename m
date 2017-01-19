Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5190120A17
	for <e@80x24.org>; Thu, 19 Jan 2017 22:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbdASWY0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 17:24:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:41854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdASWYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 17:24:25 -0500
Received: (qmail 18847 invoked by uid 109); 19 Jan 2017 22:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 22:24:09 +0000
Received: (qmail 10027 invoked by uid 111); 19 Jan 2017 22:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 17:25:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 17:24:07 -0500
Date:   Thu, 19 Jan 2017 17:24:07 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates <mdwfhl@nottheoilrig.com>
Cc:     git@vger.kernel.org
Subject: Re: grep open pull requests
Message-ID: <20170119222407.7y55did5hft55s27@sigill.intra.peff.net>
References: <276f6ed9-ff06-a00f-b88a-4d40d55c6d40@nottheoilrig.com>
 <20170119190227.opjisryyqn766tqy@sigill.intra.peff.net>
 <9f59c0d7-73d3-1b4c-65ca-700d6e1f4f23@nottheoilrig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f59c0d7-73d3-1b4c-65ca-700d6e1f4f23@nottheoilrig.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 03:12:53PM -0700, Jack Bates wrote:

> Cool, thanks for all your help! "git log --cherry-pick" works quite well.
> One thing: I expected the following to be equivalent, but found that they're
> not. Is that by accident or design?
> 
>   $ git rev-list --cherry-pick --right-only master...refs/pull/1112/head
>   $ git rev-list --cherry-pick master..refs/pull/1112/head

It's by design. The "left" and "right" notions are defined only for a
three-dot symmetric difference.

In the first command you've asked git to look at commits on _both_
master and the PR, down to their merge base. It marks the tips with a
"left" and "right" bit, and then those bits propagate down.

In the second command, you've only asked for the PR commits, and there
is no left/right bit at all. So --cherry-pick is doing nothing, as it
has no "left" commits to compare to.

-Peff
