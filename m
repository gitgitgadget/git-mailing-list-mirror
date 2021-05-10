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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85605C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414AD6127A
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbhEJMwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 08:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbhEJMXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 08:23:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F6C0611EB
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:17:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s6so18411508edu.10
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=e5AlPAH0IYOSNcLfqk7gPQLc9Lgoywe9mS8y2wA5c3o=;
        b=Z+Pa9g4q61vGQwhYgUB7JsTXjbWaO6vMtlgTKU9u5ikhDCx3pcYwEgTI5aR3uIYwed
         g4U9q2mxsOVeVEv2H4VqI448VEuLPQqD2DpXmQ+gNSQoM6t+x3FlUzOLh5yPy51DEeWh
         hVRhLZE6/DmlXjH4dKqxhBAXyGjLVvgUJUXOrTcW3TsHZsbJwj4oWhSUz1j0B7hkqZhG
         yZWfDc/AnZPHfw79EdtD9x15QeM/ne0b0WEh4gwSfAa1A7MLqUa4t5NuZlwz8cQg9fi5
         vG2SxEGBkiwl3wSpdTgpf1mQOjHY3Se3IByUD3P1nuv4bW4CofFQdaqPYGHqZM6bnUxk
         eH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=e5AlPAH0IYOSNcLfqk7gPQLc9Lgoywe9mS8y2wA5c3o=;
        b=WynrRyO0lnvQf9dfd2IrjBcC59w/oB9xF5CLGEDXL55DYKU9CYfDKPLQZnLq7jTf0t
         mvZ8l049xbhwDgSMitfYGHp6iN7W6ndwFYP/+oPcUwWNVYfSW7IndDmKeNw7BUxKVS9f
         65f2AyH580GWiVaTUP3BHfGF62lXVFoDt/nnkNuShBK0/o0aD6bVWCLjlUvhpackRX59
         Abt0lmsnoYjYr61kVNKXnx8k4TySi49AW0dP+xo2eL1xUDxfCMoZXSvJ5y1iNH6kYIpz
         +mDDjxxLLk3Y7k3IB2m95HesnSi1zo4eZ4bHQCNBWuunuJm2CM8tXvH0mtmUEBMkfc6t
         NBvQ==
X-Gm-Message-State: AOAM532V+owxyLYbUkQoHtKCRQFb6wMqtFjbifSEnHvfQWI4ECmmgNBL
        D39cET40wqK5fdE4LHUVOKFhLOYEC66SyQ==
X-Google-Smtp-Source: ABdhPJybEMfMlbLMhoVE8BZ0taWln7K9KyyonplMkCfLSzKWvcG7mjNchLKKwQ9O1QkHUzaRUKZLiw==
X-Received: by 2002:aa7:cb84:: with SMTP id r4mr28971928edt.187.1620649054129;
        Mon, 10 May 2021 05:17:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z22sm12636106edm.57.2021.05.10.05.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:17:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/8] maintenance: add --schedule option and config
Date:   Mon, 10 May 2021 14:16:12 +0200
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <dae8c04bb5523c9b63c770862a1104a0ff4aa6c4.1602782524.git.gitgitgadget@gmail.com>
 <87blctcp30.fsf@evledraar.gmail.com>
 <1eff631f-b079-d097-b16d-36dc974efea9@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <1eff631f-b079-d097-b16d-36dc974efea9@gmail.com>
Message-ID: <87o8diu6jn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 09 2021, Derrick Stolee wrote:

> On 2/9/2021 9:06 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Oct 15 2020, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> +--schedule::
>>> +	When combined with the `run` subcommand, run maintenance tasks
>>> +	only if certain time conditions are met, as specified by the
>>> +	`maintenance.<task>.schedule` config value for each `<task>`.
>>> +	This config value specifies a number of seconds since the last
>>> +	time that task ran, according to the `maintenance.<task>.lastRun`
>>> +	config value. The tasks that are tested are those provided by
>>> +	the `--task=3D<task>` option(s) or those with
>>> +	`maintenance.<task>.enabled` set to true.
>>=20
>> I see from searching on list and from spying on your repo that patches
>> for this maintenance.<task>.lastRun feature exist, but there's no code
>> for it in git.git.
>>=20
>> So we've got a 2.30.0 release with a mention of that, and it can't work,
>> because it's only in the doc due to b08ff1fee00 (maintenance: add
>> --schedule option and config, 2020-09-11).
>
> Thank you for pointing out this docbug. This is based on an early
> version of the patch series and should have been changed.
>
> Please see this patch which attempts to do a better job. I can
> create a new thread with this submission if we need more edits.
>
> Thanks,
> -Stolee
>
> --- >8 ---
>
> From 46436b06caf65ee824e781603a8108413bb87705 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Tue, 9 Feb 2021 11:51:32 -0500
> Subject: [PATCH] maintenance: properly document --schedule
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The documentation for the '--schedule' option is incorrect and based on
> an early version of the background maintenance feature. Update the
> documentation to describe the actual use of the option.
>
> The most important thing is that Git takes this option as a hint for
> which tasks it should run. Users should not run this command arbitrarily
> and expect that Git will enforce some timing restrictions.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-maintenance.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-mainte=
nance.txt
> index 6fec1eb8dc2..d4b5aea6760 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -155,15 +155,15 @@ OPTIONS
>  	exceeds the `gc.autoPackLimit` config setting. Not compatible with
>  	the `--schedule` option.
>=20=20
> ---schedule::
> +--schedule=3D<frequency>::
>  	When combined with the `run` subcommand, run maintenance tasks
> -	only if certain time conditions are met, as specified by the
> -	`maintenance.<task>.schedule` config value for each `<task>`.
> -	This config value specifies a number of seconds since the last
> -	time that task ran, according to the `maintenance.<task>.lastRun`
> -	config value. The tasks that are tested are those provided by
> -	the `--task=3D<task>` option(s) or those with
> -	`maintenance.<task>.enabled` set to true.
> +	whose `maintenance.<task>.schedule` config value is equal to
> +	`<frequency>`. There is no timing restriction imposed by this
> +	option, but instead is used to inform the Git process which
> +	frequency to use. The command scheduler created by
> +	`git maintenance start` runs this command with `<frequency>`
> +	equal to `hourly`, `daily`, and `weekly` at the appropriate
> +	intervals.
>=20=20
>  --quiet::
>  	Do not report progress or other information over `stderr`.

+ CC Junio

Late reply, I was reminded of this again. This patch looks good to me,
but I see it never got picked up, and our docs still mention an
unsupported "lastRun". Junio: I think it makes sense to just pick this
up...
