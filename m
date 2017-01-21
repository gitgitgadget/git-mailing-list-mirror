Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878CB1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 14:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbdAUOIK (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 09:08:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:42590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdAUOIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 09:08:09 -0500
Received: (qmail 1657 invoked by uid 109); 21 Jan 2017 14:08:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 14:08:09 +0000
Received: (qmail 22800 invoked by uid 111); 21 Jan 2017 14:09:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 09:09:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jan 2017 09:08:06 -0500
Date:   Sat, 21 Jan 2017 09:08:06 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] log: new option decorate reflog of remote refs
Message-ID: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
References: <20170119122630.27645-1-pclouds@gmail.com>
 <20170119172310.6meuj6ksxloeee2t@sigill.intra.peff.net>
 <CACsJy8A_LkRMZYfoJuYEUok4r7Tw0VuMwVkG_Kr1o1hFcAUWNw@mail.gmail.com>
 <20170120143031.p2mux5uxxzniovkx@sigill.intra.peff.net>
 <CA+P7+xqgyUW-Wt2oUSCc86HG-MfL-itAu2yVrZ219LNwqQnwKw@mail.gmail.com>
 <CACsJy8C41D0Qb0ZJoAPJ6Pwp904dVixUR9yXQmZr0NU9W-BU8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8C41D0Qb0ZJoAPJ6Pwp904dVixUR9yXQmZr0NU9W-BU8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 07:48:50PM +0700, Duy Nguyen wrote:

> OK. Next question, how do we deal with the reflog count (i..e the
> argument of --decorate-remote-reflog). Should it be shared for all ref
> type, or can be specified differently for remote, local and tags? I'm
> leaning towards the former. But I'll wait a bit for ideas before
> rewriting the patch.

I doubt that anybody really cares about different reflog depths for
different refs. But I would say that the natural syntax ends up as:

  git log --decorate-reflog=10 --remotes \
          --decorate-reflog=10 --tags

anyway, so you get the ability to do it anyway "for free" (at the cost
of having to repeat yourself).

I guess the other option is:

  git log --decorate-reflog-depth=10 \
          --decorate-reflog --remotes
	  --decorate-reflog --tags

That's actually _more_ typing, and besides being less flexible just
muddles the "is this option for the next ref-selector or not" question.

(The whole thing is obviously a lot of typing; I wonder if people would
want a config option to do this all the time).

-Peff
