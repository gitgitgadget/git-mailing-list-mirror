Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA68329C40
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851019; cv=none; b=o6fnGVEeqz8RziE61SNFiVYCR5//AdGotol6ltYi4X2Hvahw9O8R4ZmCCGELhRdooYOLqRZYanT8EGdDMlWX/2stsK1eyJnXBgUuHSeQbKr/E38+qwNMsgv0EfCUmy7+SQHQ0SkbWQRs9DxGOBZfiNGBIX1iSox+kL+BMXyvVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851019; c=relaxed/simple;
	bh=c7Se8FbbGCQfxYEgcQjkiJYDkeV/QX3wBI9b2qAINq8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=as8PJ+DhoMpSvLvSZITc54g7oWIMrKRGlx2pkEqcfUc5KE9isifcLz2ndCGKEtu8Z+vsxWG9CbsxDATiym6Cpc0aSaBbdayuyHN5zANUaqNN2e174YSOSVRsAccQmsUAdT+/v50OKq7QUNhxIpBaepM48mfMjieP2NYv8DQnyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=L2kLTaOi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="L2kLTaOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776851011; x=1777455811;
	i=johannes.schindelin@gmx.de;
	bh=6myfhFvzCmrCEn843RWvrlj4cSyf+Nsq5gfYC5f+D54=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L2kLTaOi8Bbnqb8zyyDwwxSReLiye67N2ymM+YT4271I0fXelocdtvTwVQiX64TL
	 7AXV6icFajqA2voo7sW83/DEP3KDgEEyAj+inx4BmI99ts2CClVv0Ike6nfSbsrTP
	 C+xW5+GjKuexnh73279FcTIdDoVkIa5AgEy1qeU8fkEvuwtnzQCC75NqgOu/pd2H8
	 4VrkhKtNFbVMxIeWiaoNddefKoZ8Q3zS7/Q/0XW91VRXPO/uhQpGOnZfS18r01570
	 v35ztD3dcnUZJYlluVY+yBcbNZo8orMc9BUnRUb8Vk8iDG1AwLUzv7TltaF5WQdHC
	 INxLsg69W8TvSk2+mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1vZ2dJ2uO6-00ZT3N; Wed, 22
 Apr 2026 11:43:31 +0200
Date: Wed, 22 Apr 2026 11:43:29 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Colin Stagner <ask+git@howdoi.land>
cc: Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org, 
    Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub, 
    Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <cca575ae-e5dd-4a5d-bde2-f493a3e62a87@howdoi.land>
Message-ID: <02c82c5c-6bc6-e298-3002-e6d322bdb957@gmx.de>
References: <20260215201748.889866-1-ask+git@howdoi.land> <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land> <27104.58166.993109.63505@chiark.greenend.org.uk> <a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land> <27109.13129.424068.382997@chiark.greenend.org.uk>
 <27109.63619.90318.366157@chiark.greenend.org.uk> <cca575ae-e5dd-4a5d-bde2-f493a3e62a87@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rh/p9sFmkwmBEYGwGJdGcEy5pDEaLUe6sgtV6v6NQjdfALhUEgq
 m++mpoN2AAda96TphiEjgMxsVT9g0yOmNmpDjfmyOKlLhKxaBbretah1bQ7Zn5WllfEg2t/
 /Mo9Yo9KqusVakWw7N5Xqe/b1xkKU5kEfCMF8euuXAgPt9gCEkWOgJDASEDbVeZqKRJXflm
 HwMKLA2Y3wdhYFuHPT1GA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/Fmu+5AFlPI=;jWCNJzdvr/krBFiG+NR+sJXufuV
 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
 MJ2MbE7QxuTV/Su/aVKZ0IaQ==
Content-Transfer-Encoding: quoted-printable

Hi Colin & Ian,

On Wed, 22 Apr 2026, Colin Stagner wrote:

> On 4/20/26 04:57, Ian Jackson wrote:
>=20
> > I need to think about this some more but I doubt this can be made to
> > work well without more significant changes, including to the data
> > model.  There would have to be some kind of compatibility arrangement
> > to handle existing histories.
>=20
> I would take a look at the test-cases for git-subtree.sh, which document=
=20
> some of the kinds of issues you will encounter. They may help you test=
=20
> compatibility.
>=20
> Anything you can do to limit breakage to "opt-in" points-in-time only=20
> would be greatly appreciated.
>=20
> > Colin, is that OK with you?
>=20
> You can name it and develop it however you like. No need to ask=20
> permission here.
>=20
> (For the record, I'm also not the maintainer of contrib/git-subtree.=20
> I've just been trying to fix a few issues with it.)
>=20
> > If you would prefer, I could choose a different name for the
> > resulting program.
>=20
> If I were writing it, I would give the new program a different name but=
=20
> perhaps provide a "compile-time" way to set it to "git-subtree" instead.=
=20
> My reason for this is that it may need to exist with the legacy script=
=20
> for awhile, and it's good to be able to tell them apart.

I just wanted to chime in to cheer you on, I've been following this
Rust-based `git-subtree` idea with interest. You may know it already, Git
for Windows is shipping `git subtree` with its installers for ages, and
given the abysmal performance characteristics of shell-based Git commands
on Windows, it would be really good to replace the shell-scripted version
with the Rust version (also to ensure proper error handling, which is
hard to make comprehensive in Unix shell scripts).

Thank you for pushing this forward!

Ciao,
Johannes
