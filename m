Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB635EE9D
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kCCTqBa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1705064669; x=1705323869;
	bh=p3MlYfRutG43Xsdn3eQoGdtakBScGN5LM7vlKmHfh+E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kCCTqBa9O68Prn6y2xxoVqQVd/38l3HBW4FcxgjYzy/UILr4TU4NTYqe7ur2NgtoH
	 NPFxLt8oDZYcIyAWocv12lI1i9lIjowysubUm7AGt9yznKAlka326ilfIxDidTk/rb
	 Ks/7ov35LugNIQo1/l6ATeg2MzE8L4dzrQcNXYD3Aj74ne1WX126FOpVkedMdkNYPy
	 ulhq5F2a+vNTKttvBos1wmtSNIXetT42Q+yWF0GiM8s8MppLa/iEoPiD46lstKe5Yn
	 zCyHj1WGjGZAVZKR+O7G8PYecBWUpq4z67bq/Jpj31S4hUK7Zq/jZ6qkpJZXX7DD55
	 54EbxdbngI/7A==
Date: Fri, 12 Jan 2024 13:04:11 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Mohit Marathe <mohitmarathe@proton.me>
Cc: Christian Couder <christian.couder@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>, "britton.kerin@gmail.com" <britton.kerin@gmail.com>, "peff@peff.net" <peff@peff.net>
Subject: Re: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a microproject
Message-ID: <N4StHAGzqHVGHJxcPqm6LviErWK3vILDzmedr0WVcNyjprnEh4PgVUXk3LufOjO90wMZKqAeujSdzKa2OJx_uTvEzK0bSk_QdFDwggZAjnk=@proton.me>
In-Reply-To: <xmqqa5pdav04.fsf@gitster.g>
References: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me> <CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com> <F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me> <xmqqa5pdav04.fsf@gitster.g>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 > > I took a closer look at `builtin/patch-id.c` and it seems replacing
> > `atoi()` (which is used to parse numbers in the hunk header) wouldn't
> > improve anything, unless I'm missing something.
>=20
>=20
> You can of course notice an invalid patch that places non-digit to
> the hunk header and error out with such a change. If we are reading
> output from Git that we are invoking, hopefully we will not see such
> an invalid patch, but the command is designed to read arbitrary
> input like a patch e-mail you received over the network, so I do not
> think it is fair to say there is no merit to such a change, even
> though I agree that it may not matter all that much.
>=20
> A corrupt patch may be getting a nonsense patch-ID with the current
> code and hopefully is not matching other patches that are not
> corrupt, but with such a change, a corrupt patch may not be getting
> any patch-ID and a loop that computes patch-ID for many files and
> try to match them up might need to be rewritten to take the new
> failure case into account.

Oh, I didn't know corrupt patches were a thing. I will start working=20
on the patch for this.
