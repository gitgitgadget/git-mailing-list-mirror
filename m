Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC79520248
	for <e@80x24.org>; Fri, 15 Mar 2019 03:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCODJ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 23:09:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:51842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726719AbfCODJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 23:09:29 -0400
Received: (qmail 14397 invoked by uid 109); 15 Mar 2019 03:09:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 03:09:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28574 invoked by uid 111); 15 Mar 2019 03:08:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 23:08:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 23:08:12 -0400
Date:   Thu, 14 Mar 2019 23:08:12 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool: allow running outside Git worktrees with
 --no-index
Message-ID: <20190315030811.GA28943@sigill.intra.peff.net>
References: <pull.163.git.gitgitgadget@gmail.com>
 <9f6eb60eeeccf920af83652899c5bc2d40e2092f.1552504812.git.gitgitgadget@gmail.com>
 <20190313204644.GA5397@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903141305550.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903141305550.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 01:16:45PM +0100, Johannes Schindelin wrote:

> In other words, my take is that the ways in which `--no-index` is used are
> probably not very different from one another, and the bugs lurk in
> really rarely exercised code paths.

Yeah, that's more likely (and consistent with the bugs I remember fixing
in the last few years).

> > We'd just have to remember to add it back to the argv of diff
> > sub-commands we run.
> 
> It was that "add it back" that I was not keen to implement.

Yes, I saw that we pass on the argv we get back from parse_options()
literally to the sub-functions. I was thinking you'd do some trickery
with an argv_array. But I like your approach of using OPT_ARGUMENT()
much better.

> So I was already done with implementing `OPT_ARGUMENT_SEEN()`, based on
> `OPT_ARGUMENT()`, and testing it with my difftool patch, when it occurred
> to me to look what existing users of `OPT_ARGUMENT()` do. Guess what:
> there are none, apart from that test helper used in t0040 to verify that
> `parse_options()` works as intended. And there were none other. In the
> entire commit history.

Heh. That is not the first time I have hit that with the parse-options
code.

I see you posted the new patches, so I'll try to give a careful read in
that part of the thread.

-Peff
