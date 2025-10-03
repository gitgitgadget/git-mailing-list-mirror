Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095E1DB13A
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491666; cv=none; b=FdXiALo0L8pDLjpT3D/MLi1UK+2lV8zYoVjaHmFEKCgjHvdFNNBn8OttMihx8lYbKJts3ztfXgNNUpjSoffgrcsNUw1qkR5meKNtfrkvGtPjbgDIr9cLM8948ciEDIw77MBUP6D3LIaFvvX0et2wn1b/2sraJh5RRBcVXFxBEYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491666; c=relaxed/simple;
	bh=maU6ajonbxo+6Xh9BHXWps8IKP/jLxjIHucGyMePF9E=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AT5RiHNEo2Q5wHnl+U5JC0HfFecTOgAeez+AhkgBVET48i3ARBZzlQyOLXEISPmj1r5p0Mtjk+mf8elB3yAf0VbOMqmWDHGMm3uAd3fbmvEEZcpaOtA4XBu7sfS5ziU/DvJhG7+UMleztEoFDhdcqL2jjOJzPNzVmG0sAOlPb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=MkCksZUE; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="MkCksZUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail3; t=1759491652; x=1759750852;
	bh=maU6ajonbxo+6Xh9BHXWps8IKP/jLxjIHucGyMePF9E=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MkCksZUElM76777c5Z6JvLdE8pQ9VlgoglYu07kayqCw3oVOhFUYAOoNhcplDQ59t
	 +u524rMYwWlSUchJcjtan/50H81/EJFgpgZ5qqTeZOY1EiRbyz7F4KvT0CUO+I1ob6
	 5drPf9xEj9237ge+Qyl7o1ECA2gMxc1OokCmGWrRo3brkSEfPlX3nhFyVCGAUVV/5Y
	 GPEcks+YkQV7NNULQZtoyLqtWeVLO25J0A/InCEOZvOUTdwTOMZCpzPk/k9A6ByWPo
	 lP3rV+86uLoYsonhAzAcP1MEWnuNN/oFZLHfLnd7wdJqizOSbcT/DZURKd/DFz7zwQ
	 9XVdwC13VVP0w==
Date: Fri, 03 Oct 2025 11:39:13 +0000
To: Jeff King <peff@peff.net>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Sainan <sainan@calamity.inc>
Subject: Re: Could Git be smarter about object reuse?
Message-ID: <B0Y9iigwIf1VSJpVtY_IzINon0LTimi0sIg9B4j8pDJt2FoxHmQ-Gn5C0s0l-GhsHMP2ZptgNbm879BqQgpDOo-CFEOhh-nQqhlISosKoWY=@calamity.inc>
In-Reply-To: <20250923005421.GB2271307@coredump.intra.peff.net>
References: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc> <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de> <2RWL_muy24EPDZ9wWFx-WZfu4Br_F2LenvcVJbKewfSVYipYM3qmeEIgV-6o4EbL39ZjMXtLHbVFOCPcBdHHVAU-0BrgBtuQ9BdRjS_2niE=@calamity.inc> <20250922200510.GC2205919@coredump.intra.peff.net> <ZURUr5sfXi0wsjBeXiwAxyNgalVa2ZveXDgoTcexUNOAgcP_JscHvFFDIss4stpsiB2MzUQ_Z30tFrPSgr8W8V02ecfCj4BFFwQqWwJpba4=@calamity.inc> <20250923005421.GB2271307@coredump.intra.peff.net>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: bb106ef62d04822f01bfd366eff9a0712ef4cb37
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yeah, I have to be honest, I'm not sure 'git repack -abd' is such a magic s=
olution. I have a branch that diverged from main like 1000 commits ago and =
added roughly 30 commits of its own (they're all small commits, at most 1 b=
lob), and yet even with a bitmap it's pushing over 475000 objects when my d=
iverged branch could be expressed in about 100.

--=C2=A0Sainan
