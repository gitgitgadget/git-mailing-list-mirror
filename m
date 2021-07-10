Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E5C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 12:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB16D61289
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 12:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhGJMHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 08:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhGJMHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 08:07:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0555C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 05:04:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11so7221995pji.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=nrVCHvwI3FxNy2K2ZlBVq/3PteItxKz33ycG3Mai1Qs=;
        b=BHaW39QgD2i65nV8D1IkqQZ+nm/JupzKdbbE4icPiYEZHqFaNbsRLQZbhPtA9sFMDE
         bvETDIOuLDillvY2qACVBaEZVHh7GHmzTb0DqFv7No1rTmrbI4szmLQ4LPGioARuf99X
         ginExTX9+t2uUXEl5Ca4+4gV0bS6kCz3wnRU/BtDJKV3AXJpAGf3nBLp1hFGqCLXSr4e
         qjWvDB3FddPpCYGZwqMB4u8oHKWay6SGhZqaIUifi+rwVP0kr9WTSQ0pvsPPj9Mj6R1T
         zAMidjsCNxrjn5w7Snfsota8MnTVDw7QFa//AuvZv6E25YqjS91pGN8rj/f5FHdt/QzN
         u4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=nrVCHvwI3FxNy2K2ZlBVq/3PteItxKz33ycG3Mai1Qs=;
        b=URbQZg7hBwWr4GeaD5kL1lllmdmvOQV1TSKdw+wcW6gHVOYloROJzp0gmD5So0Lt+N
         FsCJhXVMshKJVrbPtd7T6JuQBoWdwRMi+E0em3SAmvqwv2HIwB9ETX0tbKJASbX7CnN3
         prG3v3Wmi3kvrA4HAyQv3BHGltIHAjkXktZv58GKl5XoI6noMmmNGJzCSNwRVDsqalHj
         ZXcI0TZJojqDgkAdcvnQbKFu4mjZcYmiWo/GXyDhIoui/GoNSnkAeSPIgCtWpt++uX7q
         LxS6MBR8pJy10Ap2gU850BcVIPHMf+AujZx9HnozpiNqNjySZ7uT3WJgZpLfoJ+lVfxq
         Uvbg==
X-Gm-Message-State: AOAM530OZBxERqt9d13q9d7xZ8e8LK25IsWZfL35ZUfBrY4T0mmPVV5h
        S2Wgl42+c8mZX2s4NvkvIS4=
X-Google-Smtp-Source: ABdhPJzqXgmF/eV0CMVHjXt69AwPvRVESjRPhS28RrVmgT6Qt5ONnHMggj3BEnAXZHuCzg/Uy8ggbA==
X-Received: by 2002:a17:90b:10a:: with SMTP id p10mr49584pjz.189.1625918673256;
        Sat, 10 Jul 2021 05:04:33 -0700 (PDT)
Received: from [100.65.177.123] ([106.195.40.123])
        by smtp.gmail.com with ESMTPSA id l12sm9406597pff.105.2021.07.10.05.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 05:04:33 -0700 (PDT)
Date:   Sat, 10 Jul 2021 17:34:30 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <598E78EB-48B1-4C2E-BD89-90EF003A15F6@gmail.com>
References: <20210706181936.34087-1-raykar.ath@gmail.com> <20210708095533.26226-1-raykar.ath@gmail.com> <20210708095533.26226-3-raykar.ath@gmail.com> <YOhirWqj7ajsqlYw@danh.dev> <598E78EB-48B1-4C2E-BD89-90EF003A15F6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GSoC] [PATCH v2 2/4] submodule: prefix die messages with 'fatal'
To:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
CC:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <ED07F10B-BE44-4BCC-873A-73688683CCF4@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,


On 10 =E0=AE=9C=E0=AF=82=E0=AE=B2=E0=AF=88, 2021 =E0=AE=AA=E0=AE=BF=E0=AE=
=B1=E0=AF=8D=E0=AE=AA=E0=AE=95=E0=AE=B2=E0=AF=8D 1:22:16 IST, Atharva Rayka=
r <raykar=2Eath@gmail=2Ecom> wrote:
>
>
>> On 09-Jul-2021, at 20:22, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail=2Ecom>
>wrote:
>>=20
>> On 2021-07-08 15:25:31+0530, Atharva Raykar <raykar=2Eath@gmail=2Ecom>
>wrote:
>>> The standard `die()` function that is used in C code prefixes all
>the
>>> messages passed to it with 'fatal: '=2E This does not happen with the
>>> `die` used in 'git-submodule=2Esh'=2E
>>>=20
>>> Let's prefix each of the shell die messages with 'fatal: ' so that
>when
>>> they are converted to C code, the error messages stay the same as
>before
>>> the conversion=2E
>>=20
>> That sounds good=2E
>>=20
>>> --- a/git-submodule=2Esh
>>> +++ b/git-submodule=2Esh
>>> @@ -147,7 +147,7 @@ cmd_add()
>>>=20
>>> 	if ! git submodule--helper config --check-writeable >/dev/null 2>&1
>>> 	then
>>> -		 die "$(eval_gettext "please make sure that the =2Egitmodules file
>is in the working tree")"
>>> +		 die "$(eval_gettext "fatal: please make sure that the
>=2Egitmodules file is in the working tree")"
>>=20
>> Except that, "fatal: " isn't subjected to translation=2E And this will
>> create new translatable item for translator=2E Perhaps:
>>=20
>> -		 die "$(eval_gettext "please make sure that the =2Egitmodules file
>is in the working tree")"
>> +		 die "fatal: $(eval_gettext "please make sure that the =2Egitmodules
>file is in the working tree")"
>
>Okay, I have made the change=2E I was wondering if there any specific
>reason as to why 'fatal' should not be translated? Is it because
>an intermediate change like this should not create more work for
>translators?=20

Yes=2E That's likely the intention=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
