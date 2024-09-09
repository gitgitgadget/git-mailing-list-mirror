Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541B1CAA6
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906839; cv=none; b=i8ovnnEp6KnBVFf+iQAFjMmmThWdKl6CeG47PmIN6aBX4QeQaRrR0gE9Ll8OkjsFH06ZsCW4pi4MSLNg5e4QDWwlM2v0IydMGGqtHG7enT6gfXagL35/OjCGb3FV9zLMoEfJiGjFq11G64onbThlPWSCEvStYwY9F8gLZpFdGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906839; c=relaxed/simple;
	bh=JI+PaeDdTh4Isp3JbXaEexVqExZZEojoV+HXHRGcTNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPZKjoUs0paKgPR3QFPmSquIqLBXeJXJJgDK8/JGMZF77RV6oCFubRjzs86jKf/kTfjlWpVpTzmMcCgtN6c/M26k6rIsjYM/FuZv+JYfIewp8huHzUSPRXOPrqTfGtL96ipwvVRNr5q1c6pIvaNwJLobz3Dk4XLPJRinmvf5Rcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=baECxbw/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="baECxbw/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5828621368;
	Mon,  9 Sep 2024 14:33:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JI+PaeDdTh4I
	sp3JbXaEexVqExZZEojoV+HXHRGcTNc=; b=baECxbw/54EdNrXLxSj0DcGD+wqx
	P8hL9SbVdKMv1Xkk6Y3jLgdbWVNf4pmfewsbwXlFM6ZHfj/5rycgZj//Yd/GL01v
	oV8el8js9w89dY6UjggHC/p9g+gRkSR2FNenksyAUjZEAiYpwZJE6DyASia2TTgx
	xOw1hX1TCU0IvJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E8D321367;
	Mon,  9 Sep 2024 14:33:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3B6521366;
	Mon,  9 Sep 2024 14:33:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Derrick
 Stolee [ ]" <stolee@gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
In-Reply-To: <CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
	(Shubham Kanodia's message of "Mon, 9 Sep 2024 23:51:39 +0530")
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
	<xmqqzfogsrqo.fsf@gitster.g>
	<CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
Date: Mon, 09 Sep 2024 11:33:55 -0700
Message-ID: <xmqq5xr4r818.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 12B4656C-6EDA-11EF-8C0A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Shubham Kanodia <shubham.kanodia10@gmail.com> writes:

> How should we handle the related `remote.<remote-name>.fetch` config?

The get_ref_map() helper is what the rest of the code interacts with
configured refspec.  remote->fetch is handled there and goes through
the same filter_prefetch_refspec().

> In an earlier discussion, it was discussed that =E2=80=94
> `.prefetchref` should override `.fetch` completely (instead of
> patching it) which makes sense to me.

Maybe it made sense to you back when it was discussed, but after
seeing the current code (before applying this patch), specifically
what happens in filter_prefetch_refspec(), it no longer makes much
sense to me.

Especially it is nonsense to allow .prefetchref to widen the set of
refs that are being prefetched beyond what is normally fetched, so
we should look at a design that easily allows such a configuration
with strong suspicion, I would think.

