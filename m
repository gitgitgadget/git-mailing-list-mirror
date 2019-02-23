Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4FA20248
	for <e@80x24.org>; Sat, 23 Feb 2019 13:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfBWNeV (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 08:34:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:55510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725954AbfBWNeV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 08:34:21 -0500
Received: (qmail 22857 invoked by uid 109); 23 Feb 2019 13:34:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Feb 2019 13:34:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4154 invoked by uid 111); 23 Feb 2019 13:34:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 23 Feb 2019 08:34:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2019 08:34:19 -0500
Date:   Sat, 23 Feb 2019 08:34:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] format-patch: --no-clobber refrains from overwriting
 output files
Message-ID: <20190223133418.GD22403@sigill.intra.peff.net>
References: <20190222201111.98196-1-gitster@pobox.com>
 <20190222201111.98196-4-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222201111.98196-4-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 12:11:11PM -0800, Junio C Hamano wrote:

> If you keep an output for an older iteration of the same topic in
> the same directory around and use "git format-patch" to prepare a
> newer iteration of the topic, those commits that happen to be at the
> same position in the series that have not been retitled will get the
> same filename---and the command opens them for writing without any
> check.
> 
> Existing "-o outdir" and "-v number" options are both good ways to
> avoid such name collisions, and in general helps to give good ways
> to compare the latest iteration with older iteration(s), but let's
> see if "--no-clobber" option that forbids overwrting existing files
> would also help people.

I suspect it won't help much, because remembering to use --no-clobber is
just as hard as remembering to clean up the stale patches in the first
place.

If we were starting from scratch, I'd suggest that --no-clobber be the
default[1]. But at this point I wonder if people would be annoyed
(because the clobbering behavior is convenient and works _most_ of the
time, as long as you don't add, remove, reorder, or retitle patches).

I suppose that implies having a config option, so at least people who
want it only have to remember once.

>  Documentation/git-format-patch.txt |  8 +++++++-
>  builtin/log.c                      | 32 ++++++++++++++++++++++++------
>  t/t4014-format-patch.sh            | 16 +++++++++++++++
>  3 files changed, 49 insertions(+), 7 deletions(-)

The patch itself looks well done.

-Peff

[1] Actually, I'd suggest that --stdout be the default, which is what I
    always use. But then I typically feed the result into mutt anyway.
    Separate files is probably nicer if you're hand-editing.
