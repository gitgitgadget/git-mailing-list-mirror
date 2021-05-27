Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1FBC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FA6613BC
	for <git@archiver.kernel.org>; Thu, 27 May 2021 13:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhE0Ntr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 09:49:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:38726 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236531AbhE0Ntr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 09:49:47 -0400
Received: (qmail 4698 invoked by uid 109); 27 May 2021 13:48:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 May 2021 13:48:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2995 invoked by uid 111); 27 May 2021 13:48:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 May 2021 09:48:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 May 2021 09:48:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re:
 [PATCH v6 1/3] test: add helper functions for git-bundle")
Message-ID: <YK+jGxlHHZ63o94N@coredump.intra.peff.net>
References: <87bl8xmipo.fsf@evledraar.gmail.com>
 <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
 <87tumol4tg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tumol4tg.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 02:19:04PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Anyway, looking at this whole test file with fresh eyes this pattern
> seems very strange. You duplicated most of test_commit with this
> test_commit_setvar. It's a bit more verbosity but why not just use:
> 
>     test_commit ...
>     A=$(git rev-parse HEAD)
> 
> Or teach test_commit a --rev-parse option or something and:
> 
>     A=$(test_commit ...)

The latter would be nice (and maybe even could be the default, as the
stdout is usually just going to --verbose output anyway). But I don't
think it works, because the $() is a subshell, so we lose the side
effect of test_tick incrementing the timestamp counter.

I wasn't following this thread carefully, but your suggestion to just
do "A=$(git rev-parse HEAD)" seems quite readable to me.

-Peff
