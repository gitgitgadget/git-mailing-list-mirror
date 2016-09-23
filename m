Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200C81F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 06:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758267AbcIWGGs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 02:06:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:47064 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757894AbcIWGGr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 02:06:47 -0400
Received: (qmail 461 invoked by uid 109); 23 Sep 2016 06:06:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 06:06:47 +0000
Received: (qmail 15384 invoked by uid 111); 23 Sep 2016 06:06:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 02:06:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2016 02:06:43 -0400
Date:   Fri, 23 Sep 2016 02:06:43 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
Message-ID: <20160923060643.3ubr5gn7qczzs2ut@sigill.intra.peff.net>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
 <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
 <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
 <20160923034113.4rnps3nogvzxkfjx@sigill.intra.peff.net>
 <CAGZ79kZ+LTd5PuT4+Z9K6d+GQ-33E=tLY1Fokbp22uNoygaEtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ+LTd5PuT4+Z9K6d+GQ-33E=tLY1Fokbp22uNoygaEtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 10:47:17PM -0700, Stefan Beller wrote:

> On Thu, Sep 22, 2016 at 8:41 PM, Jeff King <peff@peff.net> wrote:
> 
> >>  * As Stefan alluded to (much) earlier, it might be a better idea
> >>    to have these 'prefix' as the global option to "git" potty, not
> >>    to each subcommand that happens to support them;
> >
> > That seems like it would be nice, but there's going to be an interim
> > period where some commands do not respect the global "--prefix" at all
> > (in the worst case, consider a third party command).
> 
> My current line of thinking is to have a new flag in command struct in
> git.c to enable the global --prefix, (c.f. RUN_SETUP | NEED_WORK_TREE)
> so we'd have a ALLOW_OUTSIDE_PREFIX flag which can be used to enable
> this feature. In case that flag is not set, but a user tries a
> --prefix=<somewhere>
> we can still
> 
>     die("nope, we don't do that");

Yeah, a positive "I support this" flag would at least let us correctly
flag errors, which is the best we can do. That won't work for
non-builtins, but perhaps it is good enough in practice.

-Peff
