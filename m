Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B8A194A68
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929902; cv=none; b=L6w+x2A4cOV9Y7Bgl1tqRS09FU0IoIchXGyr7pBxK7Ysm90pujv4mV+lmE8KzROMSKn3zATOnVPFH1vsjIIfGDlQK1b/6hGR8ATNgItFTDklmgnXzJ0DQJDr/beUULq34tCmRji7NGOXK4tuMPUvK080+qzYScXFLas5IiD34bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929902; c=relaxed/simple;
	bh=PVsAPiUzY2UeQ56HzNlVAEnY+Ysnl3tY1fMKDt+xzvw=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=KxMDQh5tXKQthVWSEHi/tFKDQdtAiy4h1My+++yyR/9mefQoH+Fx3XalFiLRrP+BbTvmzTOtMpFjtokuLX6iji8z51C4U0vjRTrqHd4dKdjtrtP1xq7pafaDsyzz2vzO3p6C8h7RNPTWVRUTWFV7mhet9jI2GD+t7bzOEfd0BVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=KY9sReme; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="KY9sReme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=LZpSGNKFNU5s2UAQfnV4mErrYYMiJ4loi23P4vvcnlU=;
 b=KY9sRemefqeOA/kkS/D9Hns0yYPQu3rylRP+XqxPCIn3ZjBOy6TQqldT0ZMcsLAG8SqSug3C8VJt
   cuVJu6ALsst7AiH5EdsjHAu8RZdQvoXQpOpyWc5QM6Rgw0/f4CKTnfVkNg1IwFSpmSc2BtWf47Ua
   WULxESDn4kBueg4pVAGCASHk3Y2HJMPHng6eaBqmsNtXjPFpXBZxftF4Mu6y0GeZoVFFKI/JsD/o
   ldSviGMtv8B33EbWo+NNsxqY6yEwUjEHXpAgfD/iOh5jYgkR/gve5762hoGVC+B+UrShMzyV+mwL
   GobQh7rMypz44WjTFf/y/rCEbmTMi3SzPbDtrQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500M009NOXIB0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 11:38:12 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 18 Nov 2024 12:37:09 +0100
Message-id: <D5P9VVO3AN4K.3DKPEVZW6C911@ferdinandy.com>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
Cc: "Bence Ferdinandy" <ferdinandy.bence@ttk.elte.hu>,
 "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
 <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
To: "Patrick Steinhardt" <ps@pks.im>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-3-bence@ferdinandy.com> <xmqqr07d11wt.fsf@gitster.g>
 <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu> <ZzrrMrhRxOuB6QKH@pks.im>
 <D5P5FWL8I3SY.DPYSUTU8GAYJ@ferdinandy.com> <Zzr50O7AkczbqIo7@pks.im>
In-reply-to: <Zzr50O7AkczbqIo7@pks.im>
Reporting-Meta:
 AAF63nW88HVX71r4DdBOt1fAlDkN+3qZ6wsuTN9ioWLhAyyTkSRWe/NNs7LrBk2K
 DvXjc9GzWB9k8H69jLgLdcFQVhAK0V+xBfaESGdIPOyoqnIyvxhEnDkcXtZZxoEh
 kt8x6GsFziFpevxVrH+JJpdgS0VVrEU7a+skos88v6Msu74Qrpkcv6RZHNMWU6PX
 fDr5TodkkiLc08zqezWdeGrIApE+OHQeZtPQaePyCB+0LLMt6og5O2QNxTk0Sn4v
 qJxHNtOXTVLOpN1S1sv5iv285g/DgmieyRWdfEInL1axHIsxIC/ZGG/wFMUjcKci
 jVrHiCYrP0AHL3yyOy60S4q23Wt3vRPiD+z3swp8BhrebxqNQqZuoB2Bzyut0Qq9
 /LgfF/InNn8oXTdXsA5+4q98Eo6VA5si3p3RaaOWWNRcyeupOBrlTQP4XANeJvy4
 hBjg7itqjLD7Cc8shciIXGpkRpnSu6cTqeA6Nz6WNt6ivZA6/240RPZh


On Mon Nov 18, 2024 at 09:24, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Nov 18, 2024 at 09:08:13AM +0100, Bence Ferdinandy wrote:
>> On Mon Nov 18, 2024 at 08:22, Patrick Steinhardt <ps@pks.im> wrote:
>> > This behaviour isn't documented anywhere, so I wouldn't declare it a b=
ug
>> > in the reftable backend. But what is a bug is that the two backends
>> > behave differently, and that should be fixed indeed.
>> >
>> > I couldn't find any callsites of `refs_read_symbolic_ref()` where we
>> > rely on the current behaviour of either of the backends. We do have a
>> > check whether `refs_read_symbolic_ref()` returns negative in "refs.c" =
in
>> > `migrate_one_ref()`, but that one should be mostly fine given that we
>> > check for the type of the ref beforehand. "Mostly" though because it c=
an
>> > happen that we race with another writer that happened to convert the r=
ef
>> > we are about to migrate from a symbolic ref into a normal ref. Unlikel=
y,
>> > but it can happen in theory.
>> >
>> > I think it's an easy mistake to make to check for a negative return
>> > code. So maybe we should adapt both backends to return -1 for generic
>> > failures and -2 in case the ref is a regular ref?
>>=20
>> I've been wondering about this when writing other parts of the series an=
d now
>> is a good a time as any to ask: I've already seen this pattern of return=
ing
>> various negative integers as error codes, but never quite got the logic =
behind
>> it. Why not just return the same numbers but positive?
>
> It's a matter of style, I guess. Many functions use the return value as
> both an indicator for error and as the actual returned value. Think e.g.
> function calls like open(3p), where a negative value indicates an error
> and everything else is an actual file descriptor. This carries over into
> our codebase for many functions, but we're not consistent.
>
>> Anyhow, the proposed solution sounds good and as far as I see how things=
 are
>> done in the code. I guess if I want the series to land I should just fix=
 that
>> as well, there are already a couple of not-entirely-related fixes in the=
re :)
>>=20
>> Two questions about that:
>>=20
>> - what would be the ideal place to document this behaviour? In refs.c wi=
th
>>   `refs_read_symbolic_ref` or with the `struct ref_storage_be` in
>>   refs/refs-internal.h?
>
> I'd document this in "refs.h", where the user-facing function is
> declared, and in "refs-internal.h", where the callback is defined.
>
>> - should I look into adding specific tests for this? Since the rest of t=
he
>>   series will depend on this behaviour it will be implicit tested anyway=
, so
>>   I don't particularly think it would be necessary, but I don't know wha=
t the
>>   general approach is.
>
> I had a look and couldn't find another way to test the behaviour because
> we use `refs_read_symbolic_ref()` sparingly, only. So I think it's okay
> to implicitly test this, only.

Thanks, it was surprisingly easy to do, I'll do a touchup of the other patc=
hes
and will send a v13 today with the fix.

Best,
Bence

