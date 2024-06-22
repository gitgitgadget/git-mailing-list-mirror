Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502021373
	for <git@vger.kernel.org>; Sat, 22 Jun 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719085295; cv=none; b=am/a5Wscn6y0AzqfIvj7h/O0cE4016cvZLbYf0rDZ4+Vt0Wn0ZmDrYoc7VF/9e/DEKYQSPoFtO/k4Zucfh35H3ZcUCE6XVWh9co1GKKJCCQ3yeXn7+hJ/fXgNqJkdftY/uHoEPksfJiMymXiiym5uG43lGEDTp2aUDfIRYtckCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719085295; c=relaxed/simple;
	bh=POztaSB27yM1nj7LKX3lJ3FUWWR6jh6yvp/n5H41Vvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jp7IbhTG4nbUyceDeT+VsJD8WQnnz68oDs/Ebo3o3T25MIELU058d6+1oqrRARDS4CKg/CsR0TR967Jt2k84JxjloG3Uhov6MBq+7mpMt91A/wqiXOwg3+Un0U9X0sHNLLG6EHxNJj6eon54tXCiXIX9uK+N8C0IZt9aktoBtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tpberX0A; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tpberX0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719085290; x=1719690090; i=l.s.r@web.de;
	bh=fVswwENxVX4k+XxsrEHteZz/sQ4r7YI5nEPo5Hbb1kw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tpberX0AV6Sga2uu/+PY7dMVaD3LQlekGjGR86ol6tX7/+/NYS4elms59VAv+Uv+
	 RDab8k/nafwvwUi+ru7XNmO2lAdD9eOJokb3LwdV0+3cIES2rfjA5XTW66pyu1Ppk
	 r5fnZIv72T34pIO8NV4bfw4pz+vpTXDT19bOz2ta8jBc+utAucuWNkDZvQv1g9IJn
	 EGtCyD1vykLcP4A6dMgpuNHmQ7gqVf/ha6me2rGy3m8QRkmMNfa1QJ8SmNN49OJ9Z
	 3EcUA3EV82vJ9elPKgVP6c4GQxXHWdg2AAaQDq33sCQHFfBi3K5HYRi+XvaqILFue
	 5Z4TBXVhfsqbGO9gOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vRY-1sSyqc3DBU-00v7Q0; Sat, 22
 Jun 2024 21:41:30 +0200
Message-ID: <8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de>
Date: Sat, 22 Jun 2024 21:41:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] diff: allow --color-moved with --no-ext-diff
To: lolligerhans@gmx.de, git@vger.kernel.org
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:udRHzUf99Fyd1/SfZTfSADXgUyKQBnszu939GHsyDvrjIYh15Bw
 jVfvGqcOOI+pu789d35r7CS1P3W+hdsz7n5Yy9hBJBmUV4wN/2/qkmkYJMit+p2g3GfCEqx
 x2a9LITYBNWElnYtMj0QXZBZqNf+Hg59EiXJpprBYndOQc+pmYSut6Mkby8kFPBaElgmtNJ
 OcFIhVUM69PkO7ckb7hWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:93tg3AQiChQ=;pgQbf9vG8qSexBKDZhBPRdgTbrI
 fzhifIm8rOvWAZ+JD3ZhlvyzrmKce31wUUhAAtiG9kgr15fccxWKb0AKGbbNMxQFK3L99uvt/
 FXLKUfNa1lkp0D9MSVBll5nZ9s0PZF2m8SZEo2/UAx/csN5N80cXKx6OAXQHWGcnwqpLfuj4g
 bZFCMcPwrtAkT+1DUXClG2z14vSlux8gri/MDNxN0GNcf5VpMv0MYERtJWhdIkCC4F3GsV9X0
 iH2rJw6+mai+bDCUFjUM1OzLZi2yOzTKjVzK9PKgnhZb4Sd4bs1BFX3nvyJDwqrKlVajq5JY2
 wgGOM0YriIDJPTY0ZURKpXu86msf3bOK5cpntNVlTUXCQKRWkIiTiLTfukm9dTLEW1Gvjk/ro
 HCsMZZTBof4OC1chyyOw/Y1Q2hzGiY3gpik+RNj9I+/83XvyNX6PUEXy9byexw3oVdb7U0dzu
 i0BrQrKkf3R2OsgL+aKdj72K+Yk1QqjAW1yXgkDXrtF69B35pLCbwjoV1P5EdqJFsVtue07Nf
 GXPhHHXzkIPyNSET7YABJJGKmXxAzDVayKjGPL7l9XC2kl5Se36L90dnIhFygZG2YbswNf9SS
 NNIHghF9ZqEhcJ8inOQvLfrzdeGPtpESYibsQlHIyTXC72/yXFjP37gPJDSd4s6qXNBWq9NOL
 /cbo3PM/EjpYOHqlB8vrmKBNcMebXyeE+H1r0lsHYXdVfEgzaSrh0t36ckK9a7p3oAOCjkJ4H
 WmsIuNPU00VyWhyLOjzZxJtmnrOtl5OAqu/lcnp0C4OJr44x9rv+G7aNQAABsOFpnNKg5rwWb
 uLu4feuvm9j0EyRt6AATc9NgsbhIoMKOlGVCvv0A12Y5Q=

Since the option --color-moved was added by 2e2d5ac184 (diff.c: color
moved lines differently, 2017-06-30) we have been ignoring it if an
external diff program is configured, presumably because its overhead is
unnecessary in that case.

Do respect --color-moved if we don't actually use the configured
external diff, though.

Reported-by: lolligerhans@gmx.de
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
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
index b443626afd..a1478680b6 100755
=2D-- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1184,6 +1184,15 @@ test_expect_success 'detect moved code, complete fi=
le' '
 	test_cmp expected actual
 '

+test_expect_success '--color-moved with --no-ext-diff' '
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	cp actual.raw expect &&
+	git -c diff.external=3Dfalse diff HEAD --no-ext-diff \
+		--color-moved=3Dzebra --color --no-renames >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'detect malicious moved code, inside file' '
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
=2D-
2.45.2
