Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22221F453
	for <e@80x24.org>; Tue,  2 Oct 2018 21:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeJCDxj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:53:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:39112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727747AbeJCDxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:53:39 -0400
Received: (qmail 16245 invoked by uid 109); 2 Oct 2018 21:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 21:08:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6633 invoked by uid 111); 2 Oct 2018 21:07:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 17:07:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 17:08:21 -0400
Date:   Tue, 2 Oct 2018 17:08:21 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] coccicheck: process every source file at once
Message-ID: <20181002210821.GA27904@sigill.intra.peff.net>
References: <20181002191642.21504-1-jacob.e.keller@intel.com>
 <20181002195519.GB2014@sigill.intra.peff.net>
 <CA+P7+xrjpEe_3_mAwZ73O2JP2Pd518OFnSf+gfmbTJW7A3Q=Nw@mail.gmail.com>
 <20181002203124.GC2014@sigill.intra.peff.net>
 <CA+P7+xqxov6-+t6ixuVxUvi=yfjDuxsa8poGL0TrUrWoj3NUNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqxov6-+t6ixuVxUvi=yfjDuxsa8poGL0TrUrWoj3NUNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 01:58:10PM -0700, Jacob Keller wrote:

> On Tue, Oct 2, 2018 at 1:31 PM Jeff King <peff@peff.net> wrote:
> > Actually, I guess we do not need to save $? at all, since we have only a
> > single process to care about. So even simpler:
> >
> >   spatch ... 2>$@+ 2>$@.log ||
> >   {
> >         cat $@.log
> >         exit 1
> >   }
> >   # if we get here, we were successful
> >   mv $@+ $@ ;# etc
> >
> > would work. That's missing all the Makefile=required backslashes and
> > semicolons, of course. ;)
> >
> 
> I opted to drop to just save the return, immediately after calling.
> It's a bit less code change, and I think the result is as clear as the
> above would be. This way we do drop the subshell, not that it matters
> much in the end...

Yeah. To be clear, I'm fine with any of the versions discussed in this
thread. Thanks for working on this!

-Peff
