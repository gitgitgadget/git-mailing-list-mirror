Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF8C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16E961184
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhETI3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:29:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:60080 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhETI3A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:29:00 -0400
Received: (qmail 26439 invoked by uid 109); 20 May 2021 08:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 May 2021 08:27:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29080 invoked by uid 111); 20 May 2021 08:27:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 May 2021 04:27:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 May 2021 04:27:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
Message-ID: <YKYdeom6SgAHqojm@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 10:18:57AM +0200, Ævar Arnfjörð Bjarmason wrote:

> A re-roll of [1], the work I based v1 on top of has landed in master,
> so this has been rebased on master.
> 
> The changes here are minor, just a typo fix / commit message
> clarification, moving "require" closer to where it's used, and finally
> a new 10/10 patch to s/cwd/getcwd/g.

I like all of this, except for the change in the interface of
Git::config_regexp(). You mention that it's new-ish, and probably not in
wide use. And I agree that's probably true. But it feels like violating
a principle of not breaking APIs, and we should stick to that principle
and not bend it for "well, it's not that old an API".

I'd find it more compelling if it the existing interface was broken or
hard to avoid changing. But couldn't we just add a new function with the
extra info (config_regexp_with_values() or something)?

-Peff
