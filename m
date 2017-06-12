Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924DA20C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdFLVpF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:45:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:38554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdFLVpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:45:04 -0400
Received: (qmail 3735 invoked by uid 109); 12 Jun 2017 21:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:45:04 +0000
Received: (qmail 16907 invoked by uid 111); 12 Jun 2017 21:45:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:45:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:45:02 -0400
Date:   Mon, 12 Jun 2017 17:45:02 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH 0/4] config.h
Message-ID: <20170612214502.xynyfswj2ipf25ah@sigill.intra.peff.net>
References: <20170612213406.83247-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170612213406.83247-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 02:34:02PM -0700, Brandon Williams wrote:

> After some discussion I realized that my 'repository object' series was getting
> to be rather long and increase in scope.  So I've decided to break off these
> couple patches into their own series so they can be reviewed more easily.  This
> should also let them be merged in faster as I suspect it'll take a while for my
> 'repository object' series to be reviewed thourouly and these couple patches
> could result in a lot of merge conflicts as it touches a lot of files.
> 
> Brandon Williams (4):
>   config: create config.h
>   config: remove git_config_iter
>   config: don't include config.h by default
>   config: don't implicitly use gitdir

These all seem reasonable to me. Patch 3 made me shrug a little, because
it seems like the majority of C files end up including it anyway. I
suspect you could break config.h down into two files: the few things
that everybody needs (git_config() and the few parsing functions needed
in callbacks) and the ones for commands that actually manipulate the
config.

That would reduce the surface area of the module that most callers look
at, but I don't think there's a huge benefit to doing so (mostly it just
makes re-compiling faster by decreasing the chance that a dependent
header has changed for each file).

-Peff
