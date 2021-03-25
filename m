Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A098C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 02:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBB1619F7
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 02:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbhCYC3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 22:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbhCYC3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 22:29:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3CBC06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 19:29:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt15so394609ejb.12
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 19:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HxXcg1K8tamTfzbTLAI952cmEBLLEwIj3m3SRcIoB+o=;
        b=Xcimgrmc+OnMTOnbEwBIsvcJ5oeLXYx42zfFLh4zTma5BOojJeqa28gKI8/AaEDhkf
         6oFVKRsEz5s3ISqaJfZGFWmixJqe7F1ja1bnrSKfuqTv41pbFyRUZqbkmBzugBpVkMfo
         yKoySjMlye/MQ9GMZ9x894+yd2ZksaDsMhgAuydcNGoOeVJF2mGoOgB3rO5d6fBhxIQ2
         1n0Gqbh1a4zwROZilUNebcRnvSGYHZbL2bKiHhYnpzIKNeMx8uOrfSpH02doLsgd3V8o
         RofMdxMtTVcirsr+ldo/GF0pBjxJNYlAKl4/7j56IJ8yX/Y4icnynB6a355rNLZSZi7X
         30tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HxXcg1K8tamTfzbTLAI952cmEBLLEwIj3m3SRcIoB+o=;
        b=VMhotSmc33ModdPQw9JSX+PN6xqSE8Uy5HYy5olTBwpxYEu9DWlsn3eAwpLwZ3E49w
         1nJUGXeRtio07Jeqza6oYJKDD4ZgtzgCrUuYazzoPCBJHJz1Q3AR0zbgpcwBGrcW1xRi
         hB92OfpJ8p9+KShas6dL40FyFRTpG6c3kLHorMV/pdIrmW/6x9HvwekRmxV/+iBQLjfz
         s7HHYnph5knRZ+NwnAH63LN7wABQzP2WVTwTYNSP9dY3bWFgLmBpFnZkUHRo2szjIvDn
         siSirse0ieNRyjksU+SgsaVEsvNQg2y7trn9KtG3IxROgzroyan24vd9mD6MJv7hlM1c
         9wDw==
X-Gm-Message-State: AOAM53156tBDvUKfIenFu4Q1vTlCOqUaEXeAFC5vY8IF+BE6LpTELzoa
        kvr+OjuZiah1HvP6r+UQ0GibET79HFiY3A==
X-Google-Smtp-Source: ABdhPJxQ9M1NUidOo2fEpFmL3J6Uyt3SztmXmeL2ltZNKAKV7OTQBSRzXeldqstbJERdeHUF5/yUEQ==
X-Received: by 2002:a17:906:f9d8:: with SMTP id lj24mr6960601ejb.200.1616639352198;
        Wed, 24 Mar 2021 19:29:12 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n16sm2015316edr.42.2021.03.24.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 19:29:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 3/4] Makefile/coccicheck: allow for setting xargs
 concurrency
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <9d5814dacdc281389c4cb163ddbe4b749e6c0852.1616414951.git.avarab@gmail.com>
 <YFuSSqbAjTmaEMCB@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YFuSSqbAjTmaEMCB@coredump.intra.peff.net>
Date:   Thu, 25 Mar 2021 03:29:11 +0100
Message-ID: <877dlwotjc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 24 2021, Jeff King wrote:

> On Mon, Mar 22, 2021 at 01:11:49PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Extend the SPATCH_BATCH_SIZE facility added in
>> 960154b9c17 (coccicheck: optionally batch spatch invocations,
>> 2019-05-06) and bcb4edf7af7 (coccicheck: make batch size of 0 mean
>> "unlimited", 2019-05-08) to allow for both setting
>> SPATCH_BATCH_SIZE=3DN, and also to have a more advanced SPATCH_XARGS
>> argument.
>>=20
>> The reason to replace the "$$limit" is that now you actually see under
>> V=3D1 what argument your program will get invoked with.
>>=20
>> The reason for the "9999" limit is that if you e.g. try to define an
>> "$(XARGS)" which is conditionally an empty string or not depending on
>> this setting then e.g.:
>>=20
>>     echo $(FILES) | $(XARGS) $(XARGS_FLAGS) $(SPATCH)
>>=20
>> Over multiple lines with "\" will error out. I think just setting it
>> to "xargs -n 9999" as a trivial workaround is the best solution here.
>
> I don't understand this 9999 comment. The original was sometimes setting
> $limit to the empty string, and then doing:
>
>  xargs $limit
>
> How is that any different than setting SPATCH_XARGS to just "xargs" for
> the unlimited case?

The "over multiple lines" is important. But it seems not
anymore. I.e. in an earlier version I had:

    $(XARGS) \
        $(XARGS_FLAGS) \
        $(SPATCH)

And it would brek if XARGS_FLAGS was empty. So I set it to -n 9999 as a
fallback.

>> +# For the 'coccicheck' target; SPATCH_XARGS can be used to manually
>> +# tweak the xargs invocation. By default we invoke "xargs -n 1", and
>> +# "xargs -n 9999" under SPATCH_BATCH_SIZE=3D0.
>> +#
>> +# Setting SPATCH_XARGS overrides SPATCH_BATCH_SIZE. To get concurrency
>> +# when targeting a single contrib/coccinelle/%.patch use e.g. "-P" if
>> +# your xargs(1) supports it:
>> +#
>> +#    make contrib/coccinelle/strbuf.cocci.patch SPATCH_XARGS=3D"xargs -=
P 8 -n 8"
>> +#
>> +# Or a combination -jN and "xargs -P":
>> +#
>> +#    make -j4 coccicheck SPATCH_XARGS=3D"xargs -P 2 -n 8"
>
> As I mentioned in the last round, using "-P" is racy. I'm not sure if
> it's something we should be recommending to people.

Yes, this would need to use N tempfiles we'd cat together at the end to
be POSIX-reliable.

In practice I've never seen this sort of thing be unreliable for a case
like this.

POSIX just guarantees that the output won't be interleaved up to
PIPE_BUF, which is typically 4k. We certainly get patches bigger than
that from spatch in some cases.

But from the OS's perspective emitting this output happens at a glacial
pace. So even if it crosses that boundary it's unlikely to be
interleaved.

Even:

    perl -wE 'print "a" for 1..1024*1024*100' >1
    perl -wE 'print "b" for 1..1024*1024*100' >2
    perl -wE 'print "\n" for 1..1024*1024*100' >3
    $ du -shc 1 2 3
    100M    1
    100M    2
    100M    3
    300M    total

Which at least on this computer I can't get to not print:

    $ echo 1 2 3 | xargs -P 3 -n 1 cat|wc -l
    104857600

Suggesting that even for output of that size the \n's aren't mixed
up. YMMV.

Anyway. I think I'll just redact this topic. Maybe I'll change my mind
on it, or pick it up some other month/year/whatever.

I appreciate everyone's feedback on it, but for something I thought
would be a rather trivial bugfix I've sunk way too much time into it.
At this point I can't even remember why I was trying to run coccicheck
in the first place.

There's e.g. still your outstanding feedback on what's really going on
with that underlying spatch race I was trying to fix with this
--include-headers-for-types workaround.

I think digging into that would be interesting for someone, but right
now that's not me. I really don't want to spend time on digging into
spatch's OCaml guts to figure that & any other outstanding stuff out.
