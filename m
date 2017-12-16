Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A839D1F404
	for <e@80x24.org>; Sat, 16 Dec 2017 09:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbdLPJyC (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 04:54:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:41320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750907AbdLPJyA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 04:54:00 -0500
Received: (qmail 24266 invoked by uid 109); 16 Dec 2017 09:54:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 16 Dec 2017 09:54:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14940 invoked by uid 111); 16 Dec 2017 09:54:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sat, 16 Dec 2017 04:54:24 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Dec 2017 04:53:58 -0500
Date:   Sat, 16 Dec 2017 04:53:58 -0500
From:   Jeff King <peff@peff.net>
To:     Satyakiran Duggina <satya0521@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Git Hooks
Message-ID: <20171216095357.GB32706@sigill.intra.peff.net>
References: <CAMZug24WGWS3TaNPOVWPufGZ+67EbLggr4W3pxJtis9X375mag@mail.gmail.com>
 <CAGyf7-F8cCprvK-e2S0kO0Wo+6n4m_gigpSQjCjSj-dhozMsMw@mail.gmail.com>
 <CAMZug26A0e=AunMOjZNC_xH2E5uqHe46mt6=jawWe7ozF=Jn0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZug26A0e=AunMOjZNC_xH2E5uqHe46mt6=jawWe7ozF=Jn0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 12:48:07PM -0800, Satyakiran Duggina wrote:

> To give the code pullers a chance to review, can we not have a
> `trusted-hooks: default` and `trusted-SHA: <some sha>` field in .git/.
> I'm assuming githooks/ are source tracked here.
> 
> When developer tries to execute `git commit`, git can ask developer to
> change `trusted-hooks` field to true or false. Let's say developer
> sets it to true, git can record the SHA. If any latest pull has the
> hooks changed, git can revert the `trusted-hook` to default.
> 
> This way there is not much hassle for developers to manually copy
> hooks all the time. And at the same time, they are not running scripts
> that they haven't reviewed.

We've talked about doing something like this (though more for config
than for hooks). But what the discussion always come down to is that
carrying a script like "import-hooks.sh" in the repository ends up being
the exact same amount of work for the developer as any git-blessed "OK,
trust these hooks" command.

And it's a lot more flexible. The writer of that script can touch hooks,
config, etc. They can base decisions about what values to use based on
data that Git otherwise wouldn't care about (e.g., uname). And they only
have to handle cases that the project cares about, whereas anything Git
does has to work everywhere.

-Peff
