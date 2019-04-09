Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60D520248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIPQB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:16:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:52288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726415AbfDIPQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:16:01 -0400
Received: (qmail 7485 invoked by uid 109); 9 Apr 2019 15:16:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Apr 2019 15:16:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30836 invoked by uid 111); 9 Apr 2019 15:16:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Apr 2019 11:16:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2019 11:15:59 -0400
Date:   Tue, 9 Apr 2019 11:15:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190409151559.GB12627@sigill.intra.peff.net>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
 <xmqqo95f43dq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo95f43dq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 12:14:41AM +0900, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
> 
> > For large repositories, enumerating the list of all promisor objects (in
> > order to exclude them from a rev-list walk) can take a significant
> > amount of time).
> >
> > When --exclude-promisor-objects is passed to rev-list, don't enumerate
> > the promisor objects. Instead, filter them (and any children objects)
> > during the actual graph walk.
> >
> > Remove the mark_uninteresting() function as it's not used anywhere else.
> >
> > When testing against a large repo [1], this patch reduces the
> > connectivity check runtime from 3 minutes to ~7 seconds.
> >
> > [1]: https://android.googlesource.com/platform/frameworks/base/
> >
> > Helped-By: Jonathan Tan <jonathantanmy@google.com>
> > Helped-By: Jeff King <peff@peff.net>
> > Helped-By: Jonathan Nieder <jrnieder@gmail.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> 
> I've dealt with the stray double-sign-off locally, but is there
> anything else planned for v4 or later?  Is this performance-only
> change, or does it have an externally observable behaviour change
> that we can easily add to our test suite?

I am OK if we do not include it, but even if this is "just" a
performance-only change, we can always add to our perf regression suite.

-Peff
