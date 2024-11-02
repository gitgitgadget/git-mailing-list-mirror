Received: from jupiter.mumble.net (jupiter.mumble.net [74.50.56.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097D1922D6
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.56.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554515; cv=none; b=uct94E/P4d5DSIAftaAKx8AvYOeqp6nbk5KPiabXL+lW18IY7NB5us/aw0U4DL3IMx5wnPfeqmekPH5JpgTbYiDXOipQl0LaT0m2I8AvukMrdYVovHA0dQq0A0DPtSSHaTxp8tBx1WmPJ3HLYn/4o0uoZ022YEybFFRDDQRMRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554515; c=relaxed/simple;
	bh=kvAbu1aHummCN4gmCkxttCrHPiUtsKpR2pBSseZnPk0=;
	h=To:CC:In-reply-to:Subject:Date:From:MIME-Version:Content-Type:
	 Message-Id; b=ISIkLTEYDFyq7zIo3sfRVXafycbXe0+VJNkjWduLEmQ9+/LziJka0oPIpAWy0R9djCYzZ19lPPWL1Rf1HIkAMlJ64bquWqD8HxNox7/qIzqAPKaWMGg5WNHfnoCIDMJYPpEzXiH4rmAp+i/ocq3nY/wwEEvIJyDaB/cqrj0AyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net; spf=pass smtp.mailfrom=mumble.net; dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b=bXLmfKdL; arc=none smtp.client-ip=74.50.56.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=campbell.mumble.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mumble.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mumble.net header.i=@mumble.net header.b="bXLmfKdL"
Received: by jupiter.mumble.net (Postfix, from userid 1014)
	id 6375B609AC; Sat,  2 Nov 2024 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mumble.net; s=20240127;
	t=1730554511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=kvAbu1aHummCN4gmCkxttCrHPiUtsKpR2pBSseZnPk0=;
	b=bXLmfKdL+ljXuWrbM4Yf9PLDlG/0+dTkCF17kVYJzHPF1aehMtbewT7ETPO0hHIeUfsKsT
	pOHNZMmS+a/vHInoQN3b14smoS4Y6RaOcEOwafoyAdbgMHntI/dSWxOHphADetWu6kLgX4
	895dFEts9t7Ge6xaB1MwpT+fBcQJp5w=
To: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
CC: git@vger.kernel.org
In-reply-to: <D5BM0CBSPT9I.97E2CAX9DE17@cepl.eu> (mcepl@cepl.eu)
Subject: Re: Synchronous replication on push
Date: Sat, 2 Nov 2024 13:35:11 +0000
From: Taylor R Campbell <git@campbell.mumble.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20241102133511.6375B609AC@jupiter.mumble.net>

> Date: Sat, 02 Nov 2024 11:09:52 +0100
> From: Mat=C4=9Bj Cepl <mcepl@cepl.eu>
>=20
> On Sat Nov 2, 2024 at 3:06 AM CET, Taylor R Campbell wrote:
> > Suppose I have a front end repository:
> >
> > user@frontend.example.com:/repo.git
> >
> > Whenever I push anything to it, I want the push -- that is, all the
> > objects, and all the ref updates -- to be synchronously replicated to
> > another remote repository, the back end:
> >
> > git@backend.example.com:/repo.git
>=20
> https://stackoverflow.com/q/14290113/164233

Thanks, but that is about how to configure my local repository to use
multiple remotes for a single git push command, which is not what I'm
asking about.

I'm asking about how to configure a _single_ frontend remote, from the
perspective of developers who are pushing from their development
workstations, so that it replicates to one or many backend stores.
This is, for example, the usage model of Github's proprietary
implementation.
