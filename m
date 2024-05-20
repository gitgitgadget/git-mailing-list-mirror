Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A64137C42
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233011; cv=none; b=M0UNBfXbo/QBaJZbFFPT3911qYM9I+Ia0QfybPCE1fh7EoV/0aNT6zwO8Ff4hde2LHzYRGg8pwbZ6s3JBwIUTsyL4abYaph6rkHNwau64jlna9rSxacIMcnDI9Kt9IifvzVUk7wwHDMWMMF/etsop0vKes7bYUnKiX0YfE+Q7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233011; c=relaxed/simple;
	bh=DkBC9J60Lj5eVVaN/r3YAo4P4s7Z0GXQE/1O+GdmMyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6iwvIzmeVqh3kOYi2v0EgeUQ70UwD+gl6osimTkgzC9/+14hNc3V7kee+sungZEMSNiHgXNDtuMZPufhSCPsxXTIknXWfqEPQ1gXGlSiVLvK65zyAVJtjcFACwtuEsH1v4PD67KB19VnQni4UHD4A5rT1fR2iJelP+WfO0N4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=T/CNEVH4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="T/CNEVH4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G6S1+91FKaYiuJbKSZr37FSwxInvjkjtTJgLZAu6YVs=; t=1716233009; x=1716837809; 
	b=T/CNEVH4uVtVPO6PnHH7qeyKipZLOgB1DrqG1H66J2MNJ9+ISbfufQpKKCLXuMrlhjRYKTcD9s2
	S0RWQVRfnJyBLaq6u8QG2johuijqmzFafrlbu0cIfXcM26oVlIPJG1DsFQwJuTuktOQTmcBJg/6+k
	hDQUhCtxELifQgW8cVK3m8fRqOExoqX7T/8YpdGVEF9gOioZJaWm9h3+lhmS5XgqHafA0TkAZ8Y1/
	5hlmtSXU6wJVmpbuHhCpNoPF/ZRwKopmdwAQjJ+9Rre7GTOuK0vfaKFn7qdcsHSKIC+J7BD1Qd0ns
	VOwsB1Zbka8si9XUHS+BPlNUjzNUnwMMjA1Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s98bX-00000001mpk-1s99; Mon, 20 May 2024 21:23:27 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s98bX-00000002TFS-0Ycm; Mon, 20 May 2024 21:23:27 +0200
Message-ID: <b3bef1539c4f81780b5f705e55b12898cb084254.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] improve chainlint.pl CPU count computation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, Junio C
 Hamano <gitster@pobox.com>, Michael Cree <mcree@orcon.net.nz>, Matt Turner
 <mattst88@gmail.com>
Date: Mon, 20 May 2024 21:23:26 +0200
In-Reply-To: <CAPig+cQYJL+6J9PJX-vrNRXJ4TUCJCQRDQstUnPf4OOwOVCUnw@mail.gmail.com>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	 <20240520190131.94904-1-ericsunshine@charter.net>
	 <277726443f533446be4391cf2aa3d487974a7a18.camel@physik.fu-berlin.de>
	 <CAPig+cQYJL+6J9PJX-vrNRXJ4TUCJCQRDQstUnPf4OOwOVCUnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2024-05-20 at 15:19 -0400, Eric Sunshine wrote:
> On Mon, May 20, 2024 at 3:17=E2=80=AFPM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On Mon, 2024-05-20 at 15:01 -0400, Eric Sunshine wrote:
> > > From: Eric Sunshine <sunshine@sunshineco.com>
> > > This series replaces a patch[1] sent by John Paul Adrian Glaubitz to =
fix
> > > chainlint.pl CPU count computation on Linux SPARC.
> > >=20
> > > Unlike its predecessor, this series also fixes an underlying problem =
in
> > > which ncores() could return 0 which would result in chainlint.pl not
> > > processing any of its input test scripts. Patch [3/3] also fixes CPU
> > > count detection on Alpha[2].
> >=20
> > Works as expected on my Linux SPARC machine running Debian unstable.
> >=20
> > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>=20
> Thanks for testing. Were you able to check whether it fixes CPU count
> detection on Alpha, as well?

I can test on Alpha, but that will take a little longer as I don't have
my setup ready. Will try to report back by tomorrow.

Let me CC Michael Cree and Matt Turner who both own fast Alpha machines
and might report back faster.

@Michael, Matt: Could you test this patch series against the current git
                development tree? It should fix the testsuite on Alpha.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
