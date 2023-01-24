Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262DFC25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 19:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjAXTIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAXTII (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 14:08:08 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9365AB
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674587256; bh=eapOUOT1j8gB3oZoALwOottVmm2I++A54KZu/VetttE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oqkJutkK3Y7rYA5XxBMKByVauwEWLNEWqWpgVWJ8JtlUZtoFNg8ElgTxJ91Fys/n9
         918UcL5yTGXK6IudJRCo0dDpTREM0qDs8Knmvrk6h+CtGQNavTjKw0owJ+VbQSM69j
         mje39lSZXpp/wOhkTxyFrwoeZCCygkkAOJx5xXv+TdZJHeCQk/RiRZZxLnxjKOZh15
         v9kg2mQMeYKs/LewVR9rdzJuSUW9xgeBs+whUtH8aUODLmsQPeyrQA873einb24SPl
         cC/9taquihtknXh/DyXO7PBZumv+hTAbA/fmD1ytYpcRZWmmJUxKZWiGEDayIpVCcM
         NWJfUkNXrQqzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.86]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1pXHPF0CGV-00CmoB; Tue, 24
 Jan 2023 19:53:58 +0100
Message-ID: <b4b48877-5b80-e96f-d09f-2fe275f42950@web.de>
Date:   Tue, 24 Jan 2023 19:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
 <230123.86a629tzgc.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <230123.86a629tzgc.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:359kcn8+oO5MdjSIpyAuskpAsWw9xzQIl7p3a6U7o+waEKWDxFd
 GRifj/qLux8uvdjTmC7/Og9fa4dXZFMzhJgEDorFDLBarQF+fZKZhBhxXdAxnwnAeBKzua9
 8i0vAJTJKVtqpgMKbZPR6fTRUKV/OUgzgsH08QR2mWekmLPM+oLX51SS80DosezRA4PUR3D
 xuWQR5EWlMha+IGh+r9yg==
UI-OutboundReport: notjunk:1;M01:P0:OaKSqcVJtng=;iKEPVh/m7vIsgpX7hatbjBtKLY+
 xyzi4odTma6KlitmO8FOvRx2r3LPJeiuisfvLFCt23X3iT4Wii0mrWC6149wDv3ZsvAYJySlB
 Xx9giPoQHRKoZ17ZNl6FZcjN0Klx7h05rEwIkUx+60Q7f83QvJwkpgzLHzro2VLX2nrAPp+fB
 1WrY7KQEsb66M8XUCa2hW6uJ/cIvM9fjJAAOnNhhh/uKnh54hYLGC3s0Ty1L2Uhzqw6bvcXRb
 2CGwqjqdCwmABJTq+LNXu09YGGjbNtDps/S2zRNToo1RHoznP+PZZMNPM/NSdZirscx4Jj6oC
 LCElGKuI7OrCmKkvngu9opG/HxcrA4Tu/bVgplTex1UMim+rlzc84qxzkcDdLvWnk0TZpLTWJ
 Kau2WwUnAlTA1V3Er3JP+l9+pPicy6RW35kn387Zj92PI/DLuwiblUZyixYMde4esXghtGiSm
 C5o2SpqoaQQNSxFMiF4AhOS06qEG1Ox5V8zn7xPra6o+5VYf9DQNUjNXySpXA/OLuTz3ER7aj
 aVuHbJFKFz5sx6wmF+Zr67Ih+6kASvcyQSTxLZAFlD13DCWjNmrrDCIqiRHQ/pLSKRc3OQrKD
 sz5p9IQtYADW8YqO29uwlauWWdEB6wtD5G9jbtgjMTNtBcU78uifOemErWdBsjH6UJ8e33yO0
 YTIOoGTlTppSgDaZ6hvxaPKAmwUGELta7nq7j0CwcJ3g1SiN8NV8IJwmrkgJ6yUJEbBa96Ll4
 8eazcZPbv0UjP0nPh1QbbR1Mgx40ktBo8kZpiDIW3ynRwCsbwJczdF5b55oBooMLJyzNGlGvC
 mCDquHlhZIJr0jh8lWxixbtbgkkTQzpuqRIBiIgo3b5/LCSeAw1NthJj70S+OuHU8aPSV74nJ
 lRfg1cdKoKPBA+KNgDeZviz+9jer5UR47uUN9pZhOJ0h0rLhRohYYJ4Jym5hcT3XR2h+Vb2ZN
 wAsRm/JINSvnPqt1JmiEKhOJqWQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.01.23 um 09:33 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Jan 21 2023, Ren=C3=A9 Scharfe wrote:
>
>> When parsing tree entries, reject mode values that don't fit into an
>> unsigned int.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  tree-walk.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tree-walk.c b/tree-walk.c
>> index 74f4d710e8..5e7bc38600 100644
>> --- a/tree-walk.c
>> +++ b/tree-walk.c
>> @@ -17,6 +17,8 @@ static const char *get_mode(const char *str, unsigned=
 int *modep)
>>  	while ((c =3D *str++) !=3D ' ') {
>>  		if (c < '0' || c > '7')
>>  			return NULL;
>> +		if ((mode << 3) >> 3 !=3D mode)
>> +			return NULL;
>>  		mode =3D (mode << 3) + (c - '0');
>>  	}
>>  	*modep =3D mode;
>
> There was a discussion about this on git-security last August, in a
> report that turned out to be uninteresting for the security aspects.
>
> I'll just quote my own reply here out of context
> (<220811.86mtcbqd5x.gmgdl@evledraar.gmail.com> for those with access).

> On the other hand this edge case is also a golden opportunity we're not
> likely to ever have again. We can't really change the git object format
> at this point without *major* headaches, but in this case we have the
> ability to encode arbitrary data into tree entries (e.g file metadata)
> as long as the writer makes sure they overflow back to the valid
> filemode :)

Patch v1 cited above still keeps bits beyond S_IFMT (0xF000), so that's
at 16 bits on a platform with 32-bit unsigned int for future object
types or other metadata.

One bit would suffice to switch the path field into an URL and encode
additional metadata there.  We could do that even with the stricter
patch v2 by using one of the bits between S_IFMT and normal permissions
(0777) for that, e.g. the sticky bit.

That all said, the longer I think about mode overflow the less I
understand why I sent these patches.  It's basically harmless.  Perhaps
we just need a comment stating that, to contain the urge to "fix" this.
Anyway, I'd like to retract my overflowing modes patches (unless someone
else really, really wants one of them applied).

Ren=C3=A9
