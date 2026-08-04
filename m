Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C2361970
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873853; cv=none; b=mDTm8ekWnETqaxxvwQgAWtBYQG4zI0R2Swp5AexMdTWiTbMAA5CvVZrwLDwk08hlKwDHDTjBZ6QHSnHPECr2eDEY2efPvZEB+sIxk8/uNZOtFmVWNUhsNO2nGlGHZb7q2Cfr0iz8jcSZ0YcJ6i9JdtuPh/oZRvTdtmQf4b7mpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873853; c=relaxed/simple;
	bh=UiG+CGEtCeI+vfxByl/QJuWv1otwDiou00btkkKy43U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBawfdZJo+N10C8ATzSJcx9eKUfhHw2DiehWjFp2zqXE7GLsgoR3I8FIBGmZ2Kj3HuaIP/0PHSMqLWemdG+5GIjL201e23cfuT+Txlty3NyXM65GZPltn/2AL0XWU0KdcUhC0e+Rt+SSqqKR+xqthvGSdo30AqIhiVrVmTlQe/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FB39lRVp; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FB39lRVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785873843; x=1786133043;
	bh=UiG+CGEtCeI+vfxByl/QJuWv1otwDiou00btkkKy43U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FB39lRVpg63g0jSuTxDW1qBWH0uxSu3Mn0tUyHLa2dUMX0aRkrot8YZYaObDndq2X
	 hVp5oncPIJ2S0lJILp9oE/zLI8jIoC4dxNLHaxPbMrHnXdtBg35vMIABhjHNSziJhl
	 9dIzWHqB3p0CyukW3TJCq5KBMhvVv/0nBLgw8I3weCW5baZpDL9fc1Lhrkj1le6Zy0
	 X6U7Tzi46dkvvS3xHBZ6iPheW1I3DXy8dTbazwr5aYFvbD9XQJZqUUqMlybt57Ss38
	 fgIEyMQo3XQ3ZUQvOckMTdbAvTA4SvfUm0rTQPD3WS43wVUkOOgmhGNBcJjohVNCDA
	 6V7sdd3sFn4tg==
Date: Tue, 04 Aug 2026 20:03:57 +0000
To: domen@cachix.org, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] worktree: add post-worktree-add hook
Message-ID: <DKGFFRLXG2GY.VYU49MX8QE8Q@pm.me>
In-Reply-To: <9f6bb2ec-afe3-4a1c-ade2-addf73f8681d@mtasv.net>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net> <20260804181358.532970-1-domen@cachix.org> <9f6bb2ec-afe3-4a1c-ade2-addf73f8681d@mtasv.net>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 0e8a5f56a9179de13c204344ed81b60b5f3d22db
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Aug 4, 2026 at 1:14 PM CDT, Domen Ko=C5=BEar wrote:
> Introduce a post-worktree-add hook that runs after the working tree
> has been fully set up, including with --no-checkout and --orphan. The
> hook runs inside the new working tree with GIT_DIR and GIT_WORK_TREE
> cleared, mirroring the existing post-checkout invocation, and takes no
> arguments. Details such as the absolute path, worktree identifier, and
> checked-out branch can be queried by running git from the hook's working
> directory. Taking no arguments also lets a configured command shared
> with post-worktree-remove distinguish the events by argument count.

It looks like the `post-worktree-remove` and `post-worktree-move` hooks
both receive arguments but this hook does not. While the hook can
certainly use git to query the path and identifier, if you already have
that information I'm not sure why you can't and shouldn't just pass it
through to the hook (same thing goes for the new path and identifier on
the move hook).


Best,
Caleb

