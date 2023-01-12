Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D0C63797
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 17:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjALR1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjALR1M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 12:27:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AE8D5F6
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:54:17 -0800 (PST)
Received: (qmail 5725 invoked by uid 109); 12 Jan 2023 16:53:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Jan 2023 16:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17005 invoked by uid 111); 12 Jan 2023 16:53:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Jan 2023 11:53:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Jan 2023 11:53:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
Message-ID: <Y8A7Cb/w0VQk6ppV@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
 <Y77/T8dktee3wOA5@coredump.intra.peff.net>
 <230112.86fscg2jbm.gmgdl@evledraar.gmail.com>
 <Y8AyTE3OS7HCAzKH@coredump.intra.peff.net>
 <230112.86v8lbzpj1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230112.86v8lbzpj1.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2023 at 05:22:04PM +0100, Ævar Arnfjörð Bjarmason wrote:

> We have members like "struct strbuf"'s "buf", which always needs to be
> init'd, but never "maybe by the user", so the pattern above would work
> there.

We've discussed in the past having a strbuf that points to an existing
buffer, over which it takes ownership. Or a const string that we'd leave
behind (but not free) if we needed to grow.

In those cases you'd want to pass in a buffer to the allocator. Of
course in the case of a strbuf those initializers would probably just be
totally separate from the regular slopbuf one, just because there's not
much else in a strbuf to initialize. You don't gain much from trying to
avoid repetition.

> Anyway, I agree that it's not worth pursuing this in this case.
> 
> But I think it's a neat pattern that we might find use for sooner than
> later for something else.

I remain unconvinced. ;) Mostly just that the lines saved versus the
amount of magic and thought doesn't seem reasonable. But it's something
we can keep in mind as new opportunities show up.

-Peff
