Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337914F117
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009492; cv=none; b=OCMqcYXfsL1ialIpncASJC8stCt5plwXsuSATp0q5TxF4Z9vwpUwrjilZdlT78xR8B2dsQLFD7Vw3ArORNhzntpFEyxyBCanpVewjKD/zJkNNvfS7NFNDk8zPlkUCUtyf7RxY7eC8ltTiCT7o3FvCgL5gVs11nipnHfb8pTZbWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009492; c=relaxed/simple;
	bh=+Higey/vouXcnH3ydi/g5RoOaj2SwP0lE+CCME4XHGA=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=gw7Np2mHWXGO0xbPS6sJQtoVjbjgDwfwfgI1Uacys/4HTERRUqOvih21GL1ySrc8+a/eE2aJ1t+wGpYCfE3t4NCW6VULTg57PUhuQwqOD5bsbNm3ABRkNFEIINa0NV8Iv6kMV4IZqZ7rLw6sBm7SKCtJU+bcf1+WpUBqfISyhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=JMzFkXoQ; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="JMzFkXoQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=qkQwRbApyUqA91ngB5zuK/C6UhYsxWgsQR14TUWhWm0=;
 b=JMzFkXoQdahOkojYf3J6J7QokZ1xLZCSFlmx/P63CDWHY9/MD+pQ5nXwfGcPRS4ZCQPbWww8oQmo
   Vc6dLHFcFXz4JkgE/ER+OWH3HS3M/v+kB3c4DpncULjJoq9+2IBtSVXVXuzCLDqhZzUU/Rr2B888
   hcAwKT6XQvYMoqkPRvOjlq0PSpLTJEXCpXtqjNazoCzNsNfXGMkVqv525RgwP7LvrdosWgNUJmjp
   a3ta7AyYE7vLP2wEd2OjDfRF6asxEj+HEXm2Rger0yktyytyo224XqIqsi0UJjEraobVLI8PCfrg
   1/jS/GWq+z37w2n/RUhUV7y3NGpHDdm2YwUc7A==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLE00IKXO9DTF40@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 15 Oct 2024 16:24:49 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 18:24:10 +0200
Message-id: <D4WIP42OSINN.VGZI7YIMMK8S@ferdinandy.com>
Subject: Re: [PATCH v8 1/6] refs: atomically record overwritten ref in
 update_symref
Cc: <phillip.wood@dunelm.org.uk>, "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
To: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com>
 <20241014225431.1394565-2-bence@ferdinandy.com>
 <CAOLa=ZTMzz-9XE8AY8vk7Gpbm+U0T-5jWNJzKLyd621_URiDEA@mail.gmail.com>
In-reply-to:
 <CAOLa=ZTMzz-9XE8AY8vk7Gpbm+U0T-5jWNJzKLyd621_URiDEA@mail.gmail.com>
Reporting-Meta:
 AAFCPtQWsvrvBUFHjZYINY6vpOcMsYrCgOcwz+OOugXhI2ID3H3c4Vtnzt5NeJR/
 kU9z0bg6ORCrC1GUIBP+Hs89+AoyL5MyAbTPsFHBq19hBMmigKQeWy0VgyzqFtR1
 SYuh81kv+Ptw0I5MaPDgIWTpsA8gxfGs6s9zhpOjOAUa6nj+j+TeX2/hmPqaAuvm
 RPJq7+QOpzvGHxtLkEjbnrQVVLhAAqDw88RzAMtQ0UOyVm1o1f7QkCTFKF+3quhN
 e4tWXNcHccaLPo8BPHn7sHTG61mR9uNsarLKemP/yit3BLUjS5vWh6RtnXxz9S88
 a/l8FIKZnAZxn1qmr5vERzTTHBdj1hbjuwCerjcefPPKEvomNv9CbMKE4Fl3hu+j
 pevo+P2ImyeZoB9pgKgSlhPQMKI5LAejVCiiyHKBaxzy6PWgul0LsBp4TCGt70Ph
 8J12qrK35Ra4ESfrtWgskb9Pjiti66mnSluBlZyYus4uScRshODqNj+tzQ==


On Tue Oct 15, 2024 at 09:41, karthik nayak <karthik.188@gmail.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
> [snip]
>
>> diff --git a/refs.c b/refs.c
>> index 5f729ed412..b964ac44d0 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2114,7 +2114,8 @@ int peel_iterated_oid(struct repository *r, const =
struct object_id *base, struct
>>  }
>>
>>  int refs_update_symref(struct ref_store *refs, const char *ref,
>> -		       const char *target, const char *logmsg)
>> +		       const char *target, const char *logmsg,
>> +		       struct strbuf *referent)
>>  {
>>  	struct ref_transaction *transaction;
>>  	struct strbuf err =3D STRBUF_INIT;
>> @@ -2122,17 +2123,23 @@ int refs_update_symref(struct ref_store *refs, c=
onst char *ref,
>>
>>  	transaction =3D ref_store_transaction_begin(refs, &err);
>>  	if (!transaction ||
>> -	    ref_transaction_update(transaction, ref, NULL, NULL,
>> +		ref_transaction_update(transaction, ref, NULL, NULL,
>>  				   target, NULL, REF_NO_DEREF,
>>  				   logmsg, &err) ||
>> -	    ref_transaction_commit(transaction, &err)) {
>> +		ref_transaction_prepare(transaction, &err)) {
>>  		ret =3D error("%s", err.buf);
>> +		goto cleanup;
>>  	}
>> +	if (referent)
>> +		refs_read_symbolic_ref(refs, ref, referent);
>
> Shouldn't we also check the return value here?

My reasoning was that if this fails referent will just look like as if it d=
id
not exist. Since this is an addition to set-head and fetch failing to set t=
he
HEAD in a case which would have previously worked I did not think it pruden=
t to
now fail on this for any reason.

>
>> +
>> +	if (ref_transaction_commit(transaction, &err))
>> +		ret =3D error("%s", err.buf);
>>
>> +cleanup:
>>  	strbuf_release(&err);
>>  	if (transaction)
>>  		ref_transaction_free(transaction);
>> -
>>
>
> Why remove this whiteline?

Looks like a mistake made during rebase.



--=20
bence.ferdinandy.com

