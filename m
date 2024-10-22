Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745EB1CB323
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626525; cv=none; b=q0IyQm15WnHJhvna0cdWZZgeZ99QIAQoJg5cLINZYKSeQeA/Jcvdmad15FgU2susUH0oE1IcsXa7nHZ4/oa3W96LNMx9Jlzp6IZFoJnEbJ3oSoKmreOKfBQEZwLjOwv6+rCp/M7tEw+LmX1Kzyw5o3BWkWGIJdiZFzTdYudShwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626525; c=relaxed/simple;
	bh=HhSPRfJ68pP8wDhHKz9uxJotDV0K0OIVeoGCKMsn9fA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=H7VI4dbUc4Z7EZ4wBhWEomVk++GQH0BlJM65sbI2jpqwnXYcJhTxb/mrZgLn48KRNO7lFttcvAdvivRSMj6EhpYzkbEsdfq/q8kVewNSVDZW+i7zTxKhH71RhAL/33E8QA1BXo5oxs81wZpQVqoJc18Rnhl6vcyfEZ6FZaSkeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ZvW16Mn6; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ZvW16Mn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=gKLwOLvs6Gx3WMf75HNloPIUnkeQy9kT0npXUjPUUb4=;
 b=ZvW16Mn6ydE1AUUzyYKVoud5KAeTwK+uW5QFlYMPF/+FXATgMMJKvjx696rOhnC5rYtD1SiLF9wC
   Jmt/NHXjkDCD+mX7HbZaIXO5BpP1DZIjU5Jcy3qa1UpeF8RJJ1AJDMJMuFIhsRIpCOHrB/czsmUf
   eeI5a+uLTOKfrYRhxxPXJP8XQL7QnXoQTlBiduQTQ4vNeOjS9i/fX2ga3S2tHaMaoFN7KJnizpw2
   L9h9fh6E/S9HgO+C/uAsZ0+fQySGETKoMnbgPZy02UQiHoL2v7ZqMGSSBquqv1ZztSb03xfxTqHh
   fFHJLq7vDvuWq2iKFMJLK3M8+y7/FkuZjp03kg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR008FGWCYKS90@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:48:34 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v11 0/8] set-head/fetch remote/HEAD updates
Date: Tue, 22 Oct 2024 21:45:37 +0200
Message-id: <20241022194710.3743691-1-bence@ferdinandy.com>
In-reply-to: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG656Mgg8rkdVTkhA9mTB/tlXmcC2Vv9h4yPU9dKJPc5HdMkMGX4ZKUOB6YvE+z
 l01DlZftdJvDV31NUU8B4CQpbNnTHNWvBZh2HJ438hm6tuY2BREvbT+da99E2HFK
 aELOlYu+4kJZ+z91CJ+pLpPs40mpVZ+xqFKZzsmPJMHSUk+lr4CFU+dgoU41Y+yS
 EmHjmCloRB8fbb+VrIcGdXYD4jIyIebn5pMGmcEu76eFmwmmbydOdn5VtrY19E+Z
 RNINq6ZDl+Ok9nyPZQj4Ugee60ph8SNNtjPa3Snr1JkjxxtU53vcIcaxl3fwGyht
 LC5HTjKThc3BSJwrt0b4HC6EN2KKD7DJqfruhoR7Qf+ndqtZgwZPrMSXWd2JZzDd
 wKiM9L5jet7pulW9aXRiffSSEOZB16r5tBF94PXL5O2LA0Vw4xTWfvAtuo3i70RT
 fByE0I50eWAgxZpkhOwIvwfg6y6CeD9ObweIh5ieHWMFPgIRvQ3zfQGw

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
2.47.0.94.gb64850d498

