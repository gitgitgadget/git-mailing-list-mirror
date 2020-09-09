Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8D4C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8E721D43
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="O4GjTt07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIIUnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:43:50 -0400
Received: from mout.web.de ([212.227.15.14]:45793 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIIUnp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 16:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599684219;
        bh=VkFcADl7SUeh4J8Ujn9U9eZ56kt10loFNm0pmUzEzI4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O4GjTt0705z4bmBya6XvNA0CRoj/QZu9z66hDBTzIWgJw83o0h+hz9SbyKLpEep/V
         xmOk4AA5zGAHouhCmX584VC+0c1AytyuheAkKG8Me5jiGp5pnnLojrVHaZJCIvNWXm
         1+ZdvV0tzFJ87TAq4fiHhmrWFeVfvtUgQ0zYEjv8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xeZ-1kcXQf3z8d-014tGi; Wed, 09
 Sep 2020 22:43:39 +0200
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
To:     Jeff King <peff@peff.net>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, whydoubt@gmail.com,
        Git List <git@vger.kernel.org>
References: <20200907171639.766547-1-eantoranz@gmail.com>
 <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
 <20200909091149.GB2496536@coredump.intra.peff.net>
 <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
 <20200909191345.GA2511547@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <84ce64d0-996a-33f6-53be-e47120da81a7@web.de>
Date:   Wed, 9 Sep 2020 22:43:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909191345.GA2511547@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GgDVypMWkP+NkzPgD2Ggba3CLzPU4eYrZZIWZWn4K/tLjKVJrOC
 PtDyzJVvjFyczHN0xzULEXqcUrNk/GAaJhcrZGIg8Vrw6loapkbpuIVHA01xoaIEHWUk/C6
 C+16Tmy3TT90QxykmIrEax0qgpsjKujkd1qBiHWBo+UQ2RtmVJG8DDMsLiLP8UtWzToWxYL
 fzrXqjKswqYiq//K9pEHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f4X5Bcw0J3g=:6ilCr3DMCfJllkkSVOV74C
 gz4aoNocJBVfniGzGQIYbLWqISgWcpeI+tYausAa+Qmyt1hd0Ra04XqOEN1TB1Z4DU5A8OMXC
 MTuFmWYzczzV+Tiz++xNtbqG2Jmoc+IDdtvKmnuxhOVvO5HEN9Yp9daGwpdk8UG31CnW+Hl2p
 03hoTGIkrHKjpbsglK5iplBylEuvkZklBDHXCrXn/we7GDi22XGdBNoNOZoIj8Bh4QD2H8LLa
 zwnZgPoTZBb+j/l5AW/sTbJb387xuw2+VhK+0uOJdYlZcy1VWxcGX6KN9UchuxzBWnlOWKTCp
 L8cOaS3dmM42ksJhyUgsLcKHm+xJwTf+ESG0wSgYWJx0IaAjcWcPmVutSDH5UxqtGWkgkWhsN
 lbFpjRcoRwlGuPz4OqfxqkK4HvWaje9UfR/9h2LRhyD8ktglXY8W8rt9KQyLQy6CE/1lJ8Y+Q
 YbSMsVAweHv12VO7r0AfDu0s+WXbsAf0cwuWrfzXnTf8/5VOKul0e7cROL+LQx8kH0gubGbbs
 XN8WT7slc9EsFHQ1GJWmEZXbm1sgdk6aCXyTKzrAQTrfEwGICSTokZxDImGrgYmKvCRTgV+zk
 qWNG3tsDAvmbmIZvm6f52U4nGy7N39jXKhXuYwWrxmzZOwP12a0wtihSVmcA1Hofa6OvwYKp9
 htSnKWhHNPrsG9Nws2E37239WLQ0KyWsq/dNcm/luq23D294v41PYW3c+IXkWyhaid+jzIFST
 6JCC2LRa4/KWXLbJsLR4x58cckaLT0D/VSoo4a+kf9w/5unzgZy4PLcNXhwgA08Ffmbcg1QNx
 ViwuN7/JOLnuf93cursb+BQc9l5KxgeMEhAQv0LaBd/wSuDJXo41mD7OfsLSyyg3iR8U0P334
 Iava1m02b6VRmxz3JKfGCwDd/HuhQnyLVMeovCS2sU+JzW78AN6ptBoAv08+SorJV5Kbu/p/0
 SRB5xa/e+DgxefGkM0yFoQS+55LJEeaEn2dOfFgqQbQPOKDSgoDt4liwXCeI8h/Vf50SwJUe/
 hr8hU54bBkFDLT02Z0U6ZOtdUzaI6fGG7ugpSOjKzBujpPQv3MVJUDbkQlfJmk+7e1jsQLRRJ
 Yf7XvcvK4viyAAo/EVb+bS10dAZOj02JwBb9Y0ABPJnxucus2QTBfi46oH0D2Q3hVO+7mwA0i
 CNkT0h81laFD4eHkDOrmSD2ZycuyBAWbVZruBJo6UWPguJUB/BExQKf+4JA3/RW9XouVEiaAj
 gPHoe0tOyzeAI9Gz6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.09.20 um 21:13 schrieb Jeff King:
> On Wed, Sep 09, 2020 at 08:00:57AM -0600, Edmundo Carmona Antoranz wrote=
:
>
>> On Wed, Sep 9, 2020 at 3:11 AM Jeff King <peff@peff.net> wrote:
>>>
>>> Yeah, it looks obviously correct. I am puzzled why "make coccicheck"
>>> doesn't find this, though. +cc Ren=C3=A9, as my favorite target for
>>> coccinelle nerd-snipes. :)
>>>
>>
>> I added this to contrib/coccinelle/object_id.cocci in v2.27.0
>>
>> @@
>> identifier f !=3D oideq;
>> expression E1, E2;
>> @@
>> - !oidcmp(E1, E2)
>> + oideq(E1, E2)
>>
>> And it found it:
>
> Interesting. The existing rule is:
>
>   struct object_id *OIDPTR1;
>   struct object_id *OIDPTR2;
>   @@
>   - oidcmp(OIDPTR1, OIDPTR2) =3D=3D 0
>   + oideq(OIDPTR1, OIDPTR2)
>
> The "=3D=3D 0" part looks like it might be significant, but it's not.
> Coccinelle knows that "!foo" is the same as "foo =3D=3D 0" (and you can
> confirm by tweaking it).

It is significant in the sense that "x =3D=3D 0" in the semantic patch als=
o
matches "!x" in the code, but "!x" in the semantic patch doesn't match
"x =3D=3D 0".  That's because coccinelle has this isomorphism built in
(in /usr/lib/coccinelle/standard.iso on my machine):

Expression
@ not_int1 @
int X;
@@
 !X =3D> X =3D=3D 0

It's a one-way isomorphism (i.e. a rule that says that certain
expressions have the same meaning).  So we should use "x =3D=3D 0" over "!=
x"
in semantic patches to cover both cases.

> So the relevant part is probably that our existing rule specifies the
> exact type, whereas your rule allows any expression.
>
> And indeed, if I do this, it works:
>
> diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/obj=
ect_id.cocci
> index ddf4f22bd7..62a6cee0eb 100644
> --- a/contrib/coccinelle/object_id.cocci
> +++ b/contrib/coccinelle/object_id.cocci
> @@ -55,8 +55,8 @@ struct object_id OID;
>  + oidcmp(&OID, OIDPTR)
>
>  @@
> -struct object_id *OIDPTR1;
> -struct object_id *OIDPTR2;
> +expression OIDPTR1;
> +expression OIDPTR2;
>  @@
>  - oidcmp(OIDPTR1, OIDPTR2) =3D=3D 0
>  + oideq(OIDPTR1, OIDPTR2)
>
> Which really _seems_ like a bug in coccinelle, unless I am missing
> something. Because both of those parameters look like object_id pointers
> (and the compiler would be complaining if it were not the case).
Yes, seems it looks like coccinelle gives up trying to determine the
type of these things.

And while this one here matches the example in blame.c:

@@
expression A, B;
@@
- 0 =3D=3D oidcmp(A, B)
+ oideq(A, B)

... and this one does as well:

@@
expression A, B;
@@
- !oidcmp
+ oideq
  (A, B)

... the following one doesn't:

@@
expression A, B;
@@
- 0 =3D=3D oidcmp
+ oideq
  (A, B)

... and neither does this one:

@@
expression A, B;
@@
- oidcmp
+ oideq
  (A, B)
- =3D=3D 0

So it helps to try some variants in the hope to bypass some of the
restrictions/bugs/misunderstandings. O_o

Ren=C3=A9
