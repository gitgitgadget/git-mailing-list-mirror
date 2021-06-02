Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A242DC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 06:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8827461396
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 06:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFBGPr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 2 Jun 2021 02:15:47 -0400
Received: from botech.co.uk ([81.187.226.106]:46322 "EHLO chimp.botech.co.uk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230498AbhFBGPq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 02:15:46 -0400
Received: from botech.co.uk ([81.187.226.106] helo=[192.168.4.5])
        by chimp.botech.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <tpr.ll@botech.co.uk>)
        id 1loK8a-0001fF-Js; Wed, 02 Jun 2021 07:13:56 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.20\))
Subject: Re: [PATCH] unpack-trees: add core.sparseCheckoutRmFiles config
From:   "Tim Renouf (open source)" <tpr.ll@botech.co.uk>
In-Reply-To: <CABPp-BHs0ACvkCJMB-tO8xkiidB12NrN1hOhLRvm3U_Q=r2YcQ@mail.gmail.com>
Date:   Wed, 2 Jun 2021 07:13:57 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9BCB8981-09D5-4BF4-981B-2BF0AA0D6E5A@botech.co.uk>
References: <20210601183106.3084008-1-tpr.ll@botech.co.uk>
 <f6d39636-308c-c846-55b5-3f16a155e69d@gmail.com> <xmqqmts9q9m2.fsf@gitster.g>
 <CABPp-BHs0ACvkCJMB-tO8xkiidB12NrN1hOhLRvm3U_Q=r2YcQ@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3445.104.20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

Thanks for the reviews and comments.

My use case is that I never want it to remove or otherwise touch those files outside of sparse-checkout that happen to be the same path as index paths. I realize that currently gives me complications (e.g. I must never try and merge/cherry-pick/rebase a commit that might cause a merge conflict out there), and I realize that’s not what everyone else wants. For example, I don’t want git reset --hard or whatever to remove those files. Hence the config option.

Am I right in saying that the sparse-index work makes it easier to achieve my use case? In that those outside-sparse-checkout paths would not ever get merged into the index, even if I merge/cherry-pick/rebase a tree with paths there?

I can go into more details on how I arrived ay my use case if it helps.

So maybe there are two separate things here:

1. The bug that checkout removes my file when it is dirty, instead of refusing (unless -f) or just ignoring it.
2. My use case, which is to do its best to never remove or otherwise touch worktree files outside sparse-checkout.

> I'm also worried that making a config option may have masked subtle
> bugs in the patch that the rest of the testsuite would have turned up.

It is true that not hiding it in a config option makes a few tests fail, including ones that specifically test that a git reset after a materialization from a merge conflict causes the file to be removed.

Thanks.

-tpr

