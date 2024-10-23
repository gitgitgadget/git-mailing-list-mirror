Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57C1C726D
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697939; cv=none; b=L6fmsQjJwqT+Aoo+oshSpgSzVvqRgoX15Tt2Esn4JxCpeWxTjUAv5greT6SFttSGszAS+NJD/ED+GMxlqFdKseGabByFFfnGlln6OdI/sV0g6svQJzI/1/fRdTgCNLwqarbJBLAM/kt6LUcSdvCnSH7mRh4MeX3HnX/vNQucsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697939; c=relaxed/simple;
	bh=/b+VYWDgwtaFnJhps6IzNM85h+11AhxBrxixcV84p1M=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=E1XuuwdcXzU3r5YZ5CX+J4yyo1Pvy2uaZvbO8g/JO/5T/NYF0m7UbabC/yxf7ukDqeVGfYaQlmSP0scLDsFOFG+7lMFX1M3gDFpn7mIo3QwWEKG1qY2dLTRSKkjfmGyBHkvex4x7ev39XSmjVLRpwV71a3rrdUX9417Ds+6r6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=e1a8ArNE; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="e1a8ArNE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Egr0Vy3q+FOBwOjC4/jcgzxLC78r5STRLXFYiRmhCX4=;
 b=e1a8ArNEsShtHbUE9w/dzRwULGFsVZxcULm0W+jZG5hSEVvNApykRgioHH+RxJRKRoZ4MA9M+Bhh
   QsjIddXW+gkx4jBMN/VvxWZ9pJaUcIHz38wkhfo7MWSbW3qcRMZHetX3rXLO17NOveWKOFbmtxCq
   z9vDPq648TtZedXRceV3/yNDPBFuR8XUBzzwQIaqG6GeSPGddL5AE5tPc4JO9mTCtsZZo5kuIanm
   Y1y6NjwqsgX9zLkYzVjATHH8BM7ATTyHZY9S2On4CTASJdfhSd8f3KiTRGSkOFvY+V7IfDsIcPB0
   HjJR8D87PJ1t4PQxaP7gmonE36fAWqlbwP3hdw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00DRZFGSYL40@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 15:38:53 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	ferdinandy.bence@ttk.elte.hu
Subject: [PATCH v12 0/8] set-head/fetch remote/HEAD updates
Date: Wed, 23 Oct 2024 17:36:34 +0200
Message-id: <20241023153736.257733-1-bence@ferdinandy.com>
In-reply-to: <20241022194710.3743691-1-bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAE3E2yj7RcntEa9ZQAgXIrjzU4XcukpfUYogdhY4k8jpoCTBWTGODvDlIz70Xjn
 ssPa+a+P7IAcXylge90dbAyLXr6svSzJuZQ7Q/LAX4edp4rEa8ptNYSwAQGzwPR1
 aEjqPHV59RuTh+wTbNykVlx+6yhN0FK7Hpl7UmcIS8lnb6OWoZ/G5u5X0fYvFqRy
 I/lOvF9FOBj7rdDYI/NCrTzFcowsCImj0Prh78DPUKEMC7YK9feON8Q+5rRj4BWj
 WhWCisVdJerJYtd3HMfwHUzIM5EMje6izDWkCx1VNtW7M6YMdVkK+5FeKJrj2pB7
 VZNQIOCcIEH4FudGI7nz2yws101NzmsYGTP/ZT35g/BfHH7ws3X75Huo/fXriE7x
 zNnPOL3DFj8blSNBtQ39bYtMWgWlmLYF8o0nhLo04l2jc5GvX8iec/UwisdxM451
 WbKLo1jE1NevNxs3Lb3XGJIzPBtcTWKjwmRYCXJPK+Ubjqxtq6UrlkFH

v12: added missing S-o-b

v11: fixed leaks found by running tests after `make SANITIZE=leak`
    green pipeline:
    https://github.com/ferdinandyb/git/actions/runs/11466803523

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

Bence Ferdinandy (8):
  t/t5505-remote: set default branch to main
  refs: atomically record overwritten ref in update_symref
  remote set-head: refactor for readability
  remote set-head: better output for --auto
  refs: add TRANSACTION_CREATE_EXISTS error
  refs: add create_only option to refs_update_symref_extended
  fetch: set remote/HEAD if it does not exist
  fetch set_head: handle mirrored bare repositories

 builtin/fetch.c                  |  94 +++++++++++++
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
 17 files changed, 490 insertions(+), 154 deletions(-)

-- 
2.47.0.94.g1247fb88fd.dirty

