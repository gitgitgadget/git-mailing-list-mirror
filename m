Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79975EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGBQZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGBQZi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 12:25:38 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C868E60
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688315115; x=1688919915; i=l.s.r@web.de;
 bh=YhX34QA1fDap2eSk6OrFCBkXR2ggKHYDxnW4xDtHyxU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rNEmOeavfLAN5JMGXcdKp4iOlK6MR7w23CgH+Q9VwzlVZSLdD+3YgJ96tlQ8yrFscG+C1yx
 sd9xLjV1ft4qi9ZiTm9uCOCC7dvuisagZYZhFOXwghJ35FToxupsJ8S1amHqq3EqT08Xu5QfQ
 lNh0TKMm89w/4MO4UDGxsgamw5tTnSxPwtFudgdZskHJIKH6PqIhFUI3GYYD79zPP5bN9EF43
 OfuCIyODVBagtcPkF0qJRSLw61P/mW5ZwGVAGJAWWWh+nDga4QzuhCwEtF7Jgi23FHjvLhM6q
 +4tQIkfEVzbWy9WlY2Ki1cPboKr4J7qbUJ3E27JjbnMrALRmB+mg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.180]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myezp-1q5mAJ3SEX-00ysPN; Sun, 02
 Jul 2023 18:25:14 +0200
Message-ID: <df912fc4-601b-4d43-c6e4-aa5f74ec031f@web.de>
Date:   Sun, 2 Jul 2023 18:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jan_Kl=c3=b6tzke?= <jan@kloetzke.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20230701205703.1172505-1-jan@kloetzke.net>
 <20230702125611.GA1036686@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230702125611.GA1036686@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mJwO0EvzHKDQeqJml0XUqL1ZakXKuVtd5vS+1nHnLO2a/2uneKR
 iv2pJM+ort7sfhD5fIicqcEEvAWbSRjqfP46r4CL6QEj82DSCIdXwbHRxqW0av62vVBecSx
 pVnzV9sjfQfy6zyCO9jfUzM9nmnozo0hCm3G0ZbsEm2QaFe+5uGM+Egul+dSiXdHEYOv7Zo
 oCLrDm5+om2rjbFGgmSjg==
UI-OutboundReport: notjunk:1;M01:P0:4YJjnKcxjAw=;Q8N9oOeouBXxWf2FN6jHtJGaO9O
 5gpFy2yCSiRmGyXWjzvLdLR+Upnj1McahkOMs3H1R4YFz6SQxoghAoT089Iuh6tomHWOzvuZV
 Df3WgEUpbYd7VjWSslq7wGX7IU8oMH1sBlW7oYekP5Q8HQBpTD+vr3fPfwOu8VHSntBLzYtmq
 e8I6O9o8z7Z6YKAsi688aAO//jClq00BpFWXAm/ryzkACEHPPL5Ob+q4YF4VoouL+QoL06mnu
 jtuROzpxNsLXS83gz4eHOg+tHLigqi5+rY8wlv0YUY0EN28D9HU3JjWA2ltAmzQnLh48C1/HQ
 T6stHFG8G6F8NM4e+fW2IreApsM1uiPcT7PXBkfn4l0UBZ2QeMBvzxu1TdXiwJmxL6COIJ2cs
 dhAkEXwKohmZnRIeQhrZD2fDBJlJoqvH8pusa817tAn9Cl9y1Rv9wj8KuKqLRVR6RJe3pWyTi
 Kqx68G36I1N7C7CMczHW2X6KIYjAsrtecbfoSgXwxvInWOJj8WettVSm/PSU76JFxK2IvPd0X
 wEK8vbDQTeer4bOs/QQtxGRY6jCfhj1YEVAhqW0GReC9SnmMsK8NqEEOnSn9t5zl3XLdNoRnr
 Pxee5HbFsXVIQ0QiYPs4AqhsVFAGx0KBO6bacRVSKn4fiEbAhepd2vXDufJZOcLUFY1FGJkdZ
 +IcnxAWC6Nt3f6tt8MNYdN1g0tRsNyvhmfsE/i/+QuPrE1hUJzgUARyb0DBBwI62zYjpQNUKf
 rs3yrCe7FZV+0mXstEDVKKSBOjkK5MlKsth1pvs5jsPMrAaOzfiQKc1v3FIUxXWy8CqBjSdc2
 QvHWGPP5y7X09lU1n6iOW003Nfch7N05MYEDyhsxrAZrd+cYDsiRXSvrtp1O0IAiHo+nCzlTS
 1KLSczp6/kGaOBxLt+y+X8PVYnO6J/NHiM791oOx9VpFvoLakuIKW3vogBdd0yyo4qg7S/K+s
 nLJymv6G9ezIqDEVGPF5heacyJs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.07.23 um 14:56 schrieb Jeff King:
> On Sat, Jul 01, 2023 at 10:57:02PM +0200, Jan Kl=C3=B6tzke wrote:
>
>> @@ -2222,18 +2219,19 @@ static const struct object_id *match_points_at(=
struct oid_array *points_at,
>>  					       const struct object_id *oid,
>>  					       const char *refname)
>>  {
>> -	const struct object_id *tagged_oid =3D NULL;
>>  	struct object *obj;
>>
>>  	if (oid_array_lookup(points_at, oid) >=3D 0)
>>  		return oid;
>>  	obj =3D parse_object(the_repository, oid);
>> +	while (obj && obj->type =3D=3D OBJ_TAG) {
>> +		oid =3D get_tagged_oid((struct tag *)obj);
>> +		if (oid_array_lookup(points_at, oid) >=3D 0)
>> +			return oid;
>> +		obj =3D parse_object(the_repository, oid);
>> +	}
>
> OK, so we are doing the usual peeling loop here. I wondered if we might
> be able to use peel_object(), but it again suffers from the "peel all
> the way" syndrome. So we have to loop ourselves so that we can check at
> each level. Good.
>
>>  	if (!obj)
>>  		die(_("malformed object at '%s'"), refname);
>
> This will now trigger if refname points to a broken object, or if its
> tag does. I think the resulting message is OK in either case (and
> presumably lower level code would produce extra error messages, too).
>
>> -	if (obj->type =3D=3D OBJ_TAG)
>> -		tagged_oid =3D get_tagged_oid((struct tag *)obj);
>> -	if (tagged_oid && oid_array_lookup(points_at, tagged_oid) >=3D 0)
>> -		return tagged_oid;
>
> This code is moved into the loop body, but your version there drops the
> "if (tagged_oid)" check. I think that is OK (and even preferable),
> though. In get_tagged_oid() we will die() if the tagged object is NULL
> (though even before switching to that function this check was
> questionable, because it is "tag->tagged" that may be NULL, and we were
> dereferencing that unconditionally).

The check is necessary in the current code because tagged_oid is NULL if
obj is not a tag.  The new code no longer needs it.

> So the code looks good.

I agree.

Ren=C3=A9
