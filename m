Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67876C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B387611AF
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 09:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhDQJCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 05:02:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:54956 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhDQJCX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 05:02:23 -0400
Received: (qmail 30040 invoked by uid 109); 17 Apr 2021 09:01:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Apr 2021 09:01:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2604 invoked by uid 111); 17 Apr 2021 09:01:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Apr 2021 05:01:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Apr 2021 05:01:56 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHqkBFp+CGzWW4Xs@coredump.intra.peff.net>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
 <YHVQ9RPLk8/r+8mS@ncase>
 <YHgKiXRMq/1Fpg2x@coredump.intra.peff.net>
 <xmqqlf9hkhpp.fsf@gitster.g>
 <xmqq4kg5kehw.fsf@gitster.g>
 <YHo3LO2RKfe0W/z7@satellite>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHo3LO2RKfe0W/z7@satellite>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 02:17:32AM +0100, Ramsay Jones wrote:

> On Fri, Apr 16, 2021 at 04:15:39PM -0700, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > I think the only remaining issues are the comments on 5/8 on tests,
> > > then?  Hopefully we can have one more iteration to finalize the
> > > topic and merge it down to 'next'?
> > >
> > > Thanks.
> > 
> > I guess not.  I am guessing this topic is responsible for
> > 
> >   https://github.com/git/git/runs/2366364023?check_suite_focus=true#step:4:115
> 
> Yes, I noticed this a few days ago, and tried the obvious fix (ie to
> #include "cache.h" at the start of the list-objects-filter-options.h
> header file) which does indeed work fine. However, I then thought that
> moving the definition of 'enum object_type' (along with the TYPE_BITS
> #define) to the 'object.h' header file (and #include "object.h" into
> cache.h) would be a better idea...
> 
> Having done that, I wondered how many '#include "cache.h"' could be
> replaced by "object.h", and ... well, that was a few days ago and
> something came up...

I agree that would probably be nice, but let's not hold up the topic. It
can include "cache.h" like a bunch of other headers in the meantime.

(Too bad we can't just forward-declare the enum like we do for some
other types, but it's impossible in C).

-Peff
