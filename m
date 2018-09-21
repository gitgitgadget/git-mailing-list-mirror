Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D67C1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeIVEPs (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:15:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725748AbeIVEPs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:15:48 -0400
Received: (qmail 5348 invoked by uid 109); 21 Sep 2018 22:24:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 22:24:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9303 invoked by uid 111); 21 Sep 2018 22:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 18:24:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 18:24:54 -0400
Date:   Fri, 21 Sep 2018 18:24:54 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Gniazdowski <psprint@zdharma.org>
Cc:     git@vger.kernel.org
Subject: Re: Very simple popen() code request, ground-shaking functionality
 openned by it
Message-ID: <20180921222454.GD11177@sigill.intra.peff.net>
References: <315083291.15466.1537536854535@privateemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <315083291.15466.1537536854535@privateemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 09:34:14AM -0400, Sebastian Gniazdowski wrote:

> Git default progress indicator for clone is very unattractive, IMO. It
> does its job in providing all the operation details very well, but I
> bet most of users strongly dream about a gauge box!
> 
> Have a look at my gauge box constructed as git-stderr pipe script:
> https://asciinema.org/a/202401
> 
> The main point of my feature request is: git can add
> core.progress_pipe option, where e.g. `/usr/local/bin/mygauge' will be
> set (a script like the one in the asciinema), and then simply do the
> ground-school-known `popen("/usr/local/bin/mygauge","r+")', and write
> **unchanged current-progress data** to the pipe, then read from the
> pipe and forward to `stderr', where the progress normally lands in.
> 
> This will allow users to free their creativity and provide probably
> dozens of custom Git progress bars.

I don't personally feel that the existing progress bar is that bad, but
if anybody wants to pursue this, I think the most sensible path is:

  1. Add a trace_key for sending machine-readable progress output to a
     descriptor or file. E.g., via setting GIT_TRACE_PROGRESS=2 in the
     environment.

  2. Teach the trace code to open a command for piping, so that you
     could do something like GIT_TRACE_PROGRESS='|mygauge'.

That would make your use case work, and I think many other use cases
would benefit from both of those features independently.

-Peff
