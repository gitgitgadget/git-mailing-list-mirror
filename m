Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54546433A4
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735379385; cv=none; b=oLGj5lAwFCeMVN07ALI/445cpXWJOLSOyqnVxfV+99A+/m6ZOKAo55ps6Jk3b2N5NvG7IoUjQOCKqbimfSw0H8pK8WRO8wSuyW+gAeGcfTERHJkgqqGbA4YGleTiKJ1vloUzBkHedJVM83NgK5HWyUg5j8scPH2nAJhute5QtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735379385; c=relaxed/simple;
	bh=OXlRXF3AqxENeuz8kmkXHvJehkPWhRN7W7f/yJxugCA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rNHEgD16SBt4jd6tYwC1bx0LpLt5/ffJYi+XjcL+Y5Axy04LKo7e6UL8ymeyneBozdl1JO1DGOLP1bvtFMc96DcdI4PLdFYiBERwui1FkQbTiqOYc+ELitTR0ISnQDFM9QMHmiv7wx+aGPz6Dnke9/yCbRCjFO2rQ7h2/HlnB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=kXbEgyFw; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="kXbEgyFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735379379; x=1735984179; i=l.s.r@web.de;
	bh=kcrkxjD2WV/GHRFksAJCFRvefRGq+noNEUMGS9ew4v0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kXbEgyFw6AqH3bOHg2/U4aKa+r9pRe8CgWJBAcLab6n2tdfjLpsHvq7jsUTpLSuy
	 mwz3B3MO30vI3jcX43+KqgdRUMrPOMkIJ5RpUYWkhtRQ5ECf4dH7yXbH4X4wELUe0
	 gMIzFaCypGpUKSNNggNbfzuGJEOn7LBmadZuQqY3WX/u1tKq0UIlVxJ/xX/nOEeaZ
	 sdn5igu+2s41J9bzYJwCDHmUovdcVNneJK8VtLzFXQofwnpF4D/OghNLxXL1/1Q5F
	 lxztQ9ludVy9gmXWiLWBBAmUBjT2ZO7Ue2bsts1clQInkKXdEUTDGgphm+WWRxILu
	 bzFVSr6sBJuW1NOMTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlbHC-1trDkH0Ows-00kJlX; Sat, 28
 Dec 2024 10:49:39 +0100
Message-ID: <e6274b50-e826-4150-9a9f-4f7a2214a134@web.de>
Date: Sat, 28 Dec 2024 10:49:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/4] t-reftable-merged: handle realloc errors
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Language: en-US
In-Reply-To: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+XAPQ8oVS6W+kTPooz0bRvfuf4SvHPq+MTs4EFIl8mXt/3hRImh
 chDtaow/JvTlO2wMKq0n6y5yhCM8NXc1MQFeF/6g7zYiXx0VKTMYXU7CNKmcXWXFTMz7WxZ
 djh7gWgupmdHvU8pEdIcgPIqIpucZOA0qPn0SBNgOKEgbZm9Fshv9Rhngqt5MmcoCGMW+cu
 AwFtA3wEc+MTV97Cp/Ezw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zV79Dv+bPeM=;cIglaNM7OYpynX5Mj5uOH6Q/NP2
 RI2Jq/oKLmkD38nz6/ukEW5ApL9Og9FBYJV/fcKVLz7jmC/9b/ycJHlD8rk93iq1dn61YoqbH
 910e5S8iq9jCLIErOxOofuy8Lkp/GLHU+/xPUaeqWObefBt5asMkWGrFng1l1kM5uNg3H5Vtf
 ifud3l1pLGyN46c6/B2sY+fdzicmDSlhVV2U4UPnuK3xg8R/HkKGYy0MPlk6JpYT/qOXxApuM
 G79Pjp0XsJeKO4wtOcWq0fZCS0yPZ4XowpsJqBElmoOxurB+tUzK1Ct3zQ6HMmyC+yC1B5vWu
 OQg4NmXSkDmYYBHV2BsDQ2dsxt6DB+WFa5GTN0XAd0v/lWNZhZEL5liLU45OTbo7daxMLUJjs
 ZR/dvl2RsSZFHFu4j73updf0wRRRV18zL1yLqA1fqn8RiwdQrtDxv523sGbq4uzS23Vp3PAqL
 9arIJ8/hcXYk1STnPn6TbVBFtw0JCV2LtPLVO5ypkDRvXslLS7PNFveMMwPTRUJ6tNvo5mn/a
 xR4bTgLwwVKKxa2aYetWbKNHu0YAiGBwJnO7DOxDdyrkOWXhKIBeOxi/+HCXncS4hnKnBIiqd
 Ai5FtI5+6rGGBRt9GjsSvt93LUVS1GgADb/ig0zaW0oarNfsVZo9M47SsBqUa3bTBONDmX78F
 z3xynvLY6er0jvmJkaKsUy6/p6kXuiV4671NLN54DfNiDdZkMgbxvDn4lBSTAII/HGOCvS6WY
 wb7IjzP6eZiySuClUkdr6XAIpVRGKvKgKY8KlJk1gy+ZV253/BPm63JU4eNWHtBdhkch+AL2l
 5lxEN3uUhRytlQ/gUjp72cRgZYuoawVcLsvElOV05/qLuHXZgP2KXp7KQmN64z7Yf7td7K2Xr
 NLVRPoO140EyAq4LfRP0cDr1F9qgl6/en0jddosWExQNqpXdDW9Wp5MgqGu4CMsIUyNMJMy0+
 NdMYW44QUMBv9ElJta8MkaGKR4n1w6P3v7iGIvS2ZO3uwKKFgtRXfxHdXGyFcTvDLYZGmtBXV
 1P9zeBQn5mzXm9m/rzeJXU3n0pVIuqetB9Ma6FHSzw41y8dYv7qRF4ZZ7PyBi6+kao+ePsbDd
 zCPN71hWI=

Check reallocation errors in unit tests, like everywhere else.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-reftable-merged.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-me=
rged.c
index a12bd0e1a3..60836f80d6 100644
=2D-- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -178,7 +178,7 @@ static void t_merged_refs(void)
 		if (err > 0)
 			break;

-		REFTABLE_ALLOC_GROW(out, len + 1, cap);
+		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
 		out[len++] =3D ref;
 	}
 	reftable_iterator_destroy(&it);
@@ -459,7 +459,7 @@ static void t_merged_logs(void)
 		if (err > 0)
 			break;

-		REFTABLE_ALLOC_GROW(out, len + 1, cap);
+		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
 		out[len++] =3D log;
 	}
 	reftable_iterator_destroy(&it);
=2D-
2.47.1
