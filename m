Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDECC6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDVNwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDVNwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 09:52:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6691707
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 06:52:35 -0700 (PDT)
Received: (qmail 13596 invoked by uid 109); 22 Apr 2023 13:52:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 13:52:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28996 invoked by uid 111); 22 Apr 2023 13:52:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 09:52:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 09:52:34 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>, git@vger.kernel.org
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Message-ID: <20230422135234.GB3516940@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g>
 <20230418041253.GD60552@coredump.intra.peff.net>
 <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 10:02:44AM -0400, Derrick Stolee wrote:

> On 4/18/2023 12:12 AM, Jeff King wrote:
> 
> > One thing the commit graph perhaps _could_ do is omit the commit, or
> > mark it as "this one is broken in some way". And then fall back to
> > parsing those few instead (which is slower, but if it's a small minority
> > of commits, that's OK). But I don't think there's any code for that.
> 
> The "broken" commit would need to be included in the commit-graph file
> so its children can point to it using a graph position, but then it
> would revert to parsing from the commit object (due to some new concept
> storing "this is a bad commit").
> 
> If we decided to treat a timestamp of 0 as "probably broken, artificial
> at best" then we wouldn't need the new indicator in the commit-graph
> file, but this seems like quite a big hammer for a small case.

Makes sense. I punted on doing anything here for the series I just
posted, since the workaround of "blow away your commit graph and
rebuild" is probably sufficient for such obscure cases. And going
forward, new commit graphs would be built with the fixed parser anyway,
so it becomes less of a problem over time.

-Peff
