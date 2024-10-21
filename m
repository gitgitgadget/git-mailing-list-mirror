Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A31FA261
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518286; cv=none; b=LGjse0ftDF6B4Uh5qP/CiDEXzDMJmXR6snNXfn9NbIi8vvC1E57h7fOxsAt3ApoRIIV2PTahc5KUb33qZcBJUYUqDxye88Q1djuuQtmoIgaCT2eInjVU9ctAi1GENVgS+BmCzd884vXmyAPDdIPZbwwI4QRF8ySXjT6owc2QkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518286; c=relaxed/simple;
	bh=eAXOtpa6NMJl6qAPu34YV/hIGn0EFneztIyqdiuBl9o=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=GyD0T53pdhe6Pa17wr3ICQqwK7+lgICXb0CxJmx5C54NII4U9Q7yrVieERFQwAUYCR+nZi2SrQzFYZZws0Y4ViSgs+99rfY+F+Vu7AeDSiZ9UD6mnbkzzjBiVXZg9ymw5v9v6WEo3ZVcKcjmolDNcMHoQfdKaxGf055NcXmF+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=CbooMEvV; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="CbooMEvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=2UegkU74oouWY58Y2kCPdOKL3cLfLwTDr/2EeB/Wcsk=;
 b=CbooMEvVliRLw9Du+KnM3UgsfPzh6xMT/hjpkjm+tzSBT7isaAPoJcwEZvad8NmlLHhYoeI22BfC
   yq3okUPXePToXJqf2byCymHXIkxk0jOxp6bvBWikSt4emzg0Of8rO8QCojcYaGoAU3OqYUItJdJi
   EChMqiWGKdh3hhsbhdxh7zBJfLnLr3/9Vay0oLkiLVgZgNZfVCtcvkuOGHB1yo6OvHiJtE2gggY5
   Nf72ZnPl1AQIbJoQwRYSjJQD8dZNu0cOO7fNpyziCu4MlsU1fpe+EolXQC+EXd/J25zA6R2k+X0T
   qsq7nzLdo1Y3E9bIvh3p0G9Ro0JKxAj985Vh4Q==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP00726KUCRM00@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:44:36 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 0/8] set-head/fetch remote/HEAD updates
Date: Mon, 21 Oct 2024 15:36:57 +0200
Message-id: <20241021134354.705636-1-bence@ferdinandy.com>
In-reply-to: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGKQKp0eSHkB/MBfNPQLYFnMiOGBdGLhzF7U4/j75BiK9nU/kpGSfTnKXbeOE3M
 ++x4+j0FghhrTN7ScZ0N+hHho01Zki0BZtTS38cBAr2wZz1T+tIvGurFjSE+B/xC
 9Q2hnJm4LhfKBlzdjIiQOvTlyViIvHljWPkWzE00gK2ByJCMkHWwui3a20NI2/YJ
 gTDqZTBfughZvBTcnFgBOazxlSTGrEYE9hU4V5n91cJIioJYPwR8+LkRbemJftD6
 czsmifuNzqsdYMP9yPBJr2Glk9fLTxW5XRo+3CS/obAEsbZZ7066/PmNzltnitGe
 XR2zlj9cTSHuejzfR+GOmV3BnEgUoImTj20ALHWI45nECuTqPq/SiWUQ4YWI17QJ
 eadcfA8Jl3iSTksSOSJPBVgA4YYpXfIL5Vs5q2CnUG+jZDOI5V5OjoCEPFnG8cfz
 GE2Bgjv/77P0HG9Qt0XTdF041LA7se82l9CtYWwjA3ODluJQOFG4TSs=

Sorry for sending a v10 so soon after v9 without really waiting for feedback,
but as I started digging into
https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/ I
realized that the root cause is in fetch and not remote add, so the solution
belongs to this series. I'll leave my overall comments for v9 in here for
clarity.

v10: added a new patch (8/8) on top of v9 to handle HEAD in mirrored bare
repositories, rest of the patches are unchanged

v9:
the two most notable changes are
- the new patch 1/7 which address
  https://lore.kernel.org/git/Zw8IKyPkG0Hr6%2F5t@nand.local/, but see
  https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/
- the refs_update_symref -> refs_update_symref_extended change in 2/7,
  reflecting on Phillip's comments (see
  https://lore.kernel.org/git/a7cb48e5-d8ba-44c1-9dbe-d1e8f8a63e3c@gmail.com/)

Hopefully with 1/7 the series is ready to move back to seen :)

Best,
Bence

Bence Ferdinandy (8):
  t/t5505-remote: set default branch to main
  refs: atomically record overwritten ref in update_symref
  remote set-head: refactor for readability
  remote set-head: better output for --auto
  refs: add TRANSACTION_CREATE_EXISTS error
  refs: add create_only option to refs_update_symref_extended
  fetch: set remote/HEAD if it does not exist
  fetch set_head: handle mirrored bare repositories

 builtin/fetch.c                  |  90 ++++++++++++
 builtin/remote.c                 |  52 +++++--
 refs.c                           |  41 +++++-
 refs.h                           |   8 +-
 refs/files-backend.c             |  24 ++--
 refs/reftable-backend.c          |   6 +-
 t/t4207-log-decoration-colors.sh |   3 +-
 t/t5505-remote.sh                |  83 ++++++++++-
 t/t5510-fetch.sh                 | 229 ++++++++++++++++---------------
 t/t5512-ls-remote.sh             |   2 +
 t/t5514-fetch-multiple.sh        |  17 ++-
 t/t5516-fetch-push.sh            |   3 +-
 t/t5527-fetch-odd-refs.sh        |   3 +-
 t/t7900-maintenance.sh           |   3 +-
 t/t9210-scalar.sh                |   5 +-
 t/t9211-scalar-clone.sh          |   6 +-
 t/t9902-completion.sh            |  65 +++++++++
 17 files changed, 486 insertions(+), 154 deletions(-)

-- 
2.47.0.94.g8861098b6d

