Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3F1C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BDC611BD
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbhI0X03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:26:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:55884 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238189AbhI0X03 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:26:29 -0400
Received: (qmail 7834 invoked by uid 109); 27 Sep 2021 23:24:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Sep 2021 23:24:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21995 invoked by uid 111); 27 Sep 2021 23:24:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 19:24:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 19:24:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out"
 idiom
Message-ID: <YVJSwuqjolz28+mG@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
 <patch-v2-2.5-afcd2729c95-20210927T124407Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.5-afcd2729c95-20210927T124407Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 02:54:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In C it isn't required to specify that all members of a struct are
> zero'd out to 0, NULL or '\0', just providing a "{ 0 }" will
> accomplish that.
> 
> Let's also change code that provided N zero'd fields to just
> provide one, and change e.g. "{ NULL }" to "{ 0 }" for
> consistency. I.e. even if the first member is a pointer let's use "0"
> instead of "NULL". The point of using "0" consistently is to pick one,
> and to not have the reader wonder why we're not using the same pattern
> everywhere.

I seem to recall we've had some linter complaints about using "0" to
initialize a pointer, but I think these days it's OK, per:

 - 1c96642326 (sparse: allow '{ 0 }' to be used without warnings,
   2020-05-22)

and

 - https://lore.kernel.org/git/18bd6127-be72-b7b7-8e2a-17bbe7214a2e@ramsayjones.plus.com/

I think this is a good step, as the long lists are unwieldy and difficult to
keep up to date without actually providing any readability or functional
value.

-Peff
