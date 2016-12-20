Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8467203EA
	for <e@80x24.org>; Tue, 20 Dec 2016 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936133AbcLTQtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 11:49:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:59015 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934237AbcLTQtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 11:49:14 -0500
Received: (qmail 2350 invoked by uid 109); 20 Dec 2016 16:49:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Dec 2016 16:49:13 +0000
Received: (qmail 5668 invoked by uid 111); 20 Dec 2016 16:49:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Dec 2016 11:49:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Dec 2016 11:49:11 -0500
Date:   Tue, 20 Dec 2016 11:49:11 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Leho Kraav <leho@conversionready.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 0/7] Fix and generalize version sort reordering
Message-ID: <20161220164910.deanwq5hcve3vggt@sigill.intra.peff.net>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com>
 <20161214170852.bzh5pyl4bov6rwbt@sigill.intra.peff.net>
 <CAM0VKjmDDKgYCvtbwpx=GcwRENzvSDLW_Xhia3btdeMjtAjAvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjmDDKgYCvtbwpx=GcwRENzvSDLW_Xhia3btdeMjtAjAvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 09:50:42AM +0100, SZEDER Gábor wrote:

> > It just seems like the whole thing would conceptually easier if we
> > pre-parsed the versions into a sequence of elements, then the comparison
> > between any two elements would just walk that sequence. The benefit
> > there is that you can implement whatever rules you like for the parsing
> > (like "prefer longer suffixes to shorter"), but you know the comparison
> > will always be consistent.
> 
> I considered parsing tagnames into prefix, version number and suffix,
> and then work from that, but decided against it.
> 
> versioncmp() is taken from glibc, so I assume that it's thoroughly
> tested, even in corner cases (e.g. multiple leading zeros).
> Furthermore, I think it's a good thing that by default (i.e. without
> suffix reordering) our version sort orders the same way as glibc's
> version sort does.  Introducing a different algorithm would risk bugs
> in the more subtle cases.

Fair enough. If it's working, I agree there is risk in changing things.
And if you're willing to deal with the bugs, then I'm happy to stand
back. :)

> Then there are all the weird release suffixes out there, and I didn't
> want to decide on a policy for splitting them sanely; don't know
> whether there exist any universal rules for this splitting at
> all.  E.g. one of the packages here has the following version (let's
> ignore the fact that because of the '~' this is an invalid refname in
> git):

I have a hunch that any policy you'd have to set for splitting is going
to end up becoming a policy you'll have to use when comparing (or you
risk violating the transitivity of your comparison function).

But that's just a hunch, not a proof. Again, I'm happy to defer to you
if you're the one working on it.

-Peff
