Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B3C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 17:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A72611CA
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 17:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhFAR6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 13:58:21 -0400
Received: from mout.web.de ([212.227.15.3]:39415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhFAR6U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 13:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622570194;
        bh=2ydYGcSZsk8P5uSULUA2WsN28A6vDSPQHi+DzaFkgzo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TMPp2uv5jHDWnaOz5OAVURqfE5c2ndY7dXYMQhlJrbDjo4mrRF6IrO5IGVGOF7kSf
         SFQu9f7kxIoQaw8fmqMQ7jzNp5R4Jeubu58yKtUmO1a0Ufd51WHMXZ+J9851g2NPzV
         GIof5zX/NqTE3F7/fTzg8wIlP323S8+GDMNUZgS8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LiFT1-1l1YTC3eLL-00nQi9; Tue, 01 Jun 2021 19:56:33 +0200
Subject: Re: [PATCH] builtin/fsck.c: don't conflate "int" and "enum" in
 callback
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <patch-1.1-f109a61b11-20210601T000433Z-avarab@gmail.com>
 <de9dea3a-6138-5e2f-7dc8-8a2ddf28bb84@kdbg.org>
 <87k0ne0zx3.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8df5f832-adaa-7cb0-38e3-1a4b2bcff252@web.de>
Date:   Tue, 1 Jun 2021 19:56:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <87k0ne0zx3.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mPgJ2j3c5BsBs2hIi3Qvg2ZjibVemBca6yR0UwDFH0EzEbOqmOW
 bSo4vSqBxvBdkNkM71vWxLSABMRiAw5qQfXCIQJ7S98wuoD42za4oPBNI+mvivg5yol14cc
 2JLAH+GNCD+qXvtJ7+b+lY7IE5l57thRq0qL/jnyMJ2T6N3Hqz52rsUgSiyn5a2KOiei78N
 e0hhxVY9prKPkXv8mnmgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uJSlazV2a5o=:ntiWswh5s5iUR0Cjk8l34y
 iUfKHhE4arq6BHaEn+WuK76R9KADxKzTRM2plaznjKJy5ywE1994szvBaQ7TH2OomzieUk6rx
 adlJB4ML+pQcA9poWxAFGJcxI+lcmmB0mxNdNupgj2UfRoD92QvZmt13cvK3a0m2oiO6KsuG3
 jhwo1SUPPCsiXmRMSwv4odCUrn9QqzWLpxZXewdG0JtK3DM3WBPYH7gTDT2NAeJhTym9bOfaq
 uIa5MjFoxs6be32iryl9yjvidBQx9j4iXACE9GNQygvBMoey/oekA28faCKP1rfcFm0jQn4/d
 ciZkH7Rx1zD8sY7YVYUtlEoxB3dAstp0oKjDr9gATa9vc0X59xdoPl57lOVnSjvtRIf7Px5NI
 CAnN085ynD7Bgntmk09mCuOUIZBjyrIj5Ep9zl0y7f0/uRVotbNbCgZYQho86t/Cg8JtBXDVj
 v6DjDflnURKpVrvZH5eqFQtXQaWVis/XRB31Kq4Kc6smGYPxHKF2MhI14PMagIvk6Imns1kkF
 n+MIlhhYHVE7jHbeyOL9wsHd6t15PJHKALJs4wGbJLT6UaCyIRkwbDYGv4y1XrYxGpYJK/+rI
 zjHOMi3TNClsSUJbJ73727L8xfUQt4EM03BmlYhPWuTpEzObidHrrWAqPpTBTMKA76bDwu5YW
 VuYC8zq0ft91LOdHuQ6nj/FwcjivdwTHpg7z09SpZWth5DcjI+UsXEWEoy+DMu9lJnmrKZc8j
 asmz/K1rll4AC7Xv2JLeuUbWt2+7mHbs40oMHvi19TZ0aSvRV5K/9zrBuOr3vw6cjapwi1DyZ
 xB4dv2u0eTW37rcMfMxGw0RZuE2cGlcEoIf8Gue4c0IiQmu8SKth5aUrY76aKbIjv70+oU1Zb
 z0CXeeA3lST+rATn2fnEQijCe7bhI1EItJfM9x2i9bliCGkfxwhxJ0qGs/LyGgPDZEXBSy5g7
 qqA7B7le0lWLGNm4DOB59gE+3dMhcKsKcHn+vfS+RjHfcfmzZGXlecObF24n+j9mtznq0TiyV
 7xV63eUHXLas+++gLRYbvrrnYNRifZivizvgA2MAdl6bPXUVXvwkeRCYhA0fqd6UIcOfpDsj/
 DHo2BhZWph5qd0cflKZoo4uediGxf9XWYpN
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.06.21 um 10:04 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Jun 01 2021, Johannes Sixt wrote:
>
>> Am 01.06.21 um 02:05 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> Fix a warning on AIX's xlc compiler that's been emitted since my
>>> a1aad71601a (fsck.h: use "enum object_type" instead of "int",
>>> 2021-03-28):
>>>
>>>     "builtin/fsck.c", line 805.32: 1506-068 (W) Operation between
>>>     types "int(*)(struct object*,enum object_type,void*,struct
>>>     fsck_options*)" and "int(*)(struct object*,int,void*,struct
>>>     fsck_options*)" is not allowed.
>>>
>>> I.e. it complains about us assigning a function with a prototype "int"
>>> where we're expecting "enum object_type". Enums are just ints in C,
>>> but it seems xlc is more picky than some about conflating them at the
>>> source level.
>>
>> Is that true? I thought compilers were allowed to use whatever data typ=
e
>> is sufficient to represent all enumeration values. For this reason, you
>> sometimes see
>>
>>    enum X { A, B, X_MAX =3D 0x7fffffff };
>>
>> that ensures that an int must be used for representation of enum X. So,
>> AFAICS, your patch is an actual fix, not just cosmetic.
>
> 	The identifiers in an enumerator list are declared as constants
> 	that have type int and may appear wherever such are
> 	permitted. [...] Each enumerated type shall be compatible with
> 	char,asigned integer type, or an unsigned integer type. The
> 	choice of type is implementation-defined,110) but shall be
> 	capable of representing the values of all the members of the
> 	enumeration [...] Thus, the identifiers of enumeration constants
> 	declared in the same scope shall all be distinct from each other
> 	and from other identifiers declared in ordinary declarators
>
> 	--C99, 6.7.2.2 @
>           http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
>
> My reading of that is that mixing the two (which we indeed, do all over
> the place) is guaranteed to work, we've got plenty of places where
> e.g. enum object_type is passed to something else as an "int".
>
> This xlc warning in particular probably has nothing per-se to do with
> enum v.s. int, but just that it's complaining that a function pointer
> doesn't have exactly the expected type.

The object_type item OBJ_BAD has the value -1.  If it had a low positive
value instead, GCC and Clang would warn.  Demo:
https://godbolt.org/z/vKPdjrYsa

As you cited above, "The choice of type is implementation-defined".  You
can use enum values as if they were integers, but that doesn't dictate
their storage size.

I find the lack of a warning depending on the value range disturbing.
Perhaps it's omitted because GCC and Clang guarantee compatibility of
such an enum and int for all prior versions (i.e. the implementation-
defined specifics never changed).  A stricter check like xlc does is
more useful for portability, though.

>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>>> ---
>>>
>>> This is new in v2.32.0, so sending this during the rc phase, just a
>>> warning though, so unless you're using fatal warnings on that
>>> OS/platform it won't impact anything, and even then it's just a minor
>>> annoyance...
>>>
>>>  builtin/fsck.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/fsck.c b/builtin/fsck.c
>>> index 87a99b0108..b42b6fe21f 100644
>>> --- a/builtin/fsck.c
>>> +++ b/builtin/fsck.c
>>> @@ -109,7 +109,8 @@ static int fsck_error_func(struct fsck_options *o,
>>>
>>>  static struct object_array pending;
>>>
>>> -static int mark_object(struct object *obj, int type, void *data, stru=
ct fsck_options *options)
>>> +static int mark_object(struct object *obj, enum object_type type,
>>> +		       void *data, struct fsck_options *options)
>>>  {
>>>  	struct object *parent =3D data;
>>>
>>>
>

