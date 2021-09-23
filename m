Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE446C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C02F610D1
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 16:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhIWQWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:22:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbhIWQVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 12:21:43 -0400
Received: (qmail 15278 invoked by uid 109); 23 Sep 2021 16:20:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 16:20:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28960 invoked by uid 111); 23 Sep 2021 16:20:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 12:20:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 12:20:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
Message-ID: <YUypOEywhzEWpoef@coredump.intra.peff.net>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g>
 <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
 <xmqqzgs479d5.fsf@gitster.g>
 <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
 <xmqqo88k40pd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo88k40pd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 05:03:58PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I almost suggested using "git.c" as the dummy file, since we know it
> > must compile anyway. But that probably has other problems (it's more
> > expensive, and if it _does_ have an error, the results may be
> > confusing).
> >
> > It's a shame we can't just try to do the _real_ compiles using the
> > auto-dependency stuff, and then fall back if they fail. But I think
> > there's a chicken-and-egg problem there with "make" doing real work, and
> > figuring out the dependencies to do real work.
> 
> Yeah, if compiling any of the real sources is inexpensive enough, I
> would think that would be the happy way to go.  Do we have a trivial
> source that almost never changes?  Perhaps version.c (especially if
> we kick out two helper functions that do not really belong there)?

Perhaps. TBH, I find Ævar's latest patch to just add -Wno-pedantic to be
the simplest and most obviously-correct fix.

-Peff
