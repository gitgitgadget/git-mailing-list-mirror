Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0637A20286
	for <e@80x24.org>; Wed, 13 Sep 2017 13:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbdIMNDg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 09:03:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:36664 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751312AbdIMNDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 09:03:36 -0400
Received: (qmail 6672 invoked by uid 109); 13 Sep 2017 13:03:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:03:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13909 invoked by uid 111); 13 Sep 2017 13:04:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 09:04:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 09:03:34 -0400
Date:   Wed, 13 Sep 2017 09:03:34 -0400
From:   Jeff King <peff@peff.net>
To:     Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: use raw format for notes
Message-ID: <20170913130333.y4sgn5yjdebbvwzn@sigill.intra.peff.net>
References: <334a7be4f61c02db24008181eb1d6c80c95772f7.1503894009.git.sam.bobroff@au1.ibm.com>
 <xmqqingw8ppj.fsf@gitster.mtv.corp.google.com>
 <20170911042737.4h5b2jygdeu7cpmf@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170911042737.4h5b2jygdeu7cpmf@tungsten.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2017 at 02:27:38PM +1000, Sam Bobroff wrote:

> >  - It is very much intended to allow The "(foo)" after the "Notes"
> >    label to show which notes ref the note comes from, because there
> >    can be more than one notes refs that annotate the same commit.
> 
> Right, that makes perfect sense to me when it's being output locally.
> 
> But the ref names are local to my git repo and there is no reaason why
> they should be meaningful or even known to the recipients of the patch
> email.

I can see how your notes names might not be of interest to others. But I
can also see how they _could_ be. For instance, if you kept test result
annotations in a notes ref, you would want to mark them as such.

The idea of the current output is that you'd put general text into
"refs/notes/commits" (which shows up only as "Notes:"). And if you are
putting notes in another ref, you have some reason to do so, which
implies that it's worth showing that they're not in the default ref.

I grant that there are reasons to do so which might not be worth showing
(e.g., you might be pushing and fetching refs, and keep some hierarchy).
But I don't think "are we emailing them" is a robust determiner of "are
they worth showing". So this probably needs to be a separate option,
rather than tied to the output format.

Or possibly there should be a naming convention (e.g., that everything
that ends in "/commits" doesn't have its name shown, which would allow
multiple hierarchies). It's hard to say without knowing the reason you
chose a non-default refname in the first place.

-Peff
