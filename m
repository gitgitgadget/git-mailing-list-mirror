Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C8BC433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiBZVGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 16:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiBZVGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 16:06:14 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB9D1EC987
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 13:05:39 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id q10so5713172qtw.4
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KapQdmCmq3uzCc2VMwHwk9mXCO+KOzTu6QD/A0JttI0=;
        b=iKIIDsZiMyMwLQEq8MPenyZ87I1U1ENvjbV1hHxzs/A8gDFW9BpbuRrr7kR+18x+9P
         Kyz4bx3vnLCJii5sPiuoRV8E9r9bIFmHaCHQATaOoZ5t0wmXQyNmsrZOV/YGdP23v6cf
         HYXMzKGqwOD65i5ikUyT22XLiNChnCYE8ajyh6bQ5B9mFXRasbkAvJj25l0NZ/M95/ml
         VtrAp4d6Ls9bwsZvOhrfDJ6J1FPuOcE3tXYOgujRGUET4EM8tfV9JX299q637VhRiwLH
         3pn74/Y6jAIDHk2i9qiD9obHWEBUsHoQLmqFaXfs/QjhAlk2qCI6dJOdHD+lWxQhch0G
         nDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KapQdmCmq3uzCc2VMwHwk9mXCO+KOzTu6QD/A0JttI0=;
        b=lQBBRwrTOL3eNHs+7EKFQF7W67uibskJtxAad7Z+UW/S0WYwU8EjemyFnGI01q0x+C
         VYQk4jIqsMboZKQplaYLE8PQRtDiylFeQr/j8gc+CGQsxBQIpyLj9c/Jfd1Oorxu3bNQ
         vXxKAOUZwTXJMd/y4ybuY6odm3m7kucF6GGl3reIC/ShehXg2Cv9O3cwPLwGcwB5x9/9
         Psv3cKF9ym6xcMWqCCBuHzT8OpDwRMR3FCBSYWY951svGB2equcHa8IcjKsvRbjZFie9
         7TcCN8Ud19LxRkD84OQd8t+HfnMtFAQyptK4njG44Zc3U20cRu5HiMg8KE66wlk5nONb
         xI8g==
X-Gm-Message-State: AOAM532MtnDRd2ASL182M+Wsp0l+Tse2oKSRRN1Mh2dJTOQNuJ0ddjST
        vGO+ilrPiA2JwB1elXTHbrs=
X-Google-Smtp-Source: ABdhPJyUhrUMNaq5iaiuRNLwhCgVIOdoYQb/FQ1sPodnUvTb1F4BSrkUkup4370PXe8G45Y3XxWM+A==
X-Received: by 2002:a05:622a:4f:b0:2de:377e:2fac with SMTP id y15-20020a05622a004f00b002de377e2facmr11376732qtw.496.1645909538646;
        Sat, 26 Feb 2022 13:05:38 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id e9-20020ac85989000000b002de2bfc8f94sm3842989qte.88.2022.02.26.13.05.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Feb 2022 13:05:38 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Date:   Sat, 26 Feb 2022 16:05:37 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <5106811D-2937-49CB-AC93-875D3B3BC241@gmail.com>
In-Reply-To: <YhqNy+t5SARNivQ5@nand.local>
References: <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
 <xmqqv8x5v0qc.fsf@gitster.g> <36CA51FE-8B7F-4D08-A91D-95D8F76606C9@gmail.com>
 <YhpjbQeFaMNVnyP9@nand.local>
 <47AC2D8D-ADB2-4280-86F0-6B1E239C1EBE@gmail.com>
 <YhqNy+t5SARNivQ5@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 26 Feb 2022, at 15:30, Taylor Blau wrote:

> On Sat, Feb 26, 2022 at 03:19:11PM -0500, John Cai wrote:
>> Thanks for bringing this up again. I meant to write back regarding wha=
t you raised
>> in the other part of this thread. I think this is a valid concern. To =
attain the
>> goal of offloading certain blobs onto another server(B) and saving spa=
ce on a git
>> server(A), then there will essentially be two steps. One to upload obj=
ects to (B),
>> and one to remove objects from (A). As you said, these two need to be =
the inverse of each
>> other or else you might end up with missing objects.
>
> Do you mean that you want to offload objects both from a local clone of=

> some repository, _and_ the original remote it was cloned from?

yes, exactly. The "another server" would be something like an http server=
, OR another remote
which hosts a subset of the objects (let's say the large blobs).
>
> I don't understand what the role of "another server" is here. If this
> proposal was about making it easy to remove objects from a local copy o=
f
> a repository based on a filter provided that there was a Git server
> elsewhere that could act as a promisor remote, than that makes sense to=

> me.
>
> But I think I'm not quite understanding the rest of what you're
> suggesting.

Sorry for the lack of clarity here. The goal is to make it easy for a rem=
ote to offload a subset
of its objects to __another__ remote (either a Git server or an http serv=
er through a remote helper).
>
>>> My other concern was around what guarantees we currently provide for =
a
>>> promisor remote. My understanding is that we expect an object which w=
as
>>> received from the promisor remote to always be fetch-able later on. I=
f
>>> that's the case, then I don't mind the idea of refiltering a reposito=
ry,
>>> provided that you only need to specify a filter once.
>>
>> Could you clarify what you mean by re-filtering a repository? By that =
I assumed
>> it meant specifying a filter eg: 100mb, and then narrowing it by speci=
fying a
>> 50mb filter.
>
> I meant: applying a filter to a local clone (either where there wasn't =
a
> filter before, or a filter which matched more objects) and then removin=
g
> objects that don't match the filter.
>
> But your response makes me think of another potential issue. What
> happens if I do the following:
>
>     $ git repack -ad --filter=3Dblob:limit=3D100k
>     $ git repack -ad --filter=3Dblob:limit=3D200k
>
> What should the second invocation do? I would expect that it needs to d=
o
> a fetch from the promisor remote to recover any blobs between (100, 200=
]
> KB in size, since they would be gone after the first repack.
>
> This is a problem not just with two consecutive `git repack --filter`s,=

> I think, since you could cook up the same situation with:
>
>     $ git clone --filter=3Dblob:limit=3D100k git@github.com:git
>     $ git -C git repack -ad --filter=3Dblob:limit=3D200k
>
> I don't think the existing patches handle this situation, so I'm curiou=
s
> whether it's something you have considered or not before.

I have not-will have to think through this case, but this sound similar t=
o
what [1] is about.
is about.

>
> (Unrelated to the above, but please feel free to trim any quoted parts
> of emails when responding if they get overly long.)
>
> Thanks,
> Taylor

Thanks
John

1. https://lore.kernel.org/git/pull.1138.v2.git.1645719218.gitgitgadget@g=
mail.com/
