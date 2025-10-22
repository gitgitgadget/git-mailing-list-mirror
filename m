Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B0351FA0
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149999; cv=none; b=CsJ8AFeFgyOgqfor6K6zfQvaX6vPkCF6K+RmF92Zbg6ecXH0afDunt2846htCCN2DJ4GW9jJOowWiloxlQQ8EhCDVQluG65zZ1OygppINtSTAuAp+PWp/7PMjUc/CPMJUF1VxOAzVDY1l7QJE0TubBlzfZGo76iqz3DwJJAk/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149999; c=relaxed/simple;
	bh=pra4xY096rlywzeXZXBInmEKCoWf3+JivMaLwQ1R+ok=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3ZLPALG4DNqKtk5K5FVZzYfuwFiYcuKLwJk9hvG+zd6qgidvYG+1pSh3K7VekODvDKNoH0aHn8e8v08KajAEduKliF8q+eWinqimJBCdBodDFuyKavEY7z/iF2gOtJ86nhNQNSWIi0HZJdhqWQOD0LHchXzqFJi4mZZVCobw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=bX+chVf5; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="bX+chVf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1761149989; x=1761409189;
	bh=pra4xY096rlywzeXZXBInmEKCoWf3+JivMaLwQ1R+ok=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bX+chVf5/f4loKk0MLn3KU5O7PlSB8YcUaNDFv/+QWyAI139ne387axXIY6uoaTnt
	 oUsRiKoV4UX5t3a0mA/3/tE0vWgD1H8mIc+8B3lfLFkqBM4Tux5SjwkMwOAKTnAT8k
	 bCuidN/sdq9eQGbXmRmmAzwUtukdVjuJdJlFC6dCbUaNQIHuSgJxEmTfNT24++hp54
	 PY9T8ddGY6SM9Eow49yvCmnZunbVhUqGJzaYHEvotEVLZn8hi2E63LqOQzY2jJcqGJ
	 7nPpY3K4YFlqNFVnAa/sU3gMjyh7xW8Oft0h/As7+avqT9FKAqImCsgYIx/5mKqPB3
	 oeVwY/e+gvE1A==
Date: Wed, 22 Oct 2025 16:19:42 +0000
To: Jeff King <peff@peff.net>
From: Sruteesh Kumar <sruteesh.oss@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] match_pathname(): give fnmatch one char of prefix context
Message-ID: <XGY0s986kDTgWo-2zVwFk7RpjILTHu_-8ngClGh34WTFEvdYbDGe8j2-oX680ufpA1M3vnekbylzLgWJegDHkXolkNbW508cGJNOoLM1mec=@protonmail.com>
In-Reply-To: <20251014003404.GC1507@coredump.intra.peff.net>
References: <n_EjA_jj-d398XOogazunHfOBdh-yoa5P-Prb3b7gjkBODqWMtvKNdhnCLuikthwVcbEy4-ryWTRgyuiShJ3tam93j8S7lmGSlyFjNoxzSo=@protonmail.com> <20251014003404.GC1507@coredump.intra.peff.net>
Feedback-ID: 82334824:user:proton
X-Pm-Message-ID: 18f1f4486b87ae1a92e9e37fb93fe0e2e2c72a15
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Although this feels like a hack, it fixes the issue without impact much of =
the code. Otherwise, we would get regression issues. Someone from git commu=
nity, please check this once.




Sent with Proton Mail secure email.

On Tuesday, October 14th, 2025 at 6:04 AM, Jeff King <peff@peff.net> wrote:

> On Fri, Oct 10, 2025 at 02:57:07PM +0000, Sruteesh Kumar wrote:
>=20
> > Look at the first scenario in the above link. Git is matching the path
> > foobar with the pattern foo**/bar which is against the git's official
> > documentation (Look at the last point in the double asterisk section
> > at the URL https://git-scm.com/docs/gitignore#_pattern_format).
> >=20
> > Is this an issue with the code or the documentation?
>=20
>=20
> I think the code is buggy. Here's a patch which would fix it, but I've
> marked it as RFC because:
>=20
> 1. I haven't entirely convinced myself that there aren't more
> complicated variants of the same problem.
>=20
> 2. It's kind of a disgusting hack.
>=20
> -- >8 --
>=20
> Subject: match_pathname(): give fnmatch one char of prefix context
>=20
> In match_pathname(), which we use for matching .gitignore and
> .gitattribute patterns, we are comparing paths with with fnmatch
> patterns (actually our extended wildmatch, which will be important).
> There's an extra optimization there: we pre-compute the number of
> non-wildcard characters at the beginning of the pattern and do an
> fspathncmp() on that prefix.
>=20
> That lets us avoid fnmatch entirely on patterns without wildcards, and
> shrinks the amount of work we hand off to fnmatch. For a pattern like
> "foo*.txt" and a path "foobar.txt", we'd cut away the matching "foo"
> prefix and just pass "*.txt" and "bar.txt" to fnmatch().
>=20
> But this misses a subtle corner case. In fnmatch(), we'll think
> "bar.txt" is the start of the path, but it's not. This doesn't matter
> for the pattern above, but consider the wildmatch pattern "foo**/bar"
> and the path "foobar". These two should not match, because there is no
> file named "bar", and the "" applies only to the containing directory
> name. But after removing the "foo" prefix, fnmatch will get "/bar" and
> "bar", which it does consider a match, because "/" can match zero
> directories.
>=20
> We can solve this by giving fnmatch a bit more context. As long as it
> has one byte of the matched prefix, then it will know that "bar" is not
> the start of the path. In this example it would get "o/bar" and
> "obar", and realize that they cannot match.
>=20
> In the case that there are no wildcards at all (i.e., the whole prefix
> matches), we'll continue to return without running fnmatch at all. We
> just need to account for the extra byte in our adjusted lengths.
>=20
> Signed-off-by: Jeff King peff@peff.net
>=20
> ---
> I wonder how much this prefix-matching buys us in practice. There are
> two cases that are helped:
>=20
> 1. When there is no wildcard in the pattern at all, we skip fnmatch
> entirely.
>=20
> 2. We do a raw match of the prefix chars, shrinking the size of what
> is passed to fnmatch.
>=20
> My suspicion is that most of the improvement comes from (1), and it
> would be very easy to retain that case and get rid of (2). But I haven't
> done any measuring.
>=20
> dir.c | 9 ++++++++-
> t/t0008-ignores.sh | 11 +++++++++++
> 2 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/dir.c b/dir.c
> index 0a67a99cb3..764400d9c5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1360,6 +1360,13 @@ int match_pathname(const char pathname, int pathle=
n,
>=20
> if (fspathncmp(pattern, name, prefix))
> return 0;
> +
> + /
> + * Retain one character of the prefix to
> + * pass to fnmatch, which lets it distinguish
> + * the start of a directory component correctly.
> + */
> + prefix--;
> pattern +=3D prefix;
> patternlen -=3D prefix;
> name +=3D prefix;
> @@ -1370,7 +1377,7 @@ int match_pathname(const char pathname, int pathlen=
,
> * then our prefix match is all we need; we
> * do not need to call fnmatch at all.
> /
> - if (!patternlen && !namelen)
> + if (patternlen =3D=3D 1 && namelen =3D=3D 1)
> return 1;
> }
>=20
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 273d71411f..db8bde280e 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -847,6 +847,17 @@ test_expect_success 'directories and ** matches' '
> test_cmp expect actual
> '
>=20
> +test_expect_success ' not confused by matching leading prefix' '
> + cat >.gitignore <<-\EOF &&
>=20
> + foo**/bar
> + EOF
> + git check-ignore foobar foo/bar >actual &&
>=20
> + cat >expect <<-\EOF &&
>=20
> + foo/bar
> + EOF
> + test_cmp expect actual
> +'
> +
> #########################################################################=
###
> #
> # test whitespace handling
> --
> 2.51.0.754.gd4f5ded95f
