Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A11AC433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 20:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhLZUvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 15:51:40 -0500
Received: from mout.web.de ([212.227.15.3]:50503 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhLZUvk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 15:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640551877;
        bh=5b9msUfNmseRDQSqFjjdkT/OYxMg02nReBzargjyzGE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iorOL3MVFrSWjLRxhF0sX9HmY6oFLCqZ+q+GQKow+65lYVF5Pn0ly8/BSCfJHCDHc
         YmVjNjobbzEd4s1qRQEe+Zd+NDB2H+XynfGUkApXaSbTOzvp7VDJPIlYfYOoa4cPn6
         HM8XwNz5dsT95M09teIXK0P8B4tR4kvk94ZsmPqU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKB7-1mnTqq0Gs9-00PS2R; Sun, 26
 Dec 2021 21:51:17 +0100
Message-ID: <e288fad3-8a83-448c-d701-47c56bc258e3@web.de>
Date:   Sun, 26 Dec 2021 21:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length memcpy
 calls
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
 <xmqq1r24gsph.fsf@gitster.g> <af378ac5-a24c-5110-04a7-3257a909815b@web.de>
 <xmqqo857b11h.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo857b11h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uem/lpSFZu7Qmgc+eVm4KGY/dPUUpq0iHwgLiBig6J7uqJDAKbQ
 epTwFjoKaAQ2yziXXyX40Dvh38PhKKyORJLurysAaxZuBzGcrcu9ijCpLrGXbl9V/IsCGOC
 ET5zE2MO5t63FY+IJPWavh3FhW4K6PbnReBWHafQJDCGBUW6csAusn0cFjbEsDm77W4XZ4q
 idERHqkE6s+YqP7us/SCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GYBb5cJUfl8=:/9DCED5i62glIh4fGdl6Pa
 ESNFpV0Zldcbj3J1oJeQ56rNVnaAjvQ2EumMEGyb9mNapHPo+SVcE3mMNP784PGIA6O9zHESZ
 11qLMfiXM+DoxsQf/AYpovro6tzxQKhSOxMve1cli/2z2EcHAe9mq0/rSE8yGrvQcu4ASCAj7
 RaGplSbLw17GUaGqEzB1P9V6rMafVq2mPrPG2Wai1gZXbbVw1jjULo961dqttufSd0bniG/w5
 B4MLVPACscqsbZ3fIdUlflpYphscveFIgLfJQsGh1+FMMjy58Sw5uH+fy2xjPtTt8LTEAnG4t
 alS0erceWjVX+E8D8lH7RG/MCZ3u3LkkcmWqfg4l4RTTaEKrrfJGnBsJiV5vc7M0uVRw292rg
 kIuxF6LlxOvudJcGcEAItSxy/PDge4kfp9jGXhIIX4MSZqg0TYYPC8TRSIAdbEwZahnIObB3r
 HCf64/y5m9iHf+/Kzjmu0dp/89zXD8E6vwGLUazvRiUjIMQWv70z6FoGevAzmNJNCu17mgQWk
 tCFJUYwe0s8V6fUUtKVJZsoKF+6OluWLUMl05aZYKMhxQ9iMyR3U5o9Ns/IH2VCOLrtrs9e3r
 eDVBzUCiiFhKfmSA6MzViaQjkFPshIVNyAMF3Lj9VVd/8e7eXBIV9Nzs8SgbLtFCo7JPfcnlP
 ZvWNLT2/x7Bsuoz140ZOCp9FcRwzJaYX9FWQ99zhh7eNlaWSlac1ik/UwlhbnTxMkWcEhJtsN
 P4HX+PAp7HBHFWwHeq25zcr0RgvmoFRkjWtvXL2Zs8gf37jpG25b832mL1cRBjT6LVn40PYDM
 WLCJcAMzUaV1HyIO6TeSbVlKnC8WhzjrRO4YkJzSuOy4Ql3ZYYbvbeQFaU82jvCTbAuOBMGFk
 5NuUhITk+zB3DFrpaJIt+xVDlOL47OYPi1YSUg7Ep6KRn9Z39pLKABt82FpLuWYIvldoUyvky
 M7ABZ52oBjU+vpoF/c9xs29iRRRGePZSnQjLA7/9OKqaMGXOcalQHNxm20Y39dK0A4CGcMb2U
 wz3gb5w7My42dKM5fm9Gb0qgAULtj0Ok0gT5hoxxUE78B4As2/TTqbBI81moVf6cZA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.12.21 um 19:59 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>> @@ -569,7 +572,8 @@ static int reftable_obj_record_decode(void *rec, =
struct strbuf key,
>>>>  	uint64_t last;
>>>>  	int j;
>>>>  	r->hash_prefix =3D reftable_malloc(key.len);
>>>> -	memcpy(r->hash_prefix, key.buf, key.len);
>>>> +	if (key.len)
>>>> +		memcpy(r->hash_prefix, key.buf, key.len);
>>>>  	r->hash_prefix_len =3D key.len;
>>>>
>>>>  	if (val_type =3D=3D 0) {
>>>
>>> I am not sure why any of these are needed.
>>> ...
>> I don't know about the first two, but in the third case dst (i.e.
>> r->hash_prefix) might be NULL if key.len =3D=3D 0, reftable_malloc is m=
alloc
>> (which it is, because reftable_set_alloc is never called) and malloc(0)
>> returns NULL (which it might do according to
>> https://www.man7.org/linux/man-pages/man3/malloc.3.html).
>>
>> malloc can return NULL on failure, too, of course, and none of the
>> reftable_malloc callers check for that.  That seems a bit too
>> optimistic.
>
> Yeah, I agree that the real bug in this code is that the returned
> value of malloc() is not checked.  But checking if key.len is zero
> before using memcpy() would not help fix it, or hide it.  So I am
> not sure if that is a counter-argument against "this check is
> pointless".

It's not -- I was just trying to find a scenario which would cause a
Coverity warning that could be silenced by such a zero check.

We can use xmalloc and xrealloc to handle allocation failures and to get
valid pointers for zero-sized allocations, like in the patch below.

I don't understand why reftable_set_alloc exists, though -- is there
really a use case that requires changing the allocator at runtime?


diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
index 0ad7d5c0ff..438a1b0a7d 100644
=2D-- a/reftable/publicbasics.c
+++ b/reftable/publicbasics.c
@@ -19,14 +19,14 @@ void *reftable_malloc(size_t sz)
 {
 	if (reftable_malloc_ptr)
 		return (*reftable_malloc_ptr)(sz);
-	return malloc(sz);
+	return xmalloc(sz);
 }

 void *reftable_realloc(void *p, size_t sz)
 {
 	if (reftable_realloc_ptr)
 		return (*reftable_realloc_ptr)(p, sz);
-	return realloc(p, sz);
+	return xrealloc(p, sz);
 }

 void reftable_free(void *p)
