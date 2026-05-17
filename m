Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DCF2DB781
	for <git@vger.kernel.org>; Sun, 17 May 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779036958; cv=none; b=q2SlfZTgCyqoAdjvwU4a2OCr8QwNYi86uN97yLd5bIKKishhPHNGeqVcnLiPZ8kGgSl8CjS07H/R06UXIbBObB0lvU2ltHKEmYOI/n03pppBGJGfknSMTK/e4GmZeSy79pitT1kgYWIMXxQYgtPXVPAtMUrz/RNEXpuyqFdcPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779036958; c=relaxed/simple;
	bh=GtZYf/F9sjWzeCqhxqlufnChQdMBVSVXSc1E1TuJ96w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPMjSnys8kw35U/6viI3n3s9INfRvynDQJbVAC11liKwvdTHOxyvCM3iNXHqvFPk28TuTradxLCS4Cn8/vT8zZU1qiEOtekZ4WjgYKv+4rhw6WjNJUyGa/9zZ6CtjCPUilUNQvak1E+KeXFkDewQTuAEAqOCzvgQCOhpqWePCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=dOcfVLoL; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="dOcfVLoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779036954; x=1779641754; i=l.s.r@web.de;
	bh=bvJhIWLdsBU9Tt+FhWGoosnrvP5KzmkZ4PQ6OLb8Z4w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dOcfVLoL93Pc19wkCRtpzwrpYzzYI27w7+VB/+lSriOWxy3f6c2wJoK+LV881FPh
	 khaTRVGuzK4U5kbALhPFXRU9/X0er5+DahsxmWsZjccWdvyZdaXfUSS8Nxy/aZfkS
	 Qvqa7y7FePP7N9MPVPaZ8lEbzkFoZ0IUlBowp9+43qMGfJH5Hm43CGtwVxqcbiZVv
	 V8LsbkWlRfqHVWEec6vtOdDKxd+ETvG4+Pnlv6HdlzRYFGvTLbFdZACa428JFqzpq
	 wo4mo0Co6KWnaYwYDOo132qvYWEEw/UsbjuEOiDvOH5qvq+3tg3OTvWmw4FUr/AVK
	 V5tMrRC7jSVeNiAsPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MovnY-1xAKNy2Scg-00glGi; Sun, 17
 May 2026 18:50:40 +0200
Message-ID: <2ecb8188-b593-4b0e-9a55-db66cfd3a409@web.de>
Date: Sun, 17 May 2026 18:50:40 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: use priority queue in limit_list()
To: Derrick Stolee <stolee@gmail.com>,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
 <7e5abff7-79c9-41c3-9cfa-2aaf0e69a6a8@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <7e5abff7-79c9-41c3-9cfa-2aaf0e69a6a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:onEj+uckOjm+ePvTYGojl/r80VMFS20bCtHd/jO6m3xv3ilp/dp
 ETf9M4XTFfVYt6URt8fxB5DbGcvk9nGdMcSbrzpGBan1r6Vu/MaIRmK/A28C3M9zabCvQGy
 jGaABEnhUBFIXhNzUDYQk+gMvY9nfv3EWthqfYNaKrjwpxaQylqU2xCV0bpidAvvfTiez6o
 XTEqXXQAzteamVgiGxApA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lGGtg8ZAYnM=;RT/N90dhIW3WNPg59Eqa4UoJRB+
 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
 U27YLlPyO/o

On 5/14/26 9:57 PM, Derrick Stolee wrote:
>=20
> This is good. Is there any chance that you could demonstrate this with
> any commits in the Git repo? It does have some interesting behavior,
> especially around point releases that are independent from the 'master'
> branch and thus could have lopsided symmetric differences using well-
> established tag names.
Couldn't find cases where the patch avoids quadratic runtimes, but nice
speedups nonetheless:


Benchmark 1: ./git_main rev-list --bisect v2.0.1..v2.10.1
  Time (mean =C2=B1 =CF=83):     108.2 ms =C2=B1   1.3 ms    [User: 104.3 =
ms, System: 3.3 ms]
  Range (min =E2=80=A6 max):   106.3 ms =E2=80=A6 110.4 ms    27 runs

Benchmark 2: ./git rev-list --bisect v2.0.1..v2.10.1
  Time (mean =C2=B1 =CF=83):      93.4 ms =C2=B1   0.7 ms    [User: 89.3 m=
s, System: 3.3 ms]
  Range (min =E2=80=A6 max):    92.2 ms =E2=80=A6  94.7 ms    31 runs

Summary
  ./git rev-list --bisect v2.0.1..v2.10.1 ran
    1.16 =C2=B1 0.02 times faster than ./git_main rev-list --bisect v2.0.1=
..v2.10.1


Benchmark 1: ./git_main rev-list --bisect v2.0.1..v2.20.1
  Time (mean =C2=B1 =CF=83):     200.6 ms =C2=B1   1.8 ms    [User: 196.1 =
ms, System: 3.7 ms]
  Range (min =E2=80=A6 max):   197.3 ms =E2=80=A6 203.2 ms    14 runs

Benchmark 2: ./git rev-list --bisect v2.0.1..v2.20.1
  Time (mean =C2=B1 =CF=83):     160.1 ms =C2=B1   0.9 ms    [User: 155.5 =
ms, System: 3.8 ms]
  Range (min =E2=80=A6 max):   158.7 ms =E2=80=A6 161.7 ms    18 runs

Summary
  ./git rev-list --bisect v2.0.1..v2.20.1 ran
    1.25 =C2=B1 0.01 times faster than ./git_main rev-list --bisect v2.0.1=
..v2.20.1


Benchmark 1: ./git_main rev-list --bisect v2.0.1..v2.30.1
  Time (mean =C2=B1 =CF=83):     384.7 ms =C2=B1   2.1 ms    [User: 379.8 =
ms, System: 4.0 ms]
  Range (min =E2=80=A6 max):   382.5 ms =E2=80=A6 390.0 ms    10 runs

Benchmark 2: ./git rev-list --bisect v2.0.1..v2.30.1
  Time (mean =C2=B1 =CF=83):     300.6 ms =C2=B1   0.6 ms    [User: 295.7 =
ms, System: 4.0 ms]
  Range (min =E2=80=A6 max):   299.9 ms =E2=80=A6 301.7 ms    10 runs

Summary
  ./git rev-list --bisect v2.0.1..v2.30.1 ran
    1.28 =C2=B1 0.01 times faster than ./git_main rev-list --bisect v2.0.1=
..v2.30.1


Benchmark 1: ./git_main rev-list --bisect v2.0.1..v2.40.1
  Time (mean =C2=B1 =CF=83):     630.7 ms =C2=B1   4.2 ms    [User: 625.5 =
ms, System: 4.4 ms]
  Range (min =E2=80=A6 max):   625.0 ms =E2=80=A6 637.4 ms    10 runs

Benchmark 2: ./git rev-list --bisect v2.0.1..v2.40.1
  Time (mean =C2=B1 =CF=83):     496.9 ms =C2=B1   1.6 ms    [User: 491.6 =
ms, System: 4.3 ms]
  Range (min =E2=80=A6 max):   494.2 ms =E2=80=A6 499.5 ms    10 runs

Summary
  ./git rev-list --bisect v2.0.1..v2.40.1 ran
    1.27 =C2=B1 0.01 times faster than ./git_main rev-list --bisect v2.0.1=
..v2.40.1


Benchmark 1: ./git_main rev-list --bisect v2.0.1..v2.50.1
  Time (mean =C2=B1 =CF=83):     954.3 ms =C2=B1   7.9 ms    [User: 948.3 =
ms, System: 5.1 ms]
  Range (min =E2=80=A6 max):   943.0 ms =E2=80=A6 965.6 ms    10 runs

Benchmark 2: ./git rev-list --bisect v2.0.1..v2.50.1
  Time (mean =C2=B1 =CF=83):     754.8 ms =C2=B1   4.4 ms    [User: 748.9 =
ms, System: 5.0 ms]
  Range (min =E2=80=A6 max):   750.4 ms =E2=80=A6 765.6 ms    10 runs

Summary
  ./git rev-list --bisect v2.0.1..v2.50.1 ran
    1.26 =C2=B1 0.01 times faster than ./git_main rev-list --bisect v2.0.1=
..v2.50.1

Ren=C3=A9

