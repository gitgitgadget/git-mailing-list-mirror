Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CBA1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeKNRbM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:31:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:38670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727576AbeKNRbM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:31:12 -0500
Received: (qmail 3422 invoked by uid 109); 14 Nov 2018 07:29:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 07:29:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31447 invoked by uid 111); 14 Nov 2018 07:28:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 02:28:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 02:29:09 -0500
Date:   Wed, 14 Nov 2018 02:29:09 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] rebase: understand -C again, refactor
Message-ID: <20181114072909.GD19904@sigill.intra.peff.net>
References: <pull.76.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.76.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 04:38:24AM -0800, Johannes Schindelin via GitGitGadget wrote:

> Phillip Wood reported a problem where the built-in rebase did not understand
> options like -C1, i.e. it did not expect the option argument.
> 
> While investigating how to address this best, I stumbled upon 
> OPT_PASSTHRU_ARGV (which I was so far happily unaware of).

I was unaware of it, too. Looking at the OPT_PASSTHRU and its ARGV
counterpart, I think the original intent was that you'd pass through
normal last-one-wins individual options with OPT_PASSTHRU, and then
list-like options with OPT_PASSTHRU_ARGV. But here you've used the
latter to pass sets of individual last-one-wins options.

That said, I think what you've done here is way simpler and more
readable than using a bunch of OPT_PASSTHRUs would have been. And even
if it was not the original intent of the ARGV variant, I can't see any
reason to avoid doing it this way.

-Peff
