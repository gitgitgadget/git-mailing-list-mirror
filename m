Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78A192B88
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378459; cv=none; b=jv+mx6PBLPd5ztN0MBgHbVMzwlelbzHHmhcPElHZNHG1FWr7ing+Ml/EdfvlCb9b9JRKgEAPQY2BdLKvXtveYhoyFhBd3ITPDHDChTEDGWvbefIB09/QiNEU6sQgq4g14q/gGozo3PNj1detJ/rVrb7XGdktOU3f6Nnkx9N7G4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378459; c=relaxed/simple;
	bh=53v29JE1JbTzcXzGl1n0frFtvNHDfecbbYgmYtTB8ew=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Un/vOS0zdeux7JCgHrApnrjazbm2Don84c//QwMMNb3Fjag/u7hi9qD+goucgO4+ZJ+mGLSK21mej/l7JI+LtIfXtR5OcZnOGk45JLR6RI4dtmpWgY/INgyLoJhjEqCKAGZelLboKGeb6RUVSxHeZHXa+sjWvo4sPrkQZOE4U2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=PGbPMjN7; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="PGbPMjN7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=CHkcIOgA23q3N7GHMtWxtTtpYDJRfzZiUtsUCaDADwA=;
 b=PGbPMjN7XGAKFWbLkAdHuRPZ36sKf3ikGevcMMKMhlZMiLonCR/LOzQb6hTLTt/+y8dAKeIyxYjj
   LReSToTn5/ssFRn9aiDS+WXhTRAVXSgrd7xXA+APztgdFLVd+9W7QtjXXXb1LJZTB2OHwXy9iVrn
   ADu5tP0gsbTJb/vWVrkKcBmY/+iEtpjDBNSpe1JBNkefRtGOAvvMcn34GMyrSygbImh+3GMsmGbr
   C1WE5zuJwDF+Tl1BfdqOPVoJFODAIN1jzH5TYOeXJsqynnRogQLTkGhEg1CHzGf16nsnDjJ0KqaF
   j/9DtRO26gSFIR7SL0jXnXlbZWh39gDlTSCE/w==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLM002QJKY7V990@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 19 Oct 2024 22:54:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v9 0/7] set-head/fetch remote/HEAD updates
Date: Sun, 20 Oct 2024 00:53:07 +0200
Message-id: <20241019225330.4001477-1-bence@ferdinandy.com>
In-reply-to: <Zw8IKyPkG0Hr6/5t@nand.local>
References: <Zw8IKyPkG0Hr6/5t@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHFb1MxOxZAb3dhaH7XFcSq8YxJFc7aIXeP7+waHOfFkHkx9UZQnVAEHJwh/6c2
 bjYDgUfBMMPvyd0vtroFG4gVSsZtVDNTrrNF4q1kb9ZUPv3EMHoy0JN1qnH/bOC4
 HqskDMknuJ3ZXMUomPTC3KzV0YNg72zfrmz0YpzeYkhc8wRQuGjWZjwtz+XyZPm7
 NP22Jfl58PXqLgsSGlVNkbpBpnIExlbCrerUDThRysaywdEwQ9YOFzFMonDeR/1I
 ZWmFXNjDivdJ4JPi7aYxUGmWNmqC5t4YLENj+e7kQZCyWKKKYf4FyTeZb1xawlHk
 lFomC4/Uyvb0jzWdkgoW1RybZj9fFJXWBFCn+QIVF8ifYP3lnd1uGkl4C1NBhMWL
 ott+MVJv01tK1aWTI/q/F2SnLS8TGGHsvZbgpDnY8EoMVeaKXcC2T8B1T6SG/hpe
 0ZlaIxOQboqtSJW+iu5OHtHp6JH+oFCzlW7niiECwfJuRZxlXED5a5cS

Hi,

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

Bence Ferdinandy (7):
  t/t5505-remote: set default branch to main
  refs: atomically record overwritten ref in update_symref
  remote set-head: refactor for readability
  remote set-head: better output for --auto
  refs: add TRANSACTION_CREATE_EXISTS error
  refs: add create_only option to refs_update_symref_extended
  fetch: set remote/HEAD if it does not exist

 builtin/fetch.c                  |  82 +++++++++++
 builtin/remote.c                 |  52 +++++--
 refs.c                           |  41 +++++-
 refs.h                           |   8 +-
 refs/files-backend.c             |  24 ++--
 refs/reftable-backend.c          |   6 +-
 t/t4207-log-decoration-colors.sh |   3 +-
 t/t5505-remote.sh                |  73 +++++++++-
 t/t5510-fetch.sh                 | 229 ++++++++++++++++---------------
 t/t5512-ls-remote.sh             |   2 +
 t/t5514-fetch-multiple.sh        |  17 ++-
 t/t5516-fetch-push.sh            |   3 +-
 t/t5527-fetch-odd-refs.sh        |   3 +-
 t/t7900-maintenance.sh           |   3 +-
 t/t9210-scalar.sh                |   5 +-
 t/t9211-scalar-clone.sh          |   6 +-
 t/t9902-completion.sh            |  65 +++++++++
 17 files changed, 468 insertions(+), 154 deletions(-)

-- 
2.47.0.92.g83fdbe24c3.dirty

