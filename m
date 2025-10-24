Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13231F0E56
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330504; cv=none; b=nOJ5mrq17h8WTO/TwDudyRH8nMGbtGvrkgSBkD5NvuDzkKsIrcuW2aHAdvqhrk/gy9pMnokGJHy+i2J6kImH3C6xJLF4ifuucyYLhaZGCObX2OF5MBZWpydGIUKNFXM1XqsJ+1/0bMvlhRPfKSwYeZsPlp+zvnGvHlKMNZc0610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330504; c=relaxed/simple;
	bh=phbswO9D02433FtFVbDGJtCQwoJ6NKzq2ZRdK4tTc9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/LtKxLRw0YYRXS1JbJ7tD0qJkCJBZjTUg8zVSwUhX8rwdyHo1R4HHYvS+WOrVa7KgNnFbs2ox37l87siMDzZvo9uywZOK4jiKG+kI0Qe59E72FcegxpivKJt/xK0HjxcHxJGGt0UOX8e9Uu3vebZ1HZDuXZOP/e+ouZzHn2Diw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GMnVtlli; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GMnVtlli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1761330493; x=1761589693;
	bh=phbswO9D02433FtFVbDGJtCQwoJ6NKzq2ZRdK4tTc9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GMnVtlli3S646SQvGaEsXi4PVUVM3AB4wQwWIL8f9FJASu9aJt/btcwaLqPy+eIqg
	 4bLs+Nho1C8QW0MBtJMBtH56Qa/cwMS7t9DKS+c3fdtgoNLeLoliGJs9kEPd4k+hPr
	 4ekN53jQAJhbIf0seLtNoF1MH8EZ0yZzYa+kAd6gAjRA/Z9dAdVfa5JbXiQs8DsqWf
	 T1YnkdyxhM3REAGze1WvZwNW5C1d/hmMVxK3RqhS+ahLlBpT6hHkwOLi+SyP0g0B0B
	 ivLPUiMrGdnItSIzodh5QwnTC3CO6qn+HV05btQIWSbF7DHvBMkZN3+8xfBTKGcbNR
	 sfo7mBlPft0yg==
Date: Fri, 24 Oct 2025 18:28:08 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Sruteesh Kumar <sruteesh.oss@protonmail.com>
Cc: Jeff King <peff@peff.net>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <moJ9cWkNELTKMSYO9okcieULpTfQOEYlB1FwGoBEp6cYGDWrZqH9EojvQmvXll6vV6QS5kmvDH_g04JzlGMBGnmEb6Hn7MXB_Q9NKVsABWQ=@protonmail.com>
In-Reply-To: <xmqq7bwltlb8.fsf@gitster.g>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com> <20251014003404.GC1507@coredump.intra.peff.net> <xmqq7bwltlb8.fsf@gitster.g>
Feedback-ID: 82334824:user:proton
X-Pm-Message-ID: b210b891ee6d8d2694c6dbf20c464c50119f9ffb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Friday, October 24th, 2025 at 1:58 AM, Junio C Hamano <gitster@pobox.com=
> wrote:

> Jeff King peff@peff.net writes:
>=20
> > Subject: match_pathname(): give fnmatch one char of prefix context
> >=20
> > In match_pathname(), which we use for matching .gitignore and
> > .gitattribute patterns, we are comparing paths with with fnmatch
>=20
>=20
> "with with" -> "with".
>=20
> > patterns (actually our extended wildmatch, which will be important).
> > There's an extra optimization there: we pre-compute the number of
> > non-wildcard characters at the beginning of the pattern and do an
> > fspathncmp() on that prefix.
> >=20
> > That lets us avoid fnmatch entirely on patterns without wildcards, and
> > shrinks the amount of work we hand off to fnmatch. For a pattern like
> > "foo*.txt" and a path "foobar.txt", we'd cut away the matching "foo"
> > prefix and just pass "*.txt" and "bar.txt" to fnmatch().
> >=20
> > But this misses a subtle corner case. In fnmatch(), we'll think
> > "bar.txt" is the start of the path, but it's not. This doesn't matter
> > for the pattern above, but consider the wildmatch pattern "foo**/bar"
> > and the path "foobar". These two should not match, because there is no
> > file named "bar", and the "" applies only to the containing directory
> > name. But after removing the "foo" prefix, fnmatch will get "/bar" and
> > "bar", which it does consider a match, because "**/" can match zero
> > directories.
>=20
>=20
> Ouch.
>=20
> > We can solve this by giving fnmatch a bit more context. As long as it
> > has one byte of the matched prefix, then it will know that "bar" is not
> > the start of the path. In this example it would get "o**/bar" and
> > "obar", and realize that they cannot match.
> >=20
> > In the case that there are no wildcards at all (i.e., the whole prefix
> > matches), we'll continue to return without running fnmatch at all. We
> > just need to account for the extra byte in our adjusted lengths.
> >=20
> > Signed-off-by: Jeff King peff@peff.net
> > ---
> > I wonder how much this prefix-matching buys us in practice. There are
> > two cases that are helped:
> >=20
> > 1. When there is no wildcard in the pattern at all, we skip fnmatch
> > entirely.
> >=20
> > 2. We do a raw match of the prefix chars, shrinking the size of what
> > is passed to fnmatch.
> >=20
> > My suspicion is that most of the improvement comes from (1), and it
> > would be very easy to retain that case and get rid of (2). But I haven'=
t
> > done any measuring.
>=20
>=20
> The above matches my intuition as well.
>=20
> > diff --git a/dir.c b/dir.c
> > index 0a67a99cb3..764400d9c5 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1360,6 +1360,13 @@ int match_pathname(const char *pathname, int pat=
hlen,
> >=20
> > if (fspathncmp(pattern, name, prefix))
> > return 0;
> > +
> > + /*
> > + * Retain one character of the prefix to
> > + * pass to fnmatch, which lets it distinguish
> > + * the start of a directory component correctly.
> > + */
> > + prefix--;
> > pattern +=3D prefix;
> > patternlen -=3D prefix;
> > name +=3D prefix;
>=20
>=20
> So, checking pattern "foo/bar" against "foo/bar", we'd use
> "oo/bar" to match "oo/bar", which is not necessary but our
> conjecture is that feeding shorter fnmatch() is not buying
> us much, which justifies this change.

Actually, I too just realized that skipping the matching non-wildcard prefi=
x doesn't provide any optimization (Correct me, if I am wrong). We any need=
 to compare both pattern and path until the end of the prefix be it match_p=
athname() or fnmatch(). Any idea why this is explicitly done? May be a smal=
l demonstration through an example?

>=20
> If not, we could do a more targetted pessimization, perhaps like
> this, ...
>=20
> /* the non-wildcard prefix does not match? /
> if (fspathncmp(pattern, name, prefix))
> return 0;
>=20
> / the non-wildcard prefix is the whole thing? /
> if (namelen =3D=3D prefix && patternlen =3D=3D prefix)
> return 1;
>=20
> / avoid making foo**/bar match foobar */
> if (3 <=3D prefix && memcmp(pattern, "**/", 3)
> prefix--;
> pattern +=3D prefix;
> patternlen -=3D prefix;
> name +=3D prefix;
> namelen -=3D prefix;
>=20
> ... but that is even more specific hack than yours.

Yes. There is no way we are doing this. We are literally bypassing this sin=
gle scenario in the code which is not a good practice

>=20
> > @@ -1370,7 +1377,7 @@ int match_pathname(const char *pathname, int path=
len,
> > * then our prefix match is all we need; we
> > * do not need to call fnmatch at all.
> > */
> > - if (!patternlen && !namelen)
> > + if (patternlen =3D=3D 1 && namelen =3D=3D 1)
> > return 1;
> > }
>=20
>=20
> In any case, I do prefer doing this "our non-wildcard part matched
> the whole thing, so let's return true" before stripping matching
> prefix from the pattern and the name (like I showed earlier).
>=20
> > diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> > index 273d71411f..db8bde280e 100755
> > --- a/t/t0008-ignores.sh
> > +++ b/t/t0008-ignores.sh
> > @@ -847,6 +847,17 @@ test_expect_success 'directories and ** matches' '
> > test_cmp expect actual
> > '
> >=20
> > +test_expect_success '** not confused by matching leading prefix' '
> > + cat >.gitignore <<-\EOF &&
> > + foo**/bar
> > + EOF
> > + git check-ignore foobar foo/bar >actual &&
> > + cat >expect <<-\EOF &&
> > + foo/bar
> > + EOF
> > + test_cmp expect actual
> > +'
> > +
> > #######################################################################=
#####
> > #
> > # test whitespace handling
