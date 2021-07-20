Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EDEC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3F161029
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhGTKye (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbhGTKyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:54:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB7C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:34:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k27so28037702edk.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=S9Rirvnr14Cq6ptJpV96H7FPv0FHG0lhi8TI2/jLYkc=;
        b=fhk3AYQtzcILvh79X4wfu2ZtzfO8UiC9xyC4NxaeQlW2DWqCJ5eZNRv5Mzv+7mDcL9
         Bo5Gc7LLamd8ZO45i5boaZNOZScmmu0uAnQGGIFnevCMP3K2fNBeTQs0X5t6gusk3U1C
         FqsfmdvvzKCMarCCrlt8oBmRuOKKuhIeM+dqSm+PtGf28P27Rju3+F7ZqtUeOVY3WT1z
         EHpKc8gZwmE0uOsAHR3Y9Pyj2u/FA1eAwGiSpAhTw2Da9xk4LQq68lCiN9JYWVNgeq45
         Ty4ZbI/4ePDiXhc4a4NUF21egJxmLiaTbf4o1aGRyfRPlk4nAOXQK6pjQmXLWhEdd3dL
         YXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=S9Rirvnr14Cq6ptJpV96H7FPv0FHG0lhi8TI2/jLYkc=;
        b=r/Al7xeqyWahe3pqCaOvBvPYaWMaPNEDDwtx9jPWdUE3EEVrdSged9P7TLSpiq9qQa
         YUg56Gr/p+ot4UW9f/EuxMR4G0fJxef4S/uP2POj7jp+cTfp2yRue0L8KRyeCjyXysTW
         YKvjY394b72E5nHQ9g9Di0x6NryTQmm7lYbxFr8KTfXPFZEPj9yQsDRObA6xqZubLu/R
         W6eNyi9+sp7FfHbEZEVFdaMZeE3TWyMS4VcKisby9RbDbsZSwLJk1foVDnjQcjMnt47D
         xfN9me1KjWvfQ9alFQYyh98+DiljBfpDPT6Jz55xcwE3sEqwW/pF5kwMpxiUX2mikK8g
         MEJg==
X-Gm-Message-State: AOAM533icmf+Fsj6iTTCs2UWPDv8jnWEwRG5mxFyj2qWt1EphGKRg/Ab
        JnYET++MFaCaOPcPLkLBR6Q=
X-Google-Smtp-Source: ABdhPJwzmiJGUZ8d7kRrR2TMIyss6a9PhlLgJGQgMNeD15O4x1H5U7W7HnpthdIljySFg5raAGi48w==
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr40593421edw.87.1626780881927;
        Tue, 20 Jul 2021 04:34:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u5sm9186829edv.64.2021.07.20.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:34:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] commit-graph: use parse_options_concat()
Date:   Tue, 20 Jul 2021 13:31:15 +0200
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <patch-3.5-2e7d9b0b8e4-20210718T074936Z-avarab@gmail.com>
 <YPWtRd+523N1cWR/@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPWtRd+523N1cWR/@nand.local>
Message-ID: <8735s9w74r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 19 2021, Taylor Blau wrote:

> On Sun, Jul 18, 2021 at 09:58:07AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Make use of the parse_options_concat() so we don't need to copy/paste
>> common options like --object-dir. This is inspired by a similar change
>> to "checkout" in 2087182272
>> (checkout: split options[] array in three pieces, 2019-03-29).
>>
>> A minor behavior change here is that now we're going to list both
>> --object-dir and --progress first, before we'd list --progress along
>> with other options.
>
> This is very reminiscent to the patch I sent to do the same in the
> `multi-pack-index` builtin, probably because you were the person to
> recommend I do that cleanup in the first place ;).
>
> I got some good advice from Peff in [1] went I sent that patch, which
> I'll try to summarize here, since I think a few pieces of it could be
> applied to clean up this patch a little.
>
> [1]: https://lore.kernel.org/git/YGG7tWBzo5NGl2+g@coredump.intra.peff.net/

Thanks.

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/commit-graph.c | 39 +++++++++++++++++++++++----------------
>>  1 file changed, 23 insertions(+), 16 deletions(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index baead04a03b..ff125adf2d5 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -44,6 +44,21 @@ static struct opts_commit_graph {
>>  	int enable_changed_paths;
>>  } opts;
>>
>> +static struct option *add_common_options(struct option *prevopts)
>> +{
>> +	struct option options[] =3D {
>> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
>> +			   N_("dir"),
>> +			   N_("the object directory to store the graph")),
>> +		OPT_BOOL(0, "progress", &opts.progress,
>> +			 N_("force progress reporting")),
>> +		OPT_END()
>> +	};
>
> Not from Peff's mail, but is there any reason to non statically allocate
> this?
>
> The only reason I could think of is that `opts` is heap allocated, but
> it's not, so I think we could probably mark `options` as static here
> (and perhaps rename it to `common_opts` while we're at it, if for no
> other reason than to be consistent with what's in the multi-pack-index
> builtin).

I've applied your suggestions in full, thank a lot.

I'm a bit on the fence about this one, because it works here, but not in
other cases where the "options" refers to variables declared in the
function, i.e. &progress after an "int progress =3D 0" or whatever.

Making it all global seems like a bit of an anti-pattern, and having to
refactor it if we ever need to change it to rely on something dynamic in
the function is arguably bad.

And arguably not, because if we use this static pattern consistently
those cases will stick out more, whereas a lot of builtins now declare
them non-static in the function for no particular reason, and it's not
like we're harmed those commands hardcoding things at the top level.

But you won't find it trivial to e.g. migrate builtin/checkout.c to this
pattern, whereas using the non-static one is easy everywhere.

Anyway, I squashed this in, just say'n. Having written the above I'm
still not sure what I think about it :)
