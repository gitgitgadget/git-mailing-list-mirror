Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6AC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D2961919
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGCM7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 08:59:41 -0400
Received: from mout.web.de ([217.72.192.78]:41877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhGCM7k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 08:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625317012;
        bh=72zhjqdtZU60pIfnaiMb8b77hVGL4dRx0IXEfPg9FKc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SLo5EIVydAzOKxizpmH6OyeUyk4DeSyAEKUa8mf9oMN29g8hwIhV6qJvkvMeinX5B
         yxpIcA/jhFVr/MjNF4NzkcPs3dG5aLw22qt/V6NgaBNMyte3LnXOVUYioTG6Ile5Gp
         Gcq0EIYnviJIpxiDRR9k1mRjkBlBx42L/tn52Tic=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MhDkj-1lmeeY3faD-00MLxc; Sat, 03 Jul 2021 14:56:51 +0200
Subject: Re: [PATCH] khash: clarify that allocations never fail
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
 <87v95r8w86.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5cc24582-ed96-453a-fbad-d3fb83c8f949@web.de>
Date:   Sat, 3 Jul 2021 14:56:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87v95r8w86.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O6KIFP3aOGn36ohsHRrF6UtLZL7aSUMo+QaYPEljkz3quGU5nYP
 zpu5g/MVLxWvxdpUJjMZiYp4KyPq/34KghmiiK0d+EVJZllR3QZMC2NzyMyphYct8ZMLLlr
 LbFQODXp43CSUDWTRJb2RDg0uWfNw/EkZ6AknApCoEzsx7zIlzHTRvcw1/r+ZODnI3iqLms
 vP/JifbGN0r02naJe/vww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:452W7aKE43s=:h/bR4Hnqcue2SWuTmuY7tb
 UabOl4rD77wpDu7+WDSYNFYaYETJMn9OMpw9eLPaezsZ3j2+E1uaEyvViGQlNeIWDBR2+bFEP
 cZUA292cGLWOFI5dA6Zh18gRxKGNWtrVVYIL0vP5VNQrq/HnkTyrcuysMXTKiqTEjObDAwcWZ
 +5tHB7tRcjKaEMx/saxbJuEx8FAOG1klzU+rhTh05n0awshAWz6mUEAENb5bvBkiTrTtJ+jJj
 CfkrHgH2yYHQJMBNxscSfgCQKlgCifeEI1T1VpRNW/JQYFjx/z8lrni1LwKyIj4He2efi6fH5
 Gf58VYkV1dr+uAeGMbgPiGbJf7a/4IaNIPpbSxkiE97EwX3VkqfeXUVa1sYAUUIdryLK7Zmxf
 Lug+uGSkWdsJuyc49WHeoQuOXV1ZBL3RzdnqLMmfUVjtXlkgeME2zjPgwJsmGhowU2MflHL3v
 0xO+7+U2GVPxZLPtGlwLjhsCoWFsgWwaR4QhQemTSISY0+7oXYfU8lBlhpi5QZ16sh0fkQroX
 PeL3S6H4fGQSwAXY299mI9UaML5PKoacDy72FB4GikLRJUwJeZMXmbHBcHj7wG5heeXnqCfXX
 SDKWI+QpZWY1txld95kaXAO5HT8i+hIF1SZ4enuLnMfNbinEus9DXVQ8UR/q1mxTA/SK4g3RZ
 q7MAWLcEE8tjLnjIJFEe5qPTPV5YalnWWJCaR+yKyTDm9aIE+STTx3bapcKbpqgIeR3fjRxe3
 3KZFA1oKz05uDIh4sagW7sFNTLLGWtAk3EvEIheLHyw4pDztwM8aNSMDJK4CpvP7W4UHfSVBN
 00FF8jAg0YA/FyMUSDZYBTxAZMrbqmvj/ZUtmHY3XdRYsiKJeabjBCn0x7kyHwnONnIzUd/gS
 zJ43StixBiLBTOTLDx9BWwYneQurRd++NeEzDu4LxM1n+MwNp8V2TAWpBLO/O94cwvocNZ34B
 FjqdYsURF4bu0hJc1ruD3m8Tgvvo9WAr+KtjoDoLJWf4ifJrJTc2uQ9kYJhtuQG8jy94BOw3L
 4R1Jrc7C3/gr7zyqvkWoXiFMDRWdh6JiErb8lOZfFh43L3HD3Yhs14Vem2spYDvFU+pohuk9T
 UmZPpnCJWlWB3gKJsGjELlxge/vLLuTvsO0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.21 um 13:35 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Jul 03 2021, Jeff King wrote:
>
>> On Sat, Jul 03, 2021 at 12:05:46PM +0200, Ren=C3=A9 Scharfe wrote:
>>
>>> We use our standard allocation functions and macros (xcalloc,
>>> ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
>>> the program on error, so code that's using them doesn't have to handle
>>> allocation failures.  Make this behavior explicit by replacing the cod=
e
>>> that handles allocation errors in kh_resize_ and kh_put_ with BUG call=
s.
>>
>> Seems like a good idea.
>>
>> We're very sloppy about checking the "ret" field from kh_put_* for
>> errors (it's a tri-state for "already existed", "newly added", or
>> "error"). I think that's not a problem because as you show here, we
>> can't actually hit the error case. This makes that much more obvious.
>>
>> Two nits if we wanted to go further:
>>
>>> diff --git a/khash.h b/khash.h
>>> index 21c2095216..84ff7230b6 100644
>>> --- a/khash.h
>>> +++ b/khash.h
>>> @@ -126,7 +126,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
>>>  			if (h->size >=3D (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5))=
 j =3D 0;	/* requested size is too small */ \
>>>  			else { /* hash table size to be changed (shrink or expand); rehash=
 */ \
>>>  				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
>>> -				if (!new_flags) return -1;								\
>>> +				if (!new_flags) BUG("ALLOC_ARRAY failed");				\
>>
>> I converted this in b32fa95fd8 (convert trivial cases to ALLOC_ARRAY,
>> 2016-02-22), but left the now-obsolete error-check.
>>
>> But a few lines below...
>>
>>>  				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint3=
2_t)); \
>>>  				if (h->n_buckets < new_n_buckets) {	/* expand */		\
>>>  					REALLOC_ARRAY(h->keys, new_n_buckets); \
>>
>> These REALLOC_ARRAY() calls are in the same boat. You dropped the error
>> check in 2756ca4347 (use REALLOC_ARRAY for changing the allocation size
>> of arrays, 2014-09-16).
>>
>> Should we make the two match? I'd probably do so by making the former
>> match the latter, and just drop the conditional and BUG entirely.
>
> Yes, I don't see why we should be guarding theis anymore than we do
> xmalloc() or other x*() functions in various places (which is what it
> resolves to).

Agreed.

> If anything we might consider renaming it via coccinelle to
> XALLOC_ARRAY(), XREALLOC_ARRAY() etc. to make it clear that they handle
> any errors themselves.

I don't think there's any confusion in our internal code about the macros'
handling of allocation errors.

The following semantic patch finds a leery xmalloc() caller in
compat/mmap.c, though:

@@
expression PTR, SIZE, SIZE2;
@@
(
  PTR =3D xmalloc(SIZE);
|
  PTR =3D xcalloc(SIZE, SIZE2);
|
  PTR =3D xrealloc(SIZE);
|
  ALLOC_ARRAY(PTR, SIZE);
|
  CALLOC_ARRAY(PTR, SIZE);
|
  REALLOC_ARRAY(PTR, SIZE);
)
  if (
- PTR =3D=3D NULL
+ 0
  ) {...}

Ren=C3=A9
