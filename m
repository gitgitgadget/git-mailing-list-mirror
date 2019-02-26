Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD55220248
	for <e@80x24.org>; Tue, 26 Feb 2019 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfBZSYK (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 13:24:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:58832 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728920AbfBZSYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 13:24:10 -0500
Received: (qmail 2227 invoked by uid 109); 26 Feb 2019 18:24:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Feb 2019 18:24:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31274 invoked by uid 111); 26 Feb 2019 18:24:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Feb 2019 13:24:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2019 13:24:08 -0500
Date:   Tue, 26 Feb 2019 13:24:08 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@matthieu-moy.fr>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190226182407.GF19606@sigill.intra.peff.net>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
 <86va1630g4.fsf@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86va1630g4.fsf@matthieu-moy.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 06:48:43PM +0100, Matthieu Moy wrote:

> > '-x' tracing doesn't work in all test scripts, unless it is run with a
> > Bash version already supporting BASH_XTRACEFD, i.e. v4.1 or later.
> > Notably the default Bash shipped in macOS is somewhere around v3.2.
> 
> According to http://www.tldp.org/LDP/abs/html/bashver4.html#AEN21183,
> bash 4.1 was released on May, 2010. Are you sure macOS is _that_ late?

It's not "late", it's "never". Bash 4 switched to GPLv3.

> I also tried with dash, and -x seems to work fine too (I use "works with
> dash" as a heuristic for "should word on any shell", but it doesn't
> always work).

Yes, "-x" works everywhere. The problem is scripts which capture the
stderr of subshells or functions, which then get polluted by "-x"
output. You can fix that in two ways:

  1. Use bash 4.1+, which works around that with BASH_XTRACEFD.

  2. Don't do that. Gábor fixed most such instances already, except the
     ones in t1510. That one automatically disables "-x" tracing.

So I don't know what you tried exactly, but you should be able to
successfully run with "-x" on any script. Including t1510, but you
just won't get tracing output then.

> If -x doesn't work in some setups, it may be a good reason to wait a bit
> before trashing test_path_is_*, but if it's clear enough that the vast
> majority of platforms get -x, then why not trash these wrappers indeed.

I do think it basically works everywhere these days.

-Peff
