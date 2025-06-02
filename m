Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114B02628D
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748891226; cv=none; b=AFvQdAy+Ps2auHaLtPbT1qBxgG8alvbQqFByZkuEgwBZik0FPizBUJoouZh5nchFMn8qDkPFlMiq7l5FZEo9VTLDFhZYEsbvZsK6YehTdrmNl6Cixe10DJf7Y15xO0iBJqe4sx6BPX6fMIzAjRYQOxlXBhayxgUjdcBBwW+NAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748891226; c=relaxed/simple;
	bh=YyY7ju+sYeql/0UWgfSokfankicZfyjA0wNCv3arxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQSD0O/nZXL8dwU369qeQVHZMcCPI9BQKYkTjyHbwt2hdoawOMJgvJeuyqGWt8psn9qRbwCOBpsRESbAG2CH3QNbEqYVMvMqnhF413dIfMu6HKrpMsWgP1jWggMqirQrltS8RJWaHp/fhiVG4wHPA3ctil/W9GRCCJc4aOpzX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Y8n7bddS; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Y8n7bddS"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7150E851F4E
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 21:06:53 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:aaed:2dc9:951d:7f37])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3FC3F19F57B;
	Mon,  2 Jun 2025 21:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1748891206;
	bh=YyY7ju+sYeql/0UWgfSokfankicZfyjA0wNCv3arxhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8n7bddS3lXEWqOgqOp9nTCHZ0uiDy5rzTvA9CugcoSfo96zajc+dSKpvzXLNwvSV
	 N3lQPcbbXjhwstExjcTdYBDA38ciT4Z7r6qhrrSOtjRAtFUMIWtiAnnhBlUFot6qEB
	 829JJFOtdIBuH+kWflLZqgXXaxd9RaaBChZ+53I9zRwTSH9Iwe6U7/ZGoERzt3k1kG
	 qEHl5ApO6s9B7flO8yWZxQczKwHTxrk/V5hsecO3PNQCLyF/CZErW9BAP5/fdALEhu
	 KaiZSe3XGVqZr28i/+IxBupQzXTEoIyp11pv0dDPAaMIApRnqbONNKI13jm4khSSOY
	 /QCaCpvVQQUeg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>
Cc: Collin Funk <collin.funk1@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, vital.had@gmail.com
Subject:
 Re: [PATCH] completion: Make sed command that generates config-list.h
 portable.
Date: Mon, 02 Jun 2025 21:05:56 +0200
Message-ID: <4986157.GXAFRqVoOG@cayenne>
In-Reply-To:
 <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
References:
 <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 2 June 2025 20:41:48 CEST Collin Funk wrote:
> The OpenBSD 'sed' command does not support '\n' to represent newlines in
> sed expressions. This leads to the follow compiler error:
>=20
>     In file included from builtin/help.c:15:
>     ./config-list.h:282:18: error: use of undeclared identifier 'n'
>             "gitcvs.dbUser",n       "gitcvs.dbPass",
>                             ^
>     1 error generated.
>     gmake: *** [Makefile:2821: builtin/help.o] Error 1
>=20
> We can use a variable that expands to a newline to do this portably.
>=20
> This portably issue was introduced in e1b81f54da (completion: take into
> account the formatting backticks for options, 2025-03-19)
>=20
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  generate-configlist.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index b06da53c89..48ec8d9812 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -1,5 +1,8 @@
>  #!/bin/sh
>=20
> +nl=3D'
> +'
> +
>  SOURCE_DIR=3D"$1"
>  OUTPUT=3D"$2"
>=20
> @@ -19,7 +22,7 @@ EOF
>  	s/::$//;
>  	s/`//g;
>  	s/^.*$/	"&",/;
> -	s/,  */",\n	"/g;
> +	s/,  */",''"$nl"''	"/g;
>  	p;};
>  d' \
>  	    "$SOURCE_DIR"/Documentation/*config.adoc \

Hello,

I was on this issue here:=20
https://github.com/git/git/commit/e1b81f54da80267edee2cb8fd0d0f75f03023019

Your proposed fix is interesting in that it does not spawn an additional=20
process, but it does not work for me (debian sh =3D dash).

=E1=90=85 diff config-list.h config-list.h.new
281d280
<       "gitcvs.dbPass",
283c282
<       "gitcvs.dbUser",
=2D--
>       "gitcvs.dbUser","$nl"   "gitcvs.dbPass",
350,351c349
<       "http.lowSpeedLimit",
<       "http.lowSpeedTime",
=2D--
>       "http.lowSpeedLimit","$nl"      "http.lowSpeedTime",

If you'd like to test your patch on different systems and happen to have a=
=20
github account, you can open a PR to gitgitgadget/git . This will trigger=20
builds on several targets.

Thanks,

JN


