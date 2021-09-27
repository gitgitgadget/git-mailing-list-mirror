Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E0FC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1986113A
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhI0Aby (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhI0Abx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:31:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E2C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:30:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v18so26700752edc.11
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BHLsAsoHTg40bNt/NIbLChe39beNLwX4PEyM721coXk=;
        b=fQEQc75rCJu3fV3Laksvtb4PaMCXsUNROo0qDwHqPqY0ft/+Cju9+tkDkmbiCjhC2W
         sjKptqYr1IiF7AqXIFY17ubGQcuJusCm3hi8OV2rV44Iu11Yi76zeYE0Ty7fsIESabBR
         WOgBYCBhNNHjyRMr9fMwJpv8YKXEj66PpYZqGK2n7W3YTecloB/iKAThP8Vtyjx3IUsj
         IZWoXRemq/NqfRUB3sGyQyDX0R2eGsGwz9yNcydAe4BouizM78LcGXJTHbcoJuagkpWm
         NhLqQZNRtLMvGc/inNskSw3vJAODwxptMe3plWHCEaMxr8LJ9HC2pcgQnPI80UGoM4Bd
         Amfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BHLsAsoHTg40bNt/NIbLChe39beNLwX4PEyM721coXk=;
        b=e8gLGoD8E17FrhTRZ3V+qoMLDNwfnbLjHzR+fhME7YED3+/8gQHF3RQq86BLMSKBFA
         TQiRV2SXam44RygOOec0aXFYsqSRXjyD1+UsJ5cqlTl+3R6b6MmSBwqVaqUCJOrPXSiG
         PmFZcaEp8wTD8BOXxUWTwRHKE2nZLLuOsZ5kuCoWpdonDaFU3HHhz4QO2IZe4wXjCl+x
         sIo5qJ/q1i3vyowrxjKvwSe++fcpiioaf6UUQCoFIPIZojkcfH17+8FU2kyn6zSXswUL
         vKgFVVJijqGhlANvrI+2AjnxNTDjb+UbLQYf5X/Ik4Zt72FnZDFeXOcgsMasZffLsHVR
         YlUg==
X-Gm-Message-State: AOAM531Orp43SLSSjpGrB+3dkGVWAV/7BgOUpX1mgfKZR8N44OYYlzL/
        FJ8fV5UvN/KlT1R4OMgJaT0=
X-Google-Smtp-Source: ABdhPJykxeKEuhT4Z3b9jvHrKw1qObkJebBSQdDctXp2NN3F28lzJEpA/p0mLJCBdClYJFHqr/rjjQ==
X-Received: by 2002:a17:906:686:: with SMTP id u6mr23654222ejb.569.1632702614530;
        Sun, 26 Sep 2021 17:30:14 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k21sm7626724ejj.55.2021.09.26.17.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:30:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Joseph Jenne <joseph.jenne15@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: BUG: git log dies to SIGPIPE
Date:   Mon, 27 Sep 2021 02:29:32 +0200
References: <CAB5AetcMK6=yZh4OY-0A6x6vs7X+0_1APfp4cCP_MSK_TO46ow@mail.gmail.com>
 <CAOLTT8QqF-4rRiuWwntA3TfauCfc-MKingPQmyuKw3r5zf7O3A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAOLTT8QqF-4rRiuWwntA3TfauCfc-MKingPQmyuKw3r5zf7O3A@mail.gmail.com>
Message-ID: <87y27i273e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 26 2021, ZheNing Hu wrote:

> Joseph Jenne <joseph.jenne15@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:47=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> used `git log`, exiting the viewer (`less`) before reading the entire
>> commit history of the project
>> What did you expect to happen? (Expected behavior)
>> normal exit with status code 0
>> What happened instead? (Actual behavior)
>> git log dies to SIGPIPE after `less` exits
>> What's different between what you expected and what actually happened?
>> git does not exit normally as would be expected
>> Anything else you want to add:
>>
>>
>>
>> [System Info]
>> git version:
>> git version 2.30.2
>> cpu: x86_64
>> no commit associated with this build
>> sizeof-long: 8
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> uname: Linux 5.10.0-8-amd64 #1 SMP Debian 5.10.46-2 (2021-07-20) x86_64
>> compiler info: gnuc: 10.2
>> libc info: glibc: 2.31
>> $SHELL (typically, interactive shell): /bin/zsh
>
> I may be a little unresponsive, I also saw this bug today, and there
> is no such bug
> in a small repository, it only appears in a large repository.
>
> I now know that it comes from outside git, this is really bad.

Please see the discussion starting at
https://lore.kernel.org/git/YAG%2FvzctP4JwSp5x@zira.vinc17.org/ about
whether this is even considered a bug, but in any case the causes are
well understood.
