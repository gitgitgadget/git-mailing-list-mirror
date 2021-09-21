Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C99EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397A16115A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhIUNyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhIUNye (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:54:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71210C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:53:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg28so52019531edb.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=S2O9d2TtwK8ecGME0q7xxI4tTeuGfceqD7aB0aqhs4w=;
        b=Vxn+ysSSY2JWo9zyq8yx29bk0tkV6G023gVdf4rG0fR8CHI0nFW0r6Wqw/AhdXNt2M
         crRc5RoV2LKVFeoK+b5u/qRwTeUz2HDDrsQQclN6rMRZ82J62feBewN6u4WrLl769lOB
         hsSARfAlM6lIiYpzlKPffNWklnpcAK99zsTebPZgjQV9aKL03HxCLhOWcdpi1SXX9psG
         zmpDDpXdBXK+83pr/3fRbfo9/cwDK9K8d8G/0Brho48UL3wtjoZhwRUnscI1KoaCKyUf
         eqKkMjjPFoTx2EGUHkj/YxP0gjP3dOKxGgD6aDqX4q5eVIr9vwxKa03SKqcGeStDxj6Z
         wa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=S2O9d2TtwK8ecGME0q7xxI4tTeuGfceqD7aB0aqhs4w=;
        b=GREfMK57LX0DYlt69AjlVvEbWZwZq3mdxBHTmnA6L/GvB59mYBfDBfs9Bv738KfF8r
         3CTs5L6SeknA4BXOGpIWnYmCuB6nmRyK7NpxtBDdMM+g2fTBpCU5pTB3XaJ5FFvlup45
         xivzybnLz3/SWn483TgWnhndlCyiNlnRGHYVBOgalU/Q0tRPllEucJp3F7N18GvhROm0
         39KptuKcEp8Rski+bM4yB1bolfqAcyb96vY8op82PcPfR7hpU8sUYP+G06KFzPwgjnGR
         9X8NOTdFSHEyGAUQoLo4vSTkjx5376UCymtFTUvYngeYGZYLda1miukqWq+/DDIvtqAM
         TZOA==
X-Gm-Message-State: AOAM531DvDK38S0hAc4uYZotjUxPfOpfXksn1UfGXe+RqmqcEG8Q5v8J
        E8yahf4PkOH2uykJVe43MJA=
X-Google-Smtp-Source: ABdhPJwki5/YATlsUcrNLqo6CwA3iWQV5oW67ZyHAipG7HmKh2q//lESuQryZXfzOuFlBEoyEbFj6w==
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr10051696edl.60.1632232305202;
        Tue, 21 Sep 2021 06:51:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm4464721ede.86.2021.09.21.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:51:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] help: correct usage & behavior of "git help
 --guides"
Date:   Tue, 21 Sep 2021 15:49:23 +0200
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
 <patch-v2-2.5-039639a0dd3-20210910T112545Z-avarab@gmail.com>
 <2493437c-01c5-ddcc-6a61-666f87e70f20@iee.email>
 <8c72d383-4ae2-b96c-6886-7c36153d8991@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <8c72d383-4ae2-b96c-6886-7c36153d8991@iee.email>
Message-ID: <878rzq9gun.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Philip Oakley wrote:

> On 10/09/2021 19:15, Philip Oakley wrote:
>> On 10/09/2021 12:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> As noted in 65f98358c0c (builtin/help.c: add --guide option,
>>> 2013-04-02) and a133737b809 (doc: include --guide option description
>>> for "git help", 2013-04-02) which introduced the --guide option it
>>> cannot be combined with e.g. <command>.
>>>
>>> Change both the usage string to reflect that, and test and assert for
>>> this behavior in the command itself. Now that we assert this in code
>>> we don't need to exhaustively describe the previous confusing behavior
>>> in the documentation either, instead of silently ignoring the provided
>>> argument we'll now error out.
>>>
>>> The comment being removed was added in 15f7d494380 (builtin/help.c:
>>> split "-a" processing into two, 2013-04-02). The "Ignore any remaining
>>> args" part of it is now no longer applicable as explained above, let's
>>> just remove it entirely, it's rather obvious that if we're returning
>>> we're done.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>> ---
>>>  Documentation/git-help.txt |  6 +++---
>>>  builtin/help.c             | 11 +++++++----
>>>  t/t0012-help.sh            |  4 ++++
>>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
>>> index 568a0b606f3..cb8e3d4da9e 100644
>>> --- a/Documentation/git-help.txt
>>> +++ b/Documentation/git-help.txt
>>> @@ -8,8 +8,9 @@ git-help - Display help information about Git
>>>  SYNOPSIS
>>>  --------
>>>  [verse]
>>> -'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
>>> +'git help' [-a|--all [--[no-]verbose]]
>>>  	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
>>> +'git help' [-g|--guides]
>> Shouldn't we also include the [-c|--config] options here in the synopsis,
>> and the help_usage below?
>
> I see this is fixed in 4/5

I updated the config message for the v3 to say it'll be addressed later>

>> Further, shouldn't we mention this (git help -c) on the git config man
>> page, e.g. "A list all available configuration variables can be
>> generated by `git help -c`."=20
>
> Still feel this one would be useful (but may be out of scope of this seri=
es)

We already have such a mention in the documentation, it pre-dates this
series. I.e.:
=20=20=20=20
    -c::
    --config::
            List all available configuration variables. This is a short
            summary of the list in linkgit:git-config[1].
=20=20=20=20
The "short summary" there is quite the understatement, but that wording
was added in , 3ac68a93fd2 (help: add --config to list all available
config, 2018-05-26) so it wasn't some mistake with the option drifting
out of sync with an earlier implementation.

I think what Nguy=E1=BB=85n meant here was "much shorte than 'git help conf=
ig'".
