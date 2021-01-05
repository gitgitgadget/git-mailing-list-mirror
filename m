Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E527C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B9822D5A
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbhAEUBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 15:01:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:46736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbhAEUBx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 15:01:53 -0500
Received: (qmail 30316 invoked by uid 109); 5 Jan 2021 20:01:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Jan 2021 20:01:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30785 invoked by uid 111); 5 Jan 2021 20:01:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Jan 2021 15:01:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Jan 2021 15:01:11 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Utku <ugultopu@gmail.com>, git@vger.kernel.org
Subject: Re: How to get the branch HEAD points to using a plumbing command?
Message-ID: <X/TFh+SLYqbT1lT9@coredump.intra.peff.net>
References: <132D030A-AAD3-4EFC-9858-7EA39503A746@gmail.com>
 <8735zfs8xj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735zfs8xj.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 05, 2021 at 04:24:56PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > My question is, is there a "better" (more idiomatic, less
> > "expensive", etc.) way of doing it using only one plumbing command?
> > This solution is OK but it is more work than just matching one line
> > with a regular expression. The reason I want to do this using only
> > plumbing commands is because I think that plumbing command interface
> > would be more stable than the format (organization, structure) of
> > files under the `.git/` directory across Git versions. Please
> > correct me if I'm wrong in this idea as well.
> 
> You'll want to use git-rev-parse for this, e.g.:
> 
>     $ git rev-parse --symbolic-full-name HEAD
>     refs/heads/master

Another option is:

  git symbolic-ref HEAD

which has the benefit of working even when HEAD points to an unborn
branch. It also has a --short option to drop the refs/heads/ part.

It's also worth noting what you'd see on a detached HEAD. With rev-parse
you'll see "HEAD", but symbolic-ref will exit with a non-zero code.

-Peff
