Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86250C432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 14:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E814760551
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 14:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhHKODw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:03:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:44218 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhHKODw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 10:03:52 -0400
Received: (qmail 21009 invoked by uid 109); 11 Aug 2021 14:03:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 14:03:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10475 invoked by uid 111); 11 Aug 2021 14:03:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 10:03:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 10:03:25 -0400
From:   Jeff King <peff@peff.net>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t5607 fail with GIT_TEST_FAIL_PREREQS enabled
Message-ID: <YRPYrXYwmwVnligD@coredump.intra.peff.net>
References: <CAL3xRKcMAkfaoAWo5VfQ_Q6nYkR94spSN4Ko6xfpSRKa1cEuAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3xRKcMAkfaoAWo5VfQ_Q6nYkR94spSN4Ko6xfpSRKa1cEuAg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 03:02:52PM +0200, Son Luong Ngoc wrote:

>     git/t% GIT_TEST_FAIL_PREREQS=1 ./t5607-clone-bundle.sh
> [...]
>     #               if ! test_have_prereq SHA1
>     #               then
>     #                       echo "@object-format=sha256"
>     #               fi >expect &&

The problem is presumably here. If test_have_prereq lies and say "no, we
are using sha256" then we cannot expect what the built binary does to
match that lie.

Perhaps that is a sign that test_have_prereq is not the right tool to
check "which hash format are we using", but I don't think we have
another convenient mechanism to do so currently.

I also think that the FAIL_PREREQS system may be mis-designed a bit. We
had a similar problem a few months ago, and I think Junio's response
here points in a good direction:

  https://lore.kernel.org/git/xmqqblbgrwkg.fsf@gitster.g/

-Peff
