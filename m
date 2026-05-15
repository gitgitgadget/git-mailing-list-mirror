Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B32FFF8D
	for <git@vger.kernel.org>; Fri, 15 May 2026 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855785; cv=none; b=CnqwuTzqbfoEi7uPOCb8cF7wFarBCn0lmFtOKi1zy9+RzzZktB89e3bKhhl8mtvN2vHw230TQtLe7BNrB6+QZlSEBJmzKBxWu5JNn9+3c3P29vyniSRiZeU78ztH7GmoPIC5thapCWtIel9eOW4ePC2nW5Y7Ye5WPxdR1LOebEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855785; c=relaxed/simple;
	bh=PP6DMTKjxgZMJktCJ1xbY7pNVppQipIIr4l65oxR7DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MALdTfxozSwxwPYi82W61N+Ccu99xWl1RZPNm+01ceQCoyWY6nmFEbZZyCi8tYJpeGPL56ZMKJd5dHCXHwN4qAXhUvouKyMiY8LiPLfXzhaGk7fEa3TjUDayDC9WaBmXqdYfS5MzMT82ocNP4nFGPfwvxJztO2nDzMUqQnliCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wS+A/fVK; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wS+A/fVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778855776; x=1779460576; i=l.s.r@web.de;
	bh=Fov9wJ/y9BZmon8lSk3pevjywyl7W4UVLNJBW5zCUC0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wS+A/fVKgUBCRNbWPGM7MBzlIm61tQlPvIh1P17Y1a1VgakksqdxSUHc6MYBuW4m
	 glUlwnvfWETtDuMBgSe08VoPgbT1nILt2YoYzmCiuUmAhOM9ZeL6Nc0ZGw6Wj214U
	 TE4ZLCqwBFwF42pDkSII+O0PB5g6/edWZ69V3+K2tcuv6p1lkU8bmapzBblZ/8rwH
	 o8V2dmrnfVStESKshjSXbVxxv/WcldjfGpj+nkl0wTibFI1/vpPRNfMHm2Jecdeto
	 DUFO4NxMWohB6suScPmiF1uFqMhWm5mG39rqMUZ9PFmqEOrh9O0TPX3XMdpfXK9Kw
	 iIJEASjEiwWSUXBlqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOlwp-1wkEue3mNb-00S0AO; Fri, 15
 May 2026 16:36:15 +0200
Message-ID: <26b71f9c-0cc5-4bfd-9175-f45b584e202e@web.de>
Date: Fri, 15 May 2026 16:36:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] use __builtin_add_overflow() in st_add() with Clang
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <0ded6062-f66a-4713-af24-d1b5aa654823@web.de>
 <20260515044059.GB83595@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260515044059.GB83595@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BBTKIDkv1qMYyWGZojHnHVWuseiE1qhK5SsWUpXwuKH2SgIxJ/m
 cqAFS6qAC/jFffu8Q9Lb7qzoAk6bcQKQkTQM57VOxKZVmsE7wB8yFxRpoJXhsrk2UhkFPSW
 juVg9GFVQL+Id4Rb2gH8TR+2YSZpruBc22s+cUa775rifDQIie9uYti7kMcvRYX9oWmfZ6T
 iXBHnyge9wVmml/VXKaKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cT8+3VhzjFw=;BgD/aGNVuELDlrEiiaoq45RgP7N
 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

On 5/15/26 6:40 AM, Jeff King wrote:
> On Thu, May 14, 2026 at 05:13:46PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Clang and GCC optimize away comparisons of overflow checks by checking
>> the carry flag on x64.  GCC does the same on ARM64, but Clang currently
>> (version 22.1) doesn't.
>>
>> Provide a variant of st_add() that wraps __builtin_add_overflow() to
>> help Clang optimize it.  Use it on all platforms for simplicity.
>=20
> OK. I probably would have just used the intrinsic everywhere with
> __GNUC__, but if gcc is already figuring it out, it doesn't matter in
> practice.

Did that initially, but found it hard to justify when it has no benefit
and reduces the test coverage of the hand-made check significantly.

>> +/* Help Clang; GCC generates the same code for both variants. */
>> +#if defined(__clang__)
>> +static inline size_t st_add(size_t a, size_t b)
>> +{
>> +	size_t sum;
>> +	if (__builtin_add_overflow(a, b, &sum))
>> +		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
>> +		    (uintmax_t)a, (uintmax_t)b);
>> +	return sum;
>> +}
>> +#else
>>  static inline size_t st_add(size_t a, size_t b)
>>  {
>>  	if (unsigned_add_overflows(a, b))
>=20
> It's a shame we can't share more code here, especially the die message.
>=20
> I guess the ideal primitive is probably a wrapper with the same
> interface as __builtin_add_overflow(), which could then be used
> everywhere that unsigned_add_overflows() with some minor conversion.

Junio said the same. :)
> But it gets awkward to do as a macro, and using an inline function runs
> into type questions.
Indeed.  If it was easy then this wouldn't exist as a builtin.  We
can approximate it somewhat, but will it be robust enough?

Ren=C3=A9

