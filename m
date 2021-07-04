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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C541EC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B9261474
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGDIzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDIzT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 04:55:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2011C061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 01:52:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb6so7480073ejc.5
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ONmBP0UrMXAlDROfQFnWu3MgvH5c901ZrkCDhrqC+aI=;
        b=kXowX2+9MpqdfWMuQSj1+UicUQozGVrNpcPJexFzJupe70/iEuPNx9bUTs5C6Q9vq8
         zLmmE+6HbnrOto/KG7zXF8BG1ScUSft/8di3Zg0/ezhLA65GqTHAnOBF0/4hgbG14IaZ
         H3+aO2OLURzO5mAe6fNIXKmzQpHsWlv03ciGdqCHUB/x7TRMrgtvS7txm4hrTqt+iHmK
         t4oU9TXQuoN8nlxQEZd8A8ZsCjkDM0DGlRuEtpzHzoNlJr0z3VxCkV5maHiUqIguu4F2
         8N075RQEAKsyUfTSRZeF2gJcwvuUUeydDKfL1xKwudgHlR6Ug3o9O4ILo45TRch/XjYs
         0iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ONmBP0UrMXAlDROfQFnWu3MgvH5c901ZrkCDhrqC+aI=;
        b=UbNTOsasz0dnQUDyc5IowCG3/evxHdDcF6do0ac9bVl7EwnJoKJMsCf2NoZ1bfyK63
         kbxobGGBh/4ZzrlcGlyJZ4uzEJZFLfp3U/v+hz3g19ebLDvolax9CmWuur667jkr11j3
         YeAz9HLX2jp2CMY+ub3+s8k6zI+YCb6subY9ofG9Nhh2oGs1ffgropdIw1yFUKq7qGtk
         ZLPPD4HdvejUVAni+GVKHvVhoZ8VZbM/DYfRnAcKhr+we7ejnLjAxJb2CKsD5eJH5449
         5PKDflL2swge1l0PTwvwFIBzaY8V+sd6QV1XdtCQPML6GSkfJw1uC0AUvlrz4wINYflY
         uMGg==
X-Gm-Message-State: AOAM530YBVSVjDTVMp5ZlaCL3pr6sW+bY+iYV+TeEbUcFknplDcqH+l2
        qwH9Z+skbzfTQ90tu0/Y/WQ=
X-Google-Smtp-Source: ABdhPJwPBz2eWaJLn9Ia6XSBPxJLTTZy3LTNpnW+mt0STxrPGXPq6FJwEnN/lvZhb2xpCPbl9nparA==
X-Received: by 2002:a17:907:1c95:: with SMTP id nb21mr756829ejc.163.1625388763165;
        Sun, 04 Jul 2021 01:52:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r23sm3650560edv.26.2021.07.04.01.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 01:52:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH 5/6] ci(vs-build): build with NO_GETTEXT
Date:   Sun, 04 Jul 2021 10:52:08 +0200
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
 <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com>
 <87bl7i8ou8.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87bl7i8ou8.fsf@evledraar.gmail.com>
Message-ID: <875yxq8nqd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 04 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jun 23 2021, Dennis Ameling via GitGitGadget wrote:
>
>> From: Dennis Ameling <dennis@dennisameling.com>
>>
>> We already build Git for Windows with `NO_GETTEXT` when compiling with
>> GCC. Let's do the same with Visual C, too.
>>
>> Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  .github/workflows/main.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index 0f7516c9ef..3b40c677ab 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -159,7 +159,7 @@ jobs:
>>        shell: bash
>>        run: |
>>          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=3D`pwd`/c=
ompat/vcbuild/vcpkg/installed/x64-windows \
>> -        -DMSGFMT_EXE=3DC:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DP=
ERL_TESTS=3DOFF -DPYTHON_TESTS=3DOFF -DCURL_NO_CURL_CMAKE=3DON
>> +        -DNO_GETTEXT=3DYesPlease -DPERL_TESTS=3DOFF -DPYTHON_TESTS=3DOF=
F -DCURL_NO_CURL_CMAKE=3DON
>>      - name: MSBuild
>>        run: msbuild git.sln -property:Configuration=3DRelease -property:=
Platform=3Dx64 -maxCpuCount:4 -property:PlatformToolset=3Dv142
>>      - name: bundle artifact tar
>
> To a first approximation isn't the point of CI to test a diversity of
> setups? So "we already do X in job A, let's do it X in job B" seems like
> the opposite of a self-justifying rationale, surely our default approach
> would be to do things differently?
>
> Perhaps this change makes sense, just commenting on the explanation in
> the commit message. I think it should cover:
>
>  * Why: Is it being done for speed, hard to install libintl or whatever?
>
>  * Coverage: Before we tested on this platform with this knob, do we
>    have another CI job that covers what we'll lose in coverage here, if
>    not is it OK because it's tested in some other way etc?

Aside: I should have replied to the v2[1] version of this, but the same
comment applies to it. Sorry about the confusion.

1. http://lore.kernel.org/git/8bab4c17b8a6d7a3ed66e5d9e3eb8f598b35b874.1625=
347592.git.gitgitgadget@gmail.com
