Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E97C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D0D613D0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGOVqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:46:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:51388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230354AbhGOVqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 17:46:36 -0400
Received: (qmail 12944 invoked by uid 109); 15 Jul 2021 21:43:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jul 2021 21:43:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5128 invoked by uid 111); 15 Jul 2021 21:43:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jul 2021 17:43:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jul 2021 17:43:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] SANITIZE tests: fix memory leaks in t5701*, add
 to whitelist
Message-ID: <YPCsDLoiiAG/C/ft@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 07:23:53PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Fix a memory leak in a2ba162cda (object-info: support for retrieving
> object info, 2021-04-20) which appears to have been based on a
> misunderstanding of how the pkt-line.c API works, there is no need to
> strdup() input to, it's just a printf()-like format function.
> 
> This fixes a potentially large memory leak, since the number of OID
> lines the "object-info" call can be arbitrarily large (or a small one
> if the request is small).

Very nice. This will also be much more efficient, since we get to reuse
the same buffer in each run through the loop.

-Peff
