Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E967C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F6C2083B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgIYJJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:09:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:40498 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYJJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 05:09:08 -0400
Received: (qmail 13886 invoked by uid 109); 25 Sep 2020 09:09:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 09:09:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16620 invoked by uid 111); 25 Sep 2020 09:09:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 05:09:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 05:09:06 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Han-Wen Nienhuys <hanwen@google.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/2] bswap.h: drop unaligned loads
Message-ID: <20200925090906.GA66146@coredump.intra.peff.net>
References: <20200924191638.GA2528003@coredump.intra.peff.net>
 <20200924192111.GA2528225@coredump.intra.peff.net>
 <20200925011348.GA1392312@camp.crustytoothpaste.net>
 <CAPUEspjpUeaqCCuBJpQLSTv=C_P4f5h22HoTPm9+9rB7k0NkaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEspjpUeaqCCuBJpQLSTv=C_P4f5h22HoTPm9+9rB7k0NkaQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 02:05:09AM -0700, Carlo Arenas wrote:

> > >   [stock]
> > >   Benchmark #1: t/helper/test-tool sha1 <foo.rand
> > >     Time (mean ± σ):      6.638 s ±  0.081 s    [User: 6.269 s, System: 0.368 s]
> > >     Range (min … max):    6.550 s …  6.841 s    10 runs
> 
> slightly offtopic but what generates this nicely formatted output?

It's this:

  https://github.com/sharkdp/hyperfine

It will actually run both versions and compare them, but it's a little
more involved to set up (since you have to do a build step in between).

> > I cannot speak for s390, since I have never owned one
> 
> I happen to be lucky enough to have access to one (RHEL 8.2/z15, gcc
> 8.3.1) and seems (third consecutive run):
> 
> stock: user: 7.555s, system: 1.191s
> -DNO_UNALIGNED_LOADS: user: 7.561s, system: 1.189s

Thanks. That's not too surprising. gcc 8 seems to be able to optimize
both versions to the same thing (though I have no idea if s390 has a
bswap instruction).

-Peff
