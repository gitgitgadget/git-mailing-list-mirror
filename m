Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F46153BE4
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917638; cv=none; b=e6VcLD2cpJm5N7hZWIJU6r19OKLzByy9LQ2fAs80dXvVN7ENylhu0MLuPdVm1k+/8tvrisPvL5R+i0KhozSTVjEuBWMZss2pjVMIU6myM2a4AmmlZfBVKJSZOvXS/uoFJC4hh5lp2H/7xcx3QCv5mM3aAjg3x37Fd9g0NUp9ojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917638; c=relaxed/simple;
	bh=RIf0UGp3hfOxPtJw/E+6Be+tu/cETpeRwN80E4qUuvg=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=QJC0EkQWo/y3g3Cbqbub7TXWMT1At0q9bpItnXOZZeTo7iww2oLabZjHVrG8j9Xo2+KkmyKC9iW/4CbA42w2L53Szo8VGBVcr5Tfcnc53t3oRaBnbdQsOrswNyBVlEyKTUONMP3Hx5p2iEswDP84Ov/MRhgVpc+9CHy3QLaDpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=gSxbbLAW; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="gSxbbLAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=3Irwt6w7woM+ns38bad1jYMXXxYaC1Yt2VJFacPJQgY=;
 b=gSxbbLAWUrtxtgNJ6qaRM2u9KxMpXfRCb1OudgbIVD+ToZ8WmgAhtGrh4gvmmsNDKCzEuTY6w9Bk
   ZnDRI8sqgwCVUjYqPIrZH9kGQDveLP3lukjsaAnbBVLkDhfC/Cwl0GNVWfNK86QQCWPAQK4zacbE
   TdKhVSQUnPN76MWf3sisYshpMfauaL4faJ3FXVkVjx1hvC8RLAa4zvt54mxJ8zIaUl62gt3KeeaT
   yTnbl0xcE+cil5F6OK+qN4Ft/yz3lZgwG7M7Q8/av6iFJY5PDZFOTn2zcYTkhrjC7pWhigiauVxz
   I5f8gcqW9nmzNfNFzxSkr12JwdMZ7noR9RPXJw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN400N6MZYN9X60@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 08:08:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 18 Nov 2024 09:08:13 +0100
Message-id: <D5P5FWL8I3SY.DPYSUTU8GAYJ@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
 <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
To: "Patrick Steinhardt" <ps@pks.im>,
 "Bence Ferdinandy" <ferdinandy.bence@ttk.elte.hu>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-3-bence@ferdinandy.com> <xmqqr07d11wt.fsf@gitster.g>
 <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu> <ZzrrMrhRxOuB6QKH@pks.im>
In-reply-to: <ZzrrMrhRxOuB6QKH@pks.im>
Reporting-Meta:
 AAGG1SMeR2hRD606N5VrrTRQ7Iz317WlNIkq47s35ZUi3pzWB/ErEEpdsxaGOj1f
 B2mb2egPa1LjoMAGcCsJyVHWnC6PRw1Eev7H0a3cOdSnLECTUva2V2gaQ+QThz/d
 aOZu2rcCXZSrXNJjBU4mTNXGpOoi2Nv3R+LeRd9QmyyHx7LOQvIMbm+MnvxJCyrC
 gJnZxuvCwrdRIyDByewtXKVaoa3Gr/a3BrlDJ4J2QkcOYkEIAc8aAXo/aaDmjunS
 czkpYn13Gs/ONZ8MGpYzElsB4YbVB9soKDq0LU4Z+V+h840g/WV81HgK5loETp/a
 LkQV1A40wJTqZVoady3Gv0ZgeIlZdqukWYwxDU7WQM5LtmrxVPzr2OJg5VIkpkHr
 PUhuggs9Hox6H79KrRcojV9xfe1PTm6rGx3S17lD4+IqtaxUcvIfbQuJOhfHRoNe
 CdX9msg0FkMx0IVjfBJKmem44DnUtmGSAkLo7s98FAf9Tz071+am2M8XLg==


On Mon Nov 18, 2024 at 08:22, Patrick Steinhardt <ps@pks.im> wrote:
>
> So from what I understand you try to execute `refs_read_symbolic_ref()`
> on a non-symbolic-ref, and your expectation is:
>
>   - It returns -1 when reading the ref has failed.
>
>   - It returns 0 when reading the ref was successful and it was a
>     symref.
>
>   - It retuns 1 when reading the ref was successful, but it was a
>     regular ref.

Well, the other way around (it's how files backend does it), but I guess th=
at
is irrelevant at this point.

>
> This behaviour isn't documented anywhere, so I wouldn't declare it a bug
> in the reftable backend. But what is a bug is that the two backends
> behave differently, and that should be fixed indeed.
>
> I couldn't find any callsites of `refs_read_symbolic_ref()` where we
> rely on the current behaviour of either of the backends. We do have a
> check whether `refs_read_symbolic_ref()` returns negative in "refs.c" in
> `migrate_one_ref()`, but that one should be mostly fine given that we
> check for the type of the ref beforehand. "Mostly" though because it can
> happen that we race with another writer that happened to convert the ref
> we are about to migrate from a symbolic ref into a normal ref. Unlikely,
> but it can happen in theory.
>
> I think it's an easy mistake to make to check for a negative return
> code. So maybe we should adapt both backends to return -1 for generic
> failures and -2 in case the ref is a regular ref?

I've been wondering about this when writing other parts of the series and n=
ow
is a good a time as any to ask: I've already seen this pattern of returning
various negative integers as error codes, but never quite got the logic beh=
ind
it. Why not just return the same numbers but positive?

Anyhow, the proposed solution sounds good and as far as I see how things ar=
e
done in the code. I guess if I want the series to land I should just fix th=
at
as well, there are already a couple of not-entirely-related fixes in there =
:)

Two questions about that:

- what would be the ideal place to document this behaviour? In refs.c with
  `refs_read_symbolic_ref` or with the `struct ref_storage_be` in
  refs/refs-internal.h?

- should I look into adding specific tests for this? Since the rest of the
  series will depend on this behaviour it will be implicit tested anyway, s=
o
  I don't particularly think it would be necessary, but I don't know what t=
he
  general approach is.

Thanks,
Bence
