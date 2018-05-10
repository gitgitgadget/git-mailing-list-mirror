Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B013C1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965939AbeEJOef (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:34:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:34872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965266AbeEJOef (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:34:35 -0400
Received: (qmail 5854 invoked by uid 109); 10 May 2018 14:34:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 14:34:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24894 invoked by uid 111); 10 May 2018 14:34:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 10:34:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 10:34:33 -0400
Date:   Thu, 10 May 2018 10:34:33 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5310-pack-bitmaps: make JGit tests work with
 GIT_TEST_SPLIT_INDEX
Message-ID: <20180510143432.GC25617@sigill.intra.peff.net>
References: <20180510135852.25232-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180510135852.25232-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 03:58:52PM +0200, SZEDER Gábor wrote:

> The two JGit tests 'we can read jgit bitmaps' and 'jgit can read our
> bitmaps' in 't5310-pack-bitmaps.sh' fail when run with
> GIT_TEST_SPLIT_INDEX=YesPlease.  Both tests create a clone of the test
> repository to check bitmap interoperability with JGit.  With split
> indexes enabled the index in the clone repositories contains the
> 'link' extension, which JGit doesn't support and, consequently, an
> exception aborts it:
> 
>   <...>
>   org.eclipse.jgit.api.errors.JGitInternalException: DIRC extension 'link' not supported by this version.
>           at org.eclipse.jgit.dircache.DirCache.readFrom(DirCache.java:562)
>   <...>
> 
> Since testing bitmaps doesn't need a worktree in the first place,
> let's just create bare clones for the two JGit tests, so the cloned
> won't have an index, and these two tests can be executed even with
> split index enabled.

Nice, this seems like a clever workaround.

Reviewed-by: Jeff King <peff@peff.net>

The more heavy-handed approach would be to just disable the JGIT prereq
when GIT_TEST_SPLIT_INDEX is in use, which would cover this and
potentially any other cases. This is nicer because it lets us continue
using the test. And it's not like we have a ton of jgit dependencies,
such that dealing with each individually would be a burden.

-Peff
