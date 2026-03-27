Received: from mailproxy09.manitu.net (mailproxy09.manitu.net [217.11.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E23F99D2
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634074; cv=none; b=jtgUnZUv2UytAVLmZ5va3KT7r4OXyXnLgK1NEt34eVPb4PfKCuvaJTB63x7ewQ2sNftPrrvMhZI3U7cghX02xv5UZtliGDUIkjiIEQ3gT9k/n9BiO9v1ln8TGqhXVddkdY7ZyBLfHhUI/0njpOOuV47iCQHryHNuOxbFG1Sdtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634074; c=relaxed/simple;
	bh=ECHp4oPs/4GWK7BY9NK6MzoOqcgZzG5cCxY8lewwEss=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Message-ID:Date; b=R2fAHEi74z2fn5h7lAoHRlj2znrcVxbH3noIKPXZ70mV4tYtPDdj6+vcRx9HQIrytjSdLXQTQgM/HuNKrpIoS6+EohcChMuTaZR0nsfuHKaLQtcfgglZN+PA9sjAoiPEeQfzAUf0T6gtu0SEyCGhOIdQmCOlM0JY3uUh2WTKSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=EI+lq3Av; arc=none smtp.client-ip=217.11.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="EI+lq3Av"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774633548;
	bh=ECHp4oPs/4GWK7BY9NK6MzoOqcgZzG5cCxY8lewwEss=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date;
	b=EI+lq3AvuYG+C/ksWB7HqhUvYsN5c88EX/3NBW4ZGMMzYpcBDfP7/aQixBcGEoCnB
	 87Pkw08E0p75dfbCAprxfKIymCe3W+RyxIuyM5TN/uTORgM+cicY52//Qsv6uUYvPB
	 xThiy/sOwPtzdvhF+axnqBDPDkHyiWRH+8wKWjL6zV+Jyh3DL77HQCkq8+ftLTEs0e
	 wDdFX3fhsA+s1uTEpeKhkF7hytqyJPPwi+QCWIIybr9XziGlF7N0WkQLrc03xp7OxM
	 hhbHnDXkuRfiMDIEtKtrveAd8lu+ggVzsz68V+eldgbz0qVg/CmgKHvKS2g7YFX6II
	 s/TUbB+9B+WtQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CALnO6CA0ZfzAk8FU7xOYAW-emLwdVJ9Ed7Vt-77gfuY97FR=1A@mail.gmail.com>
References: <cover.1774537954.git.git@grubix.eu> <CALnO6CA0ZfzAk8FU7xOYAW-emLwdVJ9Ed7Vt-77gfuY97FR=1A@mail.gmail.com>
Subject: Re: [PATCH 0/6] ISOC23: quell warnings on discarding const
From: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>, Jeff King <peff@peff.net>
To: D. Ben Knoble <ben.knoble@gmail.com>
Message-ID: <177463354761.155656.13826706408579146455.git@grubix.eu>
Date: Fri, 27 Mar 2026 18:45:47 +0100

D. Ben Knoble venit, vidit, dixit 2026-03-26 17:26:35:
> On Thu, Mar 26, 2026 at 11:40=E2=80=AFAM Michael J Gruber <git@grubix.eu>=
 wrote:
> >
> > Hi there
> >
> > Fedora 44 beta (gcc-16.0.1, glibc-2.43) brought some fun new warnings
> > when building git. In essence, we're not always explicit about
> > const-ness or lack thereof of certain pointers. Before, strchr()'s
> > signature which turns const arguments into non-const return values
> > covered this up. With ISOC23, strchr() and friends return const
> > pointers.
> >
> > This little series takes a middle-ground: no new data types (no new
> > const versions of non-const data types) but more explicit casts.
>=20
> I think a few folks were working on similar things; hopefully I've
> CC'd some relevant parties.

Thanks for catching this. I had checked the list cursorily (I'm not a
regular) but overlooked it. Peff's going all in on it, as usual ;-)

Michael
