Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F2C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4CF2072C
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbgAYAih (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:38:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:44288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729147AbgAYAih (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:38:37 -0500
Received: (qmail 9348 invoked by uid 109); 25 Jan 2020 00:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 00:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12490 invoked by uid 111); 25 Jan 2020 00:45:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 19:45:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 19:38:36 -0500
From:   Jeff King <peff@peff.net>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Q] push refspec with wildcard pushes all matching branches
Message-ID: <20200125003836.GA568952@coredump.intra.peff.net>
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 09:29:53PM +0100, Bert Wesarg wrote:

> I'm a little confused, that a push refspec with a wildcard changes the number of branches pushed.

I'm confused about which part you're confused about. :)

>     $ git push --dry-run
>     To ../bare.git
>      * [new branch]      master -> master
>     $ git config remote.origin.push 'refs/heads/master*:refs/remotes/origin/master*'
>     $ git push --dry-run
>     To ../bare.git
>      * [new branch]      master -> origin/master
>      * [new branch]      master-two -> origin/master-two
> 
> Is this expected behavior?

You asked it to push master*, so it did.

Is your confusion that you had set push.default to "current"? If there
is a refspec (either in the config or specified on the command line),
then that takes precedence over push.default.

From git-push(1):

  When the command line does not specify what to push with <refspec>...
  arguments or --all, --mirror, --tags options, the command finds the
  default <refspec> by consulting remote.*.push configuration, and if it
  is not found, honors push.default configuration to decide what to push
  (See git-config(1) for the meaning of push.default).

If that's not it, can you clarify what you expected to happen?

-Peff
