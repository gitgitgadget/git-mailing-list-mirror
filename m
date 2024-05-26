Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3991A2C2E
	for <git@vger.kernel.org>; Sun, 26 May 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754621; cv=none; b=lv3jH7mUTCBBx8NLHx5GhUivKGfrZZ2SiSI0VHOHBvb6US419xoKZ5DdTmdx3ihwG+AtZ9jN2t04uX4hOWv7n3lfLsbGNFM86LGLxPG6c29Qy0/xaK+kkpEOWCE2Ruqx0lSo6QQhd0FsDNnU0fkA5rtMJkR2TYcicoLv2gRPgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754621; c=relaxed/simple;
	bh=X4hSe/LNdW397FDoQvUQFIiWdvawh17PKTkO/BW2YD0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Us97VRjlBfEv3WslWhYXz4/YJjOlC+XTwL/qAlog6800efMjsvQ/fae+s3EGBO5CrX9yAgF0AX/wvUDMcVtQgC1aLUqd0dkBV8WWmS8NJCdulKrg2n2Qr77tvUXDJofo0Ufuy23nFFep9h5RcX1SKk3HriLueBwc6415n0Epoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OVgw17Ph; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OVgw17Ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716754610; x=1717359410; i=l.s.r@web.de;
	bh=pOpJiYAkGD+xzrpxbfydWDLj+hLlsIJgmd/+9Kpgq2M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OVgw17Phoxa8OsMMToEuvNeJKxFe+rcDTcLRYA1VQaQY0JocYn7qQnIdDAPtMTYh
	 OcIqotzgGigHd2Uuo8pQc52GYvRA9R7zFwHn+Wv9w9g8CKKLQ+S6MgeQebU5hM0Nv
	 zIkBxIUcLjZmf/DcmH5c4vF/sAwdpyLOUjlypmYMxFLTOLGDgDz64QvuZTY6Sm3YT
	 1rKq5uZv3y8ir/O6dXdgRfhL9gCoJ5AQFuEDLvRWAlXbwc6EX68u2zN4zBYS86brr
	 p2pIimnJTKjzg2az0UqMWEQVQIFMED7X8eUrMHTPOfJT5hxWTF4JluTo24kjLJ8sL
	 /WOn2aaDy0DYCMRCow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xaT-1sWS2L3Hql-0154Ib for
 <git@vger.kernel.org>; Sun, 26 May 2024 22:16:50 +0200
Message-ID: <c7c843b9-0ccf-4bcb-a036-d794729a99d6@web.de>
Date: Sun, 26 May 2024 22:16:50 +0200
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
Subject: [PATCH] difftool: add env vars directly in run_file_diff()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tiH9Skeu6CPKyASCZpaq+/EYzXDoOWgE9eZEAQIeTYwZHCS2HL/
 TInR86LZRMfJB9G1Akj6IV8W0dRWe2VgyokMuyNo0H/+HrwD7EbUDzvE64OSAmTIAj6Slq4
 TkdDlBf2wx4h9vOxCDAMtigj1QUX9eQUO+2AkdHlS2cCOizXfZVsONW10yB3q0ijo0AvCaS
 Gr/gw115YnQl/v5CzFInQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ACPwCetuVWY=;n3Is7ZtoA16VyjxOaHo/iB4DS//
 5Ai3jn4t0IO7nEE7zaGC9EEwxYZF7ZkhATKna8KxYeq3qEbUv93swA4FR5cCyUCgv3xCGqL0E
 7mPAM0dtktqZgzObfKqNlW3pz1rP1k8dqf8kbgahX61NrRByqafR3SeaMfWxFBGqE9We4FKbz
 bhpc7ACqwKcqnScKDfVfo8cwUJmGAKTkoEZ0zOZx1U/cBIYrndtUUFnvLZlzL5OSx8KMw5RIc
 pi5lgMp+Xymqpt1sHIOv97sT+uxA9YY2bym4mN3aCfJGQDugCCB31Q/nOfVsnRGCi8+LScLZm
 k5mevPpzGoWaT1vnLlvIrb+ANpbAKrKxMfdVbLlduygyxZKYA3GtxOQKhL0A67BKrL4910T9b
 YGXPEp11/Jl/pYy9ptA3wd6kvVTodO4K7nX9XTRByx44vhXZ9PslPxrEutTWrkeCoBgv4GLMU
 476gQN3bmpzyT2bdl5djwPeMoX6ctKhyaeskA+8FG27LjTnvel7lzRA5IU4Co8oWNn9upq+v7
 1R/emwBpshNbZjUIY1Dfsi1cJ4D+2GCh7WELuNP65vedODJtbVfHMQOudYHUFmfciQqWQFwa9
 IsXmsCgMvZl2oDK98Jn3kfbhQGr0dtW5wRiMzJ/eyxYFGFB+UExHI1F3qjuwPFfXjIYciNvsq
 ohQYbZF/HradUiZyIgn/JYjCH/5ZN6QV1qHlp7biRmALxdDOYUxlzMttj23KSyTMe00nO+HLP
 +w3S2bx+Tz9SbqeDVi1wB6ki2y/gv0iUmDCrbUZzv75+ylvQSK96UWzEJJjgvtKYGKfbkjRaf
 iYuklmJOUMqctcc7aNxwZ3bY8Ybm1SJnKbJ0aUy5U9r4o=

Add the environment variables of the child process directly using
strvec_push() instead of building an array out of them and then adding
that using strvec_pushv().  The new code is shorter and avoids magic
array index values and fragile array padding.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/difftool.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a130faae4f..a1794b7eed 100644
=2D-- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -674,19 +674,15 @@ static int run_dir_diff(const char *extcmd, int syml=
inks, const char *prefix,
 static int run_file_diff(int prompt, const char *prefix,
 			 struct child_process *child)
 {
-	const char *env[] =3D {
-		"GIT_PAGER=3D", "GIT_EXTERNAL_DIFF=3Dgit-difftool--helper", NULL,
-		NULL
-	};
-
+	strvec_push(&child->env, "GIT_PAGER=3D");
+	strvec_push(&child->env, "GIT_EXTERNAL_DIFF=3Dgit-difftool--helper");
 	if (prompt > 0)
-		env[2] =3D "GIT_DIFFTOOL_PROMPT=3Dtrue";
+		strvec_push(&child->env, "GIT_DIFFTOOL_PROMPT=3Dtrue");
 	else if (!prompt)
-		env[2] =3D "GIT_DIFFTOOL_NO_PROMPT=3Dtrue";
+		strvec_push(&child->env, "GIT_DIFFTOOL_NO_PROMPT=3Dtrue");

 	child->git_cmd =3D 1;
 	child->dir =3D prefix;
-	strvec_pushv(&child->env, env);

 	return run_command(child);
 }
=2D-
2.45.1
