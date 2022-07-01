Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D973C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiGASVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiGASVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:21:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D61A805
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:21:51 -0700 (PDT)
Received: (qmail 9827 invoked by uid 109); 1 Jul 2022 18:21:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 18:21:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27677 invoked by uid 111); 1 Jul 2022 18:21:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 14:21:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 14:21:50 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Pavel Rappo <pavel.rappo@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: How to reduce pickaxe times for a particular repo?
Message-ID: <Yr87Pt8/l2Tte/Gd@coredump.intra.peff.net>
References: <CAChcVumN66OxOjag9gPqgLq7gQrgdaEkZAJabusE-gGC7LLVyw@mail.gmail.com>
 <6439e948-ff79-9e10-97f5-378806e25b5b@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6439e948-ff79-9e10-97f5-378806e25b5b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 09:01:17AM -0400, Derrick Stolee wrote:

> > Typically, a `git log -S/-G` lookup takes around a minute to complete.
> > I would like to significantly reduce that time. How can I do that? I
> > can spend up to 10x more disk space, if required. The machine has 10
> > cores and 32GB of RAM.
> 
> You are using -S<string> or -G<regex> to see which commits change the
> number of matches of that <string> or <regex>. If you don't provide a
> pathspec, then Git will search every changed file, including those
> very large binary files.
> 
> Perhaps you'd like to start by providing a pathspec that limits the
> search to only the meaningful code files?

I think "-S" will search every file, since it's just counting instances
of the token in each file. But "-G" does a diff first, so it skips
binary files. So you could probably speed it up in general with a
.gitattributes that mark large binary files as such. Sort of the same
concept as your pathspec suggestion (which is a good one), but you don't
have to remember to add it to each invocation. :)

-Peff
