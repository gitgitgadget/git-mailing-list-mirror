Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D679DC7
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944032; cv=none; b=lBpP7l4KOJAPB7byp8r4DXzGw2UNMQYBPkLkOkukjwu+Vw2SIfu14I4DqySfVNoZKAMWjNJf21vuBdTUcxpE4G6g2682jLMSiqyfX8LN5YnBhdzwx90kX+E5j/BeLu8B9RehrdfagwMqD63Ct+kDaDQH5Ccx+ZLIakYRAu4fwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944032; c=relaxed/simple;
	bh=pHzdm7ROm14b22OvF3kRW38AnZizQx2CFjuS2KFY7DA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=NdAXECqHw7b7V6r6wAlulxyDrp15UeT0VWGhYXwFbXM+u7hA/p2CVqVeN+jE9d92tDNl1KRrVTW3yByyN4CyPCFaMlUnaLFmeGfh2R4KQdOJ7v0wDl1vzsYnBInXWEGl+x2Q9h5Q7eHPIu5jqtWST/eDd3mJkGjymkUESKemsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Vsu+926o; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Vsu+926o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=nEIDYjKH4FKCIDFYBXsb2mMOaxRcA6E/BrkHmxhdkeA=;
 b=Vsu+926o3ZStyyOYGOiLcUi4EmC+IMK2/m+iSpnTsugJ/KrkPQd6CfBGe62jdKZ78IuGYQ1rDsKU
   TUOw8S6aptcO9c6RVs77exncu5IUNDeTznOOOWLG/qHzpeCoSxMtDbnxe510zKUDaAHZEoCSe2nO
   vaiSOuOB4E6OWxDfA7A8gffMtp73+NFTJzftikomDsPzslOkmxsg8qPyg+qMfE2y2lg1/Cl2Pz+5
   0rUqOgnizG9ia7RFMt9ofi4bzcPxUbxkLGH2/O0IwlNWpK/7UwpXgImJ+zsuN2yQrdZIUB2eyg4g
   v7PztFo6ReQnyp1smZZ7isHIesXccRz0v2N4Sw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500HQLKK75OC0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:33:43 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 0/9] set-head/fetch remote/HEAD updates
Date: Mon, 18 Nov 2024 16:09:19 +0100
Message-id: <20241118151755.756265-1-bence@ferdinandy.com>
In-reply-to: <20241023153736.257733-1-bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFvTuQ4QnxnNFVnn7+iC2xfXYfLionyixwsJlGteyHBnL0/Z3kkHEL/JVBOjy1C
 YIE7yhfq6ogUbW6gQDkFAhqB5i6nsjAkPr+gU7g8jMEIvaBpbBlP/NySV5Pll32y
 rtahmwmo9p8aopCXOdFh5hUYRMqmdMjMJ4ctiSQO+C+cmgA+V80gJSVXGd4GjqaD
 6hgIjGD71Q9vINnuJ9suzzlGThK1qUqf18+tfaD+bUCeoPsHP/dm7Z8nsm8YxfrQ
 1JbmiiLTWntyA+TamkhTXova35A1SCeGH0d9ZMAnrHlvOr+c13wu59/mjuOnm9UN
 GdPMji+3T5Y0mAGYg8k2XUXxmyeQ+OYz8MznamKSJazqkz1FS2/UhPDVOmiCVZCF
 EEhDozBl1276onnp/9FKaDInT2JfgoH8P+YaMAPnJFSz9F/5kzphYXw+DfQQmJ2u
 Hw4I1nL0cAXX3vluoV4MTDc4PpQ2R5JeoCcvvs3KOs40vpS3uBueD4k=

This iteration handles the special case when the previous HEAD was detached.
This case is now specifically printed by both remote set-head -a and fetch.
There were also some small cleanups in commit messages and unintended
formattings.

Although the patches themselves are versioned:

- 2/9 is completely new (the above uncovered a discrepancy between backends)
- 3/9 had smaller changes to accomodate this
- 5/9 and 8/9 needed more substantial changes


Bence Ferdinandy (9):
  t/t5505-remote: set default branch to main
  refs: standardize output of refs_read_symbolic_ref
  refs: atomically record overwritten ref in update_symref
  remote set-head: refactor for readability
  remote set-head: better output for --auto
  refs: add TRANSACTION_CREATE_EXISTS error
  refs: add create_only option to refs_update_symref_extended
  fetch: set remote/HEAD if it does not exist
  fetch set_head: handle mirrored bare repositories

 builtin/fetch.c                  | 105 +++++++++++++++++++++++++++++++
 builtin/remote.c                 |  72 +++++++++++++++------
 refs.c                           |  49 ++++++++++++---
 refs.h                           |  14 ++++-
 refs/files-backend.c             |  31 +++++----
 refs/refs-internal.h             |   6 ++
 refs/reftable-backend.c          |  10 ++-
 t/t4207-log-decoration-colors.sh |   3 +-
 t/t5505-remote.sh                |  95 ++++++++++++++++++++++++++--
 t/t5510-fetch.sh                 |  24 +++++++
 t/t5512-ls-remote.sh             |   2 +
 t/t5514-fetch-multiple.sh        |  17 ++++-
 t/t5516-fetch-push.sh            |   3 +-
 t/t5527-fetch-odd-refs.sh        |   3 +-
 t/t7900-maintenance.sh           |   3 +-
 t/t9210-scalar.sh                |   5 +-
 t/t9211-scalar-clone.sh          |   6 +-
 t/t9902-completion.sh            |  65 +++++++++++++++++++
 18 files changed, 455 insertions(+), 58 deletions(-)

-- 
2.47.0.296.gda1ecfef29.dirty

