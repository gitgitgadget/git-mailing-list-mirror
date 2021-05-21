Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47D5C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93643613CB
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhEUKIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 06:08:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33246 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233863AbhEUKIW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 06:08:22 -0400
Received: (qmail 3189 invoked by uid 109); 21 May 2021 10:06:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 10:06:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8068 invoked by uid 111); 21 May 2021 10:06:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 06:06:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 06:06:55 -0400
From:   Jeff King <peff@peff.net>
To:     Siavash <siavash.askari.nasr@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not
 available in `exec-path`
Message-ID: <YKeGP6STQMy63tEJ@coredump.intra.peff.net>
References: <87k0nt3f8i.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k0nt3f8i.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 02:21:25PM +0430, Siavash wrote:

> If I'm not mistaken, it's because it sets the `SCRIPT_PERL` environment variable here:
> https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/contrib/credential/netrc/Makefile#L13
> 
> But the Git Makefile un-sets environment variables here:
> https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/Makefile#L587

That part is OK. The netrc build runs "make SCRIPT_PERL=...", which will
override any instances where it is set in the top-level Makefile.

So just doing:

  cd contrib/credential/netrc
  make install

should be enough to make it work.

-Peff
