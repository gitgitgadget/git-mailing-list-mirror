Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE36BC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 00:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhL2AEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 19:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhL2AEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 19:04:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A20C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:04:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j21so79569673edt.9
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 16:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=H2e7ZlPz3ViEdeeU+KpD/nOreCDViRsOyXVoDBOA1cM=;
        b=ayGoj3k8oHXInXBJ3ROhcjFXkpIZCvWLd+cNnXCCy73yOtoH+Dyg3z1Ukeb6gfIFXc
         Gz4B5203EiUINW2lwJwxeuoXi8jNq0TXhh75IhKA0sIfZKNJT7es5PXEFiSG4MLUMtzY
         I/DR2bMhdYhVTGXQsSoA6WA3g40SVlsjzrqT3bImG+kNJX+Trelp5gUObK7WePZEgB1z
         TbCS0e0WOHnMSPQXD5oM26DVyfpbY3xrHmSFBCJ2EGfgcqusZx8EUhsQOvdnA597nH8r
         gPTrUlF2ao7vfHzBkp1Hlz468E8qAa1J52Sw6EMloTx43nMNbLJ8OcDy5k+OKhpf76Lp
         DF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=H2e7ZlPz3ViEdeeU+KpD/nOreCDViRsOyXVoDBOA1cM=;
        b=bRm2cc4Uyw+JItsan/odrk86FVweNbgSDGW2xEygOkJHoJsJnY3IXSzQ3FSKhR4pJ8
         L/jp80jFZ0AgjUyirfqbvMGv6s5mVNt7f6d4rojbrrnI43jLHj5ZesMOv6JISCZCUwE5
         o5GFAWXe6hGqvil6lLbvbykpne4VahpqwDtr20tnggFs76FiRopXtsH+Yc0QyQRZEaFD
         t6k5d9XSRM7Y5yET+LpTI0uC+urqINYgQVqRdg1hJf5/RU9IZho0LnwKD5IXwXIObKvI
         Ce7ybUDjYFu27l4s8ggSiqDj0EKK5EGj9hMnjb9gOSZMAjIFw8Z2oPVwbzH4dGZdZmxA
         r4Zg==
X-Gm-Message-State: AOAM533a/klKJlRvo0RuUij99cR8SIafOoFKEokoX9FHAIKOjYToc10L
        B0C0ZAbUrl4iN5n6NrxpVpY=
X-Google-Smtp-Source: ABdhPJyxuvZiFwyej+IDm7XIWgPvfQsLxhAljGrhSrVmwUQ3MyDqoZ0uN37ePqCGJKRGbhXPIQP5Zw==
X-Received: by 2002:a50:d492:: with SMTP id s18mr23370391edi.145.1640736250090;
        Tue, 28 Dec 2021 16:04:10 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id sg12sm6447690ejc.46.2021.12.28.16.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 16:04:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2MRs-000GFw-1Y;
        Wed, 29 Dec 2021 01:04:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v8 7/7] *.c: use isatty(0|2), not
 isatty(STDIN_FILENO|STDERR_FILENO)
Date:   Wed, 29 Dec 2021 00:56:18 +0100
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
 <patch-v8-7.7-060483fb5ce-20211228T150728Z-avarab@gmail.com>
 <d0bdc7e5-9e34-49d8-33cf-dd96a807617e@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d0bdc7e5-9e34-49d8-33cf-dd96a807617e@web.de>
Message-ID: <211229.86zgokgttz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 28 2021, Ren=C3=A9 Scharfe wrote:

> Am 28.12.21 um 16:19 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
>> and around 10 "isatty(0)", but three callers used the
>> {STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
>> them.
>>
>> Let's change these for consistency.  This makes it easier to change
>> all calls to isatty() at a whim, which is useful to test some
>> scenarios[1].
>
> Hmm.  Matching e.g. "(0|STDIN_FILENO)" instead of "0" is harder, of
> course, but not much.
>
> Shouldn't we use these macros more to reduce the number of magic values?
> The code is slightly easier to read before this patch because it doesn't
> require the reader to know the meaning of these numbers.
>
> Reducing the constants to their numerical values is easy to automate in
> general; the opposite direction is harder.  Coccinelle can help us take
> such a step with a semantic patch like this:
>
> 	@@
> 	@@
> 	  isatty(
> 	(
> 	- 0
> 	+ STDIN_FILENO
> 	|
> 	- 1
> 	+ STDOUT_FILENO
> 	|
> 	- 2
> 	+ STDERR_FILENO
> 	)
> 	  )

We don't bother with EXIT_SUCCESS and EXIT_FAILURE, and for those (VMS)
there is a reason to not use the constants, as EXIT_FAILURE may differ.

But for these I personally think these symbolic names are rather
useless.

They never differ, and when working on POSIX systems you're going to
need to know that 1 is stdout, 2 is stderr. You're also going to have to
maintain shellscripts that use ">&2" or whatever. Those aren't using a
hypothetical ">&$STDERR_FILENO".

But in any case, this change isn't even trying to make the argument that
we *should* use one over the other, just that the constants are used
much more than *_FILENO, so changing them to make a subsequent (now
ejected out of this series) change easier to explain is worth it.

So I'd think we can just take this small change, and argue separately
whether it's worth it to apply that coccinelle rule.
