Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26493A1A2
	for <git@vger.kernel.org>; Wed,  1 May 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559186; cv=none; b=aLPCCdKN3GV+X+zD4TBfIyh7fSkAL682dHufTww26H01oo91f6ODwEbGSHT5zDVlyl0LHntCMvkyNx5h1QJnth2ZEhJ6VelqhQ7TSJZzqgO9tGrL4lJFklgVa8QZDlLstTOVSAxd2kRr5OGHUg07EGpzcSOsIey8NwWmCT2xxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559186; c=relaxed/simple;
	bh=zaYlepaRtcICiGUKmfsARITTg/4tw3QDJ80GO3/aS9M=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EM/j3bjygZ3P0IqG2SWZ1neMhXR1PgpLsKKk2oshnden8FetLLYXTJ9qke+j2u0irHb3R192HIaschwwy6eEg1ZKeLzkGLRWSMtgOAGUb769LzOgCTtoqKiUp9hzqo/Z+3QphYJFl/L72bp0XGOS/UyidPoBzkemFRszYy9hMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YQQYQ8G/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YQQYQ8G/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714559176; x=1715163976; i=l.s.r@web.de;
	bh=iMGG7fkMWbHHTWUfOQtLRrCGVXjHf1ml3fXLX5S7170=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YQQYQ8G/uckqBohWtkWJ3+V5CN1Sm8Izt5arQqfPC7uv0Qd0zGF0VUX6XvmvuMqD
	 rZ+C2Y/9az/IWlpET3hgPuFXy9dMslvtysngCKHIMcSWx3iMb4uHlE6u+9hoIJNKt
	 PXWv8Vp4M6Ik0mwsc5pkv9lCI9AvmziRSgMTCaqlYTjGwy119VnRq42OX3LyEXoQk
	 jMCpVSHMniOTzaowXEXZKdS/Hm1GUn2nHl3guHRSCwMOlQLppBB9JHNx7GHLuYLfo
	 Rkg75/UJYvQHxZAm9OXehhixNZbWvnEtevFkuPCaKZ9IomVS5AzXPaUqjxAvweP/X
	 w2Ys2/whVsXw8xEPsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKFD-1sIw8D1vhN-00P9wS for
 <git@vger.kernel.org>; Wed, 01 May 2024 12:26:16 +0200
Message-ID: <0e96c5a3-7b4d-4c6b-875e-d80e3eb07a00@web.de>
Date: Wed, 1 May 2024 12:26:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] diff-lib: stop calling diff_setup_done() in do_diff_cache()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ed3qlKGKKltkT7p/rtxisYwihG5VFBCrlKzqURkzvG6ImFiQUv5
 IzhHibi/JpLQZ2rWQFl7IvuimW/nkhZIBO3bpzx7SIPuYRDB1zGO2KgVy22m4l7jMnXpDeD
 49hePMsu4319gmjMlCbGXg0F4k+VQpZrU6i2mvpM2ylAe7XsrUk+3+tAI8v7/F2sP+HL/t3
 D+SDhW1rymc5tr+sVwoGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xez9UcZwXok=;JjUJAxNHd8ARn907get7qk3wJXh
 GzriKO4pzr3prLHSgaM3PYCjLWkVDj1xRqpzSIao+B5VvjEI45LGIE7IlCTMQqfwrIvvKswx2
 2L3FmLFwXwfZNKlaWhp98pB+eO4iVeUkVLSoy06FODyCE9WbpCu0v3FhxWeFY+pKRa/pqzsUs
 +4zobIw6lFQxqk4EIRQn0K2KOi1Bi9TcBePZ7cspoQG5Vbt722GqGg8PACN+X8ET+86hakueg
 3tV7hQepzuIVQnrvTCuQhj4+v2b9AQ3TNsUqHORCqThxtB8ZgV5asDbJHh0NO3Xlw5Q13YW/1
 jz/AqlZ1WlfbpOYYf93CrC8gZQagv4SDiA57Jh95ANA+rxRZE+rPTN+wBZiqzbf8iCv3x9Kkt
 FyX6KGFm4G/VPj0LLakUOQe3hD+FSTMtLmeGXvjeXQvgfDRCkooYeDskkh5mkEqMr8kYT+OLY
 fN8di8hmnKFAnnNL/wrGw1EviMLPw9CJyiexkynorWUjpSnYkChC3ps4Lc5mMtf7k+I0mCy3N
 1shrSp151EJhcCB8v7Mzp4fa3MfLIjp1+ELq+f2AXrRKkUWgx2pd6gP3Q1D/2B0B4uuyIZcDl
 Z+MO43KZ7PYYrFh/0Kxf8RiNxvKxCSVAAy9V2o+AN6ucXralJkjPK/3dTMbOsvuDGDpPTZhR6
 16uHtLPlTRSlngt4BoOo7frltvpAKS9179yqb6i3hfBtC6sFR/W5q4MIzqWBiE333Wjcqwllf
 7aP51cOfrKXoz0MhFEbm0mDZn+djHqPOizUjMuUq17W0DJGlxih8uko6zCJBcxVAOgDiAjX2U
 vH7iiNRMEssNzJt9QFRrvya6s0pkv0rMzynEyquVrJ3tI=

d44e5267ea (diff-lib: plug minor memory leaks in do_diff_cache(),
2020-11-14) added the call to diff_setup_done() to release the memory
of the parseopt member of struct diff_options that repo_init_revisions()
had allocated via repo_diff_setup() and prep_parse_options().

189e97bc4b (diff: remove parseopts member from struct diff_options,
2022-12-01) did away with that allocation; diff_setup_done() doesn't
release any memory anymore.  So stop calling this function on the blank
diffopt member before it is overwritten, as this is no longer necessary.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff-lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 683f11e509..12b1541478 100644
=2D-- a/diff-lib.c
+++ b/diff-lib.c
@@ -660,7 +660,6 @@ int do_diff_cache(const struct object_id *tree_oid, st=
ruct diff_options *opt)

 	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
-	diff_setup_done(&revs.diffopt);
 	revs.diffopt =3D *opt;

 	if (diff_cache(&revs, tree_oid, NULL, 1))
=2D-
2.44.0
