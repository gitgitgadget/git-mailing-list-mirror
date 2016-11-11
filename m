Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5E42035F
	for <e@80x24.org>; Fri, 11 Nov 2016 18:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935023AbcKKSRc (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 13:17:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:41922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934973AbcKKSR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 13:17:29 -0500
Received: (qmail 22819 invoked by uid 109); 11 Nov 2016 18:17:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 18:17:01 +0000
Received: (qmail 16030 invoked by uid 111); 11 Nov 2016 18:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 11 Nov 2016 13:17:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2016 13:16:59 -0500
Date:   Fri, 11 Nov 2016 13:16:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like
 shell variables
Message-ID: <20161111181658.bwclcxedsrs4wcu6@sigill.intra.peff.net>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
 <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
 <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
 <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 06:31:48PM +0100, Johannes Sixt wrote:

> We have to use $PWD instead of $(pwd) because on Windows the latter
> would add a C: style path to bash's Unix-style $PATH variable, which
> becomes confused by the colon after the drive letter. ($PWD is a
> Unix-style path.)
> 
> In the case of GIT_ALTERNATE_OBJECT_DIRECTORIES, bash on Windows
> assembles a Unix-style path list with the colon as separators. It
> converts the value to a Windows-style path list with the semicolon as
> path separator when it forwards the variable to git.exe. The same
> confusion happens when bash's original value is contaminated with
> Windows style paths.

So on reading your original I wondered why you did not need to use the
";", and that explains it. But wow, it's subtle.

I don't know what people typically write in the wild, and if it's worth
actually testing explicitly the ";" case. I'll leave that to Windows
people to debate.

-Peff
