Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF56FC3
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791022253; cv=none; b=JOC8vW+eX+qXE68v6ykPevvss/6NLwG/MQDxTYBkPLA+jkELqqg0bVD1Uu1AGBnZ+ox93S2oHe4Q99fWQgE6foYefJwsWIqmvlfmX0ZQDltGdqxJquIegNKqq9AhVeDy/OhDxb8ividw2196i6CqyVPrLx8ZuoMdB23hYZeiKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791022253; c=relaxed/simple;
	bh=9AlE6dGvO9Rvukv3Ign2QRS+ciMenjX0KKRGTO1MfpM=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FD3IQerYT3CHfTwXWSmgWbnquXIWs1Wqx7fZj3rYBvbYaM06OLDbXfckt5pbpyqTNFTkaZiUk/rLT01DwS2dYLJMcd5aXo4bJEMjYG53+X8R1qzfmmgmbgMYKhfL3cvqycxmvCBUQbt/P0NYuy27/1e72d9mnLe5QA4YXbiKkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd/tOY8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd/tOY8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2511F0089B
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791022249;
	bh=GExFXD8Ky7Df2FZmhFXhoh4A/UZofnLDh8XmQjGJL+w=;
	h=Date:From:Cc:Subject;
	b=Zd/tOY8NTDnug9OGTLFh0+ZizZSWxcfNJml7gjwn4RxHrsTj0QpPpj2ex7TL47LhU
	 4lVAotgojchpZtGFQiezIJQPBgNjFoAEsGFY9vjtOd9LEyIfVtBtT6lcL2TKjdcsqg
	 qHNkqigZewBz4x86pcGRd90qCFd+FaDgYjVD5zi0CP5Ys35WYGPISRtEWB+pGyBhMs
	 EgUUqGsMfwgG0L4ngMJAesvgDgPCPs8ftm8T3X9RnWwWkKCHVPYng90qdeprl0EpyP
	 03NtMK97J+mc6RBIDpG8nEUr8ofj/fq0nxhw8oJ1GgmFATX2qkX0tvmPCYPyL8huz6
	 Z6VU/FaO32trw==
Date: Sat, 3 Oct 2026 12:10:44 +0200
From: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: git-visualize(1) plumbing equivalent
Message-ID: <asDTWsH-RuIJOyne@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mpfu5uoso7gev4gh"
Content-Disposition: inline


--mpfu5uoso7gev4gh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: git-visualize(1) plumbing equivalent
Message-ID: <asDTWsH-RuIJOyne@debian>
MIME-Version: 1.0

Hi!

I have this code, which I use to loop in a script using git-bisect(1):

	while
		git bisect visualize --oneline \
		| wc -l \
		| xargs -I{} test {} -gt 1;
	do
		if
			git rebase $gropts BISECT_HEAD >/dev/null 2>/dev/null;
			test $? -eq 0;
		then
			echo 'Rebase: success';
			git bisect good BISECT_HEAD;
		else
			echo 'Rebase: conflict';
			git rebase --abort >/dev/null;
			git bisect bad BISECT_HEAD;
		fi;
	done;

(
I know this resembles "git rebase run", but I'm avoiding it, because
passing all of that as a command is non-trivial (and I'd like to avoid
having to write a separate script to pass its name to "git bisect run").
)

Having read the documentation for git-bisect(1), visualize reads several
environment variables, and thus this code doesn't seem robust.  What
would be the plumbing version of the while-loop condition?

		git bisect visualize --oneline \
		| wc -l \
		| xargs -I{} test {} -gt 1;

The goal is to know whether git-bisect(1) has found a commit yet or not,
to stop looping.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--mpfu5uoso7gev4gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrA1KQACgkQ64mZXMKQ
wqndEA//bNh9QzMdzqA4TG5IuXHRIMfRAP7sFCEuu4Ufjh/cVvp6YaU6Akv5L33U
lLxr7L+95fxiILi/YnBKBb5XuonzrIlGeXbDMrLq//6welDJ8UEkge6pcKR0Fsqn
q0xqGVBEzBK6mFVjnN0vZAaI44qOxcZpnOd2fcbVznrfeLL/6GJsW4VETFJ4Kpkr
AjGA0WLAI/yonh9B63BXkHIg2pcVO0v/EkT+DFGmFvfNI2T8X0ZCzC+harkpBd75
kcgdNavlg7762llJ393Stv0YTnSgRFEY6BShCQrFDLPlv9uu/jh8Cfd24Dk5nzBW
2pKTo1AxScMBi64GlHowoYTanloSNhPRqY6UleowMrjmEq1ncUuqqNQ7fMYxnf8r
RrwFUJ6fWR4v9X3R6cd8d3G2SkRzQ2HiGwtbWh1EkRnTs2mq/BnOfcVm18yNMC1a
mdcRXDSWg01dDYTIzHwjgJcNwnPQVN53mYvYfXMFO0ubupXC8Lfroqw3nczvVZCT
3WBrLlvefHsaWiF7EPkPGHDdrAkZEqG8iurm8m43ajJ2G60dAq+pANVthmjFbnIL
7cCX1x3XcSqap58CN7ff0OuUKkwxlvH6DKVFjFeZfS/679Ylge6fePQZAT+dH580
jyZNceRm0qj0gJYckW2PKUBsCjh/WD17nUOYDrnrTtkiy1Y5stQ=
=V9Jo
-----END PGP SIGNATURE-----

--mpfu5uoso7gev4gh--
