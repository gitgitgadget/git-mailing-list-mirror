Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB222242917
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538164; cv=none; b=NbFQcCqK2bmY0xwjp6EK/M0x8UP5OUbaT51Q8QXF0SE2GEs3XU29F/6M/EOsMvwIiTvBA4Eapu1k/Q8yzj6d6HsVt9u7LDYcv6t6h7YHawohNNfDAKNsbVJejvJP9NTBaQtDUjH0ClFGxbPuD4mxr5QSyZ0wcL2HiMyRxDwDI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538164; c=relaxed/simple;
	bh=EAI+MAYB9nmH6YmrX5kohlJ2s7tAHr6PxWri5l7o3vo=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHsaz8HpVHvMuhO9c8TVYqd3295zRirlaYQMWidzFfzaEeWbNuCLho3PpDgNaqb0WCne6h3XgTCOyr6tJjiriVJuqeyp2uuoVUC1L1RdBIz27baX7RUHMMXaiw5obBt4nrCIKIETkX6vSMkVvuJqMXzKOKbFzqsqiWN6MpAyn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=Yg6rTUD9; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="Yg6rTUD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail3; t=1758538151; x=1758797351;
	bh=EAI+MAYB9nmH6YmrX5kohlJ2s7tAHr6PxWri5l7o3vo=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Yg6rTUD9fgGC3JLEWQqK7rcgr63EBulQ0bxpJu92BUK5wX0OAdwtj0LHcEyzGRIcS
	 N1RuSfAG+aKqXzDel96ZHlqUmC2u8Sfg8QQln7dmGKCuISmhz7ip4sgkVg/InSkzsh
	 3BO7aP9Okg5fJKAHjpQVJ8rZ/seiWsAZV9lOQdjJfq0ogPdN/RUp21BmfbTlse/syF
	 gcvMoEQN7+NpMRO4vKAktgOLPIx2an57P4w+Hc/rTGdfQt/7HjXloRxQNWQVTfWp3D
	 /Zww0LCUp8v/XJ9ipXfwrUbo8m/m2YW13fI8P9uan57JPWXwzJ9oSAnj43GgmO9xst
	 GJWjdMmsSDn3A==
Date: Mon, 22 Sep 2025 10:49:07 +0000
To: Simon Richter <Simon.Richter@hogyros.de>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Sainan <sainan@calamity.inc>
Subject: Re: Could Git be smarter about object reuse?
Message-ID: <2RWL_muy24EPDZ9wWFx-WZfu4Br_F2LenvcVJbKewfSVYipYM3qmeEIgV-6o4EbL39ZjMXtLHbVFOCPcBdHHVAU-0BrgBtuQ9BdRjS_2niE=@calamity.inc>
In-Reply-To: <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de>
References: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc> <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: 3226fca76d91e207905d9c64a9518c96ed2c9b4f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> The receiver sends a list of commits it has

This alone is not enough because if I'm amending a commit, it doesn't have =
the new commit(s), but it does have the previous commit(s), so the fact of =
blobs/trees being reusable is missed.

> For this to work, the sender needs to be able to follow the commits from =
these references

I think the issue here is more fundamental than this, because even just tak=
ing commits from one branch to the other is causing all objects to be resen=
t even if again only the commit objects are new, not any attached trees or =
blobs.

Of course, it gets even more complicated when there's forks involved which =
are usually stored in the same repo by the server, but the client might not=
 be entirely aware that different remotes are related. But that's a differe=
nt issue that I could work around if that were all that were missing.

--=C2=A0Sainan
