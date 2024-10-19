Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D905193418
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378479; cv=none; b=IRFZ7iL5yjJTUxMclgBKRb2Re0vHKp6riJxu/f6p4mZlfynrrvMFfivpHbPklh8GqrWm15zYPAlHZah6F5/k2mQyz2M8q6L09mKTBWtWDhL+BSZTLLbQ5bpyGf8D5P0z9XR//dYkYSNunrO/a09r2PeiIqsTrwo2B74Pu5ZbYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378479; c=relaxed/simple;
	bh=u9FeoWzgTf3Tewz50R1yZsuNpI2tDy8WeSjhJFzHU0U=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=LpO+RlkDToKiy9IOI8n/OASl+u3hzJfeFc7lw+pEOWXHQt+113y66JbWhHg7X2hXiNgEcCr+r76My8UJVC7TlynTYYmneJ0gkDdPR5WRD7OWNZIlmvlCI/+XfbwZwnXK4hfin39SUfov0o6qKrcwbNufiBKMrRiONTplZZVUYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IVauBWgM; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IVauBWgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=u9FeoWzgTf3Tewz50R1yZsuNpI2tDy8WeSjhJFzHU0U=;
 b=IVauBWgMVE0RjjE9bryd8h6N1cmzd1IEEwi4AqcZZinBo5y/8umTEDziL8/bdZBLbMhMtwanPi0H
   HwjVmRZcDGQr+H9F/mmGlcCf1XhxclUkERAMQiSdB8xQ2Po41Op15jJbHOT/UitBbiFRN3+30EW2
   TtCq6YtWlyflxLgsBAA3HoKRWJ7xEmsh9Uig8kdN/z0nAEsA6RyZIZMp7H4QT90R3zJvaHz78X/j
   GYK3z34ENOBTFl4gP3J27276ovHNxdr6a5GqJfSfAiLalF80lUbpcDRil7gEpXwc2FjN2RxP0Rwj
   kDWkhxlsyQ7JBpyvf/QhO0wPL4mhESAGHQvzFQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM002RHKYZV990@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:35 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 20 Oct 2024 00:53:58 +0200
Message-id: <D505HR2RH3C4.1VODDQ0I8IGMQ@ferdinandy.com>
Subject: Re: [PATCH v7 1/6] refs: atomically record overwritten ref in
 update_symref
Cc: "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
 <3c848f10-ac14-4cd7-8fbe-868da9599244@gmail.com>
 <D4UZTVHXXL1X.2KBQI9FYTAU72@ferdinandy.com>
 <a7cb48e5-d8ba-44c1-9dbe-d1e8f8a63e3c@gmail.com>
 <D4WJZVALZYZ6.1FR78333KZBAL@ferdinandy.com>
In-reply-to: <D4WJZVALZYZ6.1FR78333KZBAL@ferdinandy.com>
Reporting-Meta:
 AAE2GdbF+mCcWjovfScOg+z3IZUY0hnhSpQctsQOhAOWKoxa7Cyuo8IjDh0hOxf1
 h7tysrbbirtWtpX0pL+fTOzCg+GfvzfDXgzrDhoQePd5vx8auETY5iWBmR9PRhOU
 +qS+o0pmPgRWdTzRjl1iGtCE84T0ee9KjJMLHXdAuQHVJcXULqTCuqZfRpOarB1A
 d0+HIkOBZeio03rtnsTu4cfkBNI04/d7mIQpC1dhQM16EVRDdSdi2W4Iopo5Q6bb
 4TfeP6MztUbb4CTf2NwCT1nlNT+c+43qxrrEM7gO/MP0txJ7xnIki6eZnjI7xi+x
 rWXfmdZTdYkI0KfyqLu6m++zZGYi53+pFZpODXmKM55WcM06fgFs1+MFl/shjGIJ
 JxprnheNV/UTHZE5cijT8DytJ4bpQWzZiqH7YyUi+3/Z2Yp+3Nq9fUdmJiVevbdf
 rxtq3+y/FUddV8sYSlfhf8e0DrM82aKg0Aw7+VemuQh5VKGjpitLuKPU


On Tue Oct 15, 2024 at 19:25, Bence Ferdinandy <bence@ferdinandy.com> wrote=
:
>
> On Tue Oct 15, 2024 at 16:05, Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
[snip]
>>>>
>>>> I'm also not sure about the proposed interface I would have thought it
>>>> would be simpler to take a "char**" rather than an "struct strbuf*" if
>>>> we do decide that it is useful for callers of refs_update_symref() to
>>>> query the old value.
>>>=20
>>> refs_read_symbolic_ref requires a strbuf, so one would need to be creat=
ed
>>> anyway and I also sort of got the feeling that the project likes to han=
dle refs
>>> in strbufs (which may be wrong). Are there any downsides I'm not seeing=
?
>>
>> It's true that refs_read_symbolic_ref takes and strbuf. I'd argue that's=
=20
>> a mistake for a function that is just returning a string in an "out"=20
>> parameter as I think it is more continent for the caller not to have to=
=20
>> initialize an strbuf just to retrieve the target of a symbolic ref. I=20
>> alse think that it is inconsistent with functions like=20
>> refs_resolve_refdup() that return a string.
>
> Ok, I'll change this to use **char. On the other hand, if
> refs_read_symbolic_ref is inconsistent would it make sense to change it t=
o also
> use a **char instead of strbuf? There's only four calls to it including t=
he one
> I just added. Although I might rather do that _after_ this series is reso=
lved :)

I started doing this change, but ran into two things which I would yet agai=
n,
bring up in defence of strbuf. So not only refs_read_symbolic_ref makes use=
 of strbuf, but

a) I also use it in refs_update_symref[_extended] to check if the caller
actually wants that referent or not (passing a NULL or a strbuf).
b) the consumer, report_set_head_auto check for !buf->len

Both of these sound way more convenient with strbuf than with *char. Ofc I'=
m
not exactly a C guru so ... Anyhow, v9 does not have this change.

Best,
Bence
