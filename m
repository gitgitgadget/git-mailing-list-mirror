Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5893C2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 14:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933319AbcJYO5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 10:57:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757787AbcJYO45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 10:56:57 -0400
Received: (qmail 32046 invoked by uid 109); 25 Oct 2016 14:56:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 14:56:56 +0000
Received: (qmail 1959 invoked by uid 111); 25 Oct 2016 14:57:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 10:57:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2016 10:56:54 -0400
Date:   Tue, 25 Oct 2016 10:56:54 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/7] read info/{attributes,exclude} only when in
 repository
Message-ID: <20161025145654.6cd3lb2gsgjtc5ou@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020061641.3enppkoxfzr76has@sigill.intra.peff.net>
 <CACsJy8Bk32TcivD-5UO28UhdbpvCcxTE71cxFO2p_A4TZ1+GVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bk32TcivD-5UO28UhdbpvCcxTE71cxFO2p_A4TZ1+GVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 07:24:50PM +0700, Duy Nguyen wrote:

> > Let's detect this situation explicitly and skip reading the
> > file (i.e., the same behavior we'd get if we were in a
> > repository and the file did not exist).
> 
> On the other hand, if we invoke attr machinery too early by mistake,
> before setup_git_directory* is called, then we skip
> .git/info/attributes file as well even though I think we should shout
> "call setup_git_directory first!" so the developer can fix it.

> I wonder if we should have two flags in startup_info to say "yes
> setup_git_dir... has been called, you can trust
> startup_info->have_repository" and "yes, i do not call setup_git_dir
> on purpose, quit complaining" then we could still catch unintended
> .git/info/attributes ignore while letting git grep --no-index work
> correctly.

Yeah, it would be nice for the low-level code to be able to detect such
errors. I don't mind if you want to extend startup_info in that way, but
it will probably introduce a period of instability and regressions
(sites that are perfectly fine, but forgot to set the "I know what I'm
doing" flag).

-Peff
