Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847236E469
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944715; cv=none; b=P7NeX7MSDSR1u+oWajmhYXIe7ckMYo1v2dK9gciog0dTyekPlOZjqQBvTLb1xspDOitto7eBmGpn9LEtTMhtY4zrz6lvF5A97wnPL1bSaCA9sOtafB1VnISwK5frhQwE1r275DxYsYy8TsvMuG+BsP9PKLkaD94bomStEn7Pv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944715; c=relaxed/simple;
	bh=HV1J5LNPDBxZigHlLsyh0aOfU5RhMJKVP3GWrnTG3nU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfL83vQBzrKdE8cJXBrUD1gg2kYMCQQMTSw5FAIZ0+f+5ivlCrL6leZzL/jX0WgHStAU46LIqGP7zbgZsmIA7eALxBmxZ4udngG2XjxXs86Ue3F1BlobN7lIXOLxZWkSf/2HvMWf+8Vd6btfpL365pM1u09oKCugz+e+SXQXX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0d9EDD8L; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0d9EDD8L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774944711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMIcyP843Df2aa3frud//XA+JCdtBjHn8IvKyPsC4Os=;
	b=0d9EDD8LlVy9H3dJfZEYEjliqjHN55qyExZX4ltw6OrlXoJ/7wfgE1GVXoKkIQytaf+cWp
	yC1e/t3CWCuvcGZ2sRu4XIWV1oT8C4UjDpvlojO4ZvOtnx6VJ8ZuIUiQ+29nyHBZDHQIAb
	MWfdXfOn9ygra66Cr+fjZ6dMUjzyco4=
From: Toon Claes <toon@iotcl.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>, Tian Yuchen
 <a3205153416@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de
Subject: Re: [PATCH v6 2/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <6427d088-e41c-47ff-ab6e-4d7679e85d3c@gmail.com>
References: <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-3-siddharthasthana31@gmail.com>
 <05959eb8-4b8a-421e-bf5f-9e6f0b59a313@gmail.com>
 <6427d088-e41c-47ff-ab6e-4d7679e85d3c@gmail.com>
Date: Tue, 31 Mar 2026 10:11:46 +0200
Message-ID: <87ldf8l8ot.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> On 28/03/26 10:03, Tian Yuchen wrote:
>> I think it would be great if a low-level command supported something lik=
e:
>>=20
>>  =C2=A0=C2=A0=C2=A0=C2=A0git replay --revert new-branch HEAD~3..HEAD
>
>
> Interesting idea. git replay is still experimental so the interface=20
> could evolve. Worth considering as a follow-up but I would keep it out=20
> of this series for now.

So you want git-replay(1) to create a new ref `new-branch`? But where
should it start from?

I'm building a proposal for this in [1]. This proposal is a bit more
flexible than what you're suggesting here, because it enables setting
the starting point.

[1]: https://lore.kernel.org/git/20260325-toon-replay-arbitrary-ref-v2-0-55=
3038702c9c@iotcl.com/

--=20
Cheers,
Toon
