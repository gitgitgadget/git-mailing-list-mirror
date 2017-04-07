Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 332EF20966
	for <e@80x24.org>; Fri,  7 Apr 2017 06:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbdDGGbE (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 02:31:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbdDGGbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 02:31:03 -0400
Received: (qmail 30427 invoked by uid 109); 7 Apr 2017 06:30:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 06:30:59 +0000
Received: (qmail 32373 invoked by uid 111); 7 Apr 2017 06:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 02:31:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 02:30:57 -0400
Date:   Fri, 7 Apr 2017 02:30:57 -0400
From:   Jeff King <peff@peff.net>
To:     Joachim Durchholz <jo@durchholz.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: problem with backslash in directory name
Message-ID: <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e3af7d6-a2c1-2673-53cc-d4c5105d9051@durchholz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 08:12:49AM +0200, Joachim Durchholz wrote:

> So... something inside "git submodule add" is replacing the \b with a
> backspace control code.
> [...]
> Whatever that "something" is, it is not doing shell expansion, otherwise it
> would have started an interactive calculator session.

Probably it's "read" which does backslash expansion, but nothing else.
Just grepping git-submodule.sh, some of the "read" calls should probably
be "read -r" (I also don't know how some of those loops would cope with
a submodule name that needed quoting).

-Peff
