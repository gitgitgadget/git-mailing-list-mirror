Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155CCC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiKCQDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiKCQCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:02:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8D1D311
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:00:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f5so6508502ejc.5
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sBYY+wSq/xyUEJWMV6M2+EucmrU9v9VEGjOyVTPF5a8=;
        b=WrFLv/vjiikpKBGNb6iBTSlcFHV0TtO6mz3QFqlItdALtPe0dJz2dNfkrSKViDjii6
         PUP32Ctti6zVj/+5Vc880kxnPsisbdm5ykQIyrGxIJWjNFEHrIw2LWL/vJH9b4YsrkSD
         43ZUgQtlk+2DZs4E8R4WcYJfdnYpjjeQqbY1Na8t5nirEzAiOMCOR+y6tPS8EWryx/q4
         O8ZKwgaGbDiaTDWWYbVjGKJGMc09L3tkECbnzayKNqs8pDEHTmz7t95TGcTM0M7kxGAW
         ZVP3IgDq3dL1YTzWD4DxmvbV3amjaIhvoGeFQ3CS83OWe/nt5v593/yrhUNkIY214OqT
         EkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBYY+wSq/xyUEJWMV6M2+EucmrU9v9VEGjOyVTPF5a8=;
        b=K5TX8pByqAgzDeKIS1RB09guCVRRtq5kswFmXC5YLjg9MSNMUr0TQBUruTa5w1F9bT
         w+Scyb40TwWgBNemYdU4NwnIkAj1Qkjmw5+Ljrcl2rofgp02Qfrm/pWfHux5HnY5Ar9V
         afp50O9pXaLu2DAcclvb3Nz97xuqjY7WE6dPv0pnYjrSJOgS4cG5LPli7cBJiZ5hOyCY
         Sf4vfw92IJ6P3Zhq1EOa6yu98I7woyReEpfhs18ZlO1WmBpZpAngmhE5CnCobz1ErZVp
         ocg2PHOkOmTmo8urSLC00nGmspf9IHo5MmZ+aP57ZDkr8cAJ2ZiB6SacNzFO5g4+aso3
         vUyg==
X-Gm-Message-State: ACrzQf1H8w+97NEm+qPK0indePWgf2N3xxCgQVTAeftui7xaTVDgBBqy
        CCum/sgOa4dQA902vBPpx3xGnmhrMFg=
X-Google-Smtp-Source: AMsMyM6/+GqoF13IDnaoDKx5JRdjRUMX/z06nJzLF8UBgQwHlhoG2HmqMRYEZSpYxkzsL7/1Hc1HaQ==
X-Received: by 2002:a17:907:3207:b0:741:3a59:738d with SMTP id xg7-20020a170907320700b007413a59738dmr29444502ejb.110.1667491238679;
        Thu, 03 Nov 2022 09:00:38 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b0078d4e39d87esm619662ejh.225.2022.11.03.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:00:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqcdx-00Cjtk-1s;
        Thu, 03 Nov 2022 17:00:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v3 02/12] cmake: update instructions for portable
 CMakeLists.txt
Date:   Thu, 03 Nov 2022 17:00:15 +0100
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
 <patch-v3-02.12-7a21f4aa24c-20221101T225022Z-avarab@gmail.com>
 <059cf6aa-d288-6584-4d48-90f831de5344@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <059cf6aa-d288-6584-4d48-90f831de5344@dunelm.org.uk>
Message-ID: <221103.865yfw110a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Phillip Wood wrote:

> On 01/11/2022 22:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The instructions for running CMake went back & forth between *nix,
>> Windows and Visual Studio instructions Let's create headings and split
>> the existing instructions up into those new sections.
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   contrib/buildsystems/CMakeLists.txt | 66 +++++++++++++++++++++--------
>>   1 file changed, 48 insertions(+), 18 deletions(-)
>> diff --git a/contrib/buildsystems/CMakeLists.txt
>> b/contrib/buildsystems/CMakeLists.txt
>> index 494da807c53..7bc123da315 100644
>> --- a/contrib/buildsystems/CMakeLists.txt
>> +++ b/contrib/buildsystems/CMakeLists.txt
>> @@ -4,7 +4,48 @@
>>     #[[
>>   -Instructions how to use this in Visual Studio:
>> +=3D=3D Overview =3D=3D
>> +
>> +The top-level Makefile is Git's primary build environment, and a lot
>> +of things are missing (and probably always will be) from this CMake
>> +alternative.
>> +
>> +The primary use-case for maintaining this CMake build recipe is to
>> +have nicer IDE integration on Windows. To get Visual Studio-specific
>> +instructions see "=3D=3D Visual Studio & Windows =3D=3D" below.
>
> If that is the primary use-case (which I agree it is) then it perhaps
> we should but the instructions for that use at the top of the
> document.

Yes, I've tried to re-arrange it like that in the incoming v4.

>> +
>> +=3D=3D Creating a build recipe =3D=3D
>> +
>> +To create the build recipe run:
>> +
>> +    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_B=
UILD_TYPE=3DRelease
>> +
>> +For alternative "-DCMAKE_BUILD_TYPE=3D<type>" flags see instructions
>> +under the "=3D=3D -DCMAKE_BUILD_TYPE=3D<type> =3D=3D" heading below.
>
> Rather than forcing the reader to jump back and forth, perhaps we

*nod*, changing...
