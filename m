Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BACC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313ED2078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgDJVAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:00:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:40196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726626AbgDJVAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:00:45 -0400
Received: (qmail 8065 invoked by uid 109); 10 Apr 2020 21:00:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 21:00:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2852 invoked by uid 111); 10 Apr 2020 21:11:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 17:11:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 17:00:44 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Josep Torra <n770galaxy@gmail.com>, git@vger.kernel.org
Subject: Re: Possible regression in git 2.26.0
Message-ID: <20200410210044.GA2074620@coredump.intra.peff.net>
References: <CAE0g23A0+4MPwACTsdjk=eOYaGBDEwsD2t_F072Z33Gb6y2qZw@mail.gmail.com>
 <20200331172218.evsoljccfmjec2mz@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200331172218.evsoljccfmjec2mz@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 01:22:18PM -0400, Konstantin Ryabitsev wrote:

> 16:47 <sfr> repo: git://anongit.freedesktop.org/drm/drm-misc branch: for-linux-next
> 16:48 <sfr> went from trying to transfer 7226542 to just 19
> 16:48 <sfr> even after I did a reset of the remote branch at my end and a gc
> 16:49 <sfr> it updated b1e7396a1d0e..98878d9dfc7a
> 16:50 <sfr> in case it matters, I have "tagopt = --no-tags" set for all the repos
>             I fetch (for obvious reasons)
> 16:52 <sfr> removing the protocol.version=1 (and resetting/gcing) gets me the bad 
>             behaviour again :-(
> 16:52 <sfr> mricon: so good shot! :-)
> 
> It appears that there are cases where protocol.version=2 is causing 
> weird results during ref negotiation?

Possibly. The underlying negotiation technique is roughly the same, but
it's possible there's a subtle difference in the v2 code.

I spent a little time trying to reproduce with the branch mentioned
above, but couldn't. If somebody hits it again, the most useful thing
would be:

  - a dump of "git for-each-ref" in the client repo

  - the exact fetch (or pull) command which behaves differently between
    the two protocols

-Peff
