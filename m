Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F1439003
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701453; cv=none; b=OdJDbSB19VIv8hdOmKsiEInrgQaOcRtm1WhbF1OlRA07eZG6DyrUoiamZGyfeZOv/PS1zGQV18STbUTi+Lktv70F+uGdpr5p7i0GedwcEb6eVQom+DEhLGw6rBh/9V1TFqElatrCXYV7cWr/1tmcpHwl7awr7XE/jthlMRmfZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701453; c=relaxed/simple;
	bh=obypJAju1t0m0MejdTDQj7SrVouqbkDVozO+sP5oK/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwdCoE1cxR7sKOzkwRH7tTSbYzPWPnUA4QCjoujZfQSoQoHG0Lot9rslCnPgDix1hj3Hfa3kVwut8a88gaq9HjMnUvHCTGKzxGzJ0qi8xuWVqPf/K3JKBSsN11y/lRaJIOW+v6crcTkjV1Roex9duQFiJv2ZPfDGF6ATM0D11JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rqCz2EV9; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rqCz2EV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783701443; x=1784306243; i=l.s.r@web.de;
	bh=C2iYhFbRfBxqCWGYyCbQe4pJjYuBGTyXABCVvYY4Gpk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rqCz2EV9AGf86nR4qZT/c+19CuIPY40AhuZn1c2AKHlAWrVTyRbAwm5Pwxr/5HCK
	 vHrb4gAeDFEf3mYi1Z8gKs9AvlJZZc4YXzVjc6ansQORw4ALBC95Z/ToRIF3D0hS/
	 Phpz61ILrsIeCok88xnLkArpKnQEZa2XLfOlJ2I2MS1WRfU9LT66fMHQ9T6ckyybL
	 HmyIKQIrhjIeYeovkWIGh8pnmZFNf1Xn4EAhjdHZRzykXX+00NfcJu0fJpmVi84nt
	 zEap4vgoAuUT9irk/aw46m1JqIQVjoiBgyuyYE2rqvLCiJ4cIDZvUKNiy6/sCGg+b
	 EgAjm5qrR1QZfHbZMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Epu-1x4RxD0bxI-015H46; Fri, 10
 Jul 2026 18:37:23 +0200
Message-ID: <dfab9ff4-fbfa-4ea2-bea3-09c1d1b1cc18@web.de>
Date: Fri, 10 Jul 2026 18:37:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] prio-queue: use bottom-up sift for extract-min
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
 <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0nR920yc5Nlc3M1vxL0Y+mAWjeoGoc1yurop9LTurdPUWf/ED4/
 /Sop1/JU7vN7Q+grzW99eVtUvPJEN2MOnjTdhY9gWlRGHNgsIXa7X5MZef4U9QydDAxzc6E
 hW6XV48B2NZoS0AtoIR5xZ5cUPAGIx9nVKaq37tVX0WBwYQrN7bMzIhg0p5gs7T+2rQ/2uI
 2IcK0hRL+w6IRWm2+YZHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uf8Bnc1MJmw=;hfu37nKjWwmDFQm57hT6VhQyQeR
 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
 Aj3elyNd48Cegq3hVI=

On 7/8/26 7:49 PM, Kristofer Karlsson via GitGitGadget wrote:
> Note: sift_up() currently uses swap, matching the existing code style. I=
t
> could be further optimized to use copy (hold the element in a temp, shif=
t
> parents down, write once), but that would require changing compare() to
> accept element values instead of array indices. Left for a potential
> follow-up.

Same for sift_down_root(), I guess?  It could almost halve the number of
writes, right?  I wonder how much of that benefit will be eaten by
caching.

Ren=C3=A9

