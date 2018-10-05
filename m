Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A921F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeJFC20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:28:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:43604 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728061AbeJFC20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:28:26 -0400
Received: (qmail 25186 invoked by uid 109); 5 Oct 2018 19:28:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 19:28:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15208 invoked by uid 111); 5 Oct 2018 19:27:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 15:27:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 15:28:16 -0400
Date:   Fri, 5 Oct 2018 15:28:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
Message-ID: <20181005192816.GE17482@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <878t3cgqd2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t3cgqd2.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 09:12:09PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I'm not wild about declaring functions inside macros, just because it
> > makes tools like ctags like useful (but I have certainly been guilty of
> > it myself). I'd also worry that taking "code" as a macro parameter might
> > not scale (what happens if the code has a comma in it?)
> 
> There's always the option of generating the C code as part of some build
> step and carrying around a big C file with various type-safe functions
> that only differ in the types they operate on. It can even be committed
> to source control.
> 
> That sucks in some ways for sure, but is a lot friendlier for grepping,
> ctags etc.

Yeah, in a lot of ways the C preprocessor is not great for larger-scale
code generation. I was hoping we could get away without having the
bodies of these functions as part of the generated bit, though.

I think what René showed later in the thread is not too bad in that
respect.

> I've just barely resisted the urge to include that thread where we were
> discussing making the code C++-compiler compatible in the References
> header :)

Yes. The main thing I would want out of using C++ is type-safe,
efficient data structures. IIRC, early versions of C++ were implemented
via code generation, and we're basically walking down that same road.

I'm not sure where the right cutoff is, though. It's nice to pick up
the solution somebody else produced, but requiring a C++ compiler to
build Git is a pretty big step that I imagine will create a lot of new
problems. (We're just now allowing C99 -- I don't even want to think
about what kind of compiler issues we'll run into on antique systems
trying to use C++).

-Peff
