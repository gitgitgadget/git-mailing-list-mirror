Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C27620248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfCCRLo (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:11:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:36606 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726293AbfCCRLo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:11:44 -0500
Received: (qmail 13433 invoked by uid 109); 3 Mar 2019 17:11:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 Mar 2019 17:11:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16457 invoked by uid 111); 3 Mar 2019 17:12:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 03 Mar 2019 12:12:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Mar 2019 12:11:42 -0500
Date:   Sun, 3 Mar 2019 12:11:42 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190303171141.GC23811@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <20190301215414.GB1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022056500.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903022056500.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 08:57:57PM +0100, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Fri, 1 Mar 2019, Jeff King wrote:
> 
> > On Fri, Mar 01, 2019 at 04:36:19PM -0500, Jeff King wrote:
> > 
> > > > This has one notable consequence: we no longer include
> > > > `command-list.h` in `LIB_H`, as it is a generated file, not a
> > > > tracked one.
> > > 
> > > We should be able to add back $(GENERATED_H) as appropriate. I see you
> > > did it for the non-computed-dependencies case. Couldn't we do the same
> > > for $(LOCALIZED_C) and $(CHK_HDRS)?
> > 
> > Answering my own question somewhat: $(CHK_HDRS) explicitly ignores the
> > generated headers, so we wouldn't want to bother re-adding it there
> > anyway. Possibly $(LOCALIZED_C) would care, though. The generated file
> > does have translatable strings in it.
> 
> Yes, and it is defined thusly:
> 
> 	LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
> 
> So it does include the generated headers explictly anyway, with or without
> my patch.

Oops, I should have read the source more carefully before responding.

Is it worth mentioning in the commit message? I.e., something like:

   This has one notable consequence: we no longer include
   `command-list.h` in `LIB_H`, as it is a generated file, not a tracked
   one, but that is easily worked around. Of the three sites that use
   `LIB_H`, two (`LOCALIZED_C` and `CHK_HDRS`) already handle generated
   headers separately. In the third, the computed-dependency fallback,
   we can just add in a reference to $(GENERATED_H).

-Peff
