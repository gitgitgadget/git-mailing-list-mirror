Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC90C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3C4206D9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUVLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:11:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:35030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725850AbgDUVLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 17:11:34 -0400
Received: (qmail 29713 invoked by uid 109); 21 Apr 2020 21:11:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Apr 2020 21:11:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19714 invoked by uid 111); 21 Apr 2020 21:22:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Apr 2020 17:22:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Apr 2020 17:11:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Bug in 2.26: git-fetch fetching too many objects?
Message-ID: <20200421211133.GB3510074@coredump.intra.peff.net>
References: <878siqxiu0.wl-ashutosh.dixit@intel.com>
 <20200421064541.GG96152@google.com>
 <xmqqblnkodi4.fsf@gitster.c.googlers.com>
 <20200421193611.GA103469@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421193611.GA103469@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 12:36:11PM -0700, Jonathan Nieder wrote:

> > This is at least the fourth time we hear that v2 may not be ready
> > for the real-world use.  Perhaps we should revert the default flip
> > on the maintenance track while we hunt for bugs and improve the
> > protocol support?
> 
> That feels to me like an overreaction, since these are all reports of
> the same issue that we have a fix to.  Shouldn't we just flip the
> default for fetch.negotiationAlgorithm to skipping?  If we revert to
> buy time, what would we do with that time?

Do we know that fetch.negotiationAlgorithm helps? I thought we didn't
yet know the actual cause of the bug. If that is the culprit, and people
would have seen this under v0 using stateless-http, why didn't we get
more reports of it then? Surely some people used http over git://?

I do agree that flipping the default away from v2 may be premature,
especially if we don't have a plan for moving forward. It sounds like
swapping out the negotiationAlgorithm would at least be likely to
generate more data, even if it is only a guess.

-Peff
