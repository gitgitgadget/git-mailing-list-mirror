Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF091C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2ED60FF2
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbhI1Ad3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhI1Ad2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:33:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5880C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:31:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g7so16813277edv.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iypwsmOXVdxEKNH6LwmXkqd99SDTP6tuXVfU01uZPJw=;
        b=owfsp/Kt2k/mzFdAeKwNHBGNdI3R5wK9wA2aP/VXLqTkOxONeUpiK6eV8OZHpS7biQ
         Aefz0LWLk5T1X27n/KX/DY6/ENUoLp5g1M6sJx/4R5ZbUXJ3SarOFwIBaJnnTtHylKWI
         3V4NGMSCdobpead9gI/zEpLJdEULxnVEkRJGQ5AiV25yUuBv8QEc1qMqfpd01AqWUvLZ
         tWU0Yx3HatmTjqbwXCDhNmiL4anCmBg1tlfm3wUe3HL/7pzGOgCL0jXVYFfu5PhZk+UT
         lx4wYRTvVHnUkqZgPGUPlWYEs9ZrqO5zqdQGsk/kHzdwlz3D1WVSpBVUlvA0eGJjczF/
         NupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iypwsmOXVdxEKNH6LwmXkqd99SDTP6tuXVfU01uZPJw=;
        b=nzYULUCW3s7rJoH8apG9+zPugf5DTPD28xHx8squH9ftQk5FRWnTVyTXC24m1qG1fr
         wpMVcV5aDtwx/+HOYLeABY8Txt25w/AD8lFCbhsmz6j4diUVnQ+Jn8O+BvIvcDRjOKXE
         K/Wen4KSSBFMfPurPgqo9HLEHIIoaGxSpwFodxJIGysRjyBSVmjtjeAt0x6fQWKx6C9L
         VvYXcSQemnvbJeAKiOoFGp7r19UqpDuHZkNU8QJ9vkrfGOrWL55LTesTT7wEjTkY7HB3
         UpW1pNwJYpUJrzduuwV6QSxS6QcKadiRD2ROR+4gDJoIyf6wviEjdLxRzEj91qz6TD2C
         lstA==
X-Gm-Message-State: AOAM531K+5xUSSjW8xViwJ69gPwzNJZIl9mtnEB5fZt0W1CYPRmEY4UP
        a7iM+8MwYktuBtoboAkgHuw=
X-Google-Smtp-Source: ABdhPJwfBA+65rpPC110RbZcXECD1beTFxVd6kD0fgD+fBYumVqGMkHi5wCVD4+TtZ+b2JC8sT+xDg==
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr3571058ejb.554.1632789108330;
        Mon, 27 Sep 2021 17:31:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ck10sm11856039edb.43.2021.09.27.17.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 17:31:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out"
 idiom
Date:   Tue, 28 Sep 2021 02:25:16 +0200
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
 <patch-v2-2.5-afcd2729c95-20210927T124407Z-avarab@gmail.com>
 <YVJSwuqjolz28+mG@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVJSwuqjolz28+mG@coredump.intra.peff.net>
Message-ID: <87h7e5zgjw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Jeff King wrote:

> On Mon, Sep 27, 2021 at 02:54:25PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> In C it isn't required to specify that all members of a struct are
>> zero'd out to 0, NULL or '\0', just providing a "{ 0 }" will
>> accomplish that.
>>=20
>> Let's also change code that provided N zero'd fields to just
>> provide one, and change e.g. "{ NULL }" to "{ 0 }" for
>> consistency. I.e. even if the first member is a pointer let's use "0"
>> instead of "NULL". The point of using "0" consistently is to pick one,
>> and to not have the reader wonder why we're not using the same pattern
>> everywhere.
>
> I seem to recall we've had some linter complaints about using "0" to
> initialize a pointer, but I think these days it's OK, per:
>
>  - 1c96642326 (sparse: allow '{ 0 }' to be used without warnings,
>    2020-05-22)
>
> and
>
>  - https://lore.kernel.org/git/18bd6127-be72-b7b7-8e2a-17bbe7214a2e@ramsa=
yjones.plus.com/
>
> I think this is a good step, as the long lists are unwieldy and difficult=
 to
> keep up to date without actually providing any readability or functional
> value.

[+CC Luc Van Oostenryck <luc.vanoostenryck@gmail.com>]

It seems like we should just revert 1c96642326, looking at the history
of sparse.git there's:

 - 537e3e2d (univ-init: conditionally accept { 0 } without warnings, 2020-0=
5-18)

Followed by git.git's 1c96642326 a few days later, but then in sparse.git:

 - 41f651b4 (univ-init: set default to -Wno-universal-initializer, 2020-05-=
29)

I.e. a few days after the workaround in git.git the upstream repo
changed the default. The 537e3e2d isn't in any release of sparse that
41f651b4 isn't in, they both first appeared in v0.6.2.

So us having -Wno-universal-initializer only seems useful if you're
using some old commit in sparse.git.

Having written the above I found
https://lore.kernel.org/git/20200530162432.a7fitzjc53hsn2ej@ltop.local/;
i.e. sparse's maintainer pretty much saying the same thing.
