Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AF6086B
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200438; cv=none; b=p5dCXfrq7zMUZNr1uPsQPMgV7mcrTA4kHLiFaNm9d0gepVhZS0NC6qGLHAgHZKPPxWksEZ7EOsCL2DfkZOPXmhcR/xThw+US5rR0Y5r/NlOXR/to7uF/JJhJbM2S8YUDEnYm6CDS0nDDua4zfDcZKInic12p9/kj1VuxLM7JTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200438; c=relaxed/simple;
	bh=aC2AJEk83OF9Q3RJ1QqffKVpqlphUQQyNbtPjjyotaY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gLUIpU8ZPTfnhFuMZZYS4851wIZIyEkz0scGjIGQaSeEQLdXQgDWnBG47eOEbejJGvK2Gr2hMxMqjqVxBT7uw1wUFd/iKJYahCFb8PXApPbGq2is/UTwnmj9l0bHpNhD8K5Ocun7Gd9OGCv+VA41UNH6AOUdB9JtWHjU9KR3WHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NWf8ze0E; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NWf8ze0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709200411; x=1709805211; i=johannes.schindelin@gmx.de;
	bh=aC2AJEk83OF9Q3RJ1QqffKVpqlphUQQyNbtPjjyotaY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=NWf8ze0EDAIWtLxdH1vmmDmKvSF8NCHfYhXr7FgZj9LHTsq5nHzoUlWHipCN+cz3
	 nGDzqzLRiXE/M2JjS2x4qPYX12/cRiF+wpNLgphNfodXbtOcq2ZLreqV7HK3uZDz/
	 s3fWdyAggseoxn2Z6gr6cjie/Il9oeEkD4jN4+WB9U1rQu74v7WLp9a10fB2x9AMD
	 6N8QXo5J1IVowUGS+QmdceESE5DlWoZsbr0Jj6lz6vVRZC71JhZyloYenohqrZCi4
	 sdIxzNXUsOvY9oG+9NLaY8Kb+LPW1pEuffG15/8MJjSoyYJokUiLD8r/nBBAcSLGI
	 guAQWe4ZHFY2VQhJKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.196.15]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1qnpAN2h1Y-017X13; Thu, 29
 Feb 2024 10:53:31 +0100
Date: Thu, 29 Feb 2024 10:53:29 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
    Dirk Gouders <dirk@gouders.net>
Subject: Re: [PATCH v4 04/11] commit-reach(paint_down_to_common): prepare
 for handling shallow commits
In-Reply-To: <xmqqedcwjq04.fsf@gitster.g>
Message-ID: <a044e7aa-6a71-0fa6-c6f9-db6a08d8c9f5@gmx.de>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com> <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com> <837aa5a89c640427a5de064da93f1de4934d8212.1709113458.git.gitgitgadget@gmail.com> <xmqqedcwjq04.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rjziY0G/fC1mQ5qHNUh6SWC5iJ6v03g0vPebiymMz3OME5RcJ8U
 qCE6mx5iRL/pIwXM4V1NoazYcV1cGxRUcEfUzZmnjnhNE6dK4cgBg0fHm2mYh8RnqTc/1vX
 bqp0HlVK+ey/nQMzl/ICoQye6YfaPjNX9YyOTf295sUY4DUzVwfNxjHka8N+8keI6F/Z/Wr
 N0gNzfRJlfs7WOzCpqQUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2jS2KdKgpsA=;xiFe2ylicKhh/nHGiFoGBaIYcuS
 YEHRkv6YK/GT/KyzU97YsqkP1B2RV4eSS1fc0ZKWYKMK0ecIjdRcI5SPo39he09wZKUaPewRt
 WzBKv8lpRFkSXhwwCQX902MPbSRSKjWLQQ7t2Ek/AJfqiH62K9m7Pc1Mi1Xez7ECG3rLoLnjd
 MGS/+FajXsqy9MwECo3o2q0uolgRa8htFFFxZ7yLg8Gxe3Ob5iJ/rDh4zWLoDjewqN/JOpfJ8
 cmhtuluXUWKxox/57S0EDBZb4Jh+Xgr8tVkTE/+WsP8Tp4WlxOlSRz1Xeya0IwpNEJDxVOt7O
 2yCJfnJ+QQfmEsMsYTdHMaLOo0BMC0P14ulSJ04wL8nLZS+SMnLSy+kb8EF1QZn7ha5OYtr5q
 xQiHiLdrudnyNUCb0u6H095QPupAyPgkSIK5udkKwgN9wKdaheeaSN+r5lcOXKQOHDZGzP8gF
 NMDTW8WXP1SvxVIA8fMjQviymFZOkxQ/u2mjgIpyplA5Eq5UbZIZS4tAmZU1MZiyxSeXiNywl
 pfaT8oV+Xd3C9Xsn5KZJJTCbxMUGm5TEzcUDueXnT1ZmSJ0Xhzd2R7rmr2RhFsfTYtSQ/P1ZJ
 fXr3vJ0dTQsBvJN8LssC40Ml0TUFPj4MGxwk94NZbMDUZiQkjwGebd33ugGo/4kxVNw+WnwVt
 1b2DKrsnsIoTLXfZ3MPhI4N117oZZPSlmgr/Sejk4uyPRk15eCAnMLDXIz1r+V4QUluvrgnS+
 8H/pW4McH4x8NGpvGxNrefsbFaw73343aHU9x3WE5aXc9Xg0xr5yR3+8EgADkOKaZLXRuKNZu
 f07murpeXs1qIYDFJtJgBDOvv4OwqS8RB7EnevxRjt88o=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 28 Feb 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When `git fetch --update-shallow` needs to test for commit ancestry, i=
t
> > can naturally run into a missing object (e.g. if it is a parent of a
> > shallow commit). For the purpose of `--update-shallow`, this needs to =
be
> > treated as if the child commit did not even have that parent, i.e. the
> > commit history needs to be clamped.
> >
> > For all other scenarios, clamping the commit history is actually a bug=
,
> > as it would hide repository corruption (for an analysis regarding
> > shallow and partial clones, see the analysis further down).
> >
> > Add a flag to optionally ask the function to ignore missing commits, a=
s
> > `--update-shallow` needs it to, while detecting missing objects as a
> > repository corruption error by default.
> >
> > This flag is needed, and cannot replaced by `is_repository_shallow()` =
to

Hrmpf. I just spotted the missing "be" between "cannot" and "replaced".

Junio, would you kindly amend the commit message accordingly?

> > indicate that situation, because that function would return 0 in the
> > `--update-shallow` scenario: There is not actually a `shallow` file in
> > that scenario, as demonstrated e.g. by t5537.10 ("add new shallow root
> > with receive.updateshallow on") and t5538.4 ("add new shallow root wit=
h
> > receive.updateshallow on").
>
> Nicely written.
>
> The description above that has been totally revamped reads much much
> clearer, at least to me, compared to the previous round.

Thank you!

> Should we declare the topic done and mark it for 'next'?

After you looked over the correctness of the patches, I would be
comfortable with that.

Thanks!
Johannes
