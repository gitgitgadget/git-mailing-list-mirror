Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4733C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 02:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhLUCtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 21:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhLUCtt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 21:49:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287B9C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 18:49:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m21so18940492edc.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 18:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=P0OI2oXIRs4ouE5mJVtNs4CeIvcrMyJMl2bhwCiuySI=;
        b=Wei0Slf7Q33GNYHYkm6IV5IB7zmdi+FGnS0R9Z8Y1lzwK/BkjRzDBGNPRJsc7cGIzP
         ms610F9ZgtRk61T+aWSDegj0uRO3GqhLmWofnK4eVT+XzxYaZeak4ZJNKyjrlEzvAXBV
         o9v4iXIjMCG+qOYlg6AF9UxV5xc9r2YWY2O3EkpKy/o5jJIh+CgG/pFaxEf7y+tsRzMe
         MPhe2+BF6kXcxsLMXoyQJ6fTB9gND9JFayp6cxm/Akd435zfdCigHQt/YD9LOZRs/EEv
         3nCKc2kzNRSo0b+nM2Hysa4MNodb9D/MM0JX4Euc1sFCPkru+IhTcAyixoY85yhvFvET
         3H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=P0OI2oXIRs4ouE5mJVtNs4CeIvcrMyJMl2bhwCiuySI=;
        b=hiROPcAyIHL/4L9TuexexeMLDy2YnXdKNUatv9abOq0/Sr6AjsszjQBiAx1Jul8UMZ
         JG6qoFVhqZnffGh9JnC7Mim4xr2lQWxXYm72j1alJC4IPfs5NQITdHUMqoO7ogc0UkXm
         Wufj9FVsaHA6s+SX9g6hsVe7M8nBJ9VWyc/JrzKttdnj4/PAYBDNbZUL4UjocQXRsAsZ
         SdINCk9E0hz0cNAhkvnp+zbh5NEDARYAsitsL71R2OxVRaKg4v3S6j3chftiIfZ/4FOG
         mGeObYkXrpfjlAYy8tlrxpdZtEefluKW8zYSjaD2L6HIeKQSyXexd57tVuZM6SgcBrVF
         3yfg==
X-Gm-Message-State: AOAM531v452e1XRkt7pFPUxdacc/jHw1VwXlaunvwFsZ+fcC2czqmoiY
        PL+XZXMUnybHkxQdiLPeJoU=
X-Google-Smtp-Source: ABdhPJy32YQ0ifvYksnRPACepYfTfmWp6GZIfbyiAXy1ZiVq0OVTlXDe3sl1cD0VOQwj15Q0gHcbvQ==
X-Received: by 2002:a17:906:7688:: with SMTP id o8mr922742ejm.291.1640054987663;
        Mon, 20 Dec 2021 18:49:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z26sm7077923edr.11.2021.12.20.18.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 18:49:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzVDm-000cix-J6;
        Tue, 21 Dec 2021 03:49:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Date:   Tue, 21 Dec 2021 03:39:36 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
        <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
        <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
        <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
        <xmqq1r27xfi4.fsf@gitster.g>
        <211221.861r26u4b9.gmgdl@evledraar.gmail.com>
        <xmqqr1a6so6c.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr1a6so6c.fsf@gitster.g>
Message-ID: <211221.86o85asmd1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I don't see why we'd consider that as a worthwhile direction to go
>> in. The "git-init" documentation states:
>>=20=20=20=20=20
>>     This command creates an empty Git repository - basically a `.git`
>>     directory with subdirectories for `objects`, `refs/heads`,
>>     `refs/tags`, and template files.=20
>>
>> I.e. we promise to create "objects", but not "objects/{info,pack}", even
>> though we've done so since f49fb35d0d5 (git-init-db: create "pack"
>> subdirectory under objects, 2005-06-27) and d57306c7945 (Create
>> objects/info/ directory in init-db., 2005-08-20).
>
> I view it as a documentation bug, though.
>
> The only thing we need to promise is that (1) the directory prepared
> by "git init" will be recognised as a repository by the current and
> future versions of Git (and hopefully the existing ones, too), and
> (2) versions of Git will not barf due to missing directory and stuff
> due to end-user mischief around custom templates.  I do not think we
> even need refs/heads/ directory and I do not see that, especially
> with a presence with "basically" there, the sentence promises that
> we will always create refs/tags/ directory.  For (1), only objects/,
> refs/ and HEAD is necessary, as long as (2) is satisfied by lazy
> creation of leading paths.

Do you think that we should stop creating objects/{pack,info} then,
provided that the few test failures that assume them are cleand up
(which for at least one of them is much easier than the top-level
"info")?

> We would want to be able to cope with a repository that lost
> .git/info directory due to loss of it in custom templates anyway.
> Just like we create leading missing directories lazily for any
> hierarchy under .git/, we should create .git/info on-demand.
>
> Pre-creating .git/info might be nice, but becomes much less
> important after it happens, and that is why I view it as a much
> lower priority than what Derrick suggested.

Yes, we agree that we should deal with it not being created, that we
don't is a bug in sparse-checkout.

That's still a separate question from whether it's worthwhile investment
of both our and user time to skip creating them and deal with the
resulting churn in the tests and needlessly break code in the wild.

It seems as though you're saying that any fixes or changes in this area
would be incomplete without moving us towards the most pedantic and
minimalist interpretation possible when doing a "git init", is that
right?

I.e. to end up with this .git from "git init --template=3D" (the same as
now plus rmdir .git/{objects,refs}/*):
=20=20=20=20
    $ tree -a -p
    .
    =E2=94=94=E2=94=80=E2=94=80 [drwxr-xr-x]  .git
        =E2=94=9C=E2=94=80=E2=94=80 [-rw-r--r--]  config
        =E2=94=9C=E2=94=80=E2=94=80 [-rw-r--r--]  HEAD
        =E2=94=9C=E2=94=80=E2=94=80 [drwxr-xr-x]  objects
        =E2=94=94=E2=94=80=E2=94=80 [drwxr-xr-x]  refs
=20=20=20=20
    3 directories, 2 files

I can work towards that with these patches, it just seems to me to be
needlessly creating potential issues for little or no benefit.

