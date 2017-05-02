Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5E81F790
	for <e@80x24.org>; Tue,  2 May 2017 18:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdEBSPQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 14:15:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:44099 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751137AbdEBSPP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 14:15:15 -0400
Received: (qmail 7298 invoked by uid 109); 2 May 2017 18:15:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 18:15:14 +0000
Received: (qmail 16446 invoked by uid 111); 2 May 2017 18:15:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 14:15:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 May 2017 14:15:11 -0400
Date:   Tue, 2 May 2017 14:15:11 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 14/25] setup_discovered_git_dir(): plug memory leak
Message-ID: <20170502181511.wxr75p2uuwc4nni2@sigill.intra.peff.net>
References: <cover.1493387231.git.johannes.schindelin@gmx.de>
 <cover.1493740497.git.johannes.schindelin@gmx.de>
 <ab131705c4383dc408860b516b1e18b0753b0cbf.1493740497.git.johannes.schindelin@gmx.de>
 <CAGZ79kbsy1qh02WjX0nt6ci4r+5DVxJcPzwburBf0TP0qaEMTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbsy1qh02WjX0nt6ci4r+5DVxJcPzwburBf0TP0qaEMTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2017 at 10:20:29AM -0700, Stefan Beller wrote:

> > -                       gitdir = real_pathdup(gitdir, 1);
> > +                       gitdir = to_free = real_pathdup(gitdir, 1);
> >                 if (chdir(cwd->buf))
> >                         die_errno("Could not come back to cwd");
> 
> As the original motivation was to shut up Coverity, this may not
> accomplish that goal, as in the path of taking the die_errno, we do not
> free `to_free`. But that is ok as the actual goal is to hav no memleaks
> in the good case. A memleak just before a die is no big deal.

I think Coverity understands our NORETURN attributes, so this should be
fine (and if it doesn't, then we should fix that in the model file; but
from the general results I've seen, it does).

-Peff
