Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03720C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 09:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiDHJU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiDHJUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 05:20:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360B4334122
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 02:15:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qh7so15967961ejb.11
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QM9hilvZ7eyNLMyqGZbW/z9knLV5ak3XpjHO0o9vb1A=;
        b=UWIaE3lHHjbNzJLDFvw1w1JXInA0zAVdkxn1CjIlUZe2oOBpoToAu9TBs+oHK6zFWz
         3sp3OMmd6dSGLMUWNHirmFz6QwrSNPRUBLv14C7ZpO7/8Ony6GTG9yAtnshEDKcy/KrH
         ujp+EkAYm8C5oT9Gp8H5T27X36gBAF8KFO5iZVpck9iNb/SKQbBDZuE/rb1njgpla/oU
         T1V+2gFnUA9IjndL0HZTwRHJ43KOfqh7PPUJlFskniiMX6M5kEG/uOKor0J0ajKRfvDt
         Si2x3NvlI+rHHlZK+onjdfebE5ZLgn5B2fP+qIMBwbt+N50DU/rW9DSojVW1bcv3sWo2
         HD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QM9hilvZ7eyNLMyqGZbW/z9knLV5ak3XpjHO0o9vb1A=;
        b=RhaQOih7nEIE+m+3Lr2sFJ+8rJn4l46RiEO1JKicqUMQ9UzTxID9DVl0liwyUUh+jA
         F2TxjJQ3QnX94EEC+YXmUzSpyIbBStsEsGw8EwDshhds1z/Yzh2jyeWqSFOiPHsDu12J
         BGXb1Y9qyJiMvfcjfaVocGNk6Y5hTR7Alh+aNaT5YJTLGpFfsXdnWPTqhQu+NqpwycDy
         R1yQDkP3HJ+yPfNeLTycryCMwbyt//o1UYrz3tPruGHj1FCXI5nnxvladOTpXvr0J1Op
         XV2zSDg2Vc1AAHvV9mV9NExaM7d9ybOhxIhz7AGflgWpsVl9tf8M7G3oyb+BxZs9YWuw
         yt/g==
X-Gm-Message-State: AOAM5332zCikQ/V5jnvYlrIyqbUgV1jkuk/h32nx2HcojoMTTqZlhZS2
        lmAlWJTVjJqgyjPVsb0h+zM=
X-Google-Smtp-Source: ABdhPJx++SJuyPKIMcI/72sVZi8jZGo8R9iABKhwuX95RjR5VPjx+AIgIhbLX7DuyZ/VURiEUQ1/GQ==
X-Received: by 2002:a17:907:7b92:b0:6db:71f1:fc20 with SMTP id ne18-20020a1709077b9200b006db71f1fc20mr16597498ejc.343.1649409320583;
        Fri, 08 Apr 2022 02:15:20 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sh31-20020a1709076e9f00b006e8289e5836sm2259233ejc.117.2022.04.08.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:15:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncki7-001G0M-7F;
        Fri, 08 Apr 2022 11:15:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] doc txt & -h consistency: fix recent "cat-file"
 inconsistency
Date:   Fri, 08 Apr 2022 10:55:46 +0200
References: <patch-1.1-79404e05d73-20220407T185645Z-avarab@gmail.com>
 <xmqqv8vkr64h.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqv8vkr64h.fsf@gitster.g>
Message-ID: <220408.864k34c4wo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 07 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Subject: Re: [PATCH] doc txt & -h consistency: fix recent "cat-file" inc=
onsistency
>
> IOW ...
>
>> -'git cat-file' (--batch | --batch-check) [--batch-all-objects]
>> +'git cat-file' (--batch | --batch-check | --batch-command) [--batch-all=
-objects]
>
> ... we forgot to add "--batch-command" to the documentation, even
> though we added it to the usage text in the source.
>
> And explained that way, this change makes quite a lot of sense.
>
> It could be a worthwhile longer-term goal to make it consistent
> between the synopsis and the usage text", but we are far away from
> such a goal.  I'd rather keep such a topic outside this focused fix.

Yes, I just sent this one in because it's usage new in this release,
thank for merging it.

> Given that we have been pushing to stop listing individual options
> in SYNOPSIS, and instead using <option> placeholder, and also list
> different operation mode of a single command on separate lines,
> between
>
>     $ git commit -h 2>&1 | sed -e '/^$/q'
>     $ git commit --help | sed -ne '/^SYNOPSIS/,/^$/p'
>
> we would want to pick the one we have from the command (i.e. the
> former) and update the documentation source for the latter.

I think both should have the long form, but we don't need to argue that
point here.

> Somebody needs to go through the comparison of individual
> subcommands and present a good plan.  I find that, in comparison
> between the -h and --help output, neither is quite satisfactory for
> "git bisect", for example.  It would be a huge task and would be a
> distraction during the pre-release period.

I have a branch locally that fixes a lot more of these, it just uses
"sed" to extract both the -h output and the SYNOPSIS from the .txt,
normalizes both sides (e.g. getting rid of ASCIIDOC-markup) and does a
test_cmp of the two.

It finds a lot of issues which are worth fixing, and which I have some
queued patches for (but yeah, not during the rc etc.).

A lot have nothing to do with the "long form or <options>?" question. But j=
ust:

 * Basic formatting issues, e.g. using [-v|--version] instead of [-v |
   --version], or whitespace-padding or whatever.

 * Things like referring to <path> in .txt, and <pathspec> in -h, we
   should pick one and stick to it.

 * Cases where we're 100% the same but miss 1-2 options, e.g. this
   cat-file case, there's plenty more like it, e.g. ls-remote's -h is
   missing "[--sort=3D<key>]" (but nothing else).

>     Side note: and no, we do not want to tie the documentation to a
>     particular build too tightly, and it is a no-no to generate the
>     documentation source from 'git cmd -h' output.  Even when an
>     option is conditionally excluded from a particular build, I'd
>     like to be able to build and publish documentation for wider
>     audience than just to myself.

I don't have changes to do that, but I think the particular concern
you're airing here isn't an issue at all.

I.e. whatever other issues we'd enocunter with such auto-generation we
do not have *options* that are conditional on compilation, nor do we
have commands that we build and don't build the corresponding
documentation for.

Or the other way aroun,d i.e. if we don't build the command, we don't
build the docs, that's what EXCLUDED_PROGRAMS in the Makefile ferried up
to Documentation/Makefile is doing.

Anyway, I mentioned that as a solution in some past thread, but I think
it's probably not worth it v.s. just a test scraping and comparing the
two.

It's not that big of a deal to update both, it's mainly just that we're
forgetting it now because we have no structural checks in place.

And if we did come up with such a script but didn't want building the
docs to require a C compiler we could always make it something you run
as a developer and commit the result, which is pretty much what we do
now, just without the benefit of such a script.
