Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC10520A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 13:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeLLNw5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 08:52:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:39440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726232AbeLLNw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 08:52:57 -0500
Received: (qmail 16309 invoked by uid 109); 12 Dec 2018 13:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Dec 2018 13:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15926 invoked by uid 111); 12 Dec 2018 13:52:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Dec 2018 08:52:27 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2018 08:52:55 -0500
Date:   Wed, 12 Dec 2018 08:52:55 -0500
From:   Jeff King <peff@peff.net>
To:     George King <george.w.king@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Difficulty with parsing colorized diff output
Message-ID: <20181212135255.GA5768@sigill.intra.peff.net>
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
 <20181208071634.GA18272@sigill.intra.peff.net>
 <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
 <20181211101742.GE31588@sigill.intra.peff.net>
 <871s6oni3a.fsf@evledraar.gmail.com>
 <EB1AF739-F97B-4905-9736-2A003722AD9A@gmail.com>
 <A97DD550-BE35-43BA-A181-708B7D065F3F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A97DD550-BE35-43BA-A181-708B7D065F3F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 01:55:09PM -0500, George King wrote:

> I just noticed that while `wsErrorHighlight = none` fixes the problem
> of extra green codes for regular diff, it fails to have any effect
> during interactive `git add -p`.

This is due to the way add--interactive invokes diff. It uses the
plumbing commands (diff-tree, diff-files, etc), which do not respect
config which changes the output (since their purpose is to provide
stable machine-readable output).

But add--interactive does a slightly funny thing: it runs each diff
twice. Once to get the machine-readable version, and once to get a
colorized version which it shows to the user. When it does the latter,
it has to manually enable other options (e.g., passing --color as
appropriate, or passing along diff.algorithm).

So the matching behavior here would be for it to look as
wsErrorHighlight and pass it along as a command line option.

-Peff
