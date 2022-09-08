Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B1C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiIHSmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiIHSmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 14:42:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C186E9035
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 11:42:15 -0700 (PDT)
Received: (qmail 28485 invoked by uid 109); 8 Sep 2022 18:42:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 18:42:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23514 invoked by uid 111); 8 Sep 2022 18:42:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 14:42:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 14:42:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: Re: [External Mail]Re: [PATCH 3/3] parse_object(): check
 commit-graph when skip_hash set
Message-ID: <Yxo3hXg7AwrqzQO8@coredump.intra.peff.net>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfScUATMQw9cB6m@coredump.intra.peff.net>
 <xmqqv8pzt20d.fsf@gitster.g>
 <a87e9eaccf7849fc9eeb10ce7d373db0@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a87e9eaccf7849fc9eeb10ce7d373db0@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 10:39:08AM +0000, 程洋 wrote:

> > If the caller told us that they don't care about us checking the
> > object hash, then we're free to implement any optimizations that get
> > us the parsed value more quickly. An obvious one is to check the
> > commit graph before loading an object from disk. And in fact, both of
> > the callers who pass in this flag are already doing so before they call
> > parse_object()!
> 
> > So we can simplify those callers, as well as any possible future ones,
> > by moving the logic into parse_object().
> 
> I need to mention that there is serious issue with commit-graph together with partial-clone
> https://lore.kernel.org/git/20220709005227.82423-1-hanxin.hx@bytedance.com/

Yes, though I don't think that changes anything with respect to my
patches. The argument here is simply that if a caller is OK skipping the
hash check, they are OK with using the commit graph, and vice versa.
Until the bug in the linked thread is fixed, it is a good idea to
disable the commit graph. But it does not change the intent of the
calling code.

-Peff
