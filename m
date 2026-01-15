Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363E324705
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516022; cv=none; b=VZA0f3UkPHXOQDRT2CECo/wuiug/oXSowb5pxoNBqfgSELDkbUwkUeSbfG3Ydj/HfMNkHSHaHozK9mm/xOdiZ3qkM4Rbp70+ZuH3sZicDQyMrQMNNZLxwFegYZyHtgmoh9VBQXzMMqMCLlMDAfoKPykuG5t0DGJ+Havhaoq+cfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516022; c=relaxed/simple;
	bh=41DdTNcBTbfItvR/l/U4SsT2OQxxZAhSThGx0BcgbAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtWqeqNwb6e8hALcRT+vCiMogazxU+ZwZ5VJpR9pJoBHObPmKC57+Dd4YUCAaMhd18n2jaI6OO0llDytCJxqGO9uGm4g8VuWc5Ue3MWKNW1Bpe4C/F6XqUFkoCeQJW5yJOR7gIfsUUo6ccDB4ahf/ViOZkDxwE82eDpBEwqqchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eUKiiMD2; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eUKiiMD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768516010; x=1769120810; i=l.s.r@web.de;
	bh=EajvVZuM7nYGNpgVEM8i5O+3/bN4OzbHkrT09tvmHEI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eUKiiMD2tM1lqbW/F5rbFIvrG1DMciYJR53z+OHO6GcYvVVJQz6dVGVEojXmDCll
	 IY5k5IlC9zpuadyKufCIN+GEK42p40DX26gs94hHXsltT4dVOSMvu00nEgkHilzpO
	 RqTZKXTvTzTguMsLjnLD8MT44p993g0j1ItkvrqHgb6GuPQ/SuQ0OHTYjnICErAAF
	 /Lncq8Gr5i5EODW49S+Z7lhSe19hSlOEWr32griEMZBH/ZolGvGDUA3w8omDHsgjd
	 J93BCLxS7wD3S/L2qGF8iqn7zxHgsQqogmrFyI42KDX+GHx09P5C9Ol0FGLIOW2EB
	 10DI2QS4oodsKet/5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1wByvo0THW-00lRH3; Thu, 15
 Jan 2026 23:26:50 +0100
Message-ID: <fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de>
Date: Thu, 15 Jan 2026 23:26:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
To: Amisha Chhajed <amishhhaaaa@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, stolee@gmail.com, newren@gmail.com, peff@peff.net
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
 <20260115130935.93526-1-amishhhaaaa@gmail.com>
 <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ZXFbcQe0FGyci9FgJbGCD7gyoJvmgKr8mZcBGXrwc0OInVVUIF
 cCWVbH8qkfH9QHmONNV3q6D8okzvZjLuHSNa5pqb/bIk9j2TmxwYSXRPBX2WRhcdEnSk5A1
 x5z24XyfYO0X+xtbu7i78L37xHfkikyW0+BQSxF3f/Lu/Dg/Ix/LO9CziCZ8etwaB7Q/oPP
 ma0Xbu6Kg17XS/FTtiZEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KtV/30APaRo=;ZeiQTMbP+Yr49YSDTJ4WdvIkXVX
 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

On 1/15/26 2:15 PM, Amisha Chhajed wrote:
> Made the changes for other 2 places as well!
>=20
> I was also very curious about the presence of
> string_list_remove_duplicates in the original code, from my
> understanding string_list_insert already removed duplicates and
> string_list_remove_duplicates was still present with it.

So the string_list_remove_duplicates() calls were unnecessary with
string_list_insert(), but why is it safe to remove them now that you use
string_list_append() instead, which doesn't check for duplicates?

>=20
> On Thu, 15 Jan 2026 at 18:39, amisha <amishhhaaaa@gmail.com> wrote:
>>
>> Improve O(n^2) complexity to O(n log n) while building a sorted 'string=
_list'
>> by constructing it unsorted and sorting it afterwards.
>>
>> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
>> ---
>>  builtin/sparse-checkout.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 15d51e60a8..edabe7cbd9 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -91,7 +91,7 @@ static int sparse_checkout_list(int argc, const char =
**argv, const char *prefix,
>>
>>                 hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe=
, ent) {
>>                         /* pe->pattern starts with "/", skip it */
>> -                       string_list_insert(&sl, pe->pattern + 1);
>> +                       string_list_append(&sl, pe->pattern + 1);
>>                 }
>>
>>                 string_list_sort(&sl);
>> @@ -289,11 +289,10 @@ static void write_cone_to_file(FILE *fp, struct p=
attern_list *pl)
>>                 if (!hashmap_contains_parent(&pl->recursive_hashmap,
>>                                              pe->pattern,
>>                                              &parent_pattern))
>> -                       string_list_insert(&sl, pe->pattern);
>> +                       string_list_append(&sl, pe->pattern);
>>         }
>>
>>         string_list_sort(&sl);
>> -       string_list_remove_duplicates(&sl, 0);
>>
>>         fprintf(fp, "/*\n!/*/\n");
>>
>> @@ -311,13 +310,12 @@ static void write_cone_to_file(FILE *fp, struct p=
attern_list *pl)
>>                 if (!hashmap_contains_parent(&pl->recursive_hashmap,
>>                                              pe->pattern,
>>                                              &parent_pattern))
>> -                       string_list_insert(&sl, pe->pattern);
>> +                       string_list_append(&sl, pe->pattern);
>>         }
>>
>>         strbuf_release(&parent_pattern);
>>
>>         string_list_sort(&sl);
>> -       string_list_remove_duplicates(&sl, 0);
>>
>>         for (i =3D 0; i < sl.nr; i++) {
>>                 char *pattern =3D escaped_pattern(sl.items[i].string);
>> --
>> 2.51.0
>>

