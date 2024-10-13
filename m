Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA718F64
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728854700; cv=none; b=PRJuySW8jC9anSyfY6n8NnbffuF7JzzieIh9sdKQft0J+9AO21w5dVQbjhoiuKWoVd4BponhePslvfJvBHEq71buMfS0ww6jbVOAqAQfjYixrRln+aouSnAGqWleBbbtTm8z4M4kVf8Mwbtb3c1EZh1dOrvj3DDX1nzEWCp4H8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728854700; c=relaxed/simple;
	bh=2XiICeX9OvpmEZ7kdS/LdFZTH8ApgGDvUGMcvtqWVJU=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=QT+7ew1kowcT9AOXq/0o62bwnJGF3UkN27atrDbqUxj7yavVL+CpMYJdjWNWudS3mUKaP/HU9er15dLut0eCoLt52H1jM705auPCi+j7TpCj2FKxPTxSvIBvdmYKRkUhhgwy1lf1E1jnbvKJNXT9UPdDVwa/J44oWkmCvVYzcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Z+S3m85R; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Z+S3m85R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=2XiICeX9OvpmEZ7kdS/LdFZTH8ApgGDvUGMcvtqWVJU=;
 b=Z+S3m85R001tmf5CU9iSNkXJomHgeYI+4zcbsZpM8XotbH5t3U4apFkZZfG01wxalSdF/vSl2ObT
   cXpM8B860/XNXlJFvhQg5Nm6Cu3yh8j2lCAQ4It/7lXL7erw4qq48yvP2Znlt/GmHsAz93BOtQyV
   +aYXrZuzReImb00NEsSwSOU6XkVdg0c2eylT8j+g6qli4oGiOzD4B109yjSHLSQqv0YtoaKDdQcy
   F0otsuC7JyvZB8Y+5bP4cMchiKz15Pz7EnRIUIT+ZSapcX15xVxsEus01VbjzCF1wlzs1j3msybH
   ljupMzOjk8j2hy2jtwBuqz8MVbN24YEAaTSeLQ==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLB00H6WCTF6C80@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 13 Oct 2024 21:24:51 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 13 Oct 2024 23:24:22 +0200
Message-id: <D4UZTVHXXL1X.2KBQI9FYTAU72@ferdinandy.com>
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
In-reply-to: <3c848f10-ac14-4cd7-8fbe-868da9599244@gmail.com>
Reporting-Meta:
 AAHjxn49sluWjC2XK2rAnFaGwPW4kz47/7U9LKr5dYcCwL37X6n/dtXU9ndxKg+k
 bsvKx9fbz7JOFJNYvi4p9hMJgifyHzLmG3nPAwF0Xz+9ZEcX4kIvvcU2QbnYVers
 nNTSOXBkG03+Zi0ZxecSW254VsslLikjZks/8+pUucaO3Ec5GHJUJ98mbZeHjBSY
 jaelyXitu6m1kAcq18C7lpBl6v3geA7yVj38Nid/1G5uzubSmbY3EIHYLWqprFLz
 WVOMx0EnAy2x8+c42czi/F+H7R+I3zJ9h69k4883tpZICOG4T0GdNr+cvaF/3g1q
 Er0J6kNWbNyqlDHLtHCaR6aAeabKldjGEVa7u/DapR6J/lgbzrFrgMWF9N1Fmsno
 ns1m9wn5eFCKhVcQLT99cE+kNRLgGyilGya9waoja+QArjJjL/D4/CWaokSw/uTO
 JHXDdeR99d4GHj9CkLNG2J3Z6cZVB+74XRkjssRlSDM7Dvvc+tyzdu9S


On Sun Oct 13, 2024 at 15:52, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
> Hi Bence
>
> On 13/10/2024 00:03, Bence Ferdinandy wrote:
>> When updating a symref it's currently not possible to know for sure what
>> was the previous value that was overwritten.
>
> It is if you use a ref transaction rather than call refs_update_symref()=
=20
> and query the ref after calling ref_transaction_prepare() and before=20
> calling ref_transaction_commit() which is what the code below does.

Yeah, it would be more clear if that sentence would say "when using
update_symref".

>
>> Record the value after the
>> ref has been locked if the caller of refs_update_symref requests it via
>> a new variable in the function call.
>
> To me this patch and patch 5 feel quite disruptive to all the existing=20
> callers which don't need this specialized functionality. I think it=20
> would be less disruptive over all if you used a ref transaction rather=20
> than calling refs_update_symref() in the final patch. That would enable=
=20
> us to keep the simpler interface for refs_update_symref().

The extra parameter introduced here is actually used in two places by the e=
nd
of the series, in remote set-head and fetch (of course you could make a sim=
ilar
argument for the functionality added in 5/6 which is only used in fetch by =
the
final patch). To avoid code duplication I think even if we did not touch
refs_update_symref() it would make sense to create
a "refs_update_symref_extended()" and make refs_update_symref() a wrapper
around that with a few less parameters. That would be similar to how
refs_update_symref() and refs_update_ref() predetermine a couple of paramet=
ers
to say transaction_update().

Currently there are 15 calls to refs_update_symref() in total, of these=20
5 do not use the complete functionality of the function (they pass NULL as
logmsg), so the current implementation would not be completely unprecedente=
d.
(This tally did make me catch an error on my side: the logmsg in fetch's
set_head should be "fetch" not "remote set-head", I'll fix that in a v8).

Imho, even if I manage to come up with a better name than
"refs_update_symref_extended()" wouldn't it be more confusing to have two w=
ays
to update symrefs via a function call, rather than have one, where _usually=
_
you pass two NULL-s at the end?

>
> I'm also not sure about the proposed interface I would have thought it=20
> would be simpler to take a "char**" rather than an "struct strbuf*" if=20
> we do decide that it is useful for callers of refs_update_symref() to=20
> query the old value.

refs_read_symbolic_ref requires a strbuf, so one would need to be created
anyway and I also sort of got the feeling that the project likes to handle =
refs
in strbufs (which may be wrong). Are there any downsides I'm not seeing?

Thanks,
Bence

