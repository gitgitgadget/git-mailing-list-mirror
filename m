Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39A9C05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 01:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBKBjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 20:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKBjY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 20:39:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA48453E
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:39:23 -0800 (PST)
Received: (qmail 21074 invoked by uid 109); 11 Feb 2023 01:39:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 01:39:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30083 invoked by uid 111); 11 Feb 2023 01:39:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 20:39:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 20:39:21 -0500
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <Y+bxye2zOCMAEJhN@coredump.intra.peff.net>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
 <20230209163400.xi7j3ivd4k6gqoc7@jcai-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209163400.xi7j3ivd4k6gqoc7@jcai-ubuntu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2023 at 11:34:00AM -0500, John Cai wrote:

> > From the user's perspective, this is weirdly inconsistent with the
> > existing diff attributes, which would be more like:
> > 
> >   # in .gitattributes
> >   *.json diff=json 
> > 
> >   # in config
> >   [diff "json"]
> >   algorithm = histogram
> 
> Thanks for this suggestion, Peff. What I like about this is that it builds off
> of the existing diff.<driver> scheme rather than inventing another one.
> Additionally, we won't get hit with a performance penalty since we already read
> gitattrbitues to see if a driver has been set or not.
> 
> Thinking out loud, if we add "algorithm" as a key for diff.<driver>, it would be
> mutually exclusive with "command" where "command" takes precedence, correct?

Yes. I think the documentation would be something like "When generating
a diff internally, use <algorithm> to do so." And external diffs
obviously skip that code path internally.

I didn't check whether your patch does this or not, but should this
feature (however it is engaged) apply to diff-stats, too? I think
--patience, etc, does, which makes sense. But that might be something
worth elaborating in the description, too.

-Peff
