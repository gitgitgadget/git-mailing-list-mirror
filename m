Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBCC1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeGaWTy (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 18:19:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:37858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726580AbeGaWTy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 18:19:54 -0400
Received: (qmail 5065 invoked by uid 109); 31 Jul 2018 20:37:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 20:37:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5701 invoked by uid 111); 31 Jul 2018 20:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 16:37:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 16:37:47 -0400
Date:   Tue, 31 Jul 2018 16:37:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180731203746.GA9442@sigill.intra.peff.net>
References: <20180729092759.GA14484@sigill.intra.peff.net>
 <20180730152756.15012-1-pclouds@gmail.com>
 <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
 <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
 <20180731192931.GD3372@sigill.intra.peff.net>
 <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 01:12:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jul 31, 2018 at 12:12:58PM -0700, Junio C Hamano wrote:
> > ...
> >> collapses two (or more) paths if we go that way.  We only need to
> >> report "we tried to check out X but it seems your filesystem equates
> >> something else that is also in the project to X".
> >
> > Heh. See my similar suggestion in:
> >
> >   https://public-inbox.org/git/20180728095659.GA21450@sigill.intra.peff.net/
> >
> > and the response from Duy.
> 
> Yes, but is there a reason why we need to report what that
> "something else" is?

I don't think it's strictly necessary, but it probably makes things
easier for the user. That said...

> Presumably we are already in an error codepath, so if it is
> absolutely necessary, then we can issue a lstat() to grab the inum
> for the path we are about to create, iterate over the previously
> checked out paths issuing lstat() and see which one yields the same
> inum, to find the one who is the culprit.

Yes, this is the cleverness I was missing in my earlier response.

So it seems do-able, and I like that this incurs no cost in the
non-error case.

-Peff
