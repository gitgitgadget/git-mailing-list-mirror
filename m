Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F4C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3220B613E3
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhGAQb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhGAQb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:31:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220BC061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:28:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so9313430eds.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6PVrI9LIvudWZTFozTPulUtzkcm38fxUun/30IUmKKA=;
        b=hOvoxrTsYCNnMrOvGtm5/yxR9OvssbEjFHkHLlJvvHhy/zVmhn6OF6+IecObwphY3l
         9j/6FuksZTOCjpELCMnl3nCnj+31as+mDs3krOFOX1dy0NqGEhzM2MuVQcb8lkYGOkvd
         A3UXQDU4lOEuNf9T5UTINXqrOLop80CokCghU6QGEV4gXFGnqpkwGAAWwx7z8E3Mindy
         PiRoey0R/YxaHJq+PejPiuUVauwz1niyg/ZwwSsOz5CNnmQzI/Ua1mNEtkp00VMZTFsW
         SckyLkPvnW5mjs5PtI3BxFEvexAGw7tEcL2GLdrwZZWR+1N1J7wFAWqbtgAp52PdKGq7
         zJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6PVrI9LIvudWZTFozTPulUtzkcm38fxUun/30IUmKKA=;
        b=q00ACx3Dd0iXo9RZOEI4WN7qR1+HPjukHZzGjFD+8GzUIQt/lqypL8PWjop+QN5b9f
         7kz27naL2I1/QXghRm7tkbSp3oPYmsAPr7J18qAX46kqNMnPxEoFr1jeGBz7tSHGP9XK
         aW8mrMzhvq6fT+lv5nBQHQ6IdfhePgpOrgFfGKHmpFPfnDgLitblhqzsNZQqk1+25XKG
         9D5dvAbcN0Got+nkAwfsatroKXfljKrgkHYH2bXQphMnx3KmaC3gI2JA1MpjnFMbY6eu
         HivhCEXR7jiFp7hCLeqWnzbiSByWRbkxjCjRSsXLg/gmTX+u53YCdcRSSf0us/a6CRBN
         lQxw==
X-Gm-Message-State: AOAM5313XbUAS74hAurZKcvEE7M6LA8aQHHyFb7YyMCquNuf/ykUfcYw
        M8tYsokrFF+vFMH17ocKzI8=
X-Google-Smtp-Source: ABdhPJz8shUvdI0OAbTu4Y1hwOktr8AtWIH0Qi3MBKXLaRIpA7yslx9vdygTBxmlFBoLDEJw1UaOGA==
X-Received: by 2002:a05:6402:5142:: with SMTP id n2mr879221edd.241.1625156934065;
        Thu, 01 Jul 2021 09:28:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a8sm102891ejv.120.2021.07.01.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:28:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] *.h: move some *_INIT to designated initializers
Date:   Thu, 01 Jul 2021 18:08:01 +0200
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
 <patch-1.5-9a92e7c216f-20210701T104855Z-avarab@gmail.com>
 <CAN0heSpsg=bwX9gbYfeWYqUbuen-zArR69FWxNmdtcQW_RubzA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAN0heSpsg=bwX9gbYfeWYqUbuen-zArR69FWxNmdtcQW_RubzA@mail.gmail.com>
Message-ID: <87lf6qc81m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Martin =C3=85gren wrote:

> On Thu, 1 Jul 2021 at 12:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>>
>> Move *_INIT macros I'll use in a subsequent commits to designated
>> initializers. This isn't required for those follow-up changes, but
>> since I'm changing things in this are let's use the modern pattern
>> over the old one while we're at it.
>
> s/are/area/, maybe even s/area/area,/ on top.

Will fix.

>> -#define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }
>> +#define CREDENTIAL_INIT { \
>> +       .helpers =3D STRING_LIST_INIT_DUP, \
>> +}
>
> I've verified that all of these designated initializers assign the exact
> same fields before and after this commit, e.g., `helpers` actually is
> what comes first in the struct.

Thanks!

>> -#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
>> -#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>> +#define STRING_LIST_INIT_NODUP { 0 }
>> +#define STRING_LIST_INIT_DUP   { .strdup_strings =3D 1 }
>
> This "NODUP" one is a bit of an odd case though. You don't actually
> change it to use designated initializers, as the patch says. Instead you
> change it in a slightly different way. In a sense, you assign the
> literal zero not to strdup_strings, but to the first field, which is a
> pointer, where I would have expected NULL.
>
> I think there's been some recent-ish "we can assign `{ 0 }` even if the
> first field is a pointer, because it's idiomatic and works out fine"
> even if assigning 0 to a pointer looks a bit odd. So it might not be
> wrong as such, but it doesn't match what the commit message claims, and
> I think it would be more clear to use `{ .strdup_strings =3D 0 }` here:
> We're explicitly interested in *not* duplicating the strings. It's not
> just some default "let's leave everything as zero/NULL".

Yes I'm really conflating a few different things here:

 1. Whether to use designated initializers.

 2. Whether to skip explicit initialization, i.e. not enumerate
    everything, and have the ones not mentioned initializes as if they
    had static storage duration.

 3. Using the 0 null pointer constant instead of NULL while doing #2.

 4. Using our in-codebase idiom of only setting any boolean flags during
    initialization if we're setting them to true,=20

So I think in this case just keeping it as "{ 0 }" makes the most
sense. Even better would be just a "{}", but that's a GNU-only
extension.

I think "{ NULL }" is just a distraction, i.e. it's better to use "{ 0
}" consistently everywhere. C guarantees the same-ness of the two, and
the point is to initialize the struct as if though it were done with a
memset() to 0, not mentally keep track of whether the first member is an
int, pointer or char * (in one other case we use '\0').
