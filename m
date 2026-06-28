Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA522175A69
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649222; cv=none; b=ME15YgQCY5wFdzYW6pIe/reP93OxtTwC4B0bGmHo4fzRgFkEhhxg0OqSA+U6wvpxpj4HloP3AxgDuTemUNYHQRFzj7sTg3emIp6iOaV+44qRpon8zDtOUZilS8mKAtQBVYpAjYQ7h+7Whr4dkpfyGtgu9ttXdP1LmxMjSLaJza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649222; c=relaxed/simple;
	bh=AH5z+EuSPtXwYQfgZdkmhNl6llmD8cZonRZaQ946O6Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OtWf0AZO0CJ+vSPDDRezTWh8lYHuZ3OKGolPBCScTTYB0GKeopeNbrRXuzXKD0qi29QdwjZgXcj6tbkSmrum2jC/uu9D50yIcLGdpRThX4RkfGt+jUsVSzvVZTkcihOYTf7r1UeoDKdEY5rwsB2mCJ8EQaQBIjRsH1bg8Fd9K5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=sNUmFxuy; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="sNUmFxuy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782649215; x=1783254015;
	i=johannes.schindelin@gmx.de;
	bh=Pn1hRvDrg4wQjCOGHbj85LXCAJbjp/bWTy/5bhDvr4E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sNUmFxuyR2RIg0ttlJFAW/0oM/22h/ilx66g4+Xz9RzwYHBRoSWwquIxlXPugJVv
	 aSp1ZNaZ1dRVEzazPHbWjnJl8bCivrzJekCiUFaFINqRWpHmimE/vsw/3SpFoi9KV
	 FEkJcgtQCeVsPgYqY62vZOMoIwFWaMn7Js6HKZ8UbVYRLP4+ctkD19260tF3/9HNA
	 GwZWh8LHmTqDXx7njDrX3AdRpPsQJx+B3IxLNQe6BzlBYfjLKHSMWotcPXYW+g7zj
	 +RX9zAsfnYiQEAc7dAmdJQ44jzCNmfFriqJmgxUuX7BQj72jYM3LbH5iwmIPmrj5d
	 16SicJXWK5fyYkiZ+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1wXbKm3LoJ-00Skg8; Sun, 28
 Jun 2026 14:20:15 +0200
Date: Sun, 28 Jun 2026 14:20:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Toon Claes <toon@iotcl.com>
cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 0/3] Teach git-replay(1) to linearize merge commits
In-Reply-To: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
Message-ID: <f8b520d1-edeb-9e45-c503-025c8b5833c3@gmx.de>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com> <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:WNTu0Zu3nEYHpUb+vLIzrVwXqNjq+zqoL2TrYSattSt6NsLpaOU
 gX8TVbSztD/Q2B6f/4UobZkVKhmIyk82AaveV+JMdCh8z3juYqSonaJZiQatwIG28lbZ9if
 lL6BR/qAIMQZrm1AIne/PRU9+KU+pmnOaIBSAUeTGRSRJToZ+QAnobFiniBqxFCGz5AryJE
 Gv4FwExMiagQGgdSZAv0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lYvXQm3v53Q=;vnLI9JK+enjqcEOl8SwxHV+4/Ie
 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

Hi Toon,

On Fri, 26 Jun 2026, Toon Claes wrote:

> - (BIGGEST CHANGE) When working on a refactor to undo the enum->bool
>   patch, I extended the code comments to explain how things work. This
>   made me realize the use of the "replayed_base" was incorrect when
>   multiple branches are rebased with --onto. This is fixed now and a
>   test is added for this scenario.

I am not quite certain that this results in the desired outcome when
working with a single branch that contains a merge commit. Take for
example this topology (master~2..master at the time of writing):

  *   6c3d7b73556d Merge branch 'ps/t4216-tap-fix'
  |\
  | * f0411a4c717e t4216: fix no-op test that breaks TAP output
  * | ab776a62a785 Git 2.55-rc2
  o | 1ea786d14a1b Merge branch 'hn/macos-linker-warning'
   /
  o 08b6ae38c602 t4216: test changed path filters with high bit paths

Running `git replay --linearize --onto master~2 master~2..master` used to
result in this:

  * 3ec7cc3e73c0 t4216: fix no-op test that breaks TAP output
  * 8dca9f98dc05 Git 2.55-rc2
  o 1ea786d14a1b Merge branch 'hn/macos-linker-warning'

which is what I would expect. But now, due to the dropped `replayed_base`,
that tip commit is replayed directly on top of `onto` and the first
replayed commit ("Git 2.55-rc2") is simply (and inadvertently) dropped:

  * 5e4899a3e03c t4216: fix no-op test that breaks TAP output
  o 1ea786d14a1b Merge branch 'hn/macos-linker-warning'

I had originally introduced that `replayed_base` specifically to prevent
this commit-dropping.

As to the question what should happen if multiple branches are replayed at
the same time with `--linearize`: This is a very tricky problem. Naively,
one would want all of those branches to be linearized _individually_. But
that idea breaks down when you replay three branches, two of them with
distinct commits, and the third branch a merge of the first two:

  * Branch C: merge branches A and B
  |\
  | * Branch B
  * | Branch A
  |/
  o onto

What should the replayed branch C look like? Should it have A' and B' in
that order? I.e. share the rewritten commit with the replayed branch A?
But then B' could not be the replayed B because that needs to be directly
on top of onto.

So I fear that the `replayed_base` design _is_ needed, and the only way
`git replay --linearize` can work with multiple branches is by linearizing
all of the replayed commits into one single, linear commit topology.

Obviously, there are ways one could _try_ to rescue the previous idea, so
that at least replaying just branches A and B would keep the replayed
commits non-reachable from each other, but I strongly suspect that any
such design will invariably surprise users in nasty ways when the logic
has to fall back to the simple idea I outlined anyway.

Ciao,
Johannes
