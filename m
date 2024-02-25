Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97583FC0B
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708861203; cv=none; b=awxl11KDBDqWshGNPfrnurRR8K4y8zK9NjJaL9sjdEkT9BsK74gw1iKQ673iBjOQycUlsW52kKt7behOdEMrLVLAZX0auuelDnxCtin1nBoKQonO5ZkWmCa/lEVt6B7Ez0FAQgKUp/lI9M0BTgc+NehrpFzo2aZPncgX3ZsU0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708861203; c=relaxed/simple;
	bh=yG40nsX5B2a9ENyVUOuhRU4SgAQfMqZXMUU1E0pru1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3C0ramN0Srm5QfAyZMGWdc/BzkNpAbezTbcHdXaKCP7ZdP9PgZr9LGx58vZn6gCf9Cr0gf8j6vTaW+IltMyeqS92NW6ryIP3zR4ywr8+M37EBLqGkUYbFoWqTrqVpEKC/nM+F7EObGT3KEklXaTw8hBlrrlH39PTREL8ezB6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BbarhAYO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BbarhAYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708861198; x=1709465998; i=l.s.r@web.de;
	bh=yG40nsX5B2a9ENyVUOuhRU4SgAQfMqZXMUU1E0pru1A=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=BbarhAYOpm/g+X/J25qLmdbXvxE6fa9lv/kXIiwtWr1ZhuN1+oHYNh///2ag1KcV
	 +IZZfeDzSMpf6zX3CkOgymZxQXG18q5LMzPOlG9bGrT3eBCfIAwZRaY0PdQRP54/k
	 CPNasF55GOA+3LI+AKPW0wLQ0GVUScaIpnte1MT+Q198eZ1qC1QN7A9TbOPqMMZi3
	 OKEfwkJyKQFCj6D1Zsh5WYqq7yZHZBJ2vitFVPniDUieOipP0Kuy5FHRJuRgMJ3kz
	 3mvoIF/7AGWmIN/QxmZeugQ2GCb1SvU1sKV2ZIJdvjhpAK+0MQs2MY0RGq7CJdhdg
	 g7HA8UwVvRAu8QNQow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MMGyK-1rNDho1cBC-00JgaB for <git@vger.kernel.org>; Sun, 25 Feb 2024 12:39:58
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 0/2] name-rev: use memory pool for name strings
Date: Sun, 25 Feb 2024 12:39:43 +0100
Message-ID: <20240225113947.89357-1-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l7Cc6H8SCzYOtlQlzJMb59UCAyp634StZtfTossqNg8XY46JXg+
 K86QwUFFYReTbRG/dIe8Z+EoGwwK9c1ezB5tZ1UhPKmgJ0tW6gy3cHDcjsk7RIjKlhUSP5S
 fIgsUbrRoBtTPinlfHbPe6ixT0QRC2SAKn8AvXJpg6Lj5G0mtiFltfveSpP0LfnbMdFuCP0
 u2mJYY1Q1Lpd4SO2tIe4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pV2lT+G9d9A=;IBEmoOXirJRTZ/KAcXCoiczRhZn
 du1nymalC0gy0YfxUnOeitOCyXXSwdCgskFks+KU55Zyo2SQ3m9FUi2r4dexAlAoQahdnQOKI
 Tg/HMBm3JTARh4i8Y9z5nTUycw1YZ9F71HhO68WtLHOVi/QUyTXRnoT+VScNxsmlIohPZmVDM
 raJodMXqu5k0s9u+2dV+RRiKABTudqK38C1wPwvWK1YIyZp/iWjHBmUOmNt6PuYEOwX/aV8VX
 nUb86MFIKb7ETp4AW0wF4FCq6qbUHHfO5uSS4kpeqTSANbEZVN4GqyDsTB0gNETF8QjkdCZTM
 8H3Rpbko3CJ2kATPB9lbVpMGBp14Wyv26zOzKUMAt00DIVSzjq7JT4NqjkG1lI+g/i1eqXwCz
 qfdJNiUjOPmqAyYFDaDqFprMvwLiqYewXfdGkUb9Qv8BO2Gn2+cOAggELtbFDCgI0vmQj8+rn
 W3Oz1o56kt4CbJnh/Y6hUiGm22cLxG6zIlZwFFCQbvGNzVW8Vt/P/QibpL80UKboGyLtGHqgy
 vRAa/r0wPkhVcyp+pI2Orv8pDaj3dlmjzGU2K64wwepDcGsPrjYrwIcsNCv5oBTKVe3amPQ6G
 1LUZ5v7wDxiN7j3+0Mlyr6EET/1WOtvxvOu0l0WNSzRHMeiSpKrUvu3l/uqp5U7s6p8eRcqJv
 jw5UuACymwQYXBRf3c+iG+cByuaMBIDliTnJ+xwjZQq2Kc7u0ZI3yzOoSzRl2ONbwQZWs7VzB
 KPw6FtYf8NGgC/S1yTI86yz7rsuWSG3rVdIU0wrKeaVlKhQKOIVnPX/wiFYugdUAw2E1D6mm1
 vpkgn1+XRoNRz4UzahoVv7IvrUfR0BiAH8SlgxdXJCrSo=

Avoid awkward string buffer pre-sizing by adding and using an efficient
mem-pool-backed string format function.

  mem-pool: add mem_pool_strfmt()
  name-rev: use mem_pool_strfmt()

 builtin/name-rev.c | 39 ++++++++++++++++++++-------------------
 mem-pool.c         | 39 +++++++++++++++++++++++++++++++++++++++
 mem-pool.h         |  5 +++++
 3 files changed, 64 insertions(+), 19 deletions(-)

=2D-
2.44.0

