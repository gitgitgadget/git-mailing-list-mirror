Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465AE1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfBUNwK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:52:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:52574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725385AbfBUNwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:52:09 -0500
Received: (qmail 20396 invoked by uid 109); 21 Feb 2019 13:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:52:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12536 invoked by uid 111); 21 Feb 2019 13:52:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:52:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:52:07 -0500
Date:   Thu, 21 Feb 2019 08:52:07 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: safe-guard a bit more against getenv()
 problems
Message-ID: <20190221135207.GA20899@sigill.intra.peff.net>
References: <pull.127.git.gitgitgadget@gmail.com>
 <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53e3d159c8c80924188f57c44efd2170612f2ee5.1550243863.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 15, 2019 at 07:17:45AM -0800, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Running up to v2.21.0, we fixed two bugs that were made prominent by the
> Windows-specific change to retain copies of only the 30 latest getenv()
> calls' returned strings, invalidating any copies of previous getenv()
> calls' return values.
> 
> While this really shines a light onto bugs of the form where we hold
> onto getenv()'s return values without copying them, it is also a real
> problem for users.
> 
> And even if Jeff King's patches merged via 773e408881 (Merge branch
> 'jk/save-getenv-result', 2019-01-29) provide further work on that front,
> we are far from done. Just one example: on Windows, we unset environment
> variables when spawning new processes, which potentially invalidates
> strings that were previously obtained via getenv(), and therefore we
> have to duplicate environment values that are somehow involved in
> spawning new processes (e.g. GIT_MAN_VIEWER in show_man_page()).

Belated review, as this is already in master, but: yes, I absolutely
support this patch, even on top of my patches. Those were just the cases
I found by poking around for a few minutes, and I'm sure there are many
more.

-Peff
