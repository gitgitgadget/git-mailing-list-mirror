Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098713E3E8
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695328; cv=none; b=fuz8Qk6lffhciruyDsidtR3+7fYffkJQPQtccPI/TzqkKj5OI36Pkg6PYmxaVr07e4V/GLSRO+DYgS4+k05FE9uydpxwES1WfphTJgXFntwHc1g7gdvWVgk4SVew4dyHKuVHTTaKYPFK4lRbCRPU5WywmF6NsvHZB9duMfwjQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695328; c=relaxed/simple;
	bh=Pak/WJhDiOZOLzltyN8TTgHMC7itT889A1l69eFvpLA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GtT8UvG0gAjezGKt2GDXgJtr+H5bBFUljE2vVOi6gG02egRVh9aRVpmUtRBHgz9qt6sU9e5VJqiXBnIIXiUPx4rXnl8x9fHwh/NSg97UN3/k9SNhZ7lf6/EqqYVINVP2gRg/njuvH8nO0m10BIJ4X2RmHdmH0Nqye6ICv2LPAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=jJPxy3lP; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="jJPxy3lP"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <psmith@gnu.org>)
	id 1ruII1-0006p7-EW
	for git@vger.kernel.org; Tue, 09 Apr 2024 16:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
	Subject; bh=sH8F4DYVkYfAMamH7dfUe7Rl5R9zRf4uhJ5fYi08FKI=; b=jJPxy3lPapJGNWzti
	GuAJOBenCB+orob0I9ur7Hj0tdizLAeyid2ru7UB8mFmtDm7RE3kLj9twdvWA7JOAUn3NqNlPFWsh
	6EbSoGxOxG9eThY8gnQuSSh8AaVeXBDGR82HQSYkw1oQptY54KWffbNWTSs0bBTaZrvyo4AAul5YJ
	4nmFn59dlkU1u8xv+66S40B2cLPZ3vpJpdSe+IixMGLIRBrYb3Jnfz1vco+AOripgWKu4+K+asK6r
	3NPlqLHb4DJYBH7o63W3RvJE2lq6xDb29KJDaOwiGrJh1nS+N8TOFcUZYuRvGd2TBRGkZwtCUPjME
	7w3UiZXiCNwIbgmOQ==;
Message-ID: <2b392b30614abd9a110515448853aa43eac42d8b.camel@gnu.org>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional
 statements
From: Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To: git@vger.kernel.org
Date: Tue, 09 Apr 2024 16:41:56 -0400
In-Reply-To: <xmqqh6gb5szm.fsf@gitster.g>
References: 
	<CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	 <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	 <xmqqle5n8rcr.fsf@gitster.g>
	 <606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
	 <xmqqh6gb5szm.fsf@gitster.g>
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

On Mon, 2024-04-08 at 16:34 -0700, Junio C Hamano wrote:
> I am not sure what benefits are gained by the existing users with
> this change to ease fixing some parser bug (I didn't bother to see
> your bug tracker) so I cannot judge if the benefit outweighs the
> cost of them all having to scramble and adjust to the new world
> order.

Just to point out that it's actually unusual (in my experience) for
makefiles to use TAB as indentation.  There are so many situations
where this comes back to bite you (see my other emails) that people
simply don't do it.

I realize Git and Linux (using Linus's coding style) are committed to
each-TAB-is-one-indentation-level, even insofar as using it inside
makefiles not just C code, but they are outliers IME.

So I'm not sure I'm ready to concede (yet) that the "cost of them all"
is actually very wide.  Certainly two projects as popular as Git and
Linux with this problem are very concerning.
