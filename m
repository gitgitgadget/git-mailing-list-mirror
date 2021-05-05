Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F62C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89942613BA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhEENnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:43:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:45266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231959AbhEENnG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:43:06 -0400
Received: (qmail 18305 invoked by uid 109); 5 May 2021 13:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 13:42:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9515 invoked by uid 111); 5 May 2021 13:42:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 09:42:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 09:42:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] streaming.c: remove enum/function/vtbl indirection
Message-ID: <YJKgsfJXMsR47CkW@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
 <patch-2.5-13061f01212-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.5-13061f01212-20210505T122816Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 02:33:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove the indirection of discovering a function pointer to use via an
> enum and virtual table. This refactors code added in
> 46bf043807c (streaming: a new API to read from the object store,
> 2011-05-11).
> 
> We can instead simply return an "open_istream_fn" for use from the
> "istream_source()" selector function directly. This allows us to get
> rid of the "incore", "loose" and "pack_non_delta" enum
> variables. We'll return the functions instead.
> 
> The "stream_error" variable in that enum can likewise go in favor of
> returning NULL, which is what the open_istream() was doing when it got
> that value anyway.
> 
> We can thus remove the entire enum, and the "open_istream_tbl" virtual
> table that (indirectly) referenced it.

Yeah, I think this is simpler. The value of the vtable was that we might
have added more functions to it, but we haven't done so over the course
of the last 10 years. And I have trouble imagining for what purpose we
would. So it seems like unnecessary complexity.

-Peff
