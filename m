Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0DAC433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3471D600CD
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhDRIUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 04:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRIUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 04:20:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04095C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:20:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n2so48248919ejy.7
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=5gslNmmnucPWa9C5JcJUB9X3jobWYjrlrsBnfypHhos=;
        b=umffaR0S3qEtuaNmPVaOnxK9UtgK+ktYzKZN38YYWZl+tU5nkWEIPnYHIg7HJ0hDvm
         5kUlSXjFAKBq1jN6TH+kdZo0qUd5/rKe0DUOgTNJ9M30ER8poZCbgU+FYgsSqjbX5sb+
         Oy01hlwoU7+ZRb+HYOxFr/NJH8U0PJvDXJCzI98SC4Tjny5PlOuvMAbwkbbzfva2/Xz6
         pJNwrgg3Mh4WqwgA+Mcmpi7vWKgx/gl9aBuZZWRGFazK12iWd5BHrZ5xXQEggYRsgT7g
         n4LXmB1vbahMCxNWCKyJa7CaGKDn5fZ43w5sqAdBustKK/rYE+k7eExqlXZRRSqOYP7c
         dn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=5gslNmmnucPWa9C5JcJUB9X3jobWYjrlrsBnfypHhos=;
        b=jFl1FHlkFcHFOftA6PyajJv57PzbDyRzAkWnTm1hLH/3JBM2hcGg9rCTG28W+o+JPc
         +OYrTid2MTksFKa9J/5og+Yrju+z97hHkLuXr6zdEXkavEQq7slvARVnlehHk3H5Z7P9
         RVneOcCO1vXxpBLXfslOxb2HHGI/31jOnEiWkTnHca28pkKkI71FmeGmdtvzZaEdfRwy
         vI/Dce9s5AlE09wDM6QHCgxdPKI547JfSofl5KJ2cZdniaw+6a76spgEk7UzZ35JqMio
         GiOickeqN8hROzymkmPnfNXWoBlthR07i2gdbKAKho/0GIKWAKOKx2zOkZddnM9SK8+/
         CRKA==
X-Gm-Message-State: AOAM532hUxWY+DbEiWEl1zK4xz0+pAUUKvpYzLah0XiMnzZGJH4JuhnU
        rY9awyV98pmTgzBuh/UcbzA=
X-Google-Smtp-Source: ABdhPJzXzPYETkOZRnM0zIFnHorKGslAePXHCcBwOd5chj3+tlK71TDdYsP53OpfZvbe1KmXwOpC2Q==
X-Received: by 2002:a17:906:1101:: with SMTP id h1mr16584726eja.179.1618734018901;
        Sun, 18 Apr 2021 01:20:18 -0700 (PDT)
Received: from cpm12071.fritz.box ([79.140.115.143])
        by smtp.gmail.com with ESMTPSA id s9sm9540592edd.16.2021.04.18.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 01:20:18 -0700 (PDT)
References: <20210403090412.GH2271@szeder.dev>
 <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
 <YHgEGHIgwfobcwDr@coredump.intra.peff.net>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] prevent `repack` to unpack and delete promisor objects
In-reply-to: <YHgEGHIgwfobcwDr@coredump.intra.peff.net>
Message-ID: <gohp6ky2dg9f7k.fsf@cpm12071.fritz.box>
Date:   Sun, 18 Apr 2021 10:20:17 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff King <peff@peff.net> writes:

> On Wed, Apr 14, 2021 at 09:14:01PM +0200, Rafael Silva wrote:
>
>> It took me a bit to come up with the test because it seems `repack`
>> doesn't offer an option to skip the "deletion of unpacked objects",
>> so this series adds a new option to `repack` for skip the
>> `git prune-packed` execution thus allowing us to easily inspect the
>> unpacked objects before they are removed and simplification of our
>> test suite. Furthermore, The test will now test the `repack` code
>> path instead of performing the operations by calling
>> `pack-objects`.
>
> Thanks for working on this. Overall the patches seem sane, though I
> think Jonathan's comments (especially about the confusion in the commit
> message of 2/2) are worth addressing.
>

Thanks for the review. Indeed, I will address Jonathan's comments on
the next revision to remove the confused and misleading commit message.

Sorry for the confusion.

>
> I have mixed feelings on the "--no-prune-packed" option, just because
> it's user-visible and I don't think it's something a normal user would
> ever really want.
>
> In the new test (and I think in the old ones you modified, though I
> didn't look carefully) the main thing we care about is whether we write
> out loose objects. So another solution would be to improve the debug
> logging inside pack-objects to tell us more about what it's doing.
>

Honestly, I'm also not happy adding an end user-visible variable just
for the sake of testing it, specially because it's unclear whether the
user will actually use this option.

Initially, what convinced myself for proposing the changes was the
additional cleanup in our test suite, but giving a second thought I'm
not sure now whether this is a strong argument either.

> The fork of Git we use at GitHub has something similar; when we discard
> objects or force them loose, we write their sha1 values to a log file.
> This has come in handy for a lot of after-the-fact debugging ("oops,
> this repo is corrupted; did we intentionally delete object X?").
>
> I wonder if we could do something similar with the trace2 facility. I
> know it can be turned on via config, but I don't know how good the
> support is for enabling just one segment of data (and this may generate
> a lot of entries, so people using trace2 for telemetry probably wouldn't
> want it on).
>
> For the purposes of the tests, though just a normal GIT_TRACE_PACK_DEBUG
> would be plenty. I dunno. I don't want to open up a can of worms on
> logging that would hold up getting this quite-substantial fix in place.
> But once we add --no-prune-packed, it will be hard to take away.
>
> -Peff

After reading this comment and investigating a bit more, I believe
increasing the debug logging of `pack-objects` will help drop the first
patch, at least for now, and allowing the fix to progress without the
"controversial" user option.  Later, we can revisit adding the
`--no-prune-packed` (or a better named) option in case we think this
will be useful for the users.

I'll be addressing this in v2.

-- 
Thanks
Rafael
