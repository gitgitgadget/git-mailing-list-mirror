Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764C811F7
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266375; cv=none; b=bbuhB1hg8XYtQVFp9e7ndAq53poYoyMFR/p5/0dix7X0Hu3S6YXqoFaIJ5DDqNrLsgV/A08a3zYOgE21W5/Rey5cQpOtxFdib/dO8NoSsaAl22lSLHXefpo274E0NxxeR2QMeChiyIbAaVeXKXviHXsKFsa0mc5LMKzwEVzXIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266375; c=relaxed/simple;
	bh=/GHxM4qgKaCUC9UFTyqFlxNYRwl9EIrk/8JTb22axQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R84OC5QG997/ffFrIfFbF6g6W9+G7dwr6ooCpfAM4xHQePq9rnbthGUQuS0t6bz5EKsliayvcKRdLYRi4whb4S5Pre3v7+YgDKHRQV1GCGKfy/hXSJFsEJDsS/vQSDCdcSkNm6DnLwRdKZeBrzXygKpfcACdHhPvG+0zukyN7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nuHOOz/B; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nuHOOz/B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729266370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBzTeCl8L5N+RIO3XQqMwds5FcYDchZKllRwGIUyzAs=;
	b=nuHOOz/ByK0P9zE61Z8IQ9dTs4duBaUGhVrBXgUwUJX+iEXAQ6GM97zXdPV2tQhLl2Edwz
	nb29+KIpOrsxbaOZg+xynw0yY97FU89o8rHWmu3IZQVwyBWMkb+1f3GRIHtH7L9nO1lKa8
	yjxMbUzlkuebdc2RcIMawacuZH2qn9o=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?utf-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: Re: [PATCH 2/2] Makefile: adjust sed command for generating
 "clar-decls.h"
In-Reply-To: <dda9b8e033c2e32e17dff73cad43211dd355d3ec.1728903464.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1728903464.git.ps@pks.im>
 <dda9b8e033c2e32e17dff73cad43211dd355d3ec.1728903464.git.ps@pks.im>
Date: Fri, 18 Oct 2024 17:45:58 +0200
Message-ID: <87y12lbeix.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>
> This moves the end-of-line marker out of the captured group, matching
> the start-of-line marker and for some reason fixing generation of
> "clar-decls.h" on some older, more esoteric platforms.
>
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index feeed6f9321..0101d349f38 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3905,7 +3905,7 @@ GIT-TEST-SUITES: FORCE
>=20=20
>  $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_=
TEST_SUITES)) GIT-TEST-SUITES
>  	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
> -		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)=
/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
> +		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$$=
/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
>  	done >$@
>  $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
>  	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_D=
IR)/clar.suite
> --=20
> 2.47.0.dirty

You're most likely aware, but this change needs to move when the patch
"Makefile: extract script to generate clar declarations" [1] is merged,
because this line then lives in t/unit-tests/generate-clar-decls.sh.

[1]: https://lore.kernel.org/git/7a619677c7af6ba8213a36208e20ab75c4318e38.1=
728985514.git.ps@pks.im/

--=20
Toon
