Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169411F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeBGUJC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:09:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:44178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754238AbeBGUJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:09:01 -0500
Received: (qmail 28098 invoked by uid 109); 7 Feb 2018 20:09:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 20:09:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2053 invoked by uid 111); 7 Feb 2018 20:09:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 15:09:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 15:08:59 -0500
Date:   Wed, 7 Feb 2018 15:08:59 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Todd Zullinger <tmz@pobox.com>,
        Jason Racey <jason@eluvio.com>, git <git@vger.kernel.org>,
        Paul Smith <paul@mad-scientist.net>
Subject: Re: "git branch" issue in 2.16.1
Message-ID: <20180207200859.GA9141@sigill.intra.peff.net>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
 <20180206195754.GE1427@zaya.teonanacatl.net>
 <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
 <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 06:54:23PM +0100, Lars Schneider wrote:

> > Maybe the number of branches changed since then?
> > As the pager only comes to life when the output fills
> > more than your screen. Quick workarounds:
> > * buy a bigger screen
> > * have fewer branches.
> 
> Hmmm... there might be more to it. I just noticed the
> pager behavior on macOS, too. Consider this call:
> 
> $ git diff --shortstat
> 
> This should generate at most one line of output. On Linux
> the pager is never used. On macOS the pager is always used.
> 
> I tried older versions of Git on macOS and experienced the
> same behavior.

Keep in mind that we always run the pager, since we don't know ahead of
time how much output will be generated. It's just that with certain
configurations of "less", it may exit if it sees EOF before there's a
whole screen worth of data.

This is controlled by the "-F" option. By default, Git will set LESS=FRX
in the environment if you do not already have a $LESS environment. So
some other possibilities are:

  1. You have $LESS in your environment (without "F") on one platform
     but not the other.

  2. Git was built with a different PAGER_ENV Makefile variable on one
     platform versus the other (that's what controls the baked-in LESS
     defaults).

  3. "less" somehow behaves differently on macOS. The "F" behavior is
     quite old, but possibly there's some platform-specific bug.

-Peff
