Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6134265CDD
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754778255; cv=none; b=LrGFURCjg4cmLOw/h5Sw2xA9RyTZgDcGyHQoudlobptRsi4V+KOxnDeRwq37kChrziCBTtwH9etIFTdU3BGE3D5aTeSTnsQhNTovuVTaR0VgZ286G5VngIARzjGcR2etqtdG80AIsB0z1boqXc2aIJO47HDeS/f3dJX+qV8ooLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754778255; c=relaxed/simple;
	bh=137LfFVsUe3zbo2Xb2nHb7tRMBzaRo247Z1lm35SJ58=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=KWuEJmPVDewzjR2z5GIFjexJpArhmN1hJC9JD/Wfl7zH4W2KXVr6OKglAU8rpCjMYj51/JeWT4y8ypB4WqpVRQowOBBj58nZQzuC3zNiAO/oYH1VxcAfbldW+X9IiuQoqexmT00N9xZ64oCZIauWKAU940H6G7cghtA+1xlvaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=JtKteCKE; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="JtKteCKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1754778250; x=1755037450;
	bh=nK7IT2wUHjU2fFe9sVnvTbAKm78NjhVsmA5s3i5VqNs=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JtKteCKEd4GSchzh6EdzyC1P2t6wBR1FEC1KsE0O8yyhgiylJ3cDm1K3BsNW41ENC
	 +JE6WSt3xWyxL0qihtpVyZG0HQWa3QhXjzzgIDJkaKY8H71TbT+nw4KGuUI02x9eMQ
	 dkrFf7zc9MeghS6nNOt9cdOHykcbC5RmF3tgFbZ0604uDimRNXMt2558T44rHNo6CQ
	 QvfCgF2z7fEeF/FvL9p2+MtgTSkNPlLkK56BKP8zBMvHJMV71CJ3ku4D991/cnWiu2
	 OJpPd3oq3qnl0NRTnBKVwmwlG5S8MXH7PXvJIBi9veoKJmLp88blZOLaX8JFmvmvrR
	 CBGF4rzOXX1Yw==
Date: Sat, 09 Aug 2025 22:24:06 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Sergey Poznyak <sergeypoznyak@protonmail.com>
Subject: Fatal error in git subtree split
Message-ID: <filx6Yt3bQSp1GJwOQKS6cZwaPFfFn5TgcuH0fv1kS3Wgo0xSKxhXDYs6zUm8f_9tZCtF-scyAhFi7dTl3q44w5RkM99QH8gR8RJB5UA7m4=@protonmail.com>
Feedback-ID: 4253912:user:proton
X-Pm-Message-ID: 183850cb934e3b3701426abf17293a3ada6ddfbe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to split a part of my repo into a separate tree using this comma=
nd:

=3D=3D=3D=3D=3D
$ git subtree split --debug --prefix=3Dcommon/container/xarr -b xarr
---
truncated output
---
progress: 16/161 (15) [0]
Processing commit: e618ad95203d72380cd38124b446dfd71a663e86
  parents: e22e667e27a77d22f9b2091df7e7f16e47808a9a=20
  newparents:=20
  tree is:=20
fatal: no new revisions were found
=3D=3D=3D=3D=3D



It always stops at this commit. I think the problem is in the next commit t=
hough, which is a merge created by git subtree add (without squash) a long =
time ago that I did vendor in an external library.
The merge commit looks like this:

=3D=3D=3D=3D=3D
$ git show 32d21757c1e4446cc87ddb2e93c4d49c0d205eb3

commit 32d21757c1e4446cc87ddb2e93c4d49c0d205eb3
Merge: e618ad9 e60e9b9
Author: sergeypdev <sergeypoznyak@protonmail.com>
Date:   Fri Jan 10 01:29:33 2025 +0400

    Merge commit 'e60e9b99af9e2738378444265819df71c8bba134' as 'libs/tracy'
=3D=3D=3D=3D=3D


I tried doing a fresh clone of the repo, but the exact same issue persists.=
 You can reproduce yourself if you want, the repo is public: https://git.se=
rgeyp.dev/sergeypdev/gutter_runner


I'm using
Git Version: 2.50.1
OS: Fedora Workstation 41



Thank you,
Sergei.
