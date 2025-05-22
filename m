Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C53A2AE9A
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927009; cv=none; b=txMJoqhDfE/qapdJyha2rhmbzfetfZHGokOgi4BPsVFrS0KMcAI0Knig6K0ed/VMT80jVRxDwOiCMfoaJi8EZTb/mueYP5ManeVjKEPDl9C5loHQZai/WURwjXqkbQVGg7hNgtjV3rDimJor7Qfs48AoKEqT9r7IKWBBXdNrBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927009; c=relaxed/simple;
	bh=cnSz9eKHX8Kp9I/iZKPaN2UhjwRRH4xCW4HuY2C+/Cc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lN6lUR2MctU+Ky1cydEQqxC06cR/LPwI5qItjQs2N881PQFEmTpMxQRq2zObNBsSBgMhDKR9nAOlL1OeCD7dUt7uBDVtQGhsf1XrAj6Z47H1TVR8SMrxLRo69Z6TSa0aPnSftrtvW2oMLZjWORv+IqvNZCncTqZwjCW9ri+Sk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz20t1747926960teda00e5a
X-QQ-Originating-IP: ucEIP+PGGPV4UBqs5VuloGQocstMsp1v4HV9bCZIWlw=
Received: from smtpclient.apple ( [202.119.43.147])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 May 2025 23:15:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7699032716330446919
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2 2/3] pack-bitmap: fix memory leak if
 `load_bitmap_entries_v1` failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aC5nxa0uTb+ieiML@nand.local>
Date: Thu, 22 May 2025 23:15:48 +0800
Cc: Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <457DC23C-A052-416A-B181-A1EC48AD91A1@smail.nju.edu.cn>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
 <b515c278a8fec6c2ab9d11a49261f44fe0f37bf5.1747732991.git.gitgitgadget@gmail.com>
 <aC5nxa0uTb+ieiML@nand.local>
To: Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MjlOSqg8Riw0DbAmIB0M/azcpdeXYXu9Lj+IlTAeBfVhRLRXL9gcaa0/
	CbiFPyavv6eg1cU6UwdZU1DDv3VOi5AN56E+AaCci4isVbs7S3nRN5Yvn0olvl6ES5jZszb
	x26+cqGTFwAzzdMmSS6vpUfmr2EzbAzeQBPBLt6SqVnYTmzUlj1uZRGRoG1PyoL0h9zCpW7
	DRqV2TEwudMXw8596lCAUCAYA2tSzPdyr4VOZj4c6eEDQV4c8NT0ZRTxnO4HeYpJtv5IxlY
	HfqlvSNEwp4/ynnqr0lrCAI7EiPL2fXd8+DDT9b/JaNwh3EnQkHRltPJ8LYUnNj1hOiwL+E
	YOi3jt4ZeQU9Lr+ppMxOhPtC6tqwWtTJ/DiOtVVvUy9We5XpYiie1nBjwirdH45YXpQahWD
	TNr9ylc1ZsjAfmreVKC1nEFIbpDM5wZVPG3VzoH5zR7vXcG5X5b66AdV9KNq2EgQl8DwTl3
	uI4O7mdEJR2lVK65OuVL7BckKCwr2kZbraxzC0mtr13YSSA+WjKS3JEGONi6eFgxPGtbQHu
	/UGRlmK0zLxfOeAshYdGx6Ho3Y0g/hrVcuFDtV4XPdAy2OFLZD45R0O/JiPoOcwUybNrKcD
	0dfUOn96m1cEil/rLUxLFTR+wGLl/jsOVfYjF+kHjOXtkucOuIAkuNhAoA8sIB0BnZiQpyz
	o7fzIICaLeY1yr7tF8QmSt1Huhqlf5AiKZu0CMssyuOPEsww+rIweQJCw1mg+sqdUvnYnvL
	ZtV3f5UHpX65SA3Dch9F0/d45L4x7c8VKqJuKlqpZnjcrNp5kD3gq/MHw3xbc1JQNMqGUeu
	hhdHDZjGKxb/5Bo04ZraGPfHXI2G95kK9FZxedJsh4TKxMYmK+mxJyc4a4wk26Wbs3klLdP
	cEXq9Ju+DzxD9FVxvzQP/2g48nrq/pHJM3zeeneqvZ8BCINNbbFLqrNbHhS+EMWV9sM9/LG
	PCCP5Ts8aKnjFCXSaXlp9RSn17du5NoS6t5N4AhcUqikjjbOq3OgLltFvDmRFHT0jL1A=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8822=E6=97=A5 07:54=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, May 20, 2025 at 09:23:09AM +0000, Taylor Blau via GitGitGadget =
wrote:
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>=20
> This commit forges my Signed-off-by, but I am happy with the result
> here.
>=20
> I do think the series is structured a little awkwardly as a result of
> adding this patch to it. That this and the previous patch have the
> subject "pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
> failed" make the series not quite as clear as it could be.
>=20

Agreed. I=E2=80=99ve definitely learned a lot about how to write commit =
messages
 and cover letters through this process

> I think there are a couple of things going on:
>=20
>  - This patch is a bug fix that could be applied independently of the
>    first one. The rationale there would be that we shouldn't be =
leaking
>    the EWAH bitmaps in 'b->bitmaps', but we are as a result of =
NULL'ing
>    the pointer in the "failed" label. That patch can stand alone.
>=20
>  - The first patch (yours) is no longer fixing a leak, at least after
>    this patch. But it does delay reading the bitmap until we have
>    validated its XOR offset for sanity, which is a good thing mostly
>    from a performance perspective.
>=20
> I would probably swap the two patches around so that yours applies on
> top of mine, and then rewords the patch message in yours to reflect =
that
> it is no longer fixing a leak.
>=20
> That all said, if you feel strongly that the structure is fine/better
> as-is, I'd be more than happy to discuss it further.
>=20
> Thanks,
> Taylor
>=20

I think I can do this in third version, and I have to submit patch v3 =
after
we decide if patch v2 3/3 in this series should live or not.=20=
