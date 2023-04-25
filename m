Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AB5C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 06:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjDYG0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 02:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDYG0T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 02:26:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AAB453
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 23:26:18 -0700 (PDT)
Received: (qmail 22046 invoked by uid 109); 25 Apr 2023 06:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 06:26:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1444 invoked by uid 111); 25 Apr 2023 06:26:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 02:26:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 02:26:17 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 6/6] banned.h: mark `strtok()` and `strtok_r()` as
 banned
Message-ID: <20230425062617.GB4061254@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
 <da896aa358eab65f2629f85189c5be4ad9cec635.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da896aa358eab65f2629f85189c5be4ad9cec635.1682374789.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 06:20:26PM -0400, Taylor Blau wrote:

> string_list_split_in_place() is not a perfect drop-in replacement
> for `strtok_r()`, particularly if the caller is processing a string with
> an arbitrary number of tokens, and wants to process each token one at a
> time.
> 
> But there are no instances of this in Git's tree which are more
> well-suited to `strtok_r()` than the friendlier
> `string_list_in_place()`, so ban `strtok_r()`, too.

For true incremental left-to-right parsing, strcspn() is probably a
better solution. We could mention that here in case anybody digs up the
commit after getting a "banned function" error.

I'm tempted to say that this thread could serve the same function, but
I'm not sure where people turn to for answers (I find searching the list
about as easy as "git log -S", but then I've invested a lot of effort in
my list archive tooling :) ).

I'm happy with it either the way, though.

-Peff
