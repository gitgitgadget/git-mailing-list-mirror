Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B55A1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAGIUo (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:20:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:56262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725306AbfAGIUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:20:44 -0500
Received: (qmail 32421 invoked by uid 109); 7 Jan 2019 08:20:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:20:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 601 invoked by uid 111); 7 Jan 2019 08:20:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:20:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:20:42 -0500
Date:   Mon, 7 Jan 2019 03:20:42 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com,
        Jan Palus <jpalus@fastmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/1] Revert "t/lib-git-daemon: record daemon log"
Message-ID: <20190107082041.GA21362@sigill.intra.peff.net>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
 <20181125220138.GK4883@hank.intra.tgummerer.com>
 <20181126164252.GA27711@sigill.intra.peff.net>
 <20181220164150.GB25639@hank.intra.tgummerer.com>
 <20190106175310.GC25639@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190106175310.GC25639@hank.intra.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 06, 2019 at 05:53:10PM +0000, Thomas Gummerer wrote:

> This reverts commit 314a73d658 (t/lib-git-daemon: record daemon log,
> 2018-01-25), which let tests use the output of git-daemon.
> 
> The previous commit removed the last user of deamon.log in the tests,
> there's no good way to make checking for output in the log
> race-proof.  Revert this commit as well, to make sure others are not
> tempted to use daemon.log in tests in the future, which would lead to
> racy tests.
> 
> The original commit had one change that still makes sense, namely
> switching read/echo for "read -r" and "printf", which relays the data
> more faithfully.  Don't revert that piece here, as it is still a
> useful change.
> 
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

Yep, this looks good to me. Thanks for being extra careful with the
read/printf bits!

Looks like Junio already queued a99653a9b6 (Revert "t/lib-git-daemon:
record daemon log", 2018-12-28) on the tip of tg/t5570-drop-racy-test,
but that's a pure revert. I think we can replace it with this.

-Peff
