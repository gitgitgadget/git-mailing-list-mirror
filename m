Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24FC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446106AbiDVJkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiDVJko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:40:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32E33882
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:37:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id s18so15350257ejr.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZVvemxFQ3FTgntKDkaQYyJOzS5kbajW2+WOZURcz2FI=;
        b=L91QU8jmYsynP80BXbxBxHLXJxmkhiVul5Yld1V2HgUZq5flFEtGxvrPVT1rV70sf2
         53Tm7/ZqcExXnJC52rD90M24SPM2k8CEDuK9LSyd57yGbXj/oGAA3Xu5gSZTOwL25V0t
         PGMqqltencV6Xg6Bt6vwphAQ+ztuR2al0Vam6Tzj7ZL9zvlC3wQWCpKyNcZQFKOsNnbq
         M9mhDpdtGVUQh9xn+rzvgswXZpDI/lKm+JZByY8wEku5sAZCBTA7fwTZRXU89xC3UhVD
         A88eO+3ogE6N08dvA7xKsd/sNbZIkRvCmv8EZVbZMSr55+ADxlaOxrSfvsJuNfJMxa3K
         8C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZVvemxFQ3FTgntKDkaQYyJOzS5kbajW2+WOZURcz2FI=;
        b=neoVr2Yh0dK6Jarx+jVgYjqYmeY4sepQjgrBNb7mS7GSix7EJqZOqW50OJM8g7Q3CS
         8/8TTObCju80XP8g/MI3je0YslT2ia1zxzZ5FpYcyj6ihv3PAV+61o84igMD2sSb2xSH
         OJTZYa3HEFYcvvbZGIZORP+jMfW6peeOQll3cSpCq2jdT0OMAmIRtiBsQQ8iFqlUAYFr
         6514wICoro+pH6XioZHICYGFfG33tl2za8fcfDQWXPywLUCASJ9UcbtwOV1gNI4xNFeC
         g52YRLVCS9Z0UxlO+KCZxrnBbBKsXnWLdYaB3uZOLxZnq5UDhBpjy4tI+XN4dQBoanMa
         3G7Q==
X-Gm-Message-State: AOAM532QcuJ+PzZc3HLKKJRPuGVEmMY6erkiLOaMY8erMlsnhOU58JMC
        niom7Wb7BUvnJlO/1oZL5/8=
X-Google-Smtp-Source: ABdhPJxzsxt2+etdF3gx45oMmAaURjUq5oBluKtyfH6cjG4GStG4BXWGPuaKiNLA/PpU9xjpbSmAuQ==
X-Received: by 2002:a17:907:2daa:b0:6da:924e:955 with SMTP id gt42-20020a1709072daa00b006da924e0955mr3307411ejc.1.1650620270425;
        Fri, 22 Apr 2022 02:37:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906938f00b006e8afb5a7d9sm565880ejx.33.2022.04.22.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:37:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhpjZ-008dxO-5P;
        Fri, 22 Apr 2022 11:37:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [RFC PATCH v2 00/36] bundle-uri: a "dumb CDN" for git + TOC format
Date:   Fri, 22 Apr 2022 11:37:10 +0200
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
 <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
 <dd9836e8-bfc9-9a52-199a-3ffce26101f8@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <dd9836e8-bfc9-9a52-199a-3ffce26101f8@github.com>
Message-ID: <220422.864k2l5uhe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Derrick Stolee wrote:

> On 4/18/2022 1:23 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This RFC series is a start at trying to combine the two differing RFC
>> versions of bundle URIs I [1] and Derrick Stolee [2] were kicking
>> around.
>>=20
>> =3D Layout
>>=20
>> This series arranged in the following way:
>>=20
>> * 01-08: "Prep" patches from both [1] and [2] which in principle could
>>   graduate first to "master".
>>=20
>>   I.e. they're prep fixes added for the two bundle-uri
>>   implementations, but which either justify themselves, or e.g. expose
>>   a now-static function via an API.
>>=20
>>   I tried to move things into the "justify themselves" category
>>   whenever possible, but may have overdone it e.g. for 02/36
>>   (originally an idea/commit of Derrick's, but I changed the
>>   authorship as pretty much all of it at this point is something I
>>   changed).
>>=20
>>   For the "prep" changes that are only needed for later changes in the
>>   series perhaps we should just squash them if they're small enough.
>
> I focused today on reading these first 8 patches with the intention that
> they can be submitted for full review and merging on their own. I think
> they don't fully succeed in justifying themselves (since not all public
> methods have callers) but it would be best to have these refactors
> settled before getting into the nitty gritty of the bundle URI feature.
>
> I mostly had a few nits here and there. I noticed that you did not always
> add your sign-off after mine, so please correct that when you send the
> next version (assuming you are planning to do so).

Willdo, sorry.

FWIW the ones with missing sign-off are also those I didn't modify
(extensively), so while I should fix it it might help as a marker for
stuff I changed right now...
