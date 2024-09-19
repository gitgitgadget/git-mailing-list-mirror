Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBA19D07E
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748396; cv=none; b=TtW1lBUxwPTOrbg2yBj5e1KCX95gRyMOgs2jZb+t515ulQKDkZLn5fmbUjOtID5cSemzJn+27cT2cEJLuousrBCsLxtN3UJHa+bKrJpBDtdjg0hdIT8yyeu/cChDIhEhq2fSoUgjMzyGNdAyRKs3Mq/y5FTw9RmlN8r/dP4T1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748396; c=relaxed/simple;
	bh=PXNHrIeGeeFy+N6Hv388Xsz1x7kNAcqI4pCZXSRb07s=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=YcoZeJWNoaNPAb/5jrynHSLabsBlrIp0f5EJJOxJg5JUP6M03yQGuDietr2rjGPkqvfdQzMa2ptu4tWNCYYWaRSCWsrkULIQRhPBgCG6QHBva9E2gTEgcwkgll4vHkexvrwA7TGKiId/MR4Or+Yd6moTEIdXAcP8rO9pckpi0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=TmNZ9wdB; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="TmNZ9wdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=PIAUj9sRhdpJn2/iovKEdB/Oh0CBaiNziRB+ADJTa4M=;
 b=TmNZ9wdBp6aWQb8p7LlxEwY0/V11c0CFxc1Fk63jT9VxmI1cjLjpndtS05l8WUy9bBUpAZnaZvzU
   qNFyI1ZuFyZr5RMXhmRGQH6WHlBjnxlK3HE9sqYZ9nXHUWfj419nXKTA/leGwRNdtg+OlXvlYRct
   XIJVTz+24BV8e/eM2QWRmnAwTKZxpVKAc5xBzbOudS4moGj1Ti9qVdqIxaUgNYKjt/CaGipBUpaL
   lVJEHgwl8jWx4VikPjSLQfhpe7ek2XvW1223mvc+0IT0GRG6f2VmSMBfY0OwMSEfIy/r9tnQr0Dm
   zef3zj5Q44kAD0aBGRW+2YNuWZPNGksCk6xROg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SK200FC47CLN070@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 19 Sep 2024 12:14:45 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v3 0/2] fetch: set remote/HEAD if missing
Date: Thu, 19 Sep 2024 14:13:24 +0200
Message-id: <20240919121335.298856-1-bence@ferdinandy.com>
In-reply-to: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG9xX/D4s8daHljmGGnp1CSyZk/gLIAnMTOmriCmosDcY56TjqKtj4i+RHVW197
 KJNxTvsFHA5dJAucBoP6nyNy0kBC6M5vrP3WAewbsAGOlWJjHEbYySk62WE5k/6h
 0XZjBmXSiUXXMfXDSj2HXJLw0GdeUeZs/uUPPF36HOP2safzI+8cq1D3YBsRAmsk
 0zlBuglZt4B3ZcC+nIJfD6nSaBBYKMnUG1xHzk1/hlQHn9NBC+ZCEny67yzral5r
 XOGC0DYGBp1+lhpqc9aeWG+rzamdKafcRO/ZvO2+uUmLW1S7upDy0i8AjIXXTuyo
 Hs5t93ja/DjV0VUJcxRsV2apPoSORD+Ogd69g8xLwQGABVDvFxlJNfSNXfMtAytw
 bNwjSmevC0XjfNSRqbRDplu/5blEPeLso65Fkxd/7yZKoWjmTQAQ+7z/+eqKEKKA
 mf6C2f528T4TErutTac9Zzp6R/IgzrfQLypXxL2lv2Z3zxzsp9LMUJjO

This series is a complete rewrite of the RFC without using or touching
the code of `git remote set-head` (that part of the RFC is being handled
in a new thread of it's own).

Based on the previous discussions it does an atomic update of
remote/HEAD if it doesn't exist and is able to. Since we have git remote
set-head for manual handling of remote/HEAD, my idea was that it only
outputs minimal information and in general send the user to use remote
set-head for figuring out issues. If there is a simple, clear HEAD and
is changed it will give the command to use for switching to this and if
something went wrong it tells the user to check with remote set-head.
I'm not sure if this is really needed to be honest.

A note on tests:

- the first patch changing refs_update_symref passes all tests

- the series in itself breaks many fetch tests currently, most of them
  seem to stem from the fact that we now have remote/HEAD refs as extra

I'm planning to add a test to fetch for testing not to overwrite
existing refs, and of course I'll go and clean up all the tests, but it
would be nice to know beforehand if the approach is good and to finalize
all the outputs before changing 30 something tests.

Bence Ferdinandy (2):
  update_symref: add REF_CREATE_ONLY option
  fetch: set remote/HEAD if it does not exist

 builtin/branch.c          |  2 +-
 builtin/checkout.c        |  4 +--
 builtin/clone.c           |  6 ++--
 builtin/fetch.c           | 71 +++++++++++++++++++++++++++++++++++++++
 builtin/notes.c           |  2 +-
 builtin/remote.c          |  6 ++--
 builtin/symbolic-ref.c    |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    |  6 ++--
 refs.h                    | 12 +++++--
 refs/files-backend.c      |  8 +++++
 reset.c                   |  2 +-
 sequencer.c               |  2 +-
 setup.c                   |  2 +-
 t/helper/test-ref-store.c |  2 +-
 15 files changed, 108 insertions(+), 21 deletions(-)

-- 
2.46.1.546.gaa0cd55cd3.dirty

