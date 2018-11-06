Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997F11F453
	for <e@80x24.org>; Tue,  6 Nov 2018 19:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbeKGE7Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 23:59:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:42634 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387804AbeKGE7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 23:59:23 -0500
Received: (qmail 11902 invoked by uid 109); 6 Nov 2018 19:32:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 19:32:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3162 invoked by uid 111); 6 Nov 2018 19:31:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 14:31:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 14:32:36 -0500
Date:   Tue, 6 Nov 2018 14:32:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: Regression in rebase-in-C with rebase.autoStash=true
Message-ID: <20181106193235.GA8902@sigill.intra.peff.net>
References: <pull.56.git.gitgitgadget@gmail.com>
 <878t2671dc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t2671dc.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 02:59:43PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Tue, Oct 23 2018, Johannes Schindelin via GitGitGadget wrote:
> 
> > Johannes Schindelin (2):
> >   rebase --autostash: demonstrate a problem with dirty submodules
> >   rebase --autostash: fix issue with dirty submodules
> >
> >  builtin/rebase.c            |  2 +-
> >  t/t3420-rebase-autostash.sh | 10 ++++++++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> There's another bug with rebase.autoStash in master (and next/pu) but
> not v2.19.0. I tried to bisect bit it just comes down to 5541bd5b8f
> ("rebase: default to using the builtin rebase", 2018-08-08).

That's just flipping the config default. If you add "-c
rebase.usebuiltin=true" to your invocation here:

>         git -c rebase.autoStash=true -c pull.rebase=true pull &&

you can bisect further. However, the results weren't super useful, as I
had to skip a bunch of commits (ones that did die("TODO") or just
complained that the working tree wasn't clean; if you treat the latter
as "bad", then it just bisects to e0333e5c63 (builtin rebase: require a
clean worktree, 2018-09-04).

-Peff
