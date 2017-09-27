Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FF9D20281
	for <e@80x24.org>; Wed, 27 Sep 2017 01:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032989AbdI0BZO (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 21:25:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:51372 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1032869AbdI0BZK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 21:25:10 -0400
Received: (qmail 13449 invoked by uid 109); 27 Sep 2017 01:25:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 01:25:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9533 invoked by uid 111); 27 Sep 2017 01:25:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Sep 2017 21:25:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Sep 2017 21:25:06 -0400
Date:   Tue, 26 Sep 2017 21:25:06 -0400
From:   Jeff King <peff@peff.net>
To:     Ernesto Alfonso <erjoalgo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git apply fails silently when on the wrong directory
Message-ID: <20170927012506.5tplhzain5z4eyxy@sigill.intra.peff.net>
References: <87k20lt10c.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k20lt10c.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2017 at 05:53:55PM -0700, Ernesto Alfonso wrote:

> I recently ran into a similar issue as described here:
> 
> https://stackoverflow.com/questions/24821431/git-apply-patch-fails-silently-no-errors-but-nothing-happens
> 
> I was using the alias:
> 
> alias ganw='git diff -U0 -w --no-color "$@" | git apply --cached --ignore-whitespace --unidiff-zero -'
> 
> to stage non-whitespace changes, but I was not in the root directory and
> the changes were not being applied. I broke down the command to discover
> the 'git apply' part of the pipe was silently failing to apply anything,
> exiting 0 without even a warning.
> 
> The exit status and lack of warning is terribly misleading, I imagine
> this would be the cause of subtle bugs in automated scripts. 
> 
> Is this expected behaviour?

Yes, this is as documented in git-apply(1):

   Reads the supplied diff output (i.e. "a patch") and applies it to
   files. When running from a subdirectory in a repository, patched
   paths outside the directory are ignored.

I agree it's a potential source of confusion. There's some previous
discussion in this thread:

  https://public-inbox.org/git/CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com/

-Peff
