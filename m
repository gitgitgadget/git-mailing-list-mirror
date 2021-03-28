Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CE6C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 07:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5050C6197E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 07:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhC1HW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 03:22:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:51258 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhC1HWj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 03:22:39 -0400
Received: (qmail 25670 invoked by uid 109); 28 Mar 2021 07:22:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Mar 2021 07:22:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24774 invoked by uid 111); 28 Mar 2021 07:22:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Mar 2021 03:22:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Mar 2021 03:22:38 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: Git 2.31.1, Solaris and error: conflicting types for 'inet_ntop'
Message-ID: <YGAuvmhBdz3txhXu@coredump.intra.peff.net>
References: <CAH8yC8nUpHP4iX-iQqMqX4wR6sMZO2MQv9fBVVTSys67_oGX0A@mail.gmail.com>
 <YF/RtL+TS6+DNCTk@camp.crustytoothpaste.net>
 <CAH8yC8mSMZDjhbidruAh9t7QFsv6Yxqi1poNEXBT=Nn9+sB2hA@mail.gmail.com>
 <YF/bMjJA2RguVguZ@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YF/bMjJA2RguVguZ@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 28, 2021 at 01:26:10AM +0000, brian m. carlson wrote:

> On 2021-03-28 at 01:04:32, Jeffrey Walton wrote:
> > I see what happened... I stopped Autoreconfing so the configure.ac
> > changes were not picked up. The original configure is being used.
> > 
> > I think Git is getting itself into that state.
> > 
> > Without the Autoreconf, I was able to sidestep the issue with:
> > 
> > if [[ "${IS_SOLARIS}" -eq 1 ]]; then
> >     CONFIG_OPTS+=("ac_cv_func_inet_ntop=yes")
> >     CONFIG_OPTS+=("ac_cv_func_inet_pton=yes")
> > fi
> 
> Most developers don't use the autoconf stuff and just use the makefile.
> config.mak.uname doesn't have NO_INET_NTOP set for SunOS.
> 
> If the autoconf scripts or config.mak.uname need fixing, which is
> possible, a patch would definitely be welcome.

This all seemed vaguely familiar, and indeed it came up about a year
ago:

  https://lore.kernel.org/git/CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com/

Maybe worth resurrecting this patch (at the very least it needed a
signoff):

  https://lore.kernel.org/git/CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com/

-Peff
