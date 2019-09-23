Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA8A1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 22:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391570AbfIWWbr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 18:31:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57712 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2391490AbfIWWbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 18:31:47 -0400
Received: (qmail 30962 invoked by uid 109); 23 Sep 2019 22:31:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 22:31:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4974 invoked by uid 111); 23 Sep 2019 22:34:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 18:34:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 18:31:46 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/helper: ignore only executable files
Message-ID: <20190923223145.GB22645@sigill.intra.peff.net>
References: <20190920093609.24935-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190920093609.24935-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:36:09AM +0200, SZEDER Gábor wrote:

> Ignoring everything but sources has the drawback that building an
> older version of Git (e.g. during bisecting) creates all those
> executables, and after going back to e.g. current 'master' the usual
> cleanup commands like 'make clean' or 'git clean -fd' don't remove
> them (the former doesn't know about them, and the latter doesn't
> remove ignored files).

Good reasoning. I've definitely been bit by this before when manually
testing something (for some reason, I still haven't trained my fingers
to type "test-tool foo" instead of "test-foo").

A similar one that bites me sometimes is that modern t5801 will fail
with an old built version of git-remote-testgit. That one _is_ correctly
handled in .gitignore, but you do have to remember to run "git clean".
But that's the best we can do, I think, unless we want to make t5801
more paranoid about running the version from t/t5801/git-remote-testgit.

> So let's ignore only the executable files under 't/helper/, i.e.
> 'test-tool' and the three other remaining executables that could not
> be integrated into 'test-tool' (no need to ignore object files, as
> they are already ignored by our toplevel '.gitignore').

Sounds like the right solution, and the patch looks good to me.

-Peff
