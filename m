Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163741F453
	for <e@80x24.org>; Thu, 21 Feb 2019 04:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBUER7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 23:17:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:51862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726181AbfBUER6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 23:17:58 -0500
Received: (qmail 14537 invoked by uid 109); 21 Feb 2019 04:17:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 04:17:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8130 invoked by uid 111); 21 Feb 2019 04:18:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Feb 2019 23:18:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2019 23:17:56 -0500
Date:   Wed, 20 Feb 2019 23:17:56 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mateusz Loskot <mateusz@loskot.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "Submodule registered for path" output with config aliases mixed
 in
Message-ID: <20190221041756.GA28389@sigill.intra.peff.net>
References: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
 <20190221021825.GB488342@genre.crustytoothpaste.net>
 <CACsJy8BKhroHhVWCj5fvwxk2z4XsdSK_pSQ=o8hxZcZsAn3R-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BKhroHhVWCj5fvwxk2z4XsdSK_pSQ=o8hxZcZsAn3R-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 10:47:45AM +0700, Duy Nguyen wrote:

> > > I managed to identify where that garbage injections come from:
> > > from git aliases I've got configured [1]
> > >
> > > Could anyone explain what is happening here?
> > > Is there anything wrong with my ~/.gitconfig [1] ?
> >
> > I see the right behavior on my system (Debian amd64/sid) with
> > 2.21.0.rc0.258.g878e2cd30e and with master. I've built with ASan and
> > don't see any memory warnings on my system.
> 
> I ran valgrind yesterday (gentoo amd64) and didn't find the problem
> either even though it clearly looked like some dangling pointers. I
> also audited this code and couldn't find anything obviously wrong. My
> only suspicion is maybe some strange getenv() behavior on Windows
> (_if_ the super prefix is used, but I can't see how...) and that's
> just a dead end for me.

Certainly we fixed a bunch of getenv() problems in the upcoming 2.21
release, including 8aac69038f (get_super_prefix(): copy getenv() result,
2019-01-11).

Mateusz, can you try with the one of the v2.21.0 release candidates (or
the current tip of "master")?

-Peff
