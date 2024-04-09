Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63234158209
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695338; cv=none; b=A48NG4hdq2zO8Yw0+7ctyBZBVAdx6+L2N3mIp5PxY/d/hfzyDl0e6h0qMxXDNvym8+m3epTi2JewK9KdahDA6RnIZ8CNvYg/fUn61ETYZrkfeRZ4MKk2zB4Q6R0GQlTyj1GdhxOQYmC9bwf4O2+lFP+uO0MA7x11L58nZk7lHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695338; c=relaxed/simple;
	bh=HlUniqbXDVEI4t4v95IW/oT6633x8Mjjs4n7yLGrdmU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dz6AXdZjf4ipcZg+FQXRhqED12CLnACy07denzrZXt5s+PAnPuarMn7Pq4m4lK1fC8sL5mMS4IhFev5n7KCSGeEK/XEaNT3nqiF459bu9Voka5ylFqIjhgG29qBWDcrDylbsMpQpx50zdQ7t2xdPYJOTLNuDmT/UJIanYzkG4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=Ig+ExyJN; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Ig+ExyJN"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <psmith@gnu.org>)
	id 1ruIIJ-0006q0-4C
	for git@vger.kernel.org; Tue, 09 Apr 2024 16:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
	Subject; bh=xZsjCDz5XufmoVBGWm6OFf2fpO9XrEM/9v1oyZJKGno=; b=Ig+ExyJNL1+NY/92u
	jsc0EtuohsOWiy9runBOARpeSW/ccFVsJhcEmU3KdC6OyQqy6bFAk4QgR8eaJ4338dZ5qcC3nZP89
	xz0QZzGAsryBqjQIT1NcD3Pr1sRz+lRjCOKKHNfnvrXuTJgRHyJZRTfNgVHp1yx5enfXYBV7aY//6
	jYaajZOXt2bLJeSvU5my/2aXz3522hJin+7wksFh2692dZTZPZ1tDr/p6VsuiQXw44ZmK4ncXmbwa
	3pourG6DqEtrku8Xclp84TS8Q2/mqGdFl5rU7jLblkm31GCCVUVgmBvUCrYwhePk6bOivORTDnUGq
	RcJZMM/qW4uLBf+3w==;
Message-ID: <95f2454e449cc0126aaa40d2ab08c76b55ee3c31.camel@gnu.org>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional
 statements
From: Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To: git@vger.kernel.org
Date: Tue, 09 Apr 2024 16:42:14 -0400
In-Reply-To: <xmqqcyqz5sie.fsf@gitster.g>
References: 
	<CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	 <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	 <xmqqle5n8rcr.fsf@gitster.g>
	 <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
	 <xmqqcyqz5sie.fsf@gitster.g>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 16:44 -0700, Junio C Hamano wrote:
> Paul Smith <psmith@gnu.org> writes:
>=20
> > I'd love to do that as well but unfortunately there's just no way
> > to get coherent behavior out of GNU Make if this TAB prefix is
> > allowed.
>=20
> I wonder if you could ease the transition by leaving the current
> parsing rule for conditional constructs that are indented with HT
> and clearly mark them as "works as best-effort basis---the parsing
> bug for them may remain",

I'm not sure I understand the suggestion here.  If I preserve the
current parsing behavior what do I tell people who cannot get their
makefiles to work because the current parsing doesn't allow it?

> introduce BSD compatible .if/.else and friends, and nudge the users
> in that direction.
>=20
> Having to use two different indentation style in the same Makefile
> is simply a nightmare, and that might be a good enough incentive for
> users to move to the new "you can write with dots like .if and that
> way you can continue indenting with HT".

I agree that it's a nightmare, but IMO trying to continue to work
around this terrible original sin in make (using TAB as a non-
whitespace token) by adding new keywords is the wrong direction.

The right direction is to STOP using TAB as a special token and turn it
back into what it is in other languages: simple whitespace.

That was already accomplished back in 2010 in GNU Make 3.82 with the
introduction of the .RECIPEPREFIX variable.

