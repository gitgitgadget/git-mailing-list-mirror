Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80E13541B
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994109; cv=none; b=OH32kMenmLvyLu2vkAjbUv6Uu6R/S4KM39Kq3YCyhtoV8eZHgqG6MUcEQgW+u9qlVh6OiLe2b2P011ldN/rLEeojrH30FVARllp9iEJvMP7F05k0qzLYdJa6WR1Jwme95DIWzQeQvMrTEi08MBHN9p2o1tAwBcAOZO6aMYkph2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994109; c=relaxed/simple;
	bh=dWSbHzzfPC/8b1zAjF3xzjtleT2r7ppiKZf9dKGM/pw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ab4SVRSIArOTGcMuDsAzyUFSntgKf5aJI+fdtel/pE5eVoj8HoU8pjzmc7DTbARQWeUfDGVI24nsARUNH3wO9uCunYvEvldcEPXye1mL//pwY0ayjOd09LZEamdLSXamOHrZBb4cUl/XGCwK7rmASHoLMQMUffSs1XfG1Es3uFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=V7n7Ii1O; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="V7n7Ii1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741994104; x=1742253304;
	bh=dWSbHzzfPC/8b1zAjF3xzjtleT2r7ppiKZf9dKGM/pw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=V7n7Ii1OVlCpHZ9A5CyobiC6CztQN+qLb385UowhtL4WpliiwLvwo5w4Z+R/OVDU7
	 32AP9/Sn5rhuy/hlalu0GKSFRGDcf+k1O6qR9pM6qnnYkR02nlzGrHHPGdGZfrsTwY
	 TfMdtiC9rpeKgn9Fw2tPreG5FFY0INdkwWdt7tPPqmzY3RzebFayPryJXUz9IouACy
	 LyEpdGDpAYcW0DF2L3ycoebzfP24JLUnbVpC8B60gnQXnoEJ5Q+j1a7ytz+QIhdUD2
	 Q22kQVraNMUMK9pXlQhuDfSA1RRiHq6lvTUwoBDPgskmC4aqGmR2zJAs3e8eCvKRi/
	 1mOPKPVTitSiw==
Date: Fri, 14 Mar 2025 23:14:59 +0000
To: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
From: Jason Cho <jason11choca@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff: avoid arithmetic overflow in xdl_get_hunk()
Message-ID: <gq3mW6C-_CzvRWe7vlXuDni4d2hDajYwmVqqjBC9h-2HhGU9qiyvmzxveXEVwIhBE4X4vkVKsHHYWayWLnQ9gso8HHYbjXi2TxeZaaMnf0g=@proton.me>
In-Reply-To: <4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de>
References: <xXWgbH3mlNEvFcdGLqBHwcclZoeZNPoLg8Hr6YCipHXvS5eKaHeTppzFM-l_wyB46BB1R1T0j6g_jWRXIj7-GRJh1LPxi1ta3GkQ5t8F4-0=@proton.me> <NYMqsJ7uttDzFT2OOEg5LLsxCSoQhTzqBs16KrMHGEKC7LzOAiYnYTEZavRQWqGH41UgjdwScwer7MssNzI7AEDHnD8GTBWvoBIqJ2e7D6g=@proton.me> <4e9b6b4c-aaa1-4c6f-93f4-7bb04607e843@web.de>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: a35673d3fba4dd72703cdacdb999d719a3317203
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Ren=C3=A9,

What a thorough analysis. I didn't know this bug is only on Windows.

Thank you for submitting the fix. I am excited to see it in a new release.

For now I will cherrypick your patch to my fork of git.

Best regards,
Jason Cho


On Friday, March 14th, 2025 at 11:00 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:

> xdl_get_hunk() calculates the maximum number of common lines between two
> changes that would fit into the same hunk for the given context options.
> It involves doubling and addition and thus can overflow if the terms are
> huge.
>=20
> The type of ctxlen and interhunkctxlen in xdemitconf_t is long, while
> the type of the corresponding context and interhunkcontext in struct
> diff_options is int. On many platforms longs are bigger that ints,
> which prevents the overflow. On Windows they have the same range and
> the overflow manifests as hunks that are split erroneously and lines
> being repeated between them.
>=20
> Fix the overflow by checking and not going beyond LONG_MAX. This allows
> specifying a huge context line count and getting all lines of a changed
> files in a single hunk, as expected.
>=20
> Reported-by: Jason Cho jason11choca@proton.me
>=20
> Signed-off-by: Ren=C3=A9 Scharfe l.s.r@web.de
>=20
> ---
> t/t4055-diff-context.sh | 10 ++++++++++
> xdiff/xemit.c | 8 +++++++-
> 2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
> index f7ff234cf9..ec2804eea6 100755
> --- a/t/t4055-diff-context.sh
> +++ b/t/t4055-diff-context.sh
> @@ -89,4 +89,14 @@ test_expect_success '-U0 is valid, so is diff.context=
=3D0' '
> grep "^+MODIFIED" output
> '
>=20
> +test_expect_success '-U2147483647 works' '
> + echo APPENDED >>x &&
>=20
> + test_line_count =3D 16 x &&
> + git diff -U2147483647 >output &&
>=20
> + test_line_count =3D 22 output &&
> + grep "^-ADDED" output &&
> + grep "^+MODIFIED" output &&
> + grep "^+APPENDED" output
> +'
> +
> test_done
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index f8e3f25b03..1d40c9cb40 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -43,6 +43,10 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, cha=
r const pre, xdemitcb_t *
> return 0;
> }
>=20
> +static long saturating_add(long a, long b)
> +{
> + return signed_add_overflows(a, b) ? LONG_MAX : a + b;
> +}
>=20
> /
> * Starting at the passed change atom, find the latest change atom to be i=
ncluded
> @@ -52,7 +56,9 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char=
 const *pre, xdemitcb_t *
> xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
> {
> xdchange_t *xch, *xchp, *lxch;
> - long max_common =3D 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
>=20
> + long max_common =3D saturating_add(saturating_add(xecfg->ctxlen,
>=20
> + xecfg->ctxlen),
>=20
> + xecfg->interhunkctxlen);
>=20
> long max_ignorable =3D xecfg->ctxlen;
>=20
> long ignored =3D 0; /* number of ignored blank lines */
>=20
> --
> 2.48.1
