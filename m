Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4949DC433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 03:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB12076D
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 03:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgH3Dd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 23:33:56 -0400
Received: from mimir.eigenstate.org ([206.124.132.107]:30280 "EHLO
        mimir.eigenstate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgH3Dd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 23:33:56 -0400
Received: from abbatoir.fios-router.home (pool-74-101-2-6.nycmny.fios.verizon.net [74.101.2.6])
        by mimir.eigenstate.org (OpenSMTPD) with ESMTPSA id 12869687 (TLSv1.2:ECDHE-RSA-AES256-SHA:256:NO);
        Sat, 29 Aug 2020 20:33:55 -0700 (PDT)
Message-ID: <A1CA9D499EDDACBA275BA61E114645F0@eigenstate.org>
To:     gitster@pobox.com, peff@peff.net
CC:     l.s.r@web.de, ori@eigenstate.org, git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
Date:   Sat, 29 Aug 2020 20:33:54 -0700
From:   ori@eigenstate.org
In-Reply-To: <xmqqft8b3fj4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> writes:
> 
>> It may be hard to test, as I suspect modern versions of Git are not
>> happy to create such a deep chain. We could test with a lowered value of
>> the config option, though.
> 
> Yes, that was what I meant.  Start from a 1KB text, create 50
> revisions of the file by adding a single line at its end at a time,
> pack with depth limit of 100, and then see "git log -p" die when the
> allowed max lowered to 10, or something like that.

Sorry about the delay -- most of my time to poke at this is over the weekend.

Will that work? I'd expect that modern pack files end up being
offset deltas, rather than reference deltas.

