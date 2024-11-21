Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C923098E
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230611; cv=none; b=Fhafdjm4bQG38KtcSoqUAu/CUZF/zhCYowz/F7eKAvwz1C/HXsBt/tWv6ewWmwnDk+KhuwIuDfFT1r2IXm3/14fOjKaF/ADM3HPASnD9eBet30lhxsg7TVVOFpKrTrr5NByZgNUmimdDyMliTiS4/Ja9BDnB+s1/qdL+hsBPrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230611; c=relaxed/simple;
	bh=0NR8qM6L60fXhTU9SjBb8SRb4aplXwtLh+EsJw1vhNg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=trnQwcMNxFse7CuRbm6LHWyWzrMK/CaYuM+afiaQVud7kz9L1zaiakFtNKdEV7hekxl8sHLFCjAYSsAYtKHuGcvJTKz8sICTvdeGB9pYBT63P9pZ9n3EZBdJQAfxiXLU93d2Gk1XFR+Sa8OxvJWZmIaDWGVSeiHu73fEvHbiLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=U3jBz1M1; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="U3jBz1M1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=CDMenH6er5fe4SaSl/jdY558RP26KPz2KkZoBwV+a8g=;
 b=U3jBz1M1xLMLUQBKtsylHexj8pGH0sIOwU2CVeVii0pgttHDF1ML87zwQYBfQBH6SkZTZpgPor/c
   hZOAH3VOX2g89MtFeMoWsF/deppjahlvjlig10F+Ag6S9uTeyFh0BhbEU2juQAvIQt1JNHLb4pkt
   mzsZ+MumCMPsWFC37Wjb8+Wn2EWhUBzNw0IRDXMKtKqqHB6DPfpAamOV7HuKG3DRrszmh4dYWy6a
   5Aqn2bnWUrU7qkh0Kk73RD2x0smasW+tfVSqP9A1teYAiUFtZ1w1R5gHURK6+yXmiz1dVe3tDnI1
   cxgNkDFKPIDQ/IP4NZlv4G8ZrGppnnzGAzsnkw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB00BQ7POO0770@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:10:00 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 00/10] set-head/fetch remote/HEAD updates
Date: Thu, 21 Nov 2024 23:55:00 +0100
Message-id: <20241121225757.3877852-1-bence@ferdinandy.com>
In-reply-to: <20241118151755.756265-1-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHhvjVTsuHmBCPUrQOL6MO+xdHx7LLWLQsTikv1tJ+ekdKIG5aMsXK/QPMYOoHV
 0/XbNXs+MVi+NbzsHfnaw3WW56COkth9Cg0Em77J8L+r8pzaRhr6mLATi4S0TKNp
 NjEemzToSRlgiuTOA13Nmp7Ne5JfHAgqNL7ltw2igt/dH4yK0HyudFN26im1nNSK
 D0VZ/Usr06Yzp4MR3wYQYVARoZLgbn+iFU/OqRFHdLnvWa/Lo7dHYin1e0lMCqY3
 iiBsm1KEt5hUqqpfnx5wX4a3W3oEX3U/kJ0MZG8pUtHMmc/BrKn5FiFPh+v+DeK5
 L89Wdj+4sAPjoabCICysB9CobwqreNQozZnoOtmcq/EiS1cyIqeeg0qTOUczlZPK
 q3J8VWpR7XnJ7KoQAVpDLQCuLRJpGtBl3VA5HdnFJ0aOxGT9U+bS0cZaxp5rOG+n
 Z3nSOUXDdtZdMMA8wtuDmBlawSQh4Pv1Ak0BeUVMdqU4gBrnajbrJpk=

Notable changes since v13:

- As discussed in
  https://lore.kernel.org/git/xmqqed36btxm.fsf@gitster.g/ this iteration
  has dropped printing any warning during fetch and now only sets HEAD
  if it doesn't already exist, otherwise it doesn't do anything.

- A new patch adds a new test case for testing the failure branch of
  remote set-head. This also allowed to clear up a bug in a later patch.

I will start working on a follow up patch that will add configuration
options to control how fetch sets HEAD or not. The current state should
be fine for most people, except those who explicitly wish NOT to have
remote/HEAD set. Other than that the current state is now hopefully
mature enough to graduate (unless I made yet another mistake :)).

Bence Ferdinandy (10):
  t/t5505-remote: set default branch to main
  t/t5505-remote: test failure of set-head
  refs: standardize output of refs_read_symbolic_ref
  refs: atomically record overwritten ref in update_symref
  remote set-head: refactor for readability
  remote set-head: better output for --auto
  refs: add TRANSACTION_CREATE_EXISTS error
  refs: add create_only option to refs_update_symref_extended
  fetch: set remote/HEAD if it does not exist
  fetch set_head: handle mirrored bare repositories

 builtin/fetch.c                  |  74 +++++++++++++++++++++
 builtin/remote.c                 |  72 +++++++++++++++------
 refs.c                           |  47 ++++++++++++--
 refs.h                           |  19 +++++-
 refs/files-backend.c             |  31 +++++----
 refs/refs-internal.h             |   5 ++
 refs/reftable-backend.c          |  14 ++--
 t/t4207-log-decoration-colors.sh |   3 +-
 t/t5505-remote.sh                | 107 +++++++++++++++++++++++++++++--
 t/t5510-fetch.sh                 |  24 +++++++
 t/t5512-ls-remote.sh             |   2 +
 t/t5514-fetch-multiple.sh        |  17 ++++-
 t/t5516-fetch-push.sh            |   3 +-
 t/t5527-fetch-odd-refs.sh        |   3 +-
 t/t7900-maintenance.sh           |   3 +-
 t/t9210-scalar.sh                |   5 +-
 t/t9211-scalar-clone.sh          |   6 +-
 t/t9902-completion.sh            |  65 +++++++++++++++++++
 18 files changed, 440 insertions(+), 60 deletions(-)

-- 
2.47.0.298.g52a96ec17b

