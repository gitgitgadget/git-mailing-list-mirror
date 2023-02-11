Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B53EC05027
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 02:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBKCEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 21:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKCEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 21:04:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922787358A
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 18:04:19 -0800 (PST)
Received: (qmail 21304 invoked by uid 109); 11 Feb 2023 02:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Feb 2023 02:04:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30266 invoked by uid 111); 11 Feb 2023 02:04:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Feb 2023 21:04:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Feb 2023 21:04:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <Y+b3opa1xgnGM+VN@coredump.intra.peff.net>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <CABPp-BGdKjnChEp4zeCcz24wiEJVJb9Tp40MTWn1m0LRZu+M+Q@mail.gmail.com>
 <230209.86lel7xi8l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230209.86lel7xi8l.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2023 at 10:41:33AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > If you run with more than 1 run, are your numbers even repeatable?
> 
> Yes, but tl;dr it's diff.colorMoved=true, sorry, see below.

Wow, that's really slow. I was slightly surprised, because I also use
colorMoved. But I set it to "plain", which is way faster:

  $ time git diff --color-moved=default v2.0.0 v2.28.0 >/dev/null
  real	0m18.492s
  user	0m18.411s
  sys	0m0.081s

  $ time git diff --color-moved=plain v2.0.0 v2.28.0 >/dev/null
  real	0m0.942s
  user	0m0.841s
  sys	0m0.101s

I didn't dig into why, but it's possible there's some low-hanging fruit
in the zebra/block code.

I also have a mild feeling of deja vu that we may have discussed this
before, but a quick search in the archive didn't yield anything. So I'll
leave it for somebody to investigate further if they're interested.

-Peff
