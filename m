Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1AEC433E1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FA3619D8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhC3PLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:11:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37398 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhC3PLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:09 -0400
Received: (qmail 20731 invoked by uid 109); 30 Mar 2021 15:11:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 15:11:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26667 invoked by uid 111); 30 Mar 2021 15:11:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 11:11:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 11:11:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
Message-ID: <YGM/i+k4r0q8FKg2@coredump.intra.peff.net>
References: <20210307132001.7485-1-avarab@gmail.com>
 <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
 <xmqqblb1kd47.fsf@gitster.g>
 <87a6qlmt9f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6qlmt9f.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 01:31:40AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> Use the GNU make ".DELETE_ON_ERROR" flag.
> >
> > Yay!
> >
> > With versions of $(MAKE) where this feature is available, it is far
> > more preferrable to use it than "generate into temporary and rename
> > to the final" dance.
> >
> > We do require / depend on GNU but I do not offhand know if this is
> > available in all versions that still matter.  If we know we can
> > assume the presence of this feature the I do not mind if we jump
> > directly to this step without those "do the same for $(CC)" steps
> > (which I deem crazy) before it.
> 
> Even if it's not available in all versions that's OK. You just won't get
> the nicer removal behavior on on error on such a jurassic gmake, but
> you'll probably have way bigger issues with your late-90s-era software.
> 
> It's not a syntax error on a gmake or other make that doesn't know about
> it either, i.e. you can also add a target like:
> 
>     .THIS_DOES_NOT_EXIST_AS_A_GMAKE_FEATURE:
> 
> And gmake willl happily ignore it.

Yes, I think it's fine to treat it as "nice if we have it, but OK
otherwise". But also, .DELETE_ON_ERROR first shows up in the GNU make
git repository in version 3.71.5 from 1994. So I think we can probably
just assume it's everywhere.

-Peff
