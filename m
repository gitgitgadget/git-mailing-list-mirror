Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E0C1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 05:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGBF3l (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 01:29:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:57048 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725981AbfGBF3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 01:29:40 -0400
Received: (qmail 30658 invoked by uid 109); 2 Jul 2019 05:29:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jul 2019 05:29:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11845 invoked by uid 111); 2 Jul 2019 05:30:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Jul 2019 01:30:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jul 2019 01:29:39 -0400
Date:   Tue, 2 Jul 2019 01:29:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips
 are valid
Message-ID: <20190702052938.GC16344@sigill.intra.peff.net>
References: <20190628101131.GA22862@sigill.intra.peff.net>
 <601d8561-6e24-559c-6fbb-fa25a7389fa0@gmail.com>
 <20190629074348.GA5080@sigill.intra.peff.net>
 <418213f2-82d6-f7bd-7379-7f20f0e83084@gmail.com>
 <20190701125945.GB4704@sigill.intra.peff.net>
 <20190701131713.GA25349@sigill.intra.peff.net>
 <20190701170245.GA54693@TaylorsMBP5815.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701170245.GA54693@TaylorsMBP5815.attlocal.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 01, 2019 at 12:02:45PM -0500, Taylor Blau wrote:

> One thing that I didn't catch in my initial review that I am seeing now
> is the ".alternate" marker. Why did you choose this? I was thinking that
> ".have" would make more sense since it's consistent with what's shown in
> the ref advertisement, but I think that actually ".alternate" is a
> _better_ choice: the two really do refer to different things.

Yeah, I had called these ".have" originally, but decided that was too
tied up with the current users, and not with the concept. I think
keeping the leading "." is worthwhile as that's an invalid refname.

I also thought about an empty string, but it's probably more informative
to show _something_. After all, the user would not see these unless they
specifically asked for them _and_ used something like --source, so
presumably it's a useful piece of information at that point (I don't
know of any other way to show these names except for --source).

I suppose one other option would be to name them after the oid itself.
So with --source you'd find out that 1234abcd came from 1234abcd (duh),
but also that its children came from 1234abcd. Maybe that has value. I
dunno.

It would be easy to change, but I'd also be OK punting until somebody
comes up with a compelling use case.

-Peff
