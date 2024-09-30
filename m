Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83415E97
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734930; cv=none; b=CHp9/M/+6uaE4NfVBzBEP93gpe0n/FRnzQEc5PJkC2j9HvM/7pxOXxQM3iabz1Th2uminI+2gmcp6CNq03SZI++0JzEVow4lWpYWf1Sg5ewEBZw0EkBw2RYXlu0sUDl2dWP/dzT5LZeVNN4qlsdIRt6oIimNpN7nDjOCfqfI8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734930; c=relaxed/simple;
	bh=03K5x4mAF4v7/TsrNOn8f0KgziXMCV24r23BVQX8nzA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=QOXlzw3j/r1d8UCPBp4U6egO/ukikv3bM1AFDm9aTPcmy5o+F9/f9xr3QynW5lqfCvJsHW6SlE4RHfFEZOD1Hn+aYmhKx70g/2f9J1UNoCuAk33+YJceFO4GPsQ0cEwkieIc9pVioKJlb8VLKz3rC3K2vdQ2COodnrNFnw3NjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ErwrB1hD; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ErwrB1hD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=qhdGE0c9rfb6A7EcDrnYHYMuaG7eTCeHBL/aOFzRXbI=;
 b=ErwrB1hDW7G7iO34RoVVvAn3UoE55q++aFgN7asdJQoQ66Bnaj3s+SGWuhMYJOn5e9euFtPShAGd
   QWNA2dZZqOvul+3sPd0HBmUyULYDPGMBDrZRK+q2WAzkmWy3TftdotO/EMK68iVBNbHsgatG+V45
   KZgS5eJt9nzO7bTAfAv1BZe3CAh76zaGKu7mXx8jnnytpGXOUFO2QWjra6CBMgTt+NtICLbMxcw+
   PUe9CaTwWnpK1+L9tAQVHZUPlsDOnJCcMYed6XqdqhE/cHoBEp68ojZTdjhasXa91Cn/1f0w8zxv
   9Zm4FG9i6sahWP89aIuV10LkWD7jqB3SsoQNdw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKN00BGTCSUSK80@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 30 Sep 2024 22:22:06 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v4 0/5] improve handling of remote/HEAD
Date: Tue,  1 Oct 2024 00:19:50 +0200
Message-id: <20240930222025.2349008-1-bence@ferdinandy.com>
In-reply-to: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHBeTTX65QiYNPSQkgTn7Et42EPM9Go/ewbK+FD34ddffDqZzPdm2exlkAZAK2m
 Bg9rcf7lbb8TEqCwhMHicPkJB/CJtcIB05tAOAXpjLHq0Vo9iEbGRCtKYeRGE/R/
 3zZDYI2xwWRd5cdhdrNyWars/62AOuKl4lMXWMwUipcEanKwigDHjT/JqFfwZgNt
 TU3fOQdvIaWHnf2ZmY/Og8yGcZn8ftqvpjvz8XTt3+WD4s6J3XzbQOeHf4uyRrIb
 ivvLpiLv+Sa3xqqfvH4UW3Q30yRPKSMextNAWdN7X7+EtZP7TyQZWgIJexV/3oEC
 /mmwjR8vaCAmR+sWT6GfbXUKMFXaVBzivaer39HDUjtpXMwiEklWNYqRs1+4ZSP6
 ECdt1B8QUZLhSU/6XcaYsA2E3CVaNkO2ME8z3Cr86gNMQTp+C/uPTyaKOcLx0S8J
 pIg4h8v7N0HEcjNEXEXgXmKMixGfbhVCYlR9YoLtj8vkc3NRF6yBODPA

This version has dropped some previous patches in favour of new ones.
These solve the problem of atomically deciding what the head was before
we updated it and also not reinventing the wheel for having an "create
this ref, but if it already exists, fail silently" call.

Since now both changes to remote set-head and fetch utilize some common
preceding patches I have again included in this series my changes to
remote set-head. Sorry for the mess tangent there.

All tests (that run on my system) pass for the patches up to the
last patch, which changes fetch. For the last patch I updated some of
the test where it was trivial (lot of remote/HEAD -> something appeared
as expected), but there is still work to be done there (i.e. figure out
which tests need updating and which are actual bugs in the patch).

One specific thing I wanted to mention here. Junio asked earlier what
happens on fetch, when we have a config like this:

> If I am only fetching refs (or HEAD) in FETCH_HEAD for immediate
> consumtion by doing "git pull bence HEAD" with something like
>
>     [remote "bence"]
>          URL = http://github.com/bence/git

In this case setting head will error out with the generic error message
I put at the end.

Bence Ferdinandy (5):
  refs_update_symref: atomically record overwritten ref
  set-head: better output for --auto
  transaction: add TRANSACTION_CREATE_EXISTS error
  refs_update_symref: add create_only option
  fetch: set remote/HEAD if it does not exist

 builtin/branch.c          |  2 +-
 builtin/checkout.c        |  5 ++-
 builtin/clone.c           |  8 ++--
 builtin/fetch.c           | 83 +++++++++++++++++++++++++++++++++++++++
 builtin/notes.c           |  3 +-
 builtin/remote.c          | 43 ++++++++++++++++----
 builtin/symbolic-ref.c    |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 35 ++++++++++++-----
 refs.h                    |  7 +++-
 refs/files-backend.c      | 29 ++++++++++----
 refs/refs-internal.h      |  8 ++++
 refs/reftable-backend.c   |  6 ++-
 reset.c                   |  2 +-
 sequencer.c               |  3 +-
 setup.c                   |  3 +-
 t/helper/test-ref-store.c |  2 +-
 t/t5505-remote.sh         | 13 +++++-
 t/t5514-fetch-multiple.sh |  9 +++++
 19 files changed, 222 insertions(+), 43 deletions(-)

-- 
2.47.0.rc0.5.gf1cffeb8df.dirty

