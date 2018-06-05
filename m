Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3827B1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeFERyl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:54:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:35062 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752696AbeFERyi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:54:38 -0400
Received: (qmail 31656 invoked by uid 109); 5 Jun 2018 17:54:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Jun 2018 17:54:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28583 invoked by uid 111); 5 Jun 2018 17:54:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Jun 2018 13:54:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2018 13:54:36 -0400
Date:   Tue, 5 Jun 2018 13:54:36 -0400
From:   Jeff King <peff@peff.net>
To:     Sean Hunt <seandhunt_7@icloud.com>
Cc:     git@vger.kernel.org
Subject: Re: Where is git checkout --orphan implemented at.
Message-ID: <20180605175435.GA22321@sigill.intra.peff.net>
References: <2ED916AA-3E6A-4E22-9B9B-13C3B687B357@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ED916AA-3E6A-4E22-9B9B-13C3B687B357@icloud.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 05, 2018 at 12:02:12PM -0400, Sean Hunt wrote:

> I would like to see the source code to git checkout --orphan so I can
> learn how it works and so I can manually do what it does by hand on
> making a new branch with no history in the refs folder. I can only do
> it on my iPhone as my laptop has no internet or way to do it there,
> and the program on my iPhone does not have the method implemented yet
> visually to do it, forcing manual creation of the orphan branch by
> hand in the end. If the public github had all the codes to all
> commands and subcommands like the one above it would be nice or well
> at least a file that explains the source file each command and
> subcommands are from so that way a person like me can use as a
> reference to make our own git gui that has 100% of command line git
> features.

The code for "checkout --orphan" is in builtin/checkout.c[1].

But if you want to do roughly the same thing with other tools, you can
do:

 git symbolic-ref HEAD refs/heads/new-branch

If you don't even have symbolic-ref handy, you can do:

  echo "ref: refs/heads/new-branch" >.git/HEAD

That's not generally recommended, since future versions of Git may
change the ref storage format, but it would work with any current
version of Git.

-Peff

[1] Try update_refs_for_switch(), especially:

    https://github.com/git/git/blob/61856ae69a2ceb241a90e47953e18f218e4d5f2f/builtin/checkout.c#L635

    and

    https://github.com/git/git/blob/61856ae69a2ceb241a90e47953e18f218e4d5f2f/builtin/checkout.c#L695
