Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4060C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 09:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiBQJ1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:27:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiBQJ1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 04:27:16 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22317E965
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:26:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x5so8443095edd.11
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nea6II9p3i9EC07oR6mcqgXAwYvYr3HG98BcO+pqBZ4=;
        b=HYltSJ0T3Z/bbdBcDeb3F2EH9F4QhUzWyYsuImHUCoTQ08EXLQFTh9X30sIIAkJn7y
         7P3i1o31aJ8YV6+1PRRrMh53bcAFl2IZM4OiadOAL20v/NziX+eLBQYwB4k6uk4dPouh
         M+rCHhyaU+VZbZS3T5+cKNZKhcrU3KMZMGTTf2zNhjNEf9gSSUPJ3+3EYuG4pGKnovJo
         a8mO1rTdY2T0keBnmEXjuhDj4FSVyk03CgnxTmkAYrJNIH/H+X5Va6wzfOQLY1ugSoQ4
         7MHfeOk1MSz7DWGOAe/k6oGmw5MWnV8AX18Bjl85ai51w50ly/Dom/hVFlALnm4QLz2O
         ithQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nea6II9p3i9EC07oR6mcqgXAwYvYr3HG98BcO+pqBZ4=;
        b=6YqSIqi/fcm26b+Hp0T48NBPL72Hj+mav3ImowLrERPbo/IiugO2I8I6hSf9SXbiGn
         lodYIcKSRj52uFGICwr6CsQBvhQerxgt6T5ilRF3aMmwR3ni8xDkLUPVfG3C1XPPNDTA
         /von5CTmhqpSixHp+d0CL0YFq0xu4Eh3MagY24MlQ6Xk6NFgYAeLe37qN+8qgInG0yML
         qcg/J/UTi6XwjTR/b0dBSZWmZXps2QRO+Y5it0cD+RiRMK6v1q+ZjRDMDn8P52ggqVXH
         x8Sl/BaRfoc9qVru2WE8+rUjnaCbaAptGpd/opK9eKgBocZAFrfuPNIh3OZz1zJn/dft
         Qt0g==
X-Gm-Message-State: AOAM533bN0zh8oKwbU9WwiE8ZV7oR/7TR394W7nzCuvgNWJCqCRqJJPg
        gxb2AGjMEJkiJgISp6+x19E=
X-Google-Smtp-Source: ABdhPJxQBx2iFI4HOSi62OgGD3bpXEDdHrAk0XAUzM0T9vEzOcXpFEd0hRNCijrYSAO8nEqAji3JXQ==
X-Received: by 2002:a05:6402:4311:b0:408:71a7:13aa with SMTP id m17-20020a056402431100b0040871a713aamr1622213edc.54.1645089930540;
        Thu, 17 Feb 2022 01:25:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s1sm773544edd.100.2022.02.17.01.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:25:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKd2X-003fih-IK;
        Thu, 17 Feb 2022 10:25:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 03/12] object-file API: add a format_object_header()
 function
Date:   Thu, 17 Feb 2022 10:21:38 +0100
References: <patch-v3-03.12-92fd020d199-20220204T234435Z-avarab@gmail.com>
 <20220217045943.30223-1-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220217045943.30223-1-worldhello.net@gmail.com>
Message-ID: <220217.86mtipj14m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> On Sat, Feb 5, 2022 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
>> index 2b2e28bad79..123df7d9a53 100644
>> --- a/builtin/fast-import.c
>> +++ b/builtin/fast-import.c
>> @@ -937,8 +937,8 @@ static int store_object(
>>  	git_hash_ctx c;
>>  	git_zstream s;
>>=20=20
>> -	hdrlen =3D xsnprintf((char *)hdr, sizeof(hdr), "%s %lu",
>> -			   type_name(type), (unsigned long)dat->len) + 1;
>> +	hdrlen =3D format_object_header((char *)hdr, sizeof(hdr), type,
>> +				      dat->len);
>
> Type casting can be avoid if we use "void *" as the first parameter of
> "format_object_header", and do type casting inside the helper function.
> [...]
> The return value of `type_name(type)` has not been checked for the origin=
al
> implement, how about write a online inline-function in a header file like=
 this:
>
> 	static inline int format_object_header(void *str, size_t size,
> 					       const char *type_name,
> 					       size_t objsize)
> 	{
> 		return xsnprintf((char *)str, size, "%s %"PRIuMAX, type_name,
> 				 (uintmax_t)objsize) + 1;
> 	}

I don't think the casting in the callers is bad, in that for the callers
that do use "char *" we get the compiler to help us with type checking.

Using a void * is something we really reserve only for callback-type
values, because it mens that now nobody gets any type checking.

I think if we wanted to avoid the casts it would make more sense to add
a trivial ucformat_object_header() wrapper or whatever, which would take
"unsigned chan *" and do the cast, or just tweak the relevant calling
code to change the type (IIRC some of it used unsigned v.s. signed for
no particular reason).

But I think just leaving this part as it is is better here...

> [...]
>> +	if (!name)
>> +		BUG("could not get a type name for 'enum object_type' value %d", type=
);
>> +
>
> The return value of `type_name(type)` has not been checked for the origin=
al
> implement, how about write a online inline-function in a header file like=
 this:

Yes, this part is not a faithful conversion on my part, but I think it
made sense when converting this to a library function.

The alternative is that we'd segfault on some platforms (not glibc,
since it's OK with null %s arguments), just checking it is cheap & I
think a good sanity check...
