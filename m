Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884874CB4E
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DKRL7frZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1704908290; x=1705167490;
	bh=CaCOUAemKoxkUwH+6T3GgnyidaLQ8lggGnoWS7jfdyA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DKRL7frZAm1S/YIbxLZUJ0W8RKeXQLj3xCVmAk++lEaJfXNebJqkfpuhqSJ8FzgbI
	 vR8YoeKmfODnC4OEf+ERKBTfJG0xtKXJUpI9z0fh9vNkBKav9qUx4AviaFYsx0DYia
	 vfMkJU6+BlKLNX0jB9Qeoqfafh1mYTWKY+XnO1lHrHUZo8aRZGpmd3RySrKE55SIvx
	 nu9QYaEX55HgfvKkZgaRMEm0PVFbmRQyArAiCcm2NJgRQJCWhFJwhHwGL3MTFWDblg
	 oPJ9kqWMehaWVreVgUPuV/4IM784Kux0s9nOexUw7soKxMfBBQwq4i5qs4H/bwx/38
	 /WEsjd1B1Ucyw==
Date: Wed, 10 Jan 2024 17:38:07 +0000
To: Christian Couder <christian.couder@gmail.com>
From: Mohit Marathe <mohitmarathe@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "gitster@pobox.com" <gitster@pobox.com>, "britton.kerin@gmail.com" <britton.kerin@gmail.com>, "peff@peff.net" <peff@peff.net>
Subject: Re: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a microproject
Message-ID: <F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me>
In-Reply-To: <CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com>
References: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me> <CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>In https://public-inbox.org/git/xmqqjzpjsbjl.fsf@gitster.g/ Junio says:
>
>"Some places use atoi() immediately followed by strspn() to skip over
>digits, which means they are parsing an integer and want to continue
>reading after the integer, which is incompatible with what
>strtol_i() wants to do.  They need either a separate helper or an
>updated strtol_i() that optionally allows you to parse the prefix
>and report where the integer ended, e.g., something like:"
>
>and then he suggests the above helper.
>
>So it seems that the two instances you found look like good places
>where Junio says the new helper could be useful.
>
>Now if you want to continue further on this, I think you would need to
>take a closer look at those two instances to see if replacing atoi()
>there with the new helper would improve something there or not. If you
>find it would improve something, be sure to explain what would be
>improved in the commit message.

I took a closer look at `builtin/patch-id.c` and it seems replacing=20
`atoi()` (which is used to parse numbers in the hunk header) wouldn't
improve anything, unless I'm missing something.

So then I tried finding other places where `atoi()` can be replaced
but I find it difficult to find any reason that would justify the change.
So far I've only looked at few of the MANY occurrences of `atoi()`.
As far as I understand, the only advantage of `strtol_i()`
over `atoi()` is better error handling. And most of places I've seen either
already takes care of that or does not need that at all.

Thanks!
