Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1845C1F461
	for <e@80x24.org>; Fri, 17 May 2019 01:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfEQBTo (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 21:19:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:60310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726241AbfEQBTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 21:19:43 -0400
Received: (qmail 9523 invoked by uid 109); 17 May 2019 01:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 01:19:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9631 invoked by uid 111); 17 May 2019 01:20:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 21:20:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 21:19:42 -0400
Date:   Thu, 16 May 2019 21:19:42 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
Message-ID: <20190517011941.GA30372@sigill.intra.peff.net>
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
 <20190516221702.GA11784@sigill.intra.peff.net>
 <CAPig+cQQ5svrDKRPenL2+bJHGjddUPnAXCFSsQN+WBHqzGpDow@mail.gmail.com>
 <20190517001926.GA13525@sigill.intra.peff.net>
 <CAPig+cQpmD9+frJWNfcts1+RFBTjrHUHk_eR4Y94GAnGZC=7hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQpmD9+frJWNfcts1+RFBTjrHUHk_eR4Y94GAnGZC=7hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 09:02:06PM -0400, Eric Sunshine wrote:

> On Thu, May 16, 2019 at 8:19 PM Jeff King <peff@peff.net> wrote:
> > On Thu, May 16, 2019 at 07:16:54PM -0400, Eric Sunshine wrote:
> > > Is there
> > > any existing code in Git for doing the relative fixups you mention for
> > > other Git environment variables?
> >
> > You can assign local_repo_env to child_process.env (or push it
> > individually to env_array if you have to mix with other variables). See
> > git_connect() for an example.
> 
> I wasn't aware of 'local_repo_env', but can see how it could be
> helpful as a basis for building machinery to adjust relative paths
> contained in those environment variables prior to a chdir(). My
> original question was if such machinery already exists, but I'm
> guessing from your response that it doesn't.

Oh, I see. I totally missed that you said "relative fixups" and not
"clearing". :)

There's the chdir_notify system. Any variables which need updating need
to register themselves, and then the chdir in the worktree code needs to
be done with chdir_notify(). See chdir-notify.h for details.

-Peff
