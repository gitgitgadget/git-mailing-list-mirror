Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201BC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3EA61BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhKQDE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:04:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:60714 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhKQDE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:04:56 -0500
Received: (qmail 21824 invoked by uid 109); 17 Nov 2021 03:01:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Nov 2021 03:01:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6593 invoked by uid 111); 17 Nov 2021 03:01:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 22:01:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 22:01:57 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99
 support
Message-ID: <YZRwpekXlilhOEx4@coredump.intra.peff.net>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-1-sandals@crustytoothpaste.net>
 <20211116021241.1565740-2-sandals@crustytoothpaste.net>
 <YZOh370ZMMqSADUE@coredump.intra.peff.net>
 <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
 <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
 <YZRurUdyB/cGL6Y3@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZRurUdyB/cGL6Y3@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 02:53:33AM +0000, brian m. carlson wrote:

> On 2021-11-16 at 14:54:32, Jeff King wrote:
> > On Tue, Nov 16, 2021 at 01:54:27PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > 
> > > But IMO this whole thing of trying to make this work on every compiler
> > > etc. just isn't worth it.
> > > 
> > > Let's just start using C99 features, and if anyone's compiler breaks on
> > > something like CentOS 6 document that they'll need to tweak a flag
> > > somewhere. We already know that works for all the other C99 features we
> > > have, there seems to just be this one exception of the ancient GCC
> > > version in this particular case.
> > 
> > Yeah, I definitely agree with this sentiment.
> 
> Unfortunately, we cannot do this without some sort of patch because our
> CI will be broken.  I'm fine if we want to drop GCC 4.8, but we need to
> be explicit about that or we need to add flags to make it work.  We also
> need at least something to make Windows work.  Dscho will not be happy
> if we just leave it broken.

Yes, but I'm not at all worried about breaking our CI. That's just a
patch away from fixing. I'm much more worried about confused users
building from source, because helping them is more difficult to scale.

My thinking was that breaking older compilers was preferable to breaking
non-gnu ones, because at least old ones go away eventually. But your
other email makes me wonder if those non-GNU ones may already be
overriding CFLAGS.

Still, if we can come up with a solution that breaks neither (with some
light auto-detection or heuristics in the Makefile), that could be the
best of both worlds.

-Peff
