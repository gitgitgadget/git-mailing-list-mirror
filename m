Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692DB48C3E6
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692764; cv=none; b=MeAqSTFgVQmy21zjdepP4rOwZy8CIQfoiTtrLWWO586ifivHNdYthF2OkyG83ZEw+gruOMlMv3wOWzBdSqQo+vptyi1B/iZNT6ZyIP0tOiiUbOX8WsnCgp5V3qCdmT6KC/MkXmSNfDsFbhIPMDBKwbR4PGaG6dgNK81URC6lLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692764; c=relaxed/simple;
	bh=0HevRyaw4VPHf/s/v5JdgJYDyxWCoXJtc2ny2ODFXtg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OBazQV9DxkgNf7/R2R+W40Z8I5OlgoJbCu3cVSixdtQt3oCRdsnMJB5pL1l60mlR/Vk9q0u/SzHltpRMlusn/F7xQzDtc2fKej3/dnEokkfB7EI/GXZMTsFd+N0RgAHwO4owpPaB2dUZXxfZXOHhUxIX835GGBBinJi4DC3y94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=J+kvc8a6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="J+kvc8a6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781692753; x=1782297553;
	i=johannes.schindelin@gmx.de;
	bh=vSlGCpJBJQL6oCtKDSqLHh+hs76tpkzm3cmy7JiZTcU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J+kvc8a6nCr+Rd8vcWr2Z/K5Mf+q1RWYznPAqnfIXeQrjQmCbkK55Wq/PTltaLVd
	 JsL7INyF1yfhKJg2JEUTiMoaWeZVOeQ/55rSA+QsMPpT1m47vsfkuBxl7BzL/sIPA
	 QL7hmrCIowtjVOGoaF6xx47ua0vMZ+rWGhrDmEy3NTWZoyGMDvlybz9b0dnf7pl9v
	 ZpSdP88pgWiGBhnVFUx01B7ZfCFhKi4Bypoo/sl0bSORY9cJgT1CzWUo5cDZ6CP6A
	 i5vrBwUxLDoCEXc4z+VObfZ5eXKU+q6ezOdZNdVzK96+wsLWjacjcVKX5x1xbSUxq
	 egLTUXcxB9QFjB/AlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1wRnT53lId-003mq8; Wed, 17
 Jun 2026 12:39:12 +0200
Date: Wed, 17 Jun 2026 12:39:15 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>, 
    Patrick Steinhardt <ps@pks.im>
Subject: How does GitGitGadget generate range-diffs, was Re: [PATCH v2 0/6]
 Support hashing objects larger than 4GB on Windows
In-Reply-To: <xmqqfr2m4gd1.fsf@gitster.g>
Message-ID: <fcb9e52a-5f71-1fd0-a18e-c48e22e6e28c@gmx.de>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com> <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com> <xmqqfr2m4gd1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:H3pj9+bKcCtRyNvR7GpkEpg0ffJOjKS8R2jnPiYJ6fPlQzBQ0wJ
 iXfTHOJkzE6GGU2WF5cdwOr5BkdJbsQpj2iEVXlh2VX94cKN901aIinc1V0B12MUOKlz8KX
 Kgy/VH6SiJVLSZWB7Q+z5ZyGJXt2pHHk1LcaWAlWoCigVzt1aJgklZ0l8R8VRYlCxq5wxtY
 Wh2ZmA/pyKMaEny7LGo0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g6BfVQCfkd0=;zHb7lZZl7wtJVX28R20vQBmDBJa
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 17 Jun 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > Range-diff vs v1:
> >
> >  1:  84e1cd0aa0 =3D 1:  9c01bac407 hash-object: demonstrate a >4GB/LLP=
64 problem
> >  2:  809d83e46f ! 2:  aa5859c14f object-file.c: use size_t for header =
lengths
> >      @@ Commit message
>=20
> By the way, how is range-diff driven via GGG?  After applying these
> patches on the same base commit, my "git range-diff v1...v2" invocation
> punts on matching step 2 and I do not get a comparison like this unless
> I give --creation-factor=3D<large number> from the command line.

GitGitGadget is using range-diff to compare between iterations of
essentially the same patches, therefore it encourages `range-diff` to try
harder to look for matches via `--creation-factor=3D95`:
https://github.com/gitgitgadget/gitgitgadget/blob/bf9140eef184/lib/patch-s=
eries.ts#L722

The full details how the magic number "95" was determined is in the commit
https://github.com/gitgitgadget/gitgitgadget/commit/2605f72f92bb0ff63f4db9=
1eaf91969749568dd7
(essentially, I played with a couple of values and known hard-cases of
actual, real-world patch series iterations and 95 was the best
compromise).

Ciao,
Johannes
