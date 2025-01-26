Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59341E521
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929215; cv=none; b=QHenzu1o7DDsOToQysab8qsrXT532j5BRHZgKMyW8lSk1Zd7Cr2lFsLUDZIi7mI6QKfCdNv22QQHlc5Rqn7MNrwgApln0FI8o9ZJcaapfrzVvlS/wvwP1/Nj4bV0ABE6LN51WvImUBPlDN+lzji7BzPjh+YEcKHgDfT3TOyUtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929215; c=relaxed/simple;
	bh=Wy5FO3qyMauukAK8HTO20AeDKKCX3DeuCwglREqFZeo=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=Yp8d41tpyqY8/U98CbJzKwb+0Q2lGCakiRI9ICHfTCrr5xs/tJFOeYXq1UxmgtiOZbID78PGnj55yJk+P+tcAvGnb83TF5tQXU4UoZ4i4Hp52SO6vKEehDVtV3hS9bp3k4efM+cTV1HiPr3tGsJ9DOafHM0+M8dPQjX1ZnmGotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=iZ+X5dj1; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="iZ+X5dj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=AMKB++EzwPCVDYCfwHUc+17okuFE0wuU4cWDTrvRKyA=;
 b=iZ+X5dj1wv7UkvDmW1DFk/tz0bF9yR7pFFd5OiQcQ8ZUtsBgg+we/f6HV4iTFJerq2lcIWz4kwkI
   wPiOYWvnjnYSRjlfM/REgTDW5VXDWEGabgdFPSHFfAIRh2wvVRA+cDd6pLB0iyLRz4+ecobhchVI
   tU7baUFIc6fOdV45LyUyyVqayoxbzj7nmOVShX8dZdtHgoB0rQbhRfCq64iC8vn1c56hcu/WsK3p
   sqDkiVfYsVL+FBBRPbKMQaGLTGj4Aos3FoR88kcorgzvGc6SrC5eKGvsjxoRA79DMy/Wx1ha0mbn
   rh1aX7J3doRJ3BQJuKjLIfiIEoVHnSjNsOBQtw==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQP00M1JUITN710@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 26 Jan 2025 22:01:41 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 26 Jan 2025 23:01:14 +0100
Message-id: <D7CCDAZ9CWQ9.28LRY70X1JBAZ@ferdinandy.com>
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare repositories
Cc: <git@vger.kernel.org>, "Christian Hesse" <mail@eworm.de>,
 "Christian Hesse" <list@eworm.de>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20250111202628.0e5894e4@leda.eworm.net>
 <20250112165125.130400-1-bence@ferdinandy.com> <Z5Mrk02wMdABtrVZ@pks.im>
 <xmqqldv0p559.fsf@gitster.g>
In-reply-to: <xmqqldv0p559.fsf@gitster.g>
Reporting-Meta:
 AAGxQJE2mvPvJYyGsn82nZBi6C+00/KI80E9EqRXX2QbGz3gT1lVU9+HX+sJCJZI
 0MPjyFvpW1LwzYkg+DQapeaSWGuN9XSExqXFFoHFLgZVNZ9uYsgUKq4NE0a0Da+6
 gmS0BfdggRzSfdoSCU7Hpf3BWnb/fCVBivm9RrCunxFvda0Lv2l866xJlwZWIc4b
 gRZXcINqebIhYkF9GY1R+e3dRwBM+R+QJJbxPE8AWQk8JXBe59bPqAw+8x+02MNn
 cEmBkFWfLPQBVEUviXKn/hUoIkymB5pm9cQqI9tS8+Oug0lBuF0ty7TgoUO4QDHB
 WgEkQDW8COpALzXUWmkwcceBOZK3fm20gV6DImU1vGunOKWeM7TFUM9tGEeeZa/O
 HFHPDI74rCvmGJ0NHv90tNPR9xv/Ry6OfPFIMLB/NZrYe421V/bzDpnGfd+n/elO
 37MqA8RWFXRyuGoA7dkMesWMt3nqe6HQZRZxScdTurGDXTBG6iD7CFVw


On Fri Jan 24, 2025 at 17:07, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>>> index 2d9587059f..cfa63ae086 100755
>>> --- a/t/t5510-fetch.sh
>>> +++ b/t/t5510-fetch.sh
>>> @@ -84,6 +84,19 @@ test_expect_success "fetch test remote HEAD" '
>>>  	branch=3D$(git rev-parse refs/remotes/origin/main) &&
>>>  	test "z$head" =3D "z$branch"'
>>> =20
>>> +test_expect_success "fetch test remote HEAD in bare repository" '
>>> +	cd "$D" &&
>>> +	git init --bare barerepo &&
>>> +	cd barerepo &&
>>
>> The `cd` needs to happen in a subshell. ALso, the same comment here
>> regarding whether we want to have `test_when_finished` to clean up
>> state.
>
> Yes, indeed.  The change to another script we saw earlier followed
> the "chdir around only in a subshell" pattern.
>
>> I see though that you simply follow existing code style, both for the
>> call to cd(1) and for the single-quote, so these are fine. This test
>> file could use a makeover, but that is obviously outside of the scope of
>> this patch series.
>
> Terminating quote can stay, but chdir is a correctness issue that
> may want to be addressed minimally (i.e. not making things worse,
> while leaving it for later to clean up the existing ones).

I'll be sending the fix with also the terminating quote fixed as well. Actu=
ally
tests after this which I added for followremotehead followed the correct st=
yle
so why not here as well ...

5505 remote also has some style issues that came up before so if I find som=
e
time I'll probably send a patches cleaning the up both.

>
> Thanks.




--=20
bence.ferdinandy.com

