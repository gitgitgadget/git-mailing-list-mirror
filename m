Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE47AC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJKALR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiJKAKG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:10:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247229369
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:09:54 -0700 (PDT)
Received: (qmail 29583 invoked by uid 109); 11 Oct 2022 00:09:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 00:09:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14964 invoked by uid 111); 11 Oct 2022 00:09:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 20:09:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 20:09:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 5/5] CodingGuidelines: recommend against unportable
 C99 struct syntax
Message-ID: <Y0S0Tpn/uCjG9J61@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 <20221010203800.2154698-1-gitster@pobox.com>
 <20221010203800.2154698-6-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221010203800.2154698-6-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 01:38:00PM -0700, Junio C Hamano wrote:

> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 9598b45f7e..cbe0377699 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -242,6 +242,10 @@ For C programs:
>       printf("%"PRIuMAX, (uintmax_t)v).  These days the MSVC version we
>       rely on supports %z, but the C library used by MinGW does not.
>  
> +   . Shorthand like ".a.b = *c" in struct assignments is known to trip
> +     up an older IBM XLC version, use ".a = { .b = *c }" instead. See
> +     the 33665d98e6b portability fix from mid-2022.

FWIW, the use of the word "assignment" here left me scratching my head.
Reading 33665d98e6b, it is about struct initialization.

C99 does allow assignment from a compound literal, like:

  foo = (struct some_struct){ .a = 1, .b = 2 };

but I don't think we have any examples in the current code (and I think
we'd consider it a different feature for purposes of testing a weather
balloon).

-Peff
