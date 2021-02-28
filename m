Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD52C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 16:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8364E83
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 16:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhB1QVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 11:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhB1QU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 11:20:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439BC06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 08:20:17 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bm21so4819310ejb.4
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+45VgYMfJAb2clzmvgXIKZejKNRr6ux5EFttoJX1frI=;
        b=h2OnNOO7A7C+9baedqK5gtVzzMuD3uxzevrxrrJX9i/8SNlM1RJQFWDpFI8EM65DTr
         ZRLGg2lyCq2PfB0cYULFr5TjEN6qdRcfFNJs+7AGscnf6IXwlAHhXCQ0YhJHYAj2m7/j
         PCjov2t3r+TYQTM01GU2OO8q4AQsKqWbL8YWBop9+bfIiGuzo7JEpeyYpZvx56I4d5jy
         1/wtKocNCWtRlmzoKZaNo9C/LW4DTBipjZl4Wh7UqHjoQtCFrZzvH9gqbVgbCYsZ+tJw
         kyGVjoQ5SdNbPYjuCoYhE7eJx25F+b0x31TkG1wQAwNCaj9mUBDR47ZXjI0LxFqTFRcP
         Dlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+45VgYMfJAb2clzmvgXIKZejKNRr6ux5EFttoJX1frI=;
        b=dy/rXkROXFp1FHEHDqdcHLq5vswiEbiO2LLSuLtlgy5F/EOkxEEzcly5nUMs+fU7nC
         r1oVvw/YtNjgeuU6xnnj4lPxnWSpMgH+98+psF8k3KzHHB9LRj6SoMMu2P9ZU5Ja6c90
         7++cZff5tQvfHpVC75naYVDDmzKu7iwWhtocfrt6ngU8s6fTtkMPxYARYFQ3TfCk/DCC
         wMq57MS/SjJL96FVBlkF2bIs+lR8ELBX594iHCN+aHDqZvY1At+QgGhzhE3t71HIVb6c
         pCUmBVqR2gr7JoZmpyms8LD+PA9+dQnWjSIuO5Q7tsSadVy2oR0sE0odESbHy7Plz/v4
         OStQ==
X-Gm-Message-State: AOAM530Jzo0hMXkHwqn1CFy9qwSyY06/20dogl4bLh1aoaLvpXU0atKP
        d2y0PWegAno8H+OWSwFJTrg=
X-Google-Smtp-Source: ABdhPJwDy/zFWAoFAyDBQ9zTnk3pchAEQrMcNMGuAi6YiOfkeA0bdgPnM6yI/HxblKBKgRF3az8Mag==
X-Received: by 2002:a17:906:ecf3:: with SMTP id qt19mr6391454ejb.467.1614529216206;
        Sun, 28 Feb 2021 08:20:16 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jx22sm8509501ejc.105.2021.02.28.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 08:20:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] commit-graph: warn about incompatibilities only when
 trying to write
References: <pull.888.git.1614351036334.gitgitgadget@gmail.com>
 <87r1l27rae.fsf@evledraar.gmail.com> <xmqqy2faqwr0.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqy2faqwr0.fsf@gitster.g>
Date:   Sun, 28 Feb 2021 17:20:15 +0100
Message-ID: <8735xgkvuo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 26 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Feb 26 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> In c85eec7fc37 (commit-graph: when incompatible with graphs, indicate
>>> why, 2021-02-11), we started warning the user if they tried to write a
>>> commit-graph in a shallow repository, or one containing replace objects.
>>>
>>> However, this patch was a bit overzealous, as Git now _also_ warns when
>>> merely checking whether there _is_ a usable commit graph, not only when
>>> writing one.
>>>
>>> Let's suppress that warning unless we want to write a commit-graph.
>>
>> Ah, so that's what it's for, as I suspected :) Unfortunately...
>> ...
>> ...doing this will cause "git gc --auto" to run into persistent
>> warnings. See a WIP patch-on-top in [1] below...
>
> Thanks for an input.
>
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 64f2b52d6e2..9109898eacb 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -593,7 +593,7 @@ int cmd_gc(int argc, const char **argv, const char *=
prefix)
>>  		/*
>>  		 * Auto-gc should be least intrusive as possible.
>>  		 */
>> -		if (!need_to_gc())
>> +		if (0 && !need_to_gc())
>>  			return 0;
>
> Leftover debugging cruft?

Yeah, see the "Obviously needs amending" later in my E-Mail.

>> -			if (!quiet)
>> +			if (flags & COMMIT_GRAPH_WRITE_WARNINGS)
>>  				warning(_("repository contains replace "
>>  					  "objects; skipping commit-graph"));
>
> I would have expected the code would arrange to make the bit cleared
> in the "flags" that would be passed around to the next call that
> inspects the same bit, so that we won't need to see repeated
> warning()s, but I do not see where it is done.

Right, we could do that, but I think the path down my "test_line_count =3D
1" is more useful.

I.e. it's pretty easy to reason about us not calling
write_commit_graph() twice in the same process, so I don't think such
flag clearing is needed.

But the case the user cares about is getting this warning twice when
they invoke git, but we spawn two processes.

> I am tempted to say that we should revert c85eec7f (commit-graph:
> when incompatible with graphs, indicate why, 2021-02-11) for the
> upcoming release.  That would give us enough time to come up with
> and cook the solution in 'next' in the meantime.

That's probably sensible.

Also, I noticed that we went through this whole saga in the past, see
25575015ca (repack: silence warnings when auto-enabled bitmaps cannot be
built, 2019-07-31), including breaking background gc.
