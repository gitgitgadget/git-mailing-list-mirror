Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FF32C302
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648090; cv=none; b=h+gtp0abNGmTD/9PmLVXlsScOg1PfdAa+boet8Y+Wf290pSMpWu/06MsJlCdPAHf1jx8wFmmgt/FsTxz4nNZ2ghk/ajDqyd2G0chhr5GcWvxnXexfrI0gC5ITP9WVB4UGnVDvmUaN4ycEErBRend3zYBhN2rXCMoa4iCRQElIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648090; c=relaxed/simple;
	bh=SC9DPflc3Eesl461PEaToqu4WJz6+t462jrlkEYlqvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2mOPt63IW2AchqxbKvUbXXHY9LybTEsH0aliq9/g6gTbTcI6HpAtky6evkgDQeX4CaNiJFZ6CKBvuNcZIY7+eAMfRp8ciZr87EGdF3CMy/nJYzsMxYQ7kTFfCotLmPJeUbfS5FVadce5puRGsFup2FDby3TDdcbfEE+UwnXPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=sQz8Vqjt; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sQz8Vqjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781648078; x=1782252878; i=l.s.r@web.de;
	bh=Smwbw2Efic9kgTbKPSuikNagZM1YbwjGy8+z2NIRnoM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sQz8VqjtS5VeTE2PGPTi9Gp0MmZSTNHFOs9Z6jXa2/gnVhD9evF9Cfa6ID790XOP
	 VB3HgXf1nswndDU7o+dmpiHCzyXZ8b3oU9SgBuIl8k9BKWUN6YGGeyNOXU8NObsS7
	 GoJAStBW9Hc7r/ykFpsBAAptHujTlkGY5GbmFvjFsn2IyHo5I5LgW/93+FA2fGpPK
	 pEJK6mTJMiE6CcBegzA5C1G+BsqcXr0Tkh9qHdYYrlQBdvCGiTVsEFiUqjvwnkkZf
	 Xn7Zpfld6M95uhBEY2EVBrF3fb317QK1OBYzpW77bCdOTQbltHujBCO9XQBh8Gd3L
	 F2xmAPVgIhNt0vm5wg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myv70-1xMMrH3zf8-0159YZ; Wed, 17
 Jun 2026 00:14:37 +0200
Message-ID: <47e3cf16-217e-45d4-91e2-5a1abb4ee49e@web.de>
Date: Wed, 17 Jun 2026 00:14:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cat-file: speed up default format
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
 <20260615165326.GA91269@coredump.intra.peff.net>
 <20260615170652.GB91269@coredump.intra.peff.net>
 <10a33614-837f-4166-aa30-6de28b052692@web.de>
 <20260616111237.GA687438@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260616111237.GA687438@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K5OgsK44AmM11KhWykKAKgubkrSro1UnDM0W1rTM92UoEQEbJPe
 FalohAog8MTobEaquYYBbRHRKvtEs3EWyI1dM2aM4NEROS0EDgkiCInUzA7FXuJVIk3vFrh
 nzXNRqKRnOju3EsA7p/Wtcj4DueuEjsjkv0SFzp8xswv8l1vuGN3sCtVf6rOw19hgYEZYvz
 q16YnNpGVTrMgyn7xVeag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WMLKrBiCcXI=;hoaAaZ+XDUZVGB+6GuX5B4vA7PT
 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
 ZJm4OyeOAUDd8NtwKLR6/dAY3Qw=

On 6/16/26 1:12 PM, Jeff King wrote:
> On Mon, Jun 15, 2026 at 11:53:07PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> We can also store literal characters in there.  An opcode plus with a
>> payload char incurs an overhead of 50%, which sounds high, but at least
>> the default format only has two of them and it's much better than
>> storing pointer plus size for an overhead of more than 90% in case of a
>> single char.
>=20
> True, and it's a size win if the literal portions tend to be small
> (fewer than 15 bytes). You do lose out on the ability to strbuf_add()
> them in one go, though. So lots more strbuf_grow() checks, etc. If you
> really wanted to get fancy, you could follow the opcode with a length
> represented as a variable-sized integer, followed by the literal bytes.

Or an opcode that shovels a fixed-size string.  Depends on how much
literal text people include in their formats.

> I'm not sure that Git's formatting code needs to squeeze out quite that
> much performance, though.

Good point.  Near-native performance would be necessary to make peephole
optimizations like the special handling of the default format
unnecessary, which I understand exists to speed up Gitaly [1], but I
guess most users don't have such high demands.  And there's no point in
removing a few lines of duplicate code if the necessary machinery adds a
lot of complexity.  Though the code discussed so far was not too crazy
IMHO.

[1] https://gitlab.com/gitlab-org/gitaly/-/blob/master/internal/git/gitpip=
e/catfile_info.go

> OK, so we managed another 1%. But I'm skeptical that this linear opcode
> technique is where we want to go in the long run, if we're ever going to
> unify formatters.

Agreed.

Ren=C3=A9

