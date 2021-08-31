Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7287FC4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB9160462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbhHaTjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:39:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:35482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhHaTjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:39:13 -0400
Received: (qmail 13266 invoked by uid 109); 31 Aug 2021 19:38:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 19:38:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29370 invoked by uid 111); 31 Aug 2021 19:38:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 15:38:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 15:38:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] mailmap.c: fix a memory leak in
 free_mailap_{info,entry}()
Message-ID: <YS6FKEApva30sKgl@coredump.intra.peff.net>
References: <patch-4.4-ad8680f529-20210714T172251Z-avarab@gmail.com>
 <patch-1.1-f11eb44e4c5-20210831T134023Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-f11eb44e4c5-20210831T134023Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 03:42:52PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
> and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
> clear the "me" structure, but while we freed parts of the
> mailmap_entry structure, we didn't free the structure itself. The same
> goes for the "mailmap_info" structure.
> 
> This brings us from 50 failures when running t4203-mailmap.sh to
> 49. Not really progress as far as the number of failures is concerned,
> but as far as I can tell this fixes all leaks in mailmap.c
> itself. There's still users of it such as builtin/log.c that call
> read_mailmap() without a clear_mailmap(), but that's on them.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Thanks, the patch looks good to me. I agree with Eric that mentioning
"leak failures" in the second paragraph would make it less confusing. :)

-Peff
