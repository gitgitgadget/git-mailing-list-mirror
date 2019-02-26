Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83C620248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBZRnT (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:43:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:58718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727108AbfBZRnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:43:19 -0500
Received: (qmail 1055 invoked by uid 109); 26 Feb 2019 17:43:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Feb 2019 17:43:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30801 invoked by uid 111); 26 Feb 2019 17:43:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Feb 2019 12:43:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2019 12:43:17 -0500
Date:   Tue, 26 Feb 2019 12:43:17 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190226174316.GD19606@sigill.intra.peff.net>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226170400.GC19739@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 06:04:00PM +0100, SZEDER Gábor wrote:

> > Whereas:
> > 
> >     + test -f doesnotexist
> >     + echo File doesnotexist doesn't exist.
> >     File doesnotexist doesn't exist.
> >     + false
> >     error: last command exited with $?=1
> > 
> > Gives me the same thing, but I have to read 5 lines instead of 2 that
> > ultimately don't tell me any more (and a bit of "huh, 'false' returned
> > 1? Of course! Oh! It's faking things up and it's the 'echo' that
> > matters...").
> 
> I didn't find this to be an issue, but because of functions like
> 'test_seq' and 'test_must_fail' I've thought about suppressing '-x'
> output for test helpers (haven't actually done anything about it,
> though).

I'd be curious how you'd do that. We can wrap the function and redirect
its stderr, but you'd still get a crufty line invoking the inner
function (plus the outer function). That's better than seeing the inner
details, but not as nice as just seeing the outer function invocation.

I don't think we can play games like the one we do in test_eval_(),
because "set -x" will already be on.

-Peff
