Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0525C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 15:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjDDPjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjDDPjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 11:39:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF54C29
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 08:39:20 -0700 (PDT)
Received: (qmail 20540 invoked by uid 109); 4 Apr 2023 15:39:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Apr 2023 15:39:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1415 invoked by uid 111); 4 Apr 2023 15:39:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Apr 2023 11:39:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Apr 2023 11:39:18 -0400
From:   Jeff King <peff@peff.net>
To:     Thorsten Otto <admin@tho-otto.de>
Cc:     git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
Message-ID: <20230404153918.GB160693@coredump.intra.peff.net>
References: <3473764.PTxrJRyG3s@earendil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3473764.PTxrJRyG3s@earendil>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2023 at 11:58:38AM +0200, Thorsten Otto wrote:

> "git diff" does not show a diff for newly added, binary files
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> $ git init .
> $ touch a
> $ git add a
> $ git commit -m "first commit"
> $ dd if=/dev/zero of=b count=1
> $ git add b
> $ echo hello > c
> $ git add c
> $ git diff --cached
> 
> What did you expect to happen? (Expected behavior)
> 
> I expected a binary diff for the new file, just like it is done
> when comparing two different, already committed revisions.

I responded elsewhere in the thread mentioning "git diff --binary", but
note this part of the report is a little misleading. The difference is
not showing newly added files versus committed revisions. The difference
is between "git diff" and "git format-patch". If you commit the result
above and then run:

  git diff HEAD^ HEAD

it will likewise not show the binary patch (unless you specify
--binary). Likewise for "git show", etc. I think that format-patch is
the only command with binary diffs turned on by default.

-Peff
