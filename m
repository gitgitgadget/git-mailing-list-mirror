Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2284C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD6560FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhJHTEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbhJHTEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:04:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768FC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:02:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p13so40556626edw.0
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gXa4y2MQ6UDeLVzNZ6fS2ZRyuOLXReXcibPkYBl8nJ8=;
        b=bdXPBYPodKyn9WELUjHW8s0WhPwRPi8e93bLy97LrfOzb4CADPZMlY8v3+Uh3+C/S9
         b1qFydZe1q/XyivQkjRUQKNsJwacbIa5OJfM1TGpsebKmB1lUoJEXfmOaw76KDMiMewE
         nBYNIXl6cOn7s1Tc8hvhNcRg6MZzCSfUCAAq8WE+AADH02Ig2aI7Wp0UhPQT+pNFhIJQ
         A8Xy7LA0pIbQBaHPwaF5Zr/WeyCn8NyGKG/fGfY5QeGjcQWZXPp3zx7AWXS8QGGeRuQc
         0Smhnn+kF8XdZq6ZNgqdhgev5Y4mtpQdS42+u6MitKaY1QqMYipPsAIABEupA1KqhTpp
         nESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gXa4y2MQ6UDeLVzNZ6fS2ZRyuOLXReXcibPkYBl8nJ8=;
        b=hNUg8wiNPl00L3iqLjp82g7mX7xicIn3eamXXPHntAbRqGwiooCd0D2EetkiUn3SX4
         ahMjDGWACV4avVh7oqGsYwVXJQHQV7p5nRQXudzYteL3rOXXwta3FWFpiukdDL3n6RBZ
         1ihdAwO2w6W/oSlU37xnadmr9srVy/bYLk8wUASu4XJOdMmBj/CzWQSpjEO3XnCe2+w/
         5KJYWmfJjA4vLVnuPna9gBL0FCBMqtUT6mPMWEMV/uEeCpJUOo8K9Re+5T9m2bxsROw8
         XkzqP52+qyU3ATLrmZ/H/L+2cooe2dmIini2IOd7pJf7zBX68ZAtaQ/Tn7yKRL/pUT4D
         yxSQ==
X-Gm-Message-State: AOAM533YqkeWBrZgYAbdZGd5v0sj4Wz7VH+EoanhmQ73moh0NVXP99mn
        Ay5DKUkfzs0Y+vC/x4I2m2E=
X-Google-Smtp-Source: ABdhPJxH/Nah76x+d5eAfTqFyNczDZ3bhNlbpLTlLCYpDnLFFfInoJuYKqGx4A0q0fnd3Sj62P5RuQ==
X-Received: by 2002:a17:906:71d4:: with SMTP id i20mr6526202ejk.390.1633719733923;
        Fri, 08 Oct 2021 12:02:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l13sm65145eds.92.2021.10.08.12.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:02:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/9 v2] test-mergesort: use repeatable random numbers
Date:   Fri, 08 Oct 2021 21:00:13 +0200
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
 <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de> <xmqqee9210a1.fsf@gitster.g>
 <a3eeb255-56e3-eb22-ebf7-e9f04c95fa44@web.de>
 <b73452fa-f5b0-0ab4-25e8-7494637c49f5@web.de>
 <87tuhsez93.fsf@evledraar.gmail.com>
 <c43ce422-0eba-0c7e-af01-a85cd948b0bb@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <c43ce422-0eba-0c7e-af01-a85cd948b0bb@web.de>
Message-ID: <874k9rnxvv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Ren=C3=A9 Scharfe wrote:

> Am 08.10.21 um 09:23 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Also generally: If you'd like "portable" rand() for a test just shell
>> out to perl. I ran this on various Perl versions (oldest 5.12) on Debian
>> Linux, OSX, Solaris & OpenBSD, all returned the same number for both:
>>
>>     ruby -e 'srand(1); puts rand'; perl -E 'srand(1); say $^V; say rand'
>>
>> Whereas a C program doing the same:
>>
>>     #include <stdio.h>
>>     #include <stdlib.h>
>>
>>     int main(void)
>>     {
>>             srand(1);
>>             printf("rand =3D %d\n", rand());
>>             return 0;
>>     }
>>
>> Returns different numbers an all, and on OpenBSD the number is different
>> each time, per their well-known non-standard srand()/rand() behavior.
>
> For test shell code that needs only a few random numbers this would
> be fine.
>
> For test-genrandom it would also work, but I don't see any benefit in
> converting it to a scripting language.
>
> Shelling out to a script to avoid a multiplication and a modulo in
> test-mergesort is not interesting, to put it mildly.  A mode that sorts
> input from stdin like the sort subcommand, but returns the operation
> counts, might be useful if you want to test distributions generated by
> a Perl script or other data source of your choice.

Yes, it has zero applicablility here.

It was just an aside/FYI since we were on the topic of the
cross-platformness of rand().

I.e. one might assume that for the general problem of seeding something
randomly cross-platform one had to ship a rand(), but usually at least
perl is there ahead of you, and since it has its own rand()...
