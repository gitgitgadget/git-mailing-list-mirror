Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A12175A86
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707530; cv=none; b=aTjt61MDGlt9kwSa9jYLfVmmEi+9uVhuXBjOkKa+7XLOejODICNjFNuzop4e59PDrmGxk9uJe4JUykM2WH3RInelkuw6kaD3T2vI1F9yKiBlgpje8ioIgz9FrmrHlbz48FI69oXYpRiaGgE5rFL6ZdKom7yzBenvAadh8xcdb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707530; c=relaxed/simple;
	bh=mIbBnwLSDMl7iZ5xtAHchu0kT1umihGudU5PiPZp4cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN3eSvJtl4h2tUkeskSvxJMe+Svw8hI35ZUqXgKXVf8N3DFvFA/AR78Ri8li1rknqWdZjZ65jn87VkbS8dSp/88NZmh7I7Q64hoio0Zw1JlVZnqklXdoXzrQS9MxVIZCcE7HCOoh0iSUT6gIYJNlvw6Babe9mc7fqwONjnmPyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Uu6qhSvd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Uu6qhSvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785707521;
	bh=mIbBnwLSDMl7iZ5xtAHchu0kT1umihGudU5PiPZp4cs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Uu6qhSvdAgDAGdou9Pa++I5LJUw2+8lwQ3U4vPdb5ZKsgQDtqSHd9vBqZxIR6T9JG
	 Ua79VMa8kB46QYZkgalzEGYaxp+YsWx2qj9FpWA5XEYmFgqSH4TLC2p4zIIiVQlocX
	 mWs174GZZAIvrTWqpqdD2YQ3An+28TPstr7txUKnOYWQHDZYQhxMDBXgNW651rG9bM
	 t0BY7lRmkp3rzSf0/8wONRf2F2I85WbSqx1MahVDUlkuW1DnAko7ZZlNwK1q3KxpdO
	 rJuFuEkPrnlE2CboylvC9Rgl/RZokOp30rwdVXKpFlngF3UA4Plu9NizqURZNXF9Jd
	 konSH6A6TVuvfZwGTyt554PJO1TQbA9PhiDtdhGc6NA2p82li30UVkxjshkh8hAEf+
	 Si5wQhJJH3Pz2104Z7y6D0IDzAT2foZ9wmd/cfZUCfUHSHIoOTxEqfvu1T2kXTzM2z
	 VP5j6mj0R5b74h4QTVaoXnYU4bTUbGMcdCuFvGfPigRX+s3Ia45
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:117f:c26e:50ca:6746])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 43294200C4;
	Sun,  2 Aug 2026 21:52:01 +0000 (UTC)
Date: Sun, 2 Aug 2026 21:51:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Arijit Banerjee <arijit91@gmail.com>,
	Arijit Banerjee <arijit@effectiveailabs.com>
Subject: Re: [PATCH] index-pack: speed up promisor link recording
Message-ID: <am-7_wSb-GNefKlB@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jonathan Tan <jonathantanmy@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Arijit Banerjee <arijit91@gmail.com>,
	Arijit Banerjee <arijit@effectiveailabs.com>
References: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5oeHElVf8Oqz8MHf"
Content-Disposition: inline
In-Reply-To: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--5oeHElVf8Oqz8MHf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-02 at 21:33:15, Arijit Banerjee via GitGitGadget wrote:
> From: Arijit Banerjee <arijit@effectiveailabs.com>
>=20
> When indexing a promisor pack, index-pack parses every reconstructed
> non-blob object into the shared object model to record its outgoing links.
> Since parse_object_buffer() runs under read_mutex, worker threads seriali=
ze
> while allocating persistent tree, commit, and tag structures that are only
> needed to enumerate those links.
>=20
> Read the links directly from the reconstructed object buffers instead. Ke=
ep
> the strict and fsck paths unchanged, use worker-local typed oidmaps during
> normal promisor indexing, and merge them after the workers exit. Transfer
> entries during the merge so that it does not temporarily duplicate the
> complete link set.
>=20
> The typed entries preserve checks previously performed as a side effect of
> object parsing. Reject malformed commit and tag headers, conflicting
> expected types, and targets whose actual type disagrees when the target is
> present in the pack. Preserve commit-graft handling and the existing poli=
cy
> of recording only subtree entries from trees.
>=20
> With three runs per version on Debian 12, median end-to-end wall-clock ti=
me
> for a --filter=3Dblob:none clone of linux.git decreased from 156 seconds =
to
> 133 seconds (15%). Trace2 attributed the change to the initial index-pack
> --promisor phase, whose median duration decreased from 121 seconds to 98
> seconds (19%). System CPU time decreased by 46%.
>=20
> Two paired spot checks against GitHub showed end-to-end reductions of 18%
> and 26%. These measurements include network and server variability and are
> therefore corroborating rather than controlled results. A third pair was =
not
> interpretable because the baseline request encountered a transport stall.
>=20
> A full-clone control showed no material change, taking approximately 256
> seconds with either version. This is expected because full clones do not
> exercise promisor-link recording.
>=20
> t5302-pack-index.sh passed with both SHA-1 and SHA-256, while
> t0410-partial-clone.sh and t5616-partial-clone.sh also passed. New covera=
ge
> checks malformed commit headers, conflicting link types, and mismatched t=
ag
> target types.
>=20
> Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
> ---
>     index-pack: speed up promisor link recording
>=20
>     AI assistance: OpenAI Codex was used to identify the bottleneck and
>     assist with the implementation, testing, and benchmark analysis. I
>     reviewed the resulting change and take responsibility for this
>     submission.

I don't think SubmittingPatches really allows more than trivial changes
written by AI:

    The Developer's Certificate of Origin requires contributors to certify
    that they know the origin of their contributions to the project and
    that they have the right to submit it under the project's license.
    It's not yet clear that this can be legally satisfied when submitting
    significant amount of content that has been generated by AI tools.

    [...]

    To avoid these issues, we will reject anything that looks AI
    generated, that sounds overly formal or bloated, that looks like AI
    slop, that looks good on the surface but makes no sense, or that
    senders don=E2=80=99t understand or cannot explain.

This doesn't look like it's a trivial change, so I don't believe this
patch can be accepted.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5oeHElVf8Oqz8MHf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmpvu/8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5rw2cErxSZcPebEqPNsBOEgSPGjuWegHh41ZBdlqjC3
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAixAP4/n+sYKiOTzVx5uQX132qS+ivY
I/mEWRbgHfB5iA2pbgD/VPOCx8MHCZ4Denc35gJabiCcggq+/e1NWy1BW9tVpgU=
=9o/6
-----END PGP SIGNATURE-----

--5oeHElVf8Oqz8MHf--
