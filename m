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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA7AC433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C740619ED
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 00:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhCXAra (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 20:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhCXAqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 20:46:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D248AC061765
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:46:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y6so25665406eds.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=E/n/ewxzdCxu56ymvENDk5lnY85TyD7JDkmPTAN2TyI=;
        b=bsQ/nNRcKyRh+DM9hKFKNupaGzrMsQZNaYpvGzIN1x1REdqzlZADaKOjP1RWs8sKM1
         aVfX1kC2BJbgu1l11b/0SW0puvbyeuxgEgaf0waGdX7ns4L6r4FlerBPujSUfT1Tsfjp
         f3lUiso3mBqOjxMQyhgWB7qEXUWtbAnOj3M24KmU+TVoLJQWWvFAxz8Twjt0trCR3zhO
         dX8eKZa7Yzm+mAvcFqvBO1DN52YfdbnWZ6DxlNA8nROje2duFVPG6q/h5+ewsSSgKW0b
         FW2dE+sa8+Dq65stT1KqtxGsdVTfEA9lIhkobR1lkp8tQMQ3F81k5kcad5leFOijSoCu
         Yv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=E/n/ewxzdCxu56ymvENDk5lnY85TyD7JDkmPTAN2TyI=;
        b=JA8UQUtXSrhzD12UPfPiFK7pyMvox09n5jiu7FKw0ssWoyHzkbzsud/YK0hCNAKlhJ
         EcarDl42zIPpiQZr1T4WjWDbaXAGogHn7tskoCezd9JTp5bfH7j2Y38g41BX1NWMazFl
         cDD58tc9g2pdWckOSYwTt+9LBAWI0sANhAwlhYnNp8AzoItl9Y6TXfx46I0xNF2/TdxL
         tSjvv6+jXbqex+OEYvHQC5RSR/Le/tz/Q3kZ5IClwK+vsh2znVABtjGAa5iWppdPhuWq
         FlxZA9vbEoZYbCfaMrdic/oDLx3nkfbxNrrdwCsWQSkBDRoH42ruF/sqreRvh5ZH0BQh
         aUVw==
X-Gm-Message-State: AOAM530GeKNztl3pX7aG0DtYnxOD1U/SqHqAx5sOsrXbooJe1L5ZGyu6
        yK9g9kk9Kd/ksC+fVdiXYECGj0BMhCB5Lg==
X-Google-Smtp-Source: ABdhPJyiQfVON24jeFsU1caaFqkPoFoiWZr11JohD5aQo7zsfQYi/VpZkUvhfgNAGJ0bIs/OWlaELg==
X-Received: by 2002:a05:6402:1004:: with SMTP id c4mr576725edu.364.1616546799867;
        Tue, 23 Mar 2021 17:46:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a17sm163468ejf.20.2021.03.23.17.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 17:46:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC/PATCH 2/5] ls-files: make "mode" in show_ce() loop a variable
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-3-avarab@gmail.com>
 <CABPp-BFA+6--PkJfVfERF-ak9NGd6J0=Jhzro1nqqJ+X-LH3xg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CABPp-BFA+6--PkJfVfERF-ak9NGd6J0=Jhzro1nqqJ+X-LH3xg@mail.gmail.com>
Date:   Wed, 24 Mar 2021 01:46:38 +0100
Message-ID: <87wntxpedt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Elijah Newren wrote:

> On Wed, Mar 17, 2021 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> In a subsequent commit I'll optionally change the mode in a new sparse
>> mode, let's do this first to make that change smaller.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/ls-files.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index eb72d16493..4db75351f2 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -242,9 +242,17 @@ static void show_ce(struct repository *repo, struct=
 dir_struct *dir,
>>                 if (!show_stage) {
>>                         fputs(tag, stdout);
>>                 } else {
>> +                       unsigned int mode =3D ce->ce_mode;
>> +                       if (show_sparse && S_ISSPARSEDIR(mode))
>> +                               /*
>> +                                * We could just do & 0177777 all the
>> +                                * time, just make it clear this is
>> +                                * for --stage-sparse.
>> +                                */
>> +                               mode &=3D 0177777;
>
> I could kind of see referencing the magic constant 0177777 in a test-*
> source file, but it really needs an explanation when showing up in
> actual git source code.  At least reference something about how
> cache.h mentions these are the mode bits, or better yet #define this
> constant somewhere in cache.h with an explanation.
>
> Also, what is --stage-sparse?

A relic from a WIP version of this patch. I ended up just calling it
--sparse in 3/5.

>>                         printf("%s%06o %s %d\t",
>>                                tag,
>> -                              ce->ce_mode,
>> +                              mode,
>>                                find_unique_abbrev(&ce->oid, abbrev),
>>                                ce_stage(ce));
>>                 }
>> --
>> 2.31.0.260.g719c683c1d

