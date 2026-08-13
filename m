Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC23E49D8
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611895; cv=none; b=l3B8DPflGy6ejcmMK8jIzVjYbJ23ScDcnI6E8KbsRDHKgMBTasVdblbBxfdpnnaLf+yKhHaq//Np2rGueDdx6+KM9HShEUYpy3D5aE2lycr0QixbmTXFVJD6A2rEHIFX6N6u8+GMeNWei4LnhMIOd80MS+sRsbbb9fFKlEJVp24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611895; c=relaxed/simple;
	bh=Z4R/TYQ19RqRMpx3v9U34bZNspbS//8axOfyhi6wsoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tutXi963yCjx7Zj+gwVJbyQSLSa94DjCQSKZTMucmL2+zBZGVG5tzf4SR34si6pzIHdBJT7K7WK4agJeZU6XxfxlR2pnAY3tyZp3ciYiBJxNrKZ/4pCTE63q7MZ5vHqpfQb4AoaAiUMjMknPgMD49GUCDqG5sz/AxZMUac1d4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=XGqRwkGH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="XGqRwkGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786611888; x=1787216688;
	i=johannes.schindelin@gmx.de;
	bh=OQg7gRHG8f5fn5u4ufuOZnjbX1ENyl8h59rDdLVFVts=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XGqRwkGHd/1zXHe8d7QF7x+XlJsXGUEGjSnu+1sLPfzq5Evdz+MDhsN2mZ+wuywa
	 paUkZFlCqUMbZfaNP2sWQV0lbtjnFg6fNtK/hC7RDr3mqQmaIFkR5EQ1E6IzIxCFd
	 FE8fgkSMjRtfFf+spGAT/mX4kDNuRd/Evg0111pW2xVUqO5hl2o0YTONCSbQOxsON
	 bvJEBPUSHIfvvqMuyc0BhYP0d8jxEa9w7n8CgBkZN3oLV/9VArwJ/3AtJpwVd75E0
	 BgTKZt2LY4dvm+LWIF8Jgrlwbjm+Rq8C6ikjekqrAhSEA6uPbf/yDZNeWDm6MR2hN
	 PtPp6eXiEeK1A8rspQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mBa-1wztv137vQ-0151VV; Thu, 13
 Aug 2026 11:04:48 +0200
Date: Thu, 13 Aug 2026 11:04:46 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ben Knoble <ben.knoble@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
In-Reply-To: <6EA76E66-E80C-4F19-8806-FAE8294ACFB7@gmail.com>
Message-ID: <704409ee-0319-7493-cdc9-8cdb0fea1ace@gmx.de>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com> <6EA76E66-E80C-4F19-8806-FAE8294ACFB7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=832332967075484217866118881863
X-Provags-ID: V03:K1:rQ45IECMFNdyR54zygXK+KYQizXXT/jvJ6qIeXe5PcpnoPmErK0
 Ov0yABSB552mK0/qRh5WT/Cvr3faYQTIH5EzwyALgnDGIpI5xkAoXqIwwu4Gi981YYJLFcc
 R0XZzd1irJYNLztHHJjlCZ46figdNPuP2pXW0FufvfWwEuUUmSqsXdV7BHO6mhcjHBm1NE4
 KmaXTAqYHla0FsZvDHhBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gWPNJnoWJOk=;OwFWqnWJacQBCPqRc6A40u6/41W
 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
 sa+XGnxEvKiXL2Bx9hG2lii73DbI=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332967075484217866118881863
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Wed, 12 Aug 2026, Ben Knoble wrote:

> > Le 12 ao=C3=BBt 2026 =C3=A0 15:15, Johannes Schindelin via GitGitGadge=
t
> > <gitgitgadget@gmail.com> a =C3=A9crit :
> >=20
> > [...]
> >    packfile: fix perf regression with many packs
> >=20
> >    This issue was spotted by a Microsoft Git user with the massive
> >    amount of packfiles typical of an average, long-running monorepo
> >    checkout.
>=20
> As a different kind of intermediate solution, would turning on
> maintenance for that user=E2=80=99s checkout help? (Not sure that would =
help CI
> clone times unless the server repacks, of course.)

I should have clarified that the issue is a _Scalar_ clone. And
specifically a _Microsoft Git Scalar_ clone.

This matters because, for various reasons that I don't want to elaborate
on because today I'm in need of lifting up my mood, a substantial part of
Microsoft Git failed to get upstreamed to core Git.

One of these is the "shared cache repository", i.e. a bare repository that
is established as an alternate of the actual clone, and into which the
actual scheduled fetches go. For full details, see
https://github.com/microsoft/git/commit/55226d12ed36 (scalar: do
initialize `gvfs.sharedCache`, 2021-05-03).

Now, maintenance _does_ run, usually, on that shared cache repository
(being careful not to inadvertently drop objects merely because they're
unreachable within the shared cache repository). So theoretically, you're
right that maintenance should help this issue.

For reasons (which I don't have the time to find out, but I suspect that
maintenance simply takes too long and does not finish by the time the
machine is shut down for the day), it is still not exactly rare to find
setups with five-digit packfile counts. And since we _can_ handle this
more gracefully, we should ;-)

Ciao,
Johannes

--832332967075484217866118881863--
