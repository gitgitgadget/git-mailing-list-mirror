Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DD1D88D7
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775381175; cv=none; b=Khh982RZc+32FYHCjdPR5seWucvJNsT/4ztkZv3rJbZXd9bR+K1KfUILdxZOG/mnw4kCXLyuYLEOnqgRI34LeCMLVEA1rEq43u+rWWZjLiejPvVA4b9ENJsYmaM/NA7gOv9Xygdc3IB8JzCKoZMVwuu2EyYnf7wTQq/qfG2cC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775381175; c=relaxed/simple;
	bh=xKJ9aBm3aie8gLXNWKOynOsIzvgc+nSb+RcSpx4et/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sVDClJgdHKLG322Rw1adbvIRt8fuK+We0i4De3kXh0RH4hHgqXHIQeMx3rzy1VFUPGc6xoFNZhreFx2rEdenZiu8WDxHDjEgEOZxq/vWfGqBMSxZgAhDPhGBcER6CFrwvkXt2isgk6gf5DdiYXVkMwQjGeVcdvAy894ha7mNQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ufv0nZz6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ufv0nZz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775381164; x=1775985964;
	i=johannes.schindelin@gmx.de;
	bh=FdRlsOAEPH3eOFu56bRM9ur3Z1LjOuM6mxB5jI5SVDQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ufv0nZz6tSRAE3PUO4nKvZ7sLOdO47FZzvI7fMmxUH/v3wq5tirHX5Sw+tp660ug
	 VPPqw4IyvoNCCRz/r0Ybn06zDr2uIuEneoRvgcv1nhLEZFHzqnaQ6psS9J0icNmfE
	 2aL2Zj36xEIMSKqaPp70ykR7zn1D9yzr2hZn1fxY3hnq2zy55D4B8FSSglGxkY/bs
	 kt7Esqk7MnsneijF3ASf5lrOXrJYUNACW3Z3Lwd3R0wVqP6AFlZ3iD4H5Gt2+IPHA
	 63IWEViFjZf6PWzUyF+ybxL2KtoHg7ZHOx9qlOhshha5kIVuo9YL5JrYcgkpxB6Oq
	 uGW0VUuaCYpuSHCWlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1OXZ-1vTPHz117z-00zyT9; Sun, 05
 Apr 2026 11:26:04 +0200
Date: Sun, 5 Apr 2026 11:26:02 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paul Tarjan <paul@paultarjan.com>
cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, stolee@gmail.com, 
    gitgitgadget@gmail.com
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in
 tweak_fsmonitor()
In-Reply-To: <20260405051528.74435-1-github@paulisageek.com>
Message-ID: <cd82f960-88ff-661e-1e31-a119beb817e7@gmx.de>
References: <b96ed977-525e-c3fc-a626-db1a4b3da376@gmx.de> <20260405051528.74435-1-github@paulisageek.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vJAGZQWytvoHYZy/Xsnv5Tn+P0v7UqrDazFpdrecUxlJ5rhZkfr
 s4ysE1bhjT8eKVkMA8JlZD0A9BcXQO5qufvIzPBPfUjMdV97jUKAv5xbJknZ3SoRKGwJAvG
 XpiG3MzFzx8q2KIJ8KRZlYyUV5JUKmpgWt+wJG40WTGgGV/1NTjki7cgWFLv4nfJY67G7iZ
 tmkRM0Sedmb5hLz48Ah9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z1XALXoLliA=;gwhboVWHJPvEWNhgsXGJdBstLMv
 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
 b2LeAN5FgSQyee/FDQjHxiAOVnnoZFDcw==
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, 4 Apr 2026, Paul Tarjan wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > So the actual bug fix would be to ensure that `write_shared_index()`
> > produces a hash even if `index.skipHash=3Dtrue`, because that hash is
> > needed to identify the shared index.
>=20
> You're right, and I verified this. I reverted my fsmonitor.c patch
> from seen, applied the fix below in write_shared_index(), and ran
> t9210 with GIT_TEST_SPLIT_INDEX=3Dyes on Fedora:
>=20
>   Without either fix:     not ok 12, not ok 13 (BUG assertion)
>   With only skipHash fix: passed all 22 test(s)
>=20
> The fsmonitor.c patch is not needed. I'll drop it from the next
> version of the series.

Thank you for confirming.

> Happy to submit this as a separate patch or include it in my
> series if that's helpful. Or if someone is already working on the
> skipHash + split-index interaction, I'll stay out of the way.
>=20
> --- >8 ---
>=20
> diff --git a/read-cache.c b/read-cache.c
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ write_shared_index
>  	move_cache_to_base_index(istate);
>  	convert_to_sparse(istate, 0);
>=20
> -	trace2_region_enter_printf("index", "shared/do_write_index",
> -				   the_repository, "%s", get_tempfile_path(*temp));
> -	ret =3D do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
> -	trace2_region_leave_printf("index", "shared/do_write_index",
> -				   the_repository, "%s", get_tempfile_path(*temp));
> +	/*
> +	 * The shared index is identified by the hash of its contents
> +	 * (sharedindex.<oid>).  If index.skipHash is set, do_write_index()
> +	 * would produce an all-zero hash and the shared index would not
> +	 * be found on re-read (is_null_oid() check in read_index_from()).
> +	 * Temporarily force hashing for the shared index write.
> +	 */
> +	{
> +		struct repository *r =3D the_repository;
> +		int save_skip_hash;
> +
> +		prepare_repo_settings(r);
> +		save_skip_hash =3D r->settings.index_skip_hash;
> +		r->settings.index_skip_hash =3D 0;
> +
> +		trace2_region_enter_printf("index", "shared/do_write_index",
> +					   the_repository, "%s", get_tempfile_path(*temp));
> +		ret =3D do_write_index(si->base, *temp, WRITE_NO_EXTENSION, flags);
> +		trace2_region_leave_printf("index", "shared/do_write_index",
> +					   the_repository, "%s", get_tempfile_path(*temp));
> +
> +		r->settings.index_skip_hash =3D save_skip_hash;
> +	}
>=20
>  	if (was_full)
>  		ensure_full_index(istate);

This patch essentially tells Git to disobey the `index.skipHash` config,
at least under some circumstances. While that _looks_ like it works around
the observed problem, it is unlikely to be desirable in the long run
because such an inconsistency is prone to cause problems down the line.

The fundamental problem at hand is that the split-index _requires_ the
index' hash to be calculated, while the `index.skipHash` config
specifically _skips_ it. In other words, those two features are
fundamentally incompatible with one another.

Mind you, I could imagine a sort of hacky way to make them work with each
other: rely on the fact that padding the mtime's raw ytes with enough NULs
to fill the OID array would result in a sort of fake OID that is as
unlikely to clash with a real SHA as any other real SHA. In other words,
under `index.skipHash`, instead of accepting a `base_oid` that consists of
all NULs, fake one that won't fall into the `is_null_oid()` trap.

This approach is still fraught with challenges. For one, a written
`.git/index` file will not indicate whether it was written with or without
`index.skipHash` (unlike the split-index, which results in a `link`
extension to be included), unless you count that all-NUL OID as a hint.
Therefore, just changing the OID that is written under `index.skipHash`
won't work, you'd have to introduce some sort of flag into the index file
format _and_ then you'd run into compatibility issues with other Git
implementations (or older Git versions) trying to read the index file
written with that flag.

So the safest approach I can think of really is what I suggested, to force
the `GIT_TEST_SPLIT_INDEX` variable to be unset in `t9210-scalar.sh`.

It would probably also make sense to contribute a separate patch that lets
Git error out if it is asked to read or write a split-index under
`index.skipHash`, but that might very well lead down another rabbit hole,
therefore I won't recommend it.

Ciao,
Johannes

I briefly considered skipping t9210 altogether if that variable is set,
but then all of those tests would be skipped in `linux-TEST-vars`, which
would be counter-productive.

Ciao,
Johannes
