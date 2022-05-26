Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80597C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 07:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbiEZH5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 03:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiEZH5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 03:57:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3695B18E
        for <git@vger.kernel.org>; Thu, 26 May 2022 00:57:17 -0700 (PDT)
Received: (qmail 7890 invoked by uid 109); 26 May 2022 07:57:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 May 2022 07:57:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 26 May 2022 03:57:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Makefile: build 'gitweb' in the default target
Message-ID: <Yo8y3AHWa3PChLwd@coredump.intra.peff.net>
References: <20220525205651.825669-1-szeder.dev@gmail.com>
 <220526.86k0a96sv2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220526.86k0a96sv2.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 02:14:33AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Our Makefile's default target used to build 'gitweb', though
> > indirectly: the 'all' target depended on 'git-instaweb', which in turn
> > depended on 'gitweb'.  Then e25c7cc146 (Makefile: drop dependency
> > between git-instaweb and gitweb, 2015-05-29) removed the latter
> > dependency, and for good reasons (quoting its commit message):
> [...]
> In various recent patches & some upcoming ones I plan to submit I've
> been trying to get the runtime of a noop "make" runs down, which really
> helps e.g. with "git rebase -x make ..." running faster on a large
> series.
> 
> While you're right that this wasn't intentional to begin with, we have
> lacked the "gitweb" as part of the default target since v2.4.5 now, and
> adding it back is a major performance regression on noop "make" runs:

Yes, I don't think building gitweb is worth the performance cost.
Speeding things up was part of my original goal in e25c7cc146. It would
be one thing if this were a recent change and somebody might be broken
or confused by it not being built by default. But after 7 years, I think
the question is: why _would_ we want to change the status quo and build
gitweb by default?

To exercise its Makefile for bugs, I guess, but IMHO it is not worth
inflicting that on random developers. People who care about gitweb (if
any) can build it themselves. I'd be even happier if it were just
carried in its own tree.

-Peff
