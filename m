Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7823CC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 15:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381899AbhLCPzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:55:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:43074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239659AbhLCPzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 10:55:49 -0500
Received: (qmail 23893 invoked by uid 109); 3 Dec 2021 15:52:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 15:52:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1906 invoked by uid 111); 3 Dec 2021 15:52:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 10:52:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 10:52:23 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
Message-ID: <Yao9NwxQ91XO8k1G@coredump.intra.peff.net>
References: <20211203034420.47447-1-sunshine@sunshineco.com>
 <20211203034420.47447-3-sunshine@sunshineco.com>
 <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
 <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com>
 <211203.865ys5soqk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211203.865ys5soqk.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 03:57:41PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > One caution that springs to mind is that there may be external tooling
> > which processes these documentation files directly, and such a change
> > might break them. (The one which popped to mind immediately was the
> > git-scm.{org,com} website, though I don't know what their tooling
> > looks like.)
> 
> True, I hadn't looked into how that worked before, but behold!
> https://github.com/git/git-scm.com/blob/main/lib/tasks/index.rake
> 
> It seems to be a re-implementation of a non-trivial part of the doc
> building process.

Yeah. It's kind of ugly, but the complication there is that the docs are
updated on a running heroku dyno which does not actually have a clone of
the new version of Git, let alone an actual build.

It's also hard for it to just use the output of our "make" anyway, since
there's some munging that happens to fit the page content inside the
rest of the site, changing links, etc. We could in theory operate on the
result of "make html" more directly, but it would definitely require
some changes.

IMHO the way the site operates now (with "live" updates by extracting
content from git.git and shoving it into a database) is not ideal. It's
not like we're importing new Git versions once per minute. It would be
easier to reason about as a "static site" which is built by a process
which actually has a clone of git.git and invokes "make html" there,
post-processes the pages, and saves the whole thing as a Git tree. And
then run that build occasionally (at new releases, or changes to the
source, but also periodically via GitHub Actions or similar to pick up
changed book content). It's just a big enough change (and there are some
gotcha around things like site search) that I've never gotten around to
it.

-Peff
