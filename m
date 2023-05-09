Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0200FC77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjEIAiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEIAiR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:38:17 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC664C0F
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:38:16 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1960539df06so1416079fac.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683592695; x=1686184695;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35F9i9gaFbJs0cPGUcFxDPYHojFtFW8jJv3HNxLWaEo=;
        b=konC6TaV0leIWSUQ47bmCI7MBykAQQuVBYnFWPg4uroMZtJ91K7QjLIC9oMsxO1q/S
         4te7aoU3DBIqCQA+MUK3PRGMrJ5yWWLa/In9U/zbTmKHLnShJpEB+bMoSUFQGHw7Eepg
         0jOKV9nX1u3J/0aEoFXN5BVSMS7E28aPcZAQvmqeUkwHs5JTL9M1Bn2X5wfaU2pZSMLz
         UtAYLb4XPS0dxaZDwLjDvVTCjEj6JEdVB6RzsodDhIphPB5vAEqtBAZkvmjHe96RWOw/
         I6IChAsxqQkg9ot7HNehF6cm3pJhl/HEbFtf5+I7ZSxKfSppClA8pAh0qkxUP6gbA40N
         Lueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683592695; x=1686184695;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35F9i9gaFbJs0cPGUcFxDPYHojFtFW8jJv3HNxLWaEo=;
        b=FeBJ7xFjsIf5cHVJkPYp6B/0hpXIBfJhB6NkgZwhG5nMYFyiy3a5oH6QnLGT6xXO9U
         eZ5heuxH4KFCHkV9EUtB1pwDRTVVxP0th6QlgWD8on+XrqILHCpmmA03QDdThPE5hyZb
         wx2K22akXWJqDFZt+wOzrCtcH48SOMRCkx33bOWo6Ep7RpJWoauF24MUnK9WeKz+hXYo
         vwOnj+4ZZcTArC51RTdp1UkJv9wRUZ/msojdmGG9UfckcNeqj8TttEfQeNfDUuFVO34l
         L2LoXJwoyTWMs0ttM1xXyKO0EmQHkdnAI4iR85xOnoYkUtppcbZ2IrlXxetbasi2RStt
         DIcg==
X-Gm-Message-State: AC+VfDwc1xjqGEVqmMNteyixQnEfenHGkE/jw3k5vJRJDQJLQKc/Av49
        SnhK8YQF+Gcu8so6qPZs8G2ZzHgiNdA=
X-Google-Smtp-Source: ACHHUZ55ibSkP2+QGe4BoNrvb/r3sjVVM0XjBYd9Pi1jdANj0/3nPsAYcZp2UKh+6UHHLrPUBvzCvQ==
X-Received: by 2002:a05:6870:9565:b0:196:354e:d2fa with SMTP id v37-20020a056870956500b00196354ed2famr78667oal.9.1683592694768;
        Mon, 08 May 2023 17:38:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g2-20020a056870c38200b001962e45f0d4sm287746oao.24.2023.05.08.17.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:38:14 -0700 (PDT)
Date:   Mon, 08 May 2023 18:38:13 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <645995f53dd75_7c6829483@chronos.notmuch>
In-Reply-To: <20230505165952.335256-1-gitster@pobox.com>
References: <xmqqfs8bith1.fsf_-_@gitster.g>
 <20230505165952.335256-1-gitster@pobox.com>
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Sergey Organov noticed and reported "--patch --no-patch --raw"
> behaves differently from just "--raw".  It turns out that there are
> a few interesting bugs in the implementation and documentation.
> 
>  * First, the documentation for "--no-patch" was unclear that it
>    could be read to mean "--no-patch" countermands an earlier
>    "--patch" but not other things.  The intention of "--no-patch"
>    ever since it was introduced at d09cd15d (diff: allow --no-patch
>    as synonym for -s, 2013-07-16) was to serve as a synonym for
>    "-s", so "--raw --patch --no-patch" should have produced no
>    output, but it can be (mis)read to allow showing only "--raw"
>    output.

I would say that is orthogonal.

>  * Then the interaction between "-s" and other format options were
>    poorly implemented.  Modern versions of Git uses one bit each to
>    represent formatting options like "--patch", "--stat" in a single
>    output_format word, but for historical reasons, "-s" also is
>    represented as another bit in the same word.  This allows two
>    interesting bugs to happen, and we have both X-<.
> 
>    (1) After setting a format bit, then setting NO_OUTPUT with "-s",
>        the code to process another "--<format>" option drops the
>        NO_OUTPUT bit to allow output to be shown again.  However,
>        the code to handle "-s" only set NO_OUTPUT without unsetting

s/only set/only sets/

>        format bits set earlier, so the earlier format bit got
>        revealed upon seeing the second "--<format>" option.  This is
>        the problem Sergey observed.
> 
>    (2) After setting NO_OUTPUT with "-s", code to process

s/code/the code/

>        "--<format>" option can forget to unset NO_OUTPUT, leaving
>        the command still silent.

> It is tempting to change the meaning of "--no-patch" to mean
> "disable only the patch format output" and reimplement "-s" as "not
> showing anything", but it would be an end-user visible change in
> behavior.

Yes, it would be a change in behavior from what no reasonable user would
expect, to what most reasonable users would expct.

These are synonyms:

 1.a. git diff --patch-with-raw
 1.b. git diff --patch --raw

And so should these:

 2.a. git diff --raw
 2.b. git diff --no-patch --raw

But who on Earth would then think these are different?

 2.b. git diff --no-patch --raw
 2.c. git diff --raw --no-patch

Your patch is *already* an end-user visible change in behavior, so why
not do the end-user visible change in behavior that reasonable users
would expect?

> Let's fix the interactions of these bits to first make "-s" work as
> intended.

Is it though?

> The fix is conceptually very simple.
> 
>  * Whenever we set DIFF_FORMAT_FOO because we saw the "--foo"
>    option (e.g. DIFF_FORMAT_RAW is set when the "--raw" option is
>    given), we make sure we drop DIFF_FORMAT_NO_OUTPUT.  We forgot to
>    do so in some of the options and caused (2) above.
> 
>  * When processing "-s" option, we should not just set
>    DIFF_FORMAT_NO_OUTPUT bit, but clear other DIFF_FORMAT_* bits.
>    We didn't do so and retained format bits set by options
>    previously seen, causing (1) above.
> 
> It is even more tempting to lose NO_OUTPUT bit and instead take
> output_format word being 0 as its replacement, but that would break
> the mechanism "git show" uses to default to "--patch" output, where
> the distinction between telling the command to be silent with "-s"
> and having no output format specified on the command line matters,
> and an explicit output format given on the command line should not
> be "combined" with the default "--patch" format.

That's because the logic is not correct, the default should not be 0,
the default should be a different value, for example
DIFF_FORMAT_DEFAULT, that way each tool can update DIFF_FORMAT_DEFAULT
to whatever default is desired.

Then 0 doesn't mean default, it means NO_OUTPUT, and then removing all
the formats--including DIFF_FORMAT_DEFAULT--makes it clear what the user
intends to do.

> So, while we cannot lose the NO_OUTPUT bit, as a follow-up work, we
> may want to replace it with OPTION_GIVEN bit, and
> 
>  * make "--patch", "--raw", etc. set DIFF_FORMAT_$format bit and
>    DIFF_FORMAT_OPTION_GIVEN bit on for each format.  "--no-raw",
>    etc. will set off DIFF_FORMAT_$format bit but still record the
>    fact that we saw an option from the command line by setting
>    DIFF_FORMAT_OPTION_GIVEN bit.
> 
>  * make "-s" (and its synonym "--no-patch") clear all other bits
>    and set only the DIFF_FORMAT_OPTION_GIVEN bit on.
> 
> which I suspect would make the code much cleaner without breaking
> any end-user expectations.

Why DIFF_FORMAT_OPTION_GIVEN? DIFF_FORMAT_DEFAULT as the opposite is
much more understandable.

> Once that is in place, transitioning "--no-patch" to mean the
> counterpart of "--patch", just like "--no-raw" only defeats an
> earlier "--raw", would be quite simple at the code level.

It's not only simple, it's a no-op, as (~DIFF_FORMAT_PATCH |
DIFF_FORMAT_OPTION_GIVEN) becomes indistinguishible from
DIFF_FORMAT_NO_OUTPUT unless another optin like DIFF_FORMAT_RAW is
specified.

I'm sending a patch series that shows that to be the case.

-- 
Felipe Contreras
