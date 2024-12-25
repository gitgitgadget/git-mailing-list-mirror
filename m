Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126622615
	for <git@vger.kernel.org>; Wed, 25 Dec 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735151601; cv=none; b=j8kv7DhYlOtmz+6rT521yn/4q/suc57k88gWYHkI8XRzef2YpAegdF8Uuz7ybFgPls40tnbC2r/A4tbgIu+cmrtrp83bx4QOfOJu15D/vsWnHEgkl1QLTSaqNGfjnWs3xmfjKT7Ws6QuxKkwjMT+2bCXyjS5QpykhK163y993lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735151601; c=relaxed/simple;
	bh=w9eA7Iw8kh+LytaQKzlZt/Wk2BK0Gb+X09NI8XDfMxs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GdvIAUM2K4meyMZZydW7QUlSVADRZyR0CKbJog0qxsD65AExLR1hQCzC98F4+0EQ5NwuyaaBFLUKpTb+vFq+FTMAQ6aABqTVVbv29W39Q6WhX/zSAdJhkHBSG5h5Q4HTmUg3b3xYJ5myW0xmmEiQyKwu0aQGdxOzVY+b25kQzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HBG1DcVu; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HBG1DcVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735151588; x=1735756388; i=l.s.r@web.de;
	bh=bbbClDIxjzO8cn+UDFlQwp+3fiiWf3V8HBWDXzVRG1w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HBG1DcVun45NXIHDuzRBoq84VFD9hSKjh+gKj3att4PnQHZHg95yqjgudgry3d5z
	 6on3pBgfv6yuNIMDQP0M5Q2w+bf7CwRV+nrC76raZBlXXdK5q777zMBxCXBQEcwCc
	 UXa1GAJMsZJfNKnMcDaht0G7OfkCXFi5fVcG9kAyoFRPInjbsvOdFnjGtbmv8cxWJ
	 Ar7jK6PuuM2DymlkNOucx71gakqsQyBjaZjfzyXDQ0OYF28LvwFUTeuYrR7u94urv
	 z/5BMbaqBd4F13os9JHAyWbnT9hdPjGIo++Ld9/3r/nztlidw0wTlimXfqu4Lj9Ga
	 +xS7GewGNZGk226Vtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1t9fjL0NBz-00IVxw; Wed, 25
 Dec 2024 19:33:08 +0100
Message-ID: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
Date: Wed, 25 Dec 2024 19:33:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/4] reftable: fix realloc error handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WWk8NKAfpzqyHF1nDspugZAaBtABKNAbSKoZdbKo5vULXIM6ZVJ
 E88q1047xvHB70icac3tokZPgWN2Q/KUWFeihdaSwkrbpciL0BS0CMlh427+Fxer8FyJhU8
 6TeyG20atcGZGWL9yLWtjOL4nB5CY93PIn8S3UPq+Dg7y7vdlOuApUs31KyqhkLdPr+3YcE
 VV0D6iTA4kjrKlJIVhLgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J2Fh0mh1hKw=;E90EAYBmmVJX3PEGrqOc2FBTHTR
 1RBcIP4J5RsbODkZn/8GojgouCsvOBi1fyPHbzq1NTuzJoBUx4ApOVPkzEcYx1aeAMwdUgboA
 L/FAPh72UVWdQi9TasQR5fey1K2LV93prx5MK7SOqZwoD+Sdf+zhvSdECXUf7CU9NF/ZdzMYU
 qjvpU/HLzAQQGqYq7Bo7C3R+74kaC+irX7E+sJecLDz/+ueXg6bEiYk1D8D3T7sa2HH9wS4/S
 Ny8RI7X4OZd54qUjZWswDg4M0+7UZ11zHqBMrFyBxPzoU5euFrCGckOL123O0qrmB8BCisG+O
 vW/zyVcHo9c402SN29fchK2D8JE3jD1uTUy15Aly+ePV6HJLTiGm5dv0TG44m7hVbKwTErvsl
 pxKMKFxao+EOq0SQ9h91Pn123iMQVrTxJ3LUxojIYGLSEHNxniR5gt4QUH8L/oq1jRMB9WdG6
 NO0qX8/XvyutEMbxXp4QyWBnsgcmXAfXmmO1sUQ9dVP0M9QTIYlXkJOBXmSIFgn5hM44nQoPI
 ew1d8aYNsJvJ1m2EZ2exme5VgFRRiOHUdsmcP/re3JM2lJeXNnXwX/JOJw11CWcgVFklNTMDM
 Aod2T8KuWDS94zuj6jCJ/f8/T47hNaxBdVYk9XY23uxRY+quevC3LBAkTLMFrLTD5vHPQ04fT
 SbJAV1m2uUEF2ba+gY7kAYJPed5cflqpCAiEUfOOwNGcAOMhnKDc9DRAfCUenxdSku9fIFMKu
 Ur3f2KCzvKKezxPPJuL3Oud8R/ws45XAeLLer8Wn+jTnpGizTJEK2O6nz5jpwUksHUv+g7Ri+
 LsRnhxuXZoY7uAqHMbdvxFDEQkytiB+08nLp4X0KRp3qdfTesV0pNsxnnWvCRDFfVU1/SzMR8
 mgpgM86Is7fxnoOVklyMZxSGzcjNSSxXvPgjbMIJXyok74KcHZYt04vm6QA1z5CL1YZ3TJ8QA
 1tjeR3+pqOE26jBrW5cPFHzgZ5FZ2lxmTMX8iXFqR2GyIA+Pz6jLPN3EOOjkZsTm8Cuuq30Fa
 MJw2EjdlwXVDHPXnRsheAm2rdEeahsRy7nkcSYaC0miAQ7ZQLlny/bLqdzVgPZ51wBmTHohEQ
 jq1qErxd4=

The current handling of reallocation errors leaks the original
allocation in most cases and corrupts the capacity variable.  Fix
that in REFTABLE_ALLOC_GROW and by providing a new macro
REFTABLE_ALLOC_GROW_OR_NULL -- solve this somewhat tricky issue
centrally, with minimal impact to calling code.

And the last two patches add error handling to the remaining
places that still lack it.

  reftable: avoid leaks on realloc error
  reftable: fix allocation count on realloc error
  reftable: handle realloc error in parse_names()
  t-reftable-merged: handle realloc errors

 reftable/basics.c                | 14 ++++-------
 reftable/basics.h                | 41 +++++++++++++++++++++++++-------
 reftable/block.c                 | 10 ++++----
 reftable/pq.c                    |  2 +-
 reftable/record.c                | 12 +++++-----
 reftable/stack.c                 |  8 ++++---
 reftable/writer.c                |  5 ++--
 t/unit-tests/t-reftable-merged.c |  4 ++--
 8 files changed, 60 insertions(+), 36 deletions(-)

=2D-
2.47.1

