Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7634B20188
	for <e@80x24.org>; Sun, 14 May 2017 04:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbdENEAw (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:00:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:51312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbdENEAv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:00:51 -0400
Received: (qmail 6881 invoked by uid 109); 14 May 2017 04:00:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 04:00:51 +0000
Received: (qmail 6377 invoked by uid 111); 14 May 2017 04:01:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 00:01:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 May 2017 00:00:49 -0400
Date:   Sun, 14 May 2017 00:00:49 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: checkout -b remotes/origin/<branch> should not work
Message-ID: <20170514040048.evwtngo6bixtrput@sigill.intra.peff.net>
References: <CAGZ79kYACtA_q6kJ=gGYe02H-a9g_GV=kKLn8jy2ZZKvjxGYNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYACtA_q6kJ=gGYe02H-a9g_GV=kKLn8jy2ZZKvjxGYNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 08:52:37PM -0700, Stefan Beller wrote:

> NEEDSWORK:
> 
> checkout -b remotes/origin/<branch> should not work, unless force is
> given (maybe?)
> 
> (I just run into that, now I have a remote tracking branch that points
> at my detached HEAD. Oh well.)

To be pedantic, you have a local branch with a funny name that points to
your detached HEAD. :)

I think this problem extends beyond "remotes/". The worst is:

  git checkout -b HEAD

but there are many confusing variants:

  git checkout -b refs/heads/foo
  git checkout -b tags/v1.0

etc. Those are all perfectly legal names, but almost certainly not what
the user intended. I think the plumbing should continue to allow them,
but I wouldn't object to some common-sense think-o protections in the
"checkout -b" plumbing (especially if it could be disabled for power
users).

-Peff
