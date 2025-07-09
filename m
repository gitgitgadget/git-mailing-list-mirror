Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA73156F4A
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073555; cv=none; b=GZv27oWKK8+vR+ucj7qAEI8YG7iYJK6pk4R5Qb4dxpI8pYdhqXN5WILyKv8aYj+eX7sf4lFLQI0kqrjM456aI0+MzKj3M3E8YLodvjbqUcXAM87V45h9wbfmRXrCvTtdCZTQiRZq9YGLlCUOXvEitYBJgYq5C2lMdoxvmusZWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073555; c=relaxed/simple;
	bh=80idWjcU1hTby1VorWfvG77FThhRytbaVhhEoDKRYPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5uQ3N6Fr2vagP+pbY6i+GLtlUf4NQU8qGduoWNBwFz7cQXU+DQuma4vg7fRNFKCGGZ0XdjaJutEXvL1ZCiSh7IiRAlhnC3VkbhZZaK8eMyqRUirTJTSWZuPjJ3JmDpIKovHhIaw3UJlVWSNvfTELzPXH45o3Fcm3jOexKYqbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=MXQTF30B; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MXQTF30B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752073537; x=1752678337; i=l.s.r@web.de;
	bh=KvL8AFNF85ElE4j9X48qiWgSnBoREtJmRtqIRfjwb7E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MXQTF30BQNmM/KKZOUd1NIxU7dv2upR2oRcvrR0oz9XhFPwdLRaWOHDnhlWscuL7
	 HbhKFaGXTFcDTRmMHD9a8GmmVSeWbBLaL9aU5IJSu2B4fmbRZy6IYfazzFfgeOUSb
	 ECymYqaYVH55egcwevAMgCcQL5qV8jkxxaQ+k/8vOqxFMP1k3tHcZzpbdrW84fhky
	 LQRr8UmrEDCnxE+7Q2fHGiNbiYmTrfAjwqpgPPKk8NGtMaDSgTo+3bWIMP4ZhP7Us
	 3bRIiMik3V50YlseBaAdiuHEPoA3DX3zR8DE6VfxT6qrpZYPwVgmrCgazSi40G/mQ
	 ztn0IMkIE7EwDF5zLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1u8g5a29De-00KiPB; Wed, 09
 Jul 2025 17:05:36 +0200
Message-ID: <144ecb24-4da2-4311-bf26-3101788f4b12@web.de>
Date: Wed, 9 Jul 2025 17:05:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
 <77b841ea-eab1-4e76-98ff-f7a16653fcb8@web.de> <aG51nFpH6kMT95uf@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aG51nFpH6kMT95uf@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9jk8AYxDcVsOSEhVKH2clMjW8fI6ULVL2chZobKqE/4sT8pBBPK
 THdsdwNIRhYZBA1ivJ+/OPh6aLELKwPagfk6Q8Uyp1ekQ9CZ55IZPoRqc0A4VF5R0Fb3QNd
 lVl1z3TtHFC0ywZj6QxVPunJ0Beeq5pnTK/IlMl12PUG1EOkLEidAJVQHufyqXv7mMjp7SS
 4B2s11El4Ir5Zrr3rQidw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cq6VHOIOr7o=;z8816FcmYUHWtQ9+QTDGM0iAcxA
 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

On 7/9/25 3:58 PM, Patrick Steinhardt wrote:
> On Wed, Jul 09, 2025 at 11:45:14AM +0200, Ren=C3=A9 Scharfe wrote:
>>
>> Call the function that does the raw casting do_get_int_value() to
>> reserve the name get_int_value() for a more friendly wrapper we're
>> going to introduce in one of the next patches.

>> diff --git a/parse-options.c b/parse-options.c
>> index 68ff494492..ddac008a5e 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -68,6 +68,26 @@ static char *fix_filename(const char *prefix, const =
char *file)
>>  		return prefix_filename_except_for_dash(prefix, file);
>>  }
>> =20
>> +static int do_get_int_value(const void *value, size_t precision, intma=
x_t *ret)
>=20
> Nit: after the fourth patch we have `do_get_int_value()` and
> `get_int_value()`, where the major difference is that the latter dies if
> we failed to parse the value. It might be easier to discern which is
> which if we called them `get_int_value()` and `get_int_value_or_die()`.

That would be misleading because get_int_value() doesn't die() like a
function from write-or-die.c, it BUGs instead.  I don't think it makes
sense to advertise the presence of assertions in a function's name.
But we do have a tradition of using a prefix of "do_" with wrapped
functions that have a more raw interface and do the actual work.

Nit: They don't parse, but cast a void pointer to the appropriate type
and dereference it.

Ren=C3=A9

