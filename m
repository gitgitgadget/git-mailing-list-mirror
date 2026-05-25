Received: from mail.light-speed.de (mail.light-speed.de [85.214.38.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0D339872
	for <git@vger.kernel.org>; Mon, 25 May 2026 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.38.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779749253; cv=none; b=aIj7lU7BObF8Ns7Ohpy9M7oYTPhKKA6LwTp0ntCY/BztO89FdvHO6hrA3yPBRXJlnuwJhhHKnJg+6h9BU4qY63iH+Qe0yycMydQkkiTbuiTRuT68NCTHmg64eqjdJUFnVZ7DLSD9p3NaLnKUgwlwV174nC0wW3YKOOHCS7lXP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779749253; c=relaxed/simple;
	bh=8Av0ZhNpGa20W8iCCsyTxmxpZtrKzekCekf5hLgfkKE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hi+4BI+DH7pA0GfVkaD9njkbvCBHF4QmHm41Wzz2u1ZtzHH8hERCorI0mRH6SP8piEbLBcXcq7snHNYsvF492XyndSt9b0nfWENONWcFWPFVVoHeonwFgLVpkghh9uNf3fKmWz51PNvG42QFg0y7YejohVZCwHm8qvoHmGr3Hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=light-speed.de; spf=pass smtp.mailfrom=light-speed.de; dkim=pass (1024-bit key) header.d=light-speed.de header.i=@light-speed.de header.b=TsLp3Gc9; arc=none smtp.client-ip=85.214.38.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=light-speed.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=light-speed.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=light-speed.de header.i=@light-speed.de header.b="TsLp3Gc9"
Received: from smtpclient.apple (122-151-128-174.sta.wbroadband.net.au [122.151.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.light-speed.de (Postfix) with ESMTPSA id DE06B3D4940E;
	Tue, 26 May 2026 00:47:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=light-speed.de;
	s=mail; t=1779749245;
	bh=Mye62DtxGE8LzXpUvf6CLyeq6UJZxKOeRr2VkOUiJEk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=TsLp3Gc9v31OXQIcRpsDSH7hMxshzCGb8gY3jxwh6GU9Ju4P06dVbP8xwkreGhOoF
	 Iay8HvApDz0YVJdIwutKoKwKA4/AdUmk4J5qL94StqtADNRrGInRl31M/sjq0thRlI
	 ASi5s9Oq7vUZRsBF/HBmOICBbFB7X2vuUJKntljE=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6.1.21\))
Subject: Re: How does git track history overwrites?
From: =?utf-8?Q?Jens_Tr=C3=B6ger?= <jens.troeger@light-speed.de>
In-Reply-To: <87se7gasn8.fsf@gitster.g>
Date: Tue, 26 May 2026 08:47:10 +1000
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <074E783A-027D-4C5B-BC44-CC38C53735D7@light-speed.de>
References: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de>
 <87se7gasn8.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>,
 Chris Torek <chris.torek@gmail.com>
X-Mailer: Apple Mail (2.3731.700.6.1.21)

Thank you Chris and Junio!


> [Junio] Where does this line in your discussion page at GitHub (which =
is
> omitted from the post to this list) come from?
>=20
>    commit fda77690955e9b63c6687d8806bafd56a526e45f (grafted, HEAD)
>=20
> Are you doing anything funky with .git/info/grafts by any chance?

That line is the result of a `git log` after the `git fetch` I mentioned =
in my initial email.


> [Chris] To really understand this properly, we need to understand
> the root of a seeming contradiction:
>=20
> [...]

Thank you for your elaborate explanation, Chris, that all makes a lot of =
sense. A few follow-up questions:

 =E2=80=A2  Is all the object information stored with a repo clone =
locally as well, or does some/most/all of it stay on the remote server =
repo?
 =E2=80=A2  How exactly does git connect the dots between commit dda8db1 =
and fda7769, how does it =E2=80=9Cknow=E2=80=9D the former was =
superseded by the latter (i.e. I fetch the former and Git uses the =
latter for head)?
 =E2=80=A2  Based on the previous question, can I manually find such a =
connection between two commit objects too?

It sounds like reading some internals would be helpful. I=E2=80=99m =
noodling through =
https://git-scm.com/book/en/v2/Git-Internals-Git-Objects but perhaps you =
have some more recommendations?

With many greetings,
Jens

