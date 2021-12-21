Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D9C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhLUOnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:43:46 -0500
Received: from mout.web.de ([212.227.15.14]:48697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234937AbhLUOnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640097804;
        bh=38xmECWpI8g9GylCFMfXK51Sle79GW92pGR+sH1yqxw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BcrprYBGLVYgfAOvEcZInlhxU5RQO6+BqfzA53ui7EVTTEx3KT7g2UgrV7Q+qB/Ue
         XZI1kiaruEK01vkIaEZPU5Qf7smt9BJgiw/ACQzXOvHQOGoo1Imi0cZeuc1AK4NuHw
         Wux0XVAmHPpzhl/pmeCWAy0ugKtb7WeJfj87y9hw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvspv-1mA3wZ0qrX-00shht; Tue, 21
 Dec 2021 15:43:24 +0100
Message-ID: <3f1e3a59-1288-ecff-88b5-53bbd510a6a0@web.de>
Date:   Tue, 21 Dec 2021 15:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v7 1/5] unpack-objects.c: add dry_run mode for get_data()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-2-chiyutianyi@gmail.com>
 <211221.86bl1arqls.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <211221.86bl1arqls.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:npkAq76cyE7hcOacFxw5JADk4Xm73XWaK1D8rUzlMNSJKAQW6Db
 Z/NMKV4KmuZDYKBM4y/8RyLId/cLRTzWzxPCsSBYqYzCw5k3m0Jc1pIituinGgUM21VcSSA
 5KYbSsjZDJhnCEEypr5XQENW5IRtH9DwWBYqCTAMJQaWVF4mKU97K5Ml60Aa5vZXCDVIQ0R
 NA1viwBA3PiTf7FB7qhkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u3njzSoAaOY=:sIcJUQcsqQRVyiF7o4brQO
 hDvTqqokYO3r8Wz2if4xNNycCjXawCI79J/dn4f0ttYeod/CbDHjsrPAy4+K+GIT9W+e767NB
 VPIyZW/ASiZ6/q7fjzobbthhxL6VLypRRJdsdnmHXGR20A/M/woKc/c7x758Yw+Xr4ACCNGJT
 wWndHNDHqFyRUuhymAnWqUjrxm7Fcm94W/u0BZcr/FZoWrHCPoruHOTSfx9byRBN7jw+917UD
 J3mlrS8BC8OQuyQ3sPOGl/zN+4UpdDuoFEhWFfo2fkut4oOH0wO4WZwmfww0raPMEdHFE31bL
 v0KyDwG/iaVSY60eIfnqBKjQwbD8pJ3wVzz4s9gdVceJ+yOOqfwdu8FuceUcs+hCAAaJiVlSO
 oN/3U43ZSmtWtLl2tqANY98WmjcIPSOyYzCi2tWWW/6kd/bXlTvFX25OWHkiZ0sWYScxMAyjw
 v+z0saLI5vBBZdcLoqg7z5G/eexmJ1L3FUHtOhkOIK1VwS/AMCg3AYk+XL6w/w3iBBPTGrWj7
 7h+tzUq7tAWP8OyzY7Cuenxri+KlDWwCkBoZF+qSGbFjM/jSq+pitOCrQ7aNtOIv5Z/w3/b5u
 hWFOxeasoTKfOW9/iqMlXNENRigmnnMwssl6SXE8KkC6E3bV3cwcJhfsg+X5Z9TCmWI1f6hPx
 AAa67aSajhQ3gcw1o+MEHuGSsRBn3/AJwQEj74lcah+BiCmJDmku5QW8EiAukjc5KpmJNSN9X
 zxDV6YnGP/EI125QD/TQWvJeh3xco1Jk60yv1uemUDOakduDeZAOkYWHGT62LrGj+cggc07Cc
 KkHxcJP5ZdLKGBiAG+Q95Z4tDMcQVA6QDjlUKgeVGcxyB2f+8GZDM1kPL1fPT0nuQhy/c6qd6
 ivfnB/byUaVpvuNpkrmX3q0Qw+iVwc0CsEOLucLUda9TuYSdpN/kZmFtMKH2DsRh63ER3YpHv
 7vjuI7D3Ifd0TzPOkyx4BqUOBFEtzekthZ80ZekE1pv67G5EG5dbnds/yqamvkdaupfqBHana
 9m7Nha69MqPY39SdIW+DNDAcwgRkuCM3X//RUB38fN6DSWRMRw6bzIFQUqabOiLGP08160ETX
 IJScoNTaNIFHDI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.21 um 15:09 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Dec 21 2021, Han Xin wrote:
>
>> From: Han Xin <hanxin.hx@alibaba-inc.com>
>>
>> In dry_run mode, "get_data()" is used to verify the inflation of data,
>> and the returned buffer will not be used at all and will be freed
>> immediately. Even in dry_run mode, it is dangerous to allocate a
>> full-size buffer for a large blob object. Therefore, only allocate a
>> low memory footprint when calling "get_data()" in dry_run mode.
>>
>> Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
>> ---
>>  builtin/unpack-objects.c            | 23 +++++++++---
>>  t/t5590-unpack-non-delta-objects.sh | 57 +++++++++++++++++++++++++++++
>>  2 files changed, 74 insertions(+), 6 deletions(-)
>>  create mode 100755 t/t5590-unpack-non-delta-objects.sh
>>
>> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
>> index 4a9466295b..9104eb48da 100644
>> --- a/builtin/unpack-objects.c
>> +++ b/builtin/unpack-objects.c
>> @@ -96,15 +96,21 @@ static void use(int bytes)
>>  	display_throughput(progress, consumed_bytes);
>>  }
>>
>> -static void *get_data(unsigned long size)
>> +static void *get_data(size_t size, int dry_run)
>>  {
>>  	git_zstream stream;
>> -	void *buf =3D xmallocz(size);
>> +	size_t bufsize;
>> +	void *buf;
>>
>>  	memset(&stream, 0, sizeof(stream));
>> +	if (dry_run && size > 8192)
>> +		bufsize =3D 8192;
>> +	else
>> +		bufsize =3D size;
>> +	buf =3D xmallocz(bufsize);
>
> Maybe I'm misunderstanding this, but the commit message says it would be
> dangerous to allocate a very larger buffer, but here we only limit the
> size under "dry_run".

This patch reduces the memory usage of dry runs, as its commit message
says.  The memory usage of one type of actual (non-dry) unpack is reduced
by patch 5.

> Removing that "&& size > 8192" makes all the tests pass still, so there
> seems to be some missing coverage here in any case.

How would you test that an 8KB buffer is allocated even though a smaller
one would suffice?  And why?  Wasting a few KB shouldn't be noticeable.

Ren=C3=A9
