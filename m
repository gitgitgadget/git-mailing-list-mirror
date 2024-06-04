Received: from mta-sndfb-e05.biglobe.ne.jp (mta-sndfb-e05.biglobe.ne.jp [27.86.113.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85ABA49
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=27.86.113.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463124; cv=none; b=YwhqFTUJig/k/fuaMlVCCBh1HovPFF5mpbWa1do61CqEVSDZjM9e0MVGoyRDmskjNmnkbfgRiq/+gMATE/fBasNDCvz87HQiA6LxzqleW4uJDYg+nJPb3kBVtetqLg0ipz5+H32FYZxczXzF2QA9eN081QmWCAO5dJKl+jrSCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463124; c=relaxed/simple;
	bh=N90fgg12y8eNupcCX11t28MilCRENjA/yCtyL4C8aa4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eWI5bWAXjWcZeLhlauz5jAEHaGfIBG3hcRau7FAZk6ZI5oatug78iR66arb9O5K5fD6XCFZL9cU68GldlzfBEAGNOFj0ZuH1IFSbBKehDQms0XFTxQSKAqhWxf7q0C+r1W3hJZj9QjGPqLkNRiT7vhMZcQZaw6OhqMOV3IOFq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp; spf=pass smtp.mailfrom=kba.biglobe.ne.jp; dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b=fMNckfBr; arc=none smtp.client-ip=27.86.113.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kba.biglobe.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kba.biglobe.ne.jp header.i=@kba.biglobe.ne.jp header.b="fMNckfBr"
Received: from mail.biglobe.ne.jp by mta-snd-e05.biglobe.ne.jp with ESMTP
          id <20240604005700712.FGWP.62048.mail.biglobe.ne.jp@biglobe.ne.jp>;
          Tue, 4 Jun 2024 09:57:00 +0900
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v4 1/1] macOS: ls-files path fails if path of workdir is
 NFD
From: Jun T <takimoto-j@kba.biglobe.ne.jp>
In-Reply-To: <20240531193156.28046-1-tboegi@web.de>
Date: Tue, 4 Jun 2024 09:56:50 +0900
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD63F8A7-986B-424B-B67C-B78887E8CA00@kba.biglobe.ne.jp>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
 <20240531193156.28046-1-tboegi@web.de>
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3731.700.6)
X-Biglobe-Sender: takimoto-j@kba.biglobe.ne.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kba.biglobe.ne.jp; s=default-1th84yt82rvi; t=1717462620;
 bh=N90fgg12y8eNupcCX11t28MilCRENjA/yCtyL4C8aa4=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=fMNckfBrqas+W9AYykEBm9nAJP+OrW8wqJ9efwyWPcqUSDiAZ7QgKZTEJw1tMlrje1UCkkuX
 eS2YbpSmQFGz4VgwVB/FqaTs1X4dbkX14Jw8hfBBwotSPTUqzfTp585+/SsopsGxsLCjagASqe
 Cmih0sycYMnOATCy+iuDncXI83bKDscCPVAOEkEQwkcY4xEw1qD604nP9w+RqLJz31Xvasmc55
 SJProN0QHNeSfbHG+4wqY4K43lcvPcKXD+721sQdj5pAdyTA17m5x90fP6hkXE4lILzctAalqe
 q6/+a5zK9lYEtbbXZZIxUGvljofaufX/UY1yf1yeOxnkqX5A==


> 2024/06/01 4:3, tboegi@web.de <mailto:tboegi@web.de> wrote:
>=20
> The solution is to add a call to precompose_string_if_needed()
> to this code in setup.c :
> `work_tree =3D precompose_string_if_needed(get_git_work_tree());`

This simple patch works for both 'ls-files NFD' and 'ls-files NFC'.
>=20
> There is, however, a limitation with this very usage of Git:
> The (repo) local .gitconfig file is not used,

core.precomposeunicode in .git/config is read, in function
precompose_argv_prefix(), and NFD in argv is converted to NFC.

But, as you know, the variable the_repository->worktree or
the return value of get_git_work_tree() is in NFD.

> 2024/06/03 4:40, Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
>=20
> The root cause may be fixed in a different commit later.


Of course fixing the 'root cause' is better, but I don't
know whether it's easy or not.

Anyway, thank you for woking on this problem.

--
Jun=
