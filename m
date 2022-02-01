Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EB0C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbiBAOaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiBAOai (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:30:38 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34062C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:30:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m4so54914182ejb.9
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+7BeIkwSsmP2HuH5qnyPxlWyALSsElicjy9hfDx1LpU=;
        b=kgaaowtH8m5pc3cm/qlYuaTyEaMAVtr00JnXfaCWUwTRjkAdlc4V0QOovAwACUXYY4
         uRm6yWgStqWEGusNKHEjaFxra8IHxJacYM5B7zoiYFKRr3rhwfwqnD80WK8wv+z1ZYam
         u/9fqleisCsjOnFzmSaZeCiYR4IeN3/AYkBSo62haaKYRM27btrsME5C0AnrH3U00dJe
         hpV37IR8fnwXUjmW1zqASDEhMdyUu0jf3dSthgankTc7XYWVIyiG1MuZ8zxJpJUXIw+W
         5zRF9NylA7JOaQeHSYyjFQ0CpAhwZoroUgEIpmImvPe9nxFRp2ZHJUYmb2QxrkeE9PpW
         oosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+7BeIkwSsmP2HuH5qnyPxlWyALSsElicjy9hfDx1LpU=;
        b=5Ezhh/inqgKKSSiC+JyK3vo0ZAnBSozkZJ4o57fWul2u6KD6ElaMBKwtBPzpo9houL
         rLdSWwoIIj+pK8C9ip44aPSaG+65kaGyriqCwpjeQPl/cZVJjxusUCXf7mUv98JSl1tO
         c/kicnrrn8RtHgSs6LUDuAUPW4PT5HzxG2d4pB5pPWmFRHGZXgFhzwo+MU5m9MMf/nn+
         VU1/xwf9CySBOfNoLOSTZo1YihA99ABzMpRXaikMnnURyOuoJ3xkKXGn3a2pj4k26DKR
         FURc0HwTacr4hI61RbEyjyLWfqgHInGisxHQKhhLxlSIUSG6qj3YiuVV4jDGZkKI6Zba
         KAew==
X-Gm-Message-State: AOAM531uOrPEv2GQYvxG8VRgo4iZ/EhwYsMf7zTqHkhE9TToaNcRhTR9
        BuwiObokowhlofL8srU/fmI=
X-Google-Smtp-Source: ABdhPJw/Svyt9ZS7WtzW5TCQf4DyaCCNqnEH7AX/8ZXfwAQYKIlbdqnjQbgSBRWrli+FvEbXoykuFg==
X-Received: by 2002:a17:906:7948:: with SMTP id l8mr20857149ejo.636.1643725836557;
        Tue, 01 Feb 2022 06:30:36 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id rv28sm14244096ejb.71.2022.02.01.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:30:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nEuB0-004DJ9-IX;
        Tue, 01 Feb 2022 15:30:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: C99 %z (was: [PATCH v7 2/5] object-file API: add a
 format_object_header() function)
Date:   Tue, 01 Feb 2022 15:28:30 +0100
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-3-chiyutianyi@gmail.com>
 <b2dee243-1a38-531e-02b1-ffd66c465fa5@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b2dee243-1a38-531e-02b1-ffd66c465fa5@web.de>
Message-ID: <220201.86mtjaacc5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Ren=C3=A9 Scharfe wrote:

> Am 21.12.21 um 12:51 schrieb Han Xin:
>> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> [...]
>>  		the_hash_algo->init_fn(&c);
>>  		the_hash_algo->update_fn(&c, hdr, hdrlen);
>>  	} else
>> diff --git a/bulk-checkin.c b/bulk-checkin.c
>> index 8785b2ac80..1733a1de4f 100644
>> --- a/bulk-checkin.c
>> +++ b/bulk-checkin.c
>> @@ -220,8 +220,8 @@ static int deflate_to_pack(struct bulk_checkin_state=
 *state,
>>  	if (seekback =3D=3D (off_t) -1)
>>  		return error("cannot find the current offset");
>>
>> -	header_len =3D xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
>> -			       type_name(type), (uintmax_t)size) + 1;
>> +	header_len =3D format_object_header((char *)obuf, sizeof(obuf),
>> +					 type, (uintmax_t)size);
>                                                ^^^^^^^^^^^
> Same here, just that size is already of type size_t, so a cast makes
> even less sense.

Thanks, this and the below is something I made sure to include in a
re-roll I'm about to send (to do these cleanups in object-file.c
separately from Han Xin's series).

>> +int format_object_header_extended(char *str, size_t size, enum object_t=
ype type,
>> +				 const char *typestr, size_t objsize)
>> +{
>> +	const char *s =3D type =3D=3D OBJ_NONE ? typestr : type_name(type);
>> +
>> +	return xsnprintf(str, size, "%s %"PRIuMAX, s, (uintmax_t)objsize) + 1;
>                                                       ^^^^^^^^^^^
> This cast is necessary to match PRIuMAX.  And that is used because the z
> modifier (as in e.g. printf("%zu", sizeof(size_t));) was only added in
> C99 and not all platforms may have it.  (Perhaps this cautious approach
> is worth revisiting separately, now that some time has passed, but this
> patch series should still use PRIuMAX, as it does.)

I tried to use %z recently and found that the CI breaks on Windows, but
this was a few months ago. But I think the status of that particular C99
feature is that we can't use it freely, unfortunately. I may be wrong
about that, I haven't looked it any detail beyond running those CI
errors.
