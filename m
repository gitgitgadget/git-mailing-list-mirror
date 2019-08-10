Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A06B1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 06:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfHJGKI (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 02:10:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725788AbfHJGKI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 02:10:08 -0400
Received: (qmail 16362 invoked by uid 109); 10 Aug 2019 06:10:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 10 Aug 2019 06:10:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3962 invoked by uid 111); 10 Aug 2019 06:12:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 10 Aug 2019 02:12:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 10 Aug 2019 02:10:07 -0400
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Message-ID: <20190810061006.GB25876@sigill.intra.peff.net>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
 <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
 <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
 <20190809162900.GA9094@sigill.intra.peff.net>
 <xmqq36iadygk.fsf@gitster-ct.c.googlers.com>
 <CABURp0pb4QY+Qbvn6YAtQ=bevSQW+vQXFMChyd_phtUK4P5M7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABURp0pb4QY+Qbvn6YAtQ=bevSQW+vQXFMChyd_phtUK4P5M7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 11:05:34AM -0700, Phil Hord wrote:

> On Fri, Aug 9, 2019 at 10:48 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jeff King <peff@peff.net> writes:
> >
> > > I don't know of any plans for checkout in particular, but I think the
> > > docs for restore/switch make it clear that it's way too early to start
> > > scripting around them:
> > >
> > >   $ git grep EXPERIMENTAL Documentation/
> > >   Documentation/git-restore.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> > >   Documentation/git-switch.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> >
> > Would it ever be OK to script around checkout, restore and/or switch
> > Porcelain commands?
> 
> Users who wish to get their job done will script around porcelain all
> the time.  I would be surprised if even 1% of build scripts use 'git
> checkout-index' instead of 'git checkout'.

It's even worse if you really want to switch branches, and not checkout
files. You'd probably need to use symbolic-ref, read-tree, and
checkout-index.

IMHO scripting around "action" commands like checkout is less bad than
around "output" commands like log. The general action of "switch to this
branch" is unlikely to be changed much over the years (or via config),
but the output of log, etc, is.

There are no guarantees, of course, but I imagine that the tradeoff in
simplicity of using git-switch versus manually reimplementing it is
probably a good one for many scripts.

-Peff
