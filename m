Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50872205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 07:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940575AbdAGHfA (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 02:35:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:36351 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754960AbdAGHe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 02:34:58 -0500
Received: (qmail 23369 invoked by uid 109); 7 Jan 2017 07:34:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 07:34:56 +0000
Received: (qmail 23323 invoked by uid 111); 7 Jan 2017 07:35:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 02:35:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2017 02:34:54 -0500
Date:   Sat, 7 Jan 2017 02:34:54 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Trygve Aaberge <trygveaa@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] execv_dashed_external: wait for child on signal death
Message-ID: <20170107073454.mz2pdphipv3gqvfr@sigill.intra.peff.net>
References: <20170107011445.3e4fv6vdtimrwhgv@sigill.intra.peff.net>
 <20170107012223.c27toqr6ck44kfpj@sigill.intra.peff.net>
 <650a25f6-5f22-8efb-3048-6afadbaa7092@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <650a25f6-5f22-8efb-3048-6afadbaa7092@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 07, 2017 at 08:28:22AM +0100, Johannes Sixt wrote:

> > But when you have a dashed external (or an alias pointing to
> > a builtin, which will re-exec git for the builtin), there's
> > an extra process in the mix. For instance, running:
> > 
> >   git -c alias.l=log log
> 
> This should be
> 
>   git -c alias.l=log l

Yeah, it should be.

> For the complete series:
> 
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks.

> What should we add to Documentation/technical/api-run-command.txt about the
> new flag? "Do not use?" "Understand the commit message of <this commit>
> before setting the flag to true?"

I think it can be explained pretty easily as "after killing all children
marked for clean_on_exit, do a blocking waitpid() on any child that is
also marked wait_after_clean". But I notice we do not actually document
clean_on_exit, either, nor most of the options in "struct
child_process".

IMHO it would be an improvement to merge the contents of the
technical/api-run-command.txt documentation into the header file, and
document each option with a comment above its definition. That makes it
a lot easier to have the will to document any newly-added options,
because if you don't they look bad next to the others. :)

Mechanics aside, I am not sure if we need a "do not use" or "here are
the caveats". I think if we explain what it does, we can rely on list
discussion and review to catch any obviously-stupid uses (both of it and
of clean_on_exit).

-Peff
