Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EC7520986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbcJSWmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:42:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59769 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754137AbcJSWmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:42:14 -0400
Received: (qmail 24663 invoked by uid 109); 19 Oct 2016 22:42:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 22:42:14 +0000
Received: (qmail 18849 invoked by uid 111); 19 Oct 2016 22:42:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 18:42:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 18:42:11 -0400
Date:   Wed, 19 Oct 2016 18:42:11 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
Message-ID: <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 03:26:18PM -0700, Jacob Keller wrote:

> I recently (and in the past) had an issue where I was using git add
> --interactive and accidentally did something like the following:
> 
> # hack lots of randmo changes, then begin trying to commit then separately
> git add -i
> # set only the changes I want
> # accidentally add <file> to the commit
> $git commit -s <file>
> # type up a long commit message
> # notice that I committed everything
> 
> At this point I'd like to be able to do something like:
> $git unstage -i
> # select each hunk to unstage

I'd usually do one of:

  # undo selectively
  git reset -p HEAD^
  git commit --amend

or:

  # roll back the whole commit
  git reset HEAD
  # do it right this time
  git add -p
  # and steal the commit message from the previous attempt
  git commit -c HEAD@{1}

-Peff
