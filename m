Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637736196E
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617737; cv=none; b=b0+7l9lkYtXMRgQghWw9poY++CIEGJAshZONOPzkiVhebi5ZHlJ8pvi3KTl5fdRuXxxKEQzPCLZJfNY+wYPDNMHR0RsEaRr/FJ+ZH4Dr6R9tEAzolHUmUMcR1ECLm9pP7BQuCAgLQZRNgGIP78HryICop2VSVEclflnRE+5AqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617737; c=relaxed/simple;
	bh=6PNcoN3yPeHPg0S4+bkxYthEjm8j/gWmfweJhA+klVo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CAcArZsVKiBQaWfM/GjhSuIqbvLmgfW48sg+pSWs4jiNOVLBF31aUQwY8rvCF6wWCuwJYqWC3rcpthOlk8GY6rU/GrqFH5ya/+kGKpfKwMBZdn0y0KuE3BAK+gwCwpW2gHLpwHDYsp5EnQ1uOwWU2Y+sW4UfyTjigur6Vsf1zhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=p+nZL4DV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="p+nZL4DV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786617732; x=1787222532;
	i=johannes.schindelin@gmx.de;
	bh=6PNcoN3yPeHPg0S4+bkxYthEjm8j/gWmfweJhA+klVo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p+nZL4DV7/39gY+HPHvVWvDmcm34kf8Tg2+SOC2qlpz4jAtluquinczPwUISYpvZ
	 HdhvIcOv/hdTpvttImW3QZf8r4tmwKcCXxiGTVxxZ4ZqUQFLbQujes1DmJzcGco8P
	 ncipCq96FXnBwtdZqqISBm9/Z8k+k3rkK9FnVjgl53nBlU5oOwNFWEiMfN/aEJyTh
	 sMaWiePR5EV8NtK7wKY6OWW3rI2sZ3B9+fcHUhSd19J744DiFqKH2i654OCfOj//M
	 HrDohT3daHrpQyoWu/diTXsnIp3Pphd0KqccLtmucOI6IgrXsfYpPtvce7mbk6qVn
	 2fEBk/tv4qtbTYnDXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1xIYF21hbE-00dwbF; Thu, 13
 Aug 2026 12:42:12 +0200
Date: Thu, 13 Aug 2026 12:42:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] packfile: fix perf regression with many packsy
In-Reply-To: <an2V7S-DkdypsGIE@pks.im>
Message-ID: <07585246-48cf-2d70-b022-8cb430fe82fb@gmx.de>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com> <an1zz02GNqDu-0Oz@pks.im> <b4860540-6114-2a7b-e266-d1fc2f0041b9@gmx.de> <an2V7S-DkdypsGIE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:MceAi0ocQtBES2jHsQ/Xm6t6wKgiQEXEtL+dWkpzu0Ea/umpBBP
 J16rTaxhqEuSSICn6n31D+WFTd72GCH920niRYD2+OyxK5PBTWjmPc/TQgAb0jq5KeVxEfM
 AfKyiWGCaxW/eXJO3o5o0JhxAaMXawk82g1ZoAR0ODQMvWjvZyYvA3UOXzZcHzRgxSae+5v
 6CFKQ2QP4TwEKbJpyL1ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SvtH08IAbbg=;3tFDM69J9LAKmbsAbTsLlLF62ng
 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
 N2w
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 13 Aug 2026, Patrick Steinhardt wrote:

> On Thu, Aug 13, 2026 at 11:20:11AM +0200, Johannes Schindelin wrote:
> > On Thu, 13 Aug 2026, Patrick Steinhardt wrote:
> > > I wonder whether we should slightly reformulate this and rename `is_=
new`
> > > to `accept_duplicates`. Because ultimately, that is what we're doing
> > > now: instead of ensuring that the packfile is unique in the list, we
> > > just don't care and just append the entry to the list.
> >=20
> > Hmm. I don't quite agree, we're _not_ accepting duplicates. We know th=
at
> > those packfiles _cannot_ be duplicates.
>=20
> I know that we're not, but this is only because the caller knows that
> the packs are new. Seen outside that context though the new parameter
> really just tells us whether or not we want to deduplicate packs or not.
>=20
> Anyway, I'm splitting hairs and I won't insist on a change here.

You do have a point, though, `is_new` is too narrow. How about
`skip_dup_check`?

> > > An alternative would be to use a hashmap here that tracks the packs =
that
> > > have already been added. It has the advantage that it also covers th=
e
> > > `prepend()` operation and that callers don't have to be aware of thi=
s
> > > mechanism at all. Furthermore, moving preexisting entries to the bac=
k or
> > > front could become O(logn) if the list was doubly-linked. We do this
> > > operation quite often to re-sort entries in the list when looking up
> > > objects.
> >=20
> > Indeed, that was my initial reaction, too. I was well on my way to sta=
rt
> > writing a hashmap-based fix when the AI assistant pointed out that no
> > duplicates could possibly exist yet.
> >=20
> > > Overall though I'm not quite sure whether the added complexity would=
 be
> > > worth it, see below patch.
> >=20
> > Wow, you got a lot further than I did! And yes, I agree that we do not
> > (yet?) need to deal with the added complexity.
>=20
> I may want to pursue this patch anyway, as I think that the reordering
> would be sped up by that change quite signifcantly. And that would make
> a difference indeed when you have 38k packfiles, at least when you
> assume that objects are evenly distributed across all of those and that
> we perform reads of random objects.
>=20
> I could do that tomorrow, and in that case it'd supersede your patch.

I don't think that it would _quite_ supersede this patch. Sure, while
searching through a hashset instead of a single-linked list is faster, it
is not as fast as skipping the search altogether.

Ciao,
Johannes

> But I'm also happy to have this improvement here land first and then
> I'll pursue this change eventually.
>=20
> Thanks!
>=20
> Patrick
>=20
