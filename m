Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AAEC433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 09:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7272D205CB
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 09:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIAJ1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:27:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:46052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgIAJ1d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 05:27:33 -0400
Received: (qmail 25551 invoked by uid 109); 1 Sep 2020 09:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2020 09:27:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24849 invoked by uid 111); 1 Sep 2020 09:27:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 05:27:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 05:27:31 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add struct strmap and associated utility functions
Message-ID: <20200901092731.GA1268661@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <20200821201648.GH1165@coredump.intra.peff.net>
 <CABPp-BGYiphp-93Bf=2z-ZLd-Y=buTA0BCp6zuTJF39n1x3Rfw@mail.gmail.com>
 <20200828070335.GB2105050@coredump.intra.peff.net>
 <CABPp-BGQB8rD8KyzccTQQ_X3Puyy3g5OOSEQES8Lv8Qtb-zRPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGQB8rD8KyzccTQQ_X3Puyy3g5OOSEQES8Lv8Qtb-zRPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 08:29:44AM -0700, Elijah Newren wrote:

> > It may also be a sign that we should be growing the hash more
> > aggressively in the first place. Of course all of this is predicated
> > having some benchmarks. It would be useful to know which part actually
> > provided the speedup.
> 
> Your thoughts here are great; I also had another one this past week --
> I could introduce a hashmap_partial_clear() (in addition to
> hashmap_clear()) for the special usecase I have of leaving the table
> allocated and pre-sized.  It'd prevent people from accidentally using
> it and forgetting to free stuff, while still allowing me to take
> advantage.  But, as you say, more benchmarks would be useful to find
> which parts provided the speedup before taking any of these steps.

Yeah, having a separate function to explicitly do "remove all elements
but keep the table allocated" would be fine with me. My big desire is
that clear() should do the safe, non-leaking thing by default.

-Peff
