Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C41CC77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjEVTYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjEVTYj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:24:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D404CA
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:24:38 -0700 (PDT)
Received: (qmail 32436 invoked by uid 109); 22 May 2023 19:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 May 2023 19:24:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4214 invoked by uid 111); 22 May 2023 19:24:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 May 2023 15:24:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 May 2023 15:24:37 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Which macOS versions does Git support?
Message-ID: <20230522192437.GB365027@coredump.intra.peff.net>
References: <CAGJzqsnS3SnoW__aPQ+13s+-b3a+makCjWxR=z6mjgBBnuKjLg@mail.gmail.com>
 <20230519090917.GB3515410@coredump.intra.peff.net>
 <k3dnos4h7i4sjxzotiqwhz47wc2qvuzpii4wgysgt6ywoi6dx3@2ggmoesxlqsi>
 <CAGJzqsmJSVJYTtT41wQ5Cgsz=ExMZ8y7qKPDh-7kt8RXY__NbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsmJSVJYTtT41wQ5Cgsz=ExMZ8y7qKPDh-7kt8RXY__NbQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 20, 2023 at 08:36:58AM +0100, M Hickford wrote:

> > FWIW Mac OS X 10.5 (Leopard) was last updated in 2009 and also happens to
> > be the last one that can run in PowerPC, so sadly there is a non zero
> > number of users for it (MacPorts uses a minimum of 10.4 for that reason)
> 
> Interesting! https://ports.macports.org/port/git/details/ It looks
> like the most recent build is from 2021
> https://ports.macports.org/port/git/builds/?builder_name__name=10.5_ppc_legacy
> .   https://ports.macports.org/port/git/stats/?days=365&days_ago=0
> shows 10 total PowerPC downloads in the past year between versions
> 10.4, 10.5 and 10.6

One nice thing here is that the credential helpers are pretty
independent from the rest of Git. If new versions of the helper drop
support for the old API, people on ancient systems can still use the old
helper. We'd just have to make a decision about how much to help them:

  1. (least help) Tell them to dig it out of git.git history, build, and
     stuff the resulting binary somewhere.

  2. (most help) Support both, selected by an #ifdef and a Makefile
     knob, and maybe even turn the knob automatically based on "uname
     -r".

  3. (middle ground) Rewrite with the new API, but leave the old helper
     as contrib/osxkeychain-old or something. Still easy-ish to build,
     but carries less maintenance burden.

> I don't have the equipment or expertise to develop on macOS, so I'll
> leave the API migration as a potential future #leftoverbits

I'd probably do (3), but as I also lack equipment or expertise, I'm not
planning on working on it myself (and I'd let whoever does decide to do
that work have the final say on approach).

> Reading the keychain docs more carefully, the new API only supports a
> fixed set of attribute keys such as 'kSecAttrComment', so discount my
> original "further motivation"

Bummer. Thanks for looking into this, though.

-Peff
