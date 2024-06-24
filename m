Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F321A0C
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256561; cv=none; b=mjk1TVd2jt80RQDD3OD7Z4O5sDEbxKTG3eUAvmwPs2rP8RydcRIYuQ4f5yrYgdatyWfgiFmcZGNAMqWDnRVZbgmaR/ouvHINYqWY/jTt3tYDQlkAZdqpsmaPW+8aEw5ukZsrxU9J7YAcSUvbiLA+nFM9BMNa+wA6G1BReSJno4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256561; c=relaxed/simple;
	bh=54mJPqB2/jJpsQhZh4cis7AKZDRFTc/ia4LyvKl/qRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SazCEOjFnQ89C5NRqrVEJ+V0hUglS1SX1s2DNC9gcm5UG8U8GVt1O+Y+TEmyFH9PmlSuHP/d/rAB2jY8aF0+5aFaoXjjptiDzjQyjeT4xZWWuouDrGDZTSnQZBJjaLgUwDSFLker9BRadJHN1VrYbxEveho8jTc++dD/69BLiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SprVo1kL; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SprVo1kL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719256545; x=1719861345; i=l.s.r@web.de;
	bh=UM3xgTxHksXolp+S9VcL4fkjFhh/eQp7SX3ZnCVClgc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SprVo1kLMZ+fck7/Gy6c8SbhUYbSO6h/WI6UCyt1I7zudE494ncGRWtZJ1N7NZSH
	 Ln00yYR5KU5rE41YiJwWHLz5HDLTwB+QSlEtMcUzOeXcrdLeCNOcyAWJR9hMBorTt
	 cH4NPqxqqTjC93/uOuGOkflok4bD79oNtASPb9wiy8YF9a7FZyujdV4SSdN6nz2IF
	 i96LHbZbD4VerZ8F1u4ItPgvJXblnUHjQWceCXSVJlK5uEtBTWpIeJ8mQxWff0hb8
	 pUrZlmeKr6qXX7wyqiz1bhnRshxsetVWgeXCsbLSFYpl040yTSDnOAbRdXHJ40fVN
	 +fiUkIHLFPLF12dAOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1srb5J3STs-00qk5f; Mon, 24
 Jun 2024 21:15:45 +0200
Message-ID: <fee1815c-80bb-42a4-97f3-d3f8e9b3a6ca@web.de>
Date: Mon, 24 Jun 2024 21:15:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] diff: allow --color-moved with --no-ext-diff
To: lolligerhans@gmx.de, git@vger.kernel.org
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ig/jX+FX8xHPkbO/aSoelIjrNyc916Cdxqw5z/XzyNFLXD/mlrM
 K32Sy0ln8TAZe/O9IqN/9SMxWKQMfhNBuPC1/vALQ2c5OVFXAbRv4VetQvMf1UNQttn2DaT
 mWWdpVhbwdMjeR7xWhEsEG+UB5bG+7dqMJ63FMh0+F9vLPqAH5PeEHnGx7iyy2bnGfbZ4iP
 7B8EGf6C3IBTSrt7FkLgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hbflxKgKjQA=;6K2QrC/hSL4arCWUnUNBWHE+DCE
 jcrR4vppj6vtvaUO/P4+CuzWwDJhSrC4wIO4aGGZELzRmtAmDhcMBP8PLrj8pxT7d94BZnLdE
 QaOsmmHmCyroU2ZGZnvjMZ2hCodl/mlYQBC0AL9kLym5lJAtiad1oLo+nWQe7LlQUmd31BkH6
 tU0vMGp4cZtevBYxmkDH4r/s5AnHeo9N1DH7sJl7oa9qV/6+o0p4xPMykhVGx/KK4AccoP160
 IiIQfArzmZssxNpReWXRLVt2UMOF/wKRiQjrF58IWx+D+orTWt7fjB13N3GU6XnWLesZEUv1d
 2BXta9FifgP4lNZns9LKuLXiUpXp164iZZuZuQd3az2+1ktNEmUvvbOE1KDxkAYPFJmyIqmOQ
 9xUqEDwDVfhdSOArvYr35sPf61Fy0heVI7ZpUYxBx2/HNU8gOkN0E+MUR7R/z3IzDjrTv25DJ
 taIW7p/ISzpYFOvuLYRSQ6ZX13w/8ZNKND0E55nuyAjq7ZK42JUozRnr+et+o2rO+vFTMWaWt
 qDYoDV5TqCY/oiQSwEUUQEzjTJWuIynFPPv4iprlElBb5SMTpsGSM9RhoeXlyuDO4abdi43ew
 rBiwhd0hMpFc8wQ7BaUAutSlERAlNbZ/5vxT97HSbkjVWrfvnadFiHjWRIkjBq2AkmD/SaDIV
 thlzV5IZXYhiRq1Gay5R6jjCy2IEVCR6wnGr23/CI5DQD9WlxOhEvDMZoNhMDViJ/kgNi06d4
 PgM351xBEh+VFzii1rD0jYeeb5Qutjujaa4iIWBRJ3A5c4A7a0Q6y8rPVmOuTGuMu2fhMvIVa
 3DQwVc7YEby+YTDfwlcWIxveeGZ7bccqJDmhS0nD3RLbY=

We ignore the option --color-moved if an external diff program is
configured, presumably because its overhead is unnecessary in that case.
Respect the option if we don't actually use the external diff, though.

Reported-by: lolligerhans@gmx.de
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
* use single word colors, leaving the background unchanged, as they are
  easier to read,
* run git diff to generate the expected content instead of reusing the
  output of the previous test ...
* ... and put the common arguments in a variable to make clear that we
  compare diff with and without a diff.external/--no-ext-diff dance,
* use echo instead of false as the (unused) external diff command to
  avoid giving the wrong impression that diff.external is a boolean
  option we turn off here.

  diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
  index a1478680b6..851cfe4f32 100755
  --- a/t/t4015-diff-whitespace.sh
  +++ b/t/t4015-diff-whitespace.sh
  @@ -1185,11 +1185,11 @@ test_expect_success 'detect moved code, complete=
 file' '
   '

   test_expect_success '--color-moved with --no-ext-diff' '
  -	test_config color.diff.oldMoved "normal red" &&
  -	test_config color.diff.newMoved "normal green" &&
  -	cp actual.raw expect &&
  -	git -c diff.external=3Dfalse diff HEAD --no-ext-diff \
  -		--color-moved=3Dzebra --color --no-renames >actual &&
  +	test_config color.diff.oldMoved "yellow" &&
  +	test_config color.diff.newMoved "blue" &&
  +	args=3D"--color --color-moved=3Dzebra --no-renames HEAD" &&
  +	git diff $args >expect &&
  +	git -c diff.external=3Decho diff --no-ext-diff $args >actual &&
   	test_cmp expect actual
   '


 diff.c                     | 3 ++-
 t/t4015-diff-whitespace.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 6e432cb8fc..aa0fb77761 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4965,7 +4965,8 @@ void diff_setup_done(struct diff_options *options)
 	if (options->flags.follow_renames)
 		diff_check_follow_pathspec(&options->pathspec, 1);

-	if (!options->use_color || external_diff())
+	if (!options->use_color ||
+	    (options->flags.allow_external && external_diff()))
 		options->color_moved =3D 0;

 	if (options->filter_not) {
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b443626afd..851cfe4f32 100755
=2D-- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1184,6 +1184,15 @@ test_expect_success 'detect moved code, complete fi=
le' '
 	test_cmp expected actual
 '

+test_expect_success '--color-moved with --no-ext-diff' '
+	test_config color.diff.oldMoved "yellow" &&
+	test_config color.diff.newMoved "blue" &&
+	args=3D"--color --color-moved=3Dzebra --no-renames HEAD" &&
+	git diff $args >expect &&
+	git -c diff.external=3Decho diff --no-ext-diff $args >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'detect malicious moved code, inside file' '
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
=2D-
2.45.2
