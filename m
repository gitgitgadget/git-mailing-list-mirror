Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B6F1F462
	for <e@80x24.org>; Thu, 30 May 2019 11:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfE3Lva (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 07:51:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:42164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726792AbfE3Lva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 07:51:30 -0400
Received: (qmail 924 invoked by uid 109); 30 May 2019 11:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 May 2019 11:51:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3958 invoked by uid 111); 30 May 2019 11:52:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 May 2019 07:52:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 May 2019 07:51:23 -0400
Date:   Thu, 30 May 2019 07:51:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #04; Tue, 28)
Message-ID: <20190530115122.GA31607@sigill.intra.peff.net>
References: <xmqqtvdez0yo.fsf@gitster-ct.c.googlers.com>
 <20190528222604.GA14921@sigill.intra.peff.net>
 <xmqqlfypyzfr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfypyzfr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 29, 2019 at 09:53:44AM -0700, Junio C Hamano wrote:

> >> * ds/object-info-for-prefetch-fix (2019-05-28) 1 commit
> >>  - sha1-file: split OBJECT_INFO_FOR_PREFETCH
> >> 
> >>  Code cleanup.
> >> 
> >>  Will merge to 'next'.
> >
> > I think this one is actually a bug-fix (we are refusing to prefetch for
> > "QUICK" calls even though was not the intent), and it is new in this
> > release.
> >
> > I'm not sure of the user-visible impacts, though. There are a lot of
> > QUICK calls, and I'm not sure for which ones it is important to fetch.
> 
> Hmph.  I took it as primarily futureproofing, as I didn't find a way
> to trigger bad behaviour from within the current codebase.

Hmm. Looking over the uses of OBJECT_INFO_QUICK, they all seem to be in
either index-pack or as part of a fetch operation. And in both of those
cases, we'd disable the whole feature anyway with fetch_if_missing.

So I _think_ you are right, and there isn't a way to trigger it.

-Peff
