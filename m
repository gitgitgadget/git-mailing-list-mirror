Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C128C001DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 19:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGCT3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGCT3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 15:29:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FBE5E
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 12:29:53 -0700 (PDT)
Received: (qmail 10361 invoked by uid 109); 3 Jul 2023 19:29:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 19:29:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10915 invoked by uid 111); 3 Jul 2023 19:29:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 15:29:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 15:29:52 -0400
From:   Jeff King <peff@peff.net>
To:     Dylan Brotherston <dylanb@cse.unsw.edu.au>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Possible Bug with `git commit -a` in v2.41.0
Message-ID: <20230703192952.GB3546592@coredump.intra.peff.net>
References: <ZKMRAkH1r2mQ85Ff@vx12.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKMRAkH1r2mQ85Ff@vx12.orchestra.cse.unsw.EDU.AU>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2023 at 04:18:42AM +1000, Dylan Brotherston wrote:

> $ git init
> Initialized empty Git repository in /tmp/tmp.vXqq6iVaqq/.git/
> 
> $ echo "foo" > a
> $ git add a
> $ git commit -m "C1"
> [master (root-commit) af7c07d] C1
>  1 file changed, 1 insertion(+)
>  create mode 100644 a
> 
> $ rm a
> $ git commit -a -m "C2"
> On branch master
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         deleted:    a
> 
> no changes added to commit (use "git add" and/or "git commit -a")

Thanks for an easy reproduction recipe. I think this bug has already
been fixed by 2ee045eea1 (commit -a -m: allow the top-level tree to
become empty again, 2023-06-29). That's currently in 'next', and slated
to merge to 'master' soon (and hopefully will make it to 'maint' for
a v2.41.1 release).

-Peff
