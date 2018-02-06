Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD991F404
	for <e@80x24.org>; Tue,  6 Feb 2018 02:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeBFCNR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 21:13:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:41674 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752069AbeBFCNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 21:13:16 -0500
Received: (qmail 4117 invoked by uid 109); 6 Feb 2018 02:13:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Feb 2018 02:13:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14606 invoked by uid 111); 6 Feb 2018 02:13:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Feb 2018 21:13:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Feb 2018 21:13:14 -0500
Date:   Mon, 5 Feb 2018 21:13:14 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
Message-ID: <20180206021313.GA26323@sigill.intra.peff.net>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
 <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
 <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 05, 2018 at 08:28:10PM +0700, Duy Nguyen wrote:

> >> This is still leaking 'worktrees'[1]. You probably want
> >> free_worktrees() immediately after the find_worktree() invocation.
> >
> > Sorry, free_worktrees() after the last use of 'wt' since you still
> > need to access its fields, which would be the end of the function.
> 
> I learned SANITIZE=leak today! It not only catches this but also "dst".
> 
> Jeff is there any ongoing effort to make the test suite pass with
> SANITIZE=leak? My t2038 passed, so I went ahead with the full test
> suite and saw so many failures. I did see in your original mails that
> you focused on t0000 and t0001 only..

Yeah, I did those two scripts to try to prove to myself that the
approach was good. But I haven't really pushed it any further.

Martin Ågren (cc'd) did some follow-up work, but I think we still have a
long way to go. My hope is that people who are interested in
leak-checking their new code can run some specific script they're
interested in, and maybe fix up one or two nearby bits while they're
there (either by fixing a leak, or just annotating via UNLEAK). Then we
can slowly converge on correctness. :)

-Peff
