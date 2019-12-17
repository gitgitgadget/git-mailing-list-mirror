Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59158C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 02:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3598421D7D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 02:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLQCs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:48:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:48246 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726526AbfLQCs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 21:48:59 -0500
Received: (qmail 28908 invoked by uid 109); 17 Dec 2019 02:48:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Dec 2019 02:48:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19241 invoked by uid 111); 17 Dec 2019 02:53:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2019 21:53:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Dec 2019 21:48:58 -0500
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 0/2] contrib/credential/netrc: Makefile + script cleanup
Message-ID: <20191217024858.GA2734969@coredump.intra.peff.net>
References: <cover.1576531851.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1576531851.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 01:32:32PM -0800, Denton Liu wrote:

> I recently switched my workflow to use this credential helper and I
> noticed a couple of problems:
> 
> 1. The interpreter path was hardcoded to #!/usr/bin/perl
> 
> 2. The script refuses to run outside of a Git repository
> 
> This patch series should fix these problems.

Both of these patches look good to me.

It does make me wonder if many people are using credential-netrc, given
these pretty obvious problems. You're certainly welcome to use it if it
works for you, but I am curious what made you pick it versus one of the
other more advanced helpers.

I assume you're using a gpg-encrypted netrc (if not, you should probably
just use credential-store). For "read-only" password access, I find the
combination of pass[1] with config like this is a bit nicer:

  [credential "https://github.com"]
  username = peff
  helper = "!f() { test $1 = get && echo password=`pass github/oauth`; }; f"

-Peff

[1] https://www.passwordstore.org/
