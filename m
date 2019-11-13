Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6D21F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 16:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfKMQtR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 11:49:17 -0500
Received: from mout.web.de ([212.227.15.4]:33999 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfKMQtR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 11:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573663749;
        bh=zSTfXiAKXWBynngsI2NWk/cDYIcUTzd7B3wXe6IA0rY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ROG4t9xENCBZWBRNUnnrbQU8JefyJqBh9f3Vc260ASo+d/nrAvvL8LZN9J2/HkZ2F
         bCpUp0+9mAWO9ASuyjvh4dHX538cttoWZCAWmG5zn7qaSbJHvhbBaKbVGlZY11fvRP
         jmdhZGpAOlwH+mcgRGJ+RL8bd+A0KEyXeqracs/w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMVpO-1iWZSd1mYg-008Mqu; Wed, 13
 Nov 2019 17:49:09 +0100
Subject: Re: parse-options: avoid arithmetic on pointer that's potentially
 NULL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <39a0b622-f725-9284-ea50-19cf4078209d@web.de>
 <xmqq5zjocx7i.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <df941c25-22ea-3523-9607-8e892dea320c@web.de>
Date:   Wed, 13 Nov 2019 17:48:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zjocx7i.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SUOJokan/bVQMMzwls/iN/pp0vgvPHbHfwJmnGkohH2jDbdMDOI
 gWxw8M0b2iY6tyQ+NOYCAKzrBdz36+NiOAPOEYNqPO3FwD2oMdmK0KQMQWemX2Sm+6PjWea
 mgRcRb5DP3vyADvIIt9lvEQf9+UTybEIIot/a3Rmt2iMxPI1D0KPjEzlbZV5BCjGG/8ydwx
 1xV/MDXTl5RfyPn6ajE2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e2uL6LDgOVk=:Icf+Zr+C8RFJ9Y5Lf+2KNy
 eKT8sJuyPwhALEfh7yznpITPnX2Acu/CUb8xrmFXyR71x1Y3tmiQ4rng5sd/jT40GZ0NH63O3
 IWrgQkODCSxWC8TmM9DepWS+DfWgHg+zIYiLNPqm8HohxwR5YV1MpiJY6+lyaaT90AbPDEDos
 Li7SPMyJCCgNvm85b9af9/rkKIMNe3pntraegCmI6k9kIqyR/Gs7Efbp7bRWCM4qxpfW91haF
 FM29I369tg0o7vyjAZVUs7yofTfHEryFe92jW59re3zm/BqCDGpdajamwq8YLHn5ydzBSf5ju
 KOPQJyw/1q70y+/phjNZHSWRh6H2jQ3v6PXD3mV6B42kTM9yRpn1bzpoRoFU4OToIxDLdA92u
 DE0vyXMw+OC3KxA3I9c1pX95WNaLVPC5ttLO3qcMk29Ihmduio7jss9jWbLI9tsBcYtlQFHEw
 q1e/aqlOi+AzBjFvJNd5DJxAUARxFEpcp6cPuechtjl3VxcQbVDlsidAiyJz2A7uS79ejJxn8
 q3A+3xSqAX+Xn6JaFa1oM6c9ebEVHxrleg+58kcREsx7r6VoEGj3d0j6DYjWCQgjvmpDiMGZo
 lngSgbTbbRgEJJ6sLWl6ZzNqFPwemwvXEV4x7ZpJMPgKdDKW1ZUYRxGV6kLS5MWJnj+3Tuzep
 O5fVIGZ6eOv9qVZmEgsYAEdZC3CxSmD2u2NfUZICS1l5FKwGxL0yeB2KdEEE8KPwWBB1TmRw9
 SDWUH+K7v2zkI8BluF6sAUdsPwZZ8iUd6AbdTB7cyZb4H63UIA6YqEBpvz9U4Xmh7LJPxGazS
 qMR/dcSNlV/70EkjOeaWn6QNQ+4aZEVpFGk/Sx2iDq3sr9fUXZWvr8EWm+fSGWkloUn0qoYav
 D6DfERdmkMoAynfMfX4Xes+u2dWVvM6DRABE0H57KXrsvGSXOoAgV1hR0r5BACxdiXjhyvLz7
 jzfMqCVQtG9lJSVmXIJf2tkTk+nVi6SPwsHjEU8nveUcWTwtp02julHRR3RrixXj3tgNUHwY/
 FaHS4m2nX6xfC+puVJL5kmVuyrFEkNX70UYBnpwzLAUYo62ZBxjcHI0WU3DPeAxMxqOpIOZho
 FCw7R+3jeBE1L80adLpDSpsiZ8gp+hG7MwJvVdcb7g5xIwwyYSwEFDQePgRCkCXwg5Plhpg49
 e1CQbCGZtMQBFaAhZpBjygtN9mxAzv8oQ4EOfnHa0lF6w/rQZP3L+xcFVmz8fi8zyAtZLINSo
 7U6EK7Pk8LjAHDEIzvziNutO3Ej86DzJxzH/lPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.11.19 um 03:43 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The function is also prepared to handle a NULL pointer passed to it.
>> None of its callers do that currently, but this feature was used by
>> 46e91b663b ("checkout: split part of it to new command 'restore'",
>> 2019-04-25); it seems worth keeping.
>
> ... meaning it was used but since then we rewrote the user and there
> is no caller that uses it?
>
> Gee, how are you finding such an instance of use?  I am quite
> impressed.

I wondered why the function checks for NULL, noticed that both users are
in builtin/checkout.c and pass a pointer to a struct, so I ran
"git log -p builtin/checkout.c" and searched for "=3D NULL" in its output
because I suspected or vaguely remembered that the options were added
one by one by a patch series.  Sloppy, but good enough in this case..

>>  struct option *parse_options_dup(const struct option *o)
>>  {
>> +	const struct option *orig =3D o;
>
> If I were doing this patch, I'd give the incoming parameter a more
> meaningful name and the temporary/local variable that is used to
> scan would get/keep the shorter name.  IOW
>
> 	struct parse_options_dup(const struct option *original)
> 	{
> 		const struct option *o =3D original;
> 		struct option *copied;
> 		int nr =3D 0;
>
> 		... loop to count ...
> 		ALLOC_ARRAY(copied, nr + 1);
> 		COPY_ARRAY(copied, original, nr);
> 		...

Right.  And I just rediscovered an unsent patch series from last summer
that refactors this function further.  It fixed the NULL issue as well,
but only by accident.  Will rethink/reintegrate these patches and send
them later, but here's one that's ready and fits the COPY_ARRAY theme:

=2D- >8 --
Subject: [PATCH] parse-options: use COPY_ARRAY in parse_options_concat()

Use COPY_ARRAY to copy whole arrays instead of iterating through their
elements.  That's shorter, simpler and bit more efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options-cb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index c2062ae742..8b443938b8 100644
=2D-- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -188,10 +188,8 @@ struct option *parse_options_concat(struct option *a,=
 struct option *b)
 		b_len++;

 	ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
-	for (i =3D 0; i < a_len; i++)
-		ret[i] =3D a[i];
-	for (i =3D 0; i < b_len; i++)
-		ret[a_len + i] =3D b[i];
+	COPY_ARRAY(ret, a, a_len);
+	COPY_ARRAY(ret + a_len, b, b_len);
 	ret[a_len + b_len] =3D b[b_len]; /* final OPTION_END */

 	return ret;
=2D-
2.24.0
