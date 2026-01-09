Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A3500966
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989072; cv=none; b=M/BiIUeJPIvThMxlpGDDlwo974X3Lr9+iLWakmTlV6gNE+iwjDSivEnoe9CI7or7PWTE94E00+KhoIwd+7lqeqNqNROzOiLJFfdOF7URahWJ9akEbO/2lqXHkwYpcrmgthLrDtKIAn1kL2jjr6HnFRstpBLkQGPPL7te2Xt+DnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989072; c=relaxed/simple;
	bh=YG2x/O07MEqv8zwOziDgtLGaUjfw3yWLY04uRxht8Mk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m1368vZqs7Nh31sFgTdk3KizMXI4YEn9vBdtNYYd2OaEkSsglXyM5AI+mzzfRuinfZ4Ymxor56sggX+y0N1XkZKHT3Gz8TumS+J4E8wJl5h7z9EirgEahB5lt5mjATjQa3U06rNL++PJEGBqk7lkMysNR2xQkfPnYhRNUzM7dYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Qmxp508C; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Qmxp508C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767989068; x=1768593868;
	i=johannes.schindelin@gmx.de;
	bh=YG2x/O07MEqv8zwOziDgtLGaUjfw3yWLY04uRxht8Mk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qmxp508Cc9D3SAG8IsuHJEIkc4gFfxoDjQAK17VjRHKMHuJ8mrF19TXKQvduMQMk
	 At3rVchXhQjMJMYSaL0RwWzPcRnoVlf+cEU1y/GabJPRI9DrfjGecWIoxesgZ4roC
	 4KfdyY2zafq0n5KcAFicjA2S7Fc7eD4pQk1T3uT9Vm40IQZHMT7jnY9P6qo7kcm2x
	 UqRpo5zIgIryNF/8RsguYW7G4dZntv/AMoCmapZ4Ap+LWwza/LMSJaTuLGcMHXSVg
	 P3zUltuOLZjrUwp47dTK1GH1ypQ7kWI3NpFTlhBAFOSMm7M3M6xp32M8dwtAaGYft
	 4AQYJeHfxc89IZxTTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4zAs-1voIdE1BJc-017clU; Fri, 09
 Jan 2026 21:04:28 +0100
Date: Fri, 9 Jan 2026 21:04:26 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: git@vger.kernel.org, 
    Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 02/18] mingw: implement `stat()` with symlink support
In-Reply-To: <46b69027-90b4-439a-a14d-61d1bb739b7b@kdbg.org>
Message-ID: <704e952d-7924-00ce-b8b0-ad355e659335@gmx.de>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com> <c36848eda76742f7a7c203868a077b790301344f.1765980535.git.gitgitgadget@gmail.com> <46b69027-90b4-439a-a14d-61d1bb739b7b@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vKKBUbnWGcwxnnoZgnAGZLMMOQBuvHydkH4B4C9Z/nz0zsQFWaq
 NpgdoD+TqAF2KphPomIGFQ2vkcCP2zNvQ0DSn4+O1I+Lw7nEwjTPLg8TZtmU6Isp5bUVxPp
 Mzf9/kj0cOnbfeRDPYhmXyK6mmJQMCSjrsxJGEot6GmLRoZczpaC2LRdjjBBC740CBJtL9T
 HB9hlEm5b3GbyTSMXcJtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lrR3zfsfRUQ=;eVhpTyjPurVtkU2E4rie0uN2VlC
 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
 qqV8cQKk=
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Thu, 18 Dec 2025, Johannes Sixt wrote:

> Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> > From: Karsten Blees <blees@dcon.de>
> >=20
> > With respect to symlinks, the current `mingw_stat()` implementation is
> > almost identical to `mingw_lstat()`: except for the file type (`st_mod=
e
> > & S_IFMT`), it returns information about the link rather than the targ=
et.
> >=20
> > Implement `mingw_stat()` by opening the file handle requesting minimal
> > permissions, and then calling `GetFileInformationByHandle()` on it. Th=
is
> > way, all links are resolved by the Windows file system layer.
> >=20
> > If symlinks are disabled, use `mingw_lstat()` as before, but fail with
> > `ELOOP` if a symlink would have to be resolved.
>=20
> This last paragraph is disconnected from the patch text. I can't find a
> use of ELOOP anywhere in the code that has something to do with the goal
> of this patch. Is this a remnant from early times where symbolic links
> were optional?

You're right. Sharp eyes, by the way, I cannot count how often I glanced
over this paragraph while pre-reviewing.

As to the reason why this paragraph is there: This comes from the initial
version of this patch:
https://github.com/git-for-windows/git/commit/b908441ea594f022e862c04cefe8=
ac73bb8c0ab0

I can only try to reconstruct why I skipped the ELOOP logic in the rebased
version at
https://github.com/git-for-windows/git/commit/0181eb0c78d04f5fb065cbe2f334=
6077b0f9930e
(my guess is that I realized that returning ELOOP when symlink support was
disabled via `core.symlinks =3D false` was undesirable: In particular with
Windows 7 semantics, where symlinks could be read and used, but required
administrator permissions to create, that flag was meant to turn off
symlink _creation_, but reading existing symlinks should work
nevertheless).

I'll simply remove this paragraph from the commit message.

Ciao,
Johannes
