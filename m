Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BADD920248
	for <e@80x24.org>; Thu,  4 Apr 2019 22:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDDWMM (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 18:12:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:47264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730499AbfDDWML (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 18:12:11 -0400
Received: (qmail 607 invoked by uid 109); 4 Apr 2019 22:12:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 22:12:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20024 invoked by uid 111); 4 Apr 2019 22:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 18:12:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 18:12:08 -0400
Date:   Thu, 4 Apr 2019 18:12:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
Message-ID: <20190404221208.GA30798@sigill.intra.peff.net>
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l>
 <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
 <20190403213318.GA14137@dev-l>
 <20190404020226.GG4409@sigill.intra.peff.net>
 <xmqqftqyf76a.fsf@gitster-ct.c.googlers.com>
 <20190404122722.GA23024@sigill.intra.peff.net>
 <xmqqef6he8sh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqef6he8sh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 06:54:06AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > but you have to take pretty specific steps to get a tag of a blob or
> > tree, like:
> >
> >   git tag mytag HEAD:path
> >
> > or
> >
> >   git tag mytag HEAD^{tree}
> 
> And the way to ask for commit and tag are
> 
>     git tag mytag master
>     git tag mytag v1.0.0
> 
> I do not see why only the last one should either be forbidden or
> automaticallly peel.  Each of these four names an object of a
> specific type, and singling out a tag as "curious" makes the
> interface uneven.

My point is that it's easy to accidentally tag a tag. It's not easy to
accidentally tag a tree. The counter example would be something that
looks as easy as your "git tag mytag v1.0.0" but actually tags a tree.
I couldn't think of one.

I do buy the argument that arguing for safety valves from a point of
"what's the easiest mistake to make in our current interface" might not
be the best one. It yields a set of operations that aren't necessarily
sensible or orthogonal with respect to the underlying reality of what's
possible and what's reasonable. Which I think is the point you're
making.

-Peff
