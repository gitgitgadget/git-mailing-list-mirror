Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE70C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 12:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiE0MrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 08:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiE0MrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 08:47:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3EDD8A
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:47:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z43so784644ede.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TM9o3WorhyiaLUp6u53bM7E/E8rn5+KZhNQKGVjuMEU=;
        b=U5LLHGwQn8x5WjA6+O37UyMeluCwey5kiS0no9UIgrLw7x3poX0cyeytZm3LKp+xZj
         oTqle4+MlqmNom4ISVaX/F816Y7AxIcQ9ocfL1m+joeCpdYdfiAOdoR8pRFtN4kHVSmy
         qzU1MQbeNUKUkbyuC5KmfMGr+3J/Vm9vtmGE5wxS2XiB5Q6NKI1sI1cUCNgf4P++TInr
         mbCf5huqgAVvSBj/wKayI/cNS9egxXBChjG5RqGy0bPnztVEQEgOp2/XtEbUzale3fA0
         F+zNc5ydv+JJ29XE0MYQ/evnyPo8jCefbd7W5OILqCCqm/rHi4TXhH4C1I7pBfR0dLqD
         6FkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TM9o3WorhyiaLUp6u53bM7E/E8rn5+KZhNQKGVjuMEU=;
        b=8BL+UO+KlXK8Tw20uykE9gV55RmhFU12bLJpfmKztqrCA91j/GmMS5IE6f6TcU2zrZ
         qkIAPg7aktyDrcqNEzIf6CB1CF3txSaTXtPiWj4W2Ib+v+zhQMng2DFMrhmuEfp6zRec
         RzfE2zrC98Vz8Xdb1Ttsu/nPNnQTR5s4tt8syFamCdsmc6/H0EoUVH5ROhN9diAJAvp7
         MSOwRc03bIzuac9tqjRtY2VmYC5mYHuATxTyeaxwZnjIz94Oy750NSICgmcqx7CPGhuD
         PrBCHKijhaTnyXfPRT4SXIQG6OAxerUH+Gd8UaS/0Q731AvMbAhU5uUJGsQkAeV0KLfY
         TnSA==
X-Gm-Message-State: AOAM5320Jm8XYo7hfzvCbfs+mCfo1XvitLL09U5PC5pUKsOHTYnDUubh
        LX7upkMLZW+FxGrkjUrx9ew=
X-Google-Smtp-Source: ABdhPJwMncArEHZZGNcjLgdCsCtXiWibpHITFHITqadCeH220qAkjFD7oXoT5e146EmZBvBuy29AmA==
X-Received: by 2002:aa7:c68d:0:b0:42b:cc77:4696 with SMTP id n13-20020aa7c68d000000b0042bcc774696mr12313909edq.320.1653655626462;
        Fri, 27 May 2022 05:47:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m8-20020a509308000000b0042617ba639esm2016974eda.40.2022.05.27.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:47:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuZMv-000Syr-HN;
        Fri, 27 May 2022 14:47:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Date:   Fri, 27 May 2022 14:34:20 +0200
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
 <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
 <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de>
Message-ID: <220527.86o7zj2ldi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Ren=C3=A9 Scharfe wrote:

> Am 26.05.22 um 11:40 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Thu, May 26 2022, Philip Oakley via GitGitGadget wrote:
>>
>>> From: Philip Oakley <philipoakley@iee.email>
>>>
>>> Since feebd2d256 (rebase: hide --preserve-merges option, 2019-10-18)
>>> this option is now removed as stated in the subsequent release notes.
>>>
>>> Fix the option tip.
>>>
>>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>>> ---
>>>  builtin/rebase.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>>> index 7ab50cda2ad..6ce7e98a6f1 100644
>>> --- a/builtin/rebase.c
>>> +++ b/builtin/rebase.c
>>> @@ -1110,7 +1110,7 @@ int cmd_rebase(int argc, const char **argv, const=
 char *prefix)
>>>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>>>  			parse_opt_interactive),
>>>  		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>>> +			      N_("(REMOVED) try to recreate merges instead of "
>>>  				 "ignoring them"),
>>>  			      1, PARSE_OPT_HIDDEN),
>>>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
>>
>> I have some local patches for this more generally, but for
>> PARSE_OPT_HIDDEN options we never do anything with the "argh" field,
>> i.e. it's only used for showing the "git <cmd> -h" output, and if it's
>> hidden it won't be there.
>
> Hidden options are shown if you use --help-all instead of -h.
>
> OPT_SET_INT_F always sets the struct option member "argh" to NULL.  The
> string changed above is the "help" member, not "argh".
>
>> So there's no point in changing this string, nor to have translators
>> focus on it, it'll never be used.
>>
>> This series shouldn't fix the general issue (which parse-options.c
>> should really be BUG()-ing about, after fixing the existing
>> occurances. But For this one we could just set this to have a string of
>> "" or something, only the string you're changing in 3/3 will be seen by
>> anyone.
>
> What is the general issue?

You're right. I'd missed that case with --help-all, and remembered
briefly testing where we used the string before in some WIP code.

Looking at it again I think I tried NULL-ing a few and running the tests
with SANITIZE=3Daddress or something, which in this case it looks like
we'd 100% pass with. I.e. we have zero test coverage for that subsequent
NULL dereference.

Sorry about the noise. I'll add some tests for this case in some
parse-options.c sanity checking tests/patches I'm planning to submit at
some point.
