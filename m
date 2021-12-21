Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D22C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 15:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhLUPEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 10:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhLUPEs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 10:04:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E70C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:04:47 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so53114239eds.10
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2e0COYOt2OmXh9754JfspAAiTwIQUpiL0B/NQy33e9s=;
        b=l8KwgYEkNe9XhcnUHfOlHru7yN9c31bg1JlFIiqQwEWGKG0jaYXar5v4DYELjy32Q7
         kEH90b0lkf5KIj9VNehV5sC4qqDjnx8leMMfI/PgqGeylAV0w9wOJME2KMdcOhFFtBdz
         /tYqiKwloX1yk3Rmz/F5Z+xYmL80Lhadil8ERWvFYhqOKNQCfDVig3XUwcsXFNoOu9SW
         mGjKt1HopEPcbdukanNzKU16org/XEe9NpNAKMdtXoYwSXMHLuMGANurR/z9uyKTCoNH
         kkU6GAAf1lAZfd5xDe2FyFI2PV7evc1k6oW7h9jvlhfBaUFqR9hVitm20+NIF34VTNSv
         rHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2e0COYOt2OmXh9754JfspAAiTwIQUpiL0B/NQy33e9s=;
        b=FT6ScXy2IHxHZvZJefrdmmNegJYNrU9uR0AF3rc0lGL8QBGz2t1oTyb6Fx2jDPTBsI
         N2szMZnN4kc9xhzwie8dHyPkGcrUfhETdO2KMoLGlODzuh9CB7NZ09LKK9ytpuRRLK/F
         mzsGlo64FnNKDs6kmCnpCzf5NBE/2IGrfb7/n36aO9JJXMbpk9jJACV21bNEDVowsG5I
         1stTzvuwgh46Oqo5+r0OtogTTBtfYc+6NYBm52m2j1InzTOYsjMnXQFpOUo2P0dWK+WV
         PvyHkev5ioOq2I53+NWvvCEnfMDWfR1YFxims8PinPr88m9OEo81NT1rsCEjILlaKm/r
         1zRw==
X-Gm-Message-State: AOAM531f5A1L7mibINaAJJvoXhMHCTRhOmJVTgBNGR59yDu5wYazFtSu
        wVpwv7oT8etGX5LWLUKH4hY=
X-Google-Smtp-Source: ABdhPJx8uXS+GoxexrXOtkUwMWabsgxopIKpw2VTbevAxdPH5BRUAMJjpNzY2s5M4AYpdN3J7u2i4Q==
X-Received: by 2002:a17:906:c1c6:: with SMTP id bw6mr3064878ejb.662.1640099086028;
        Tue, 21 Dec 2021 07:04:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hb11sm3315011ejc.33.2021.12.21.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:04:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzgh2-000m4v-SD;
        Tue, 21 Dec 2021 16:04:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v7 1/5] unpack-objects.c: add dry_run mode for get_data()
Date:   Tue, 21 Dec 2021 16:04:23 +0100
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-2-chiyutianyi@gmail.com>
 <211221.86bl1arqls.gmgdl@evledraar.gmail.com>
 <3f1e3a59-1288-ecff-88b5-53bbd510a6a0@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3f1e3a59-1288-ecff-88b5-53bbd510a6a0@web.de>
Message-ID: <211221.86y24eq9rn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Ren=C3=A9 Scharfe wrote:

> Am 21.12.21 um 15:09 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Tue, Dec 21 2021, Han Xin wrote:
>>
>>> From: Han Xin <hanxin.hx@alibaba-inc.com>
>>>
>>> In dry_run mode, "get_data()" is used to verify the inflation of data,
>>> and the returned buffer will not be used at all and will be freed
>>> immediately. Even in dry_run mode, it is dangerous to allocate a
>>> full-size buffer for a large blob object. Therefore, only allocate a
>>> low memory footprint when calling "get_data()" in dry_run mode.
>>>
>>> Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>>> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
>>> ---
>>>  builtin/unpack-objects.c            | 23 +++++++++---
>>>  t/t5590-unpack-non-delta-objects.sh | 57 +++++++++++++++++++++++++++++
>>>  2 files changed, 74 insertions(+), 6 deletions(-)
>>>  create mode 100755 t/t5590-unpack-non-delta-objects.sh
>>>
>>> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
>>> index 4a9466295b..9104eb48da 100644
>>> --- a/builtin/unpack-objects.c
>>> +++ b/builtin/unpack-objects.c
>>> @@ -96,15 +96,21 @@ static void use(int bytes)
>>>  	display_throughput(progress, consumed_bytes);
>>>  }
>>>
>>> -static void *get_data(unsigned long size)
>>> +static void *get_data(size_t size, int dry_run)
>>>  {
>>>  	git_zstream stream;
>>> -	void *buf =3D xmallocz(size);
>>> +	size_t bufsize;
>>> +	void *buf;
>>>
>>>  	memset(&stream, 0, sizeof(stream));
>>> +	if (dry_run && size > 8192)
>>> +		bufsize =3D 8192;
>>> +	else
>>> +		bufsize =3D size;
>>> +	buf =3D xmallocz(bufsize);
>>
>> Maybe I'm misunderstanding this, but the commit message says it would be
>> dangerous to allocate a very larger buffer, but here we only limit the
>> size under "dry_run".
>
> This patch reduces the memory usage of dry runs, as its commit message
> says.  The memory usage of one type of actual (non-dry) unpack is reduced
> by patch 5.
>
>> Removing that "&& size > 8192" makes all the tests pass still, so there
>> seems to be some missing coverage here in any case.
>
> How would you test that an 8KB buffer is allocated even though a smaller
> one would suffice?  And why?  Wasting a few KB shouldn't be noticeable.

That doesn't sound like it needs to be tested. I was just trying to grok
what this was all doing. Thanks!
