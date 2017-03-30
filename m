Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F4020966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934583AbdC3UAZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:00:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:54373 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934033AbdC3UAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:00:25 -0400
Received: (qmail 26540 invoked by uid 109); 30 Mar 2017 20:00:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 20:00:24 +0000
Received: (qmail 2163 invoked by uid 111); 30 Mar 2017 20:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 16:00:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 16:00:22 -0400
Date:   Thu, 30 Mar 2017 16:00:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
Message-ID: <20170330200021.c2l5jak3xb5aoxyc@sigill.intra.peff.net>
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 09:35:27PM +0200, Jakub Narębski wrote:

> And everything would be all right... if not the fact that Git appends
> spurious ^M to added lines in the `git diff` output.  Files use CRLF
> end-of-line convention (the native MS Windows one).
> 
>   $ git diff test.tex
>   diff --git a/test.tex b/test.tex
>   index 029646e..250ab16 100644
>   --- a/test.tex
>   +++ b/test.tex
>   @@ -1,4 +1,4 @@
>   -\documentclass{article}
>   +\documentclass{mwart}^M
>   
>    \usepackage[cp1250]{inputenc}
>    \usepackage{polski}
> 
> What gives?  Why there is this ^M tacked on the end of added lines,
> while it is not present in deleted lines, nor in content lines?

Perhaps it's trailing whitespace highlighting for added lines? You can
add "cr-at-eol" to core.whitespace to suppress it.

I suspect in the normal case that git is doing line-ending conversion,
but it's suppressed when textconv is in use.

-Peff
