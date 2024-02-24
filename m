Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824BDE560
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810287; cv=none; b=IRoL64FSn0NOSuPzxcqOy/8S9NGFB5sJpmhqg/fs6Pf8tVDZmtq2Ro/sd5qK4uxLxle/PLyijcX7jl8AxwhW/dYw5gdRDbQ4WyniCvhg6T1Hnlt8N58QBRFQMjjEVY1CJkpFneYLm+N7MHAUbe6Ho/N1c9DCZ9d+tHRNlnolEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810287; c=relaxed/simple;
	bh=K0giLqqZ2gFuEVL7BgLhoEm34jNiTMkOW70KQR2PivQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jE+ea99Vp3vkKyTTrhxjBblGrNyka8iCw8qeJb1BjeTC1owb56MaE1YFIwLMxfJ2DyrUO7Bwn8GZU94bv/fmOk8fS17nEj5uiPykM0fAIAT77+xSwF/yXQqG+jdVvfrA9aRIrU7zJgjMTiFkVMSdYmYF5nUsXTvYX8QEM9vPW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CcVV85/B; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CcVV85/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810277; x=1709415077; i=l.s.r@web.de;
	bh=K0giLqqZ2gFuEVL7BgLhoEm34jNiTMkOW70KQR2PivQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=CcVV85/BkkAEqeoUfkiwpjBE5A1+5QwNa+uGvcf0U87qmzqBbtk21GiqWEWAJJWB
	 OkwMzknxT7SBmHikVac6R8pEcG+6YlOOTAyp9G8TUU+e4oUX7a26LBhGcdWzoVp6P
	 O83R9EtNOAXkN7UH5s5+rr2+8ojx3LgIYg3S4TkIgre794xHgWqHbd1/5ZGroU2nV
	 /velF7Np5tDJHbKZ45xscHXbYbJwKs71reQBuAVoagsc5LWaLqDbssEKb2O0SmZal
	 tjsfOqsxTvwdg+aFxt9l9p8U09LZN9wvgFKw87zAL41Le8Vko42P+Rk/Ai38D3mgE
	 VK/rF33+jW495Bqxiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MDMzC-1rnJXH0Czm-00AULs for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:31:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 0/6] parse-options: long option parsing fixes and cleanup
Date: Sat, 24 Feb 2024 22:29:47 +0100
Message-ID: <20240224212953.44026-1-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a7XYONitWEwNcrAI6mvCTjUdWBuFhdsgU+yFF6HLxHKcQ5ku+Rt
 /a4t7nrWKYV37Hs81dneGvWMSud4WPeYMoY1T8Zd7rJfxuqjNalXk8YlLDegL8acnUXcec7
 pMsY+Res9W/ic0HZhPhZxQ2qsXRaHj1V242PtztFZbEmtTrDoIq61iu5mTPN3pbwVGcuu0X
 lB0ufRb4lV4uXl5rYx0QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XQW/zqRAdvM=;oGY7wMv10EE5rR59Ea1hoto/9OK
 o4YmnMzZ0tfAU4uJ2yPDSHF/VJh9KRBdFhKtwAH+R8IWt5zhNRsN8PL6VKPp1dgqGlRnbEcza
 3kB3kQd649NjDpdlVfwMWaXD9ZX92Jwyhj3hoFiE6fQupUxNCyqChxt3/9PX1l/oRikkZJvP2
 9z6CkAyMMJlq0zAuo+lVqJ75sxcprqGIQGoiRBtVuC3n46azn7zv0dEDKG/yV+Qr8nzm4gUsz
 vFAox9GfCLkQoBbk01qoxqnjvmm9R1beTQaDW5zEocRnIyTIYNwmFa85befhMYLtUeasfj10K
 xy4MirDnI4My/GrAO3/dQYwpcYpiDBFMEoieUS8A3aW4atDCKpgScMfjB1F3tIveoYOSJy3xm
 6P+gbzwIPVWYsqjwnSGLK30RmdH12pFfVOPTXkfgZTmG2kJsHs5ubLsOjN5clCLFEoDoyZNV+
 sV9YOMPyGfZV4nqURankbxIMZ6elr30HEDdl/AtBOemfFFkvC/EebAmIGgMnsMYURzpzryrBE
 BLQ5kvPLEiLYk0pyxS/nRGgP8oNcz9rUZC6mxBd7+LewIKPaj2fYA2RVYRnnjKev7xL7xBS5K
 allOBu9LjxGzatQIskUuWe6fqIPO1GGm5gajIoBYnPicOPjT0VBmynse8naBzWYPt5UqE3LSH
 FL68g5bgBnP0ueFN9ZFp9L+1l0ue/Xn3cm0xTEzdrmwbFMP+4qvg3qBr/pIb6lkOzLp2yXTPk
 71c3gnFs5ZTRaYITtXtGdaKlCKW90vWCh6gOCh0Ry3SnY4aP1dYOTZL3jyTYPqtL2+v5xbRo3
 vYQdBuGSxaPpoGsOEV4YQ/CrhLWzflnbAnMzAjzgxeNwY=

Fix two corner cases in patches 1 and 4, refactor the code in patches 2
and 3 to prepare the second fix, bonus patches 5 and 6 simplify the code
and improve readability.

  parse-options: recognize abbreviated negated option with arg
  parse-options: set arg of abbreviated option lazily
  parse-options: factor out register_abbrev() and struct parsed_option
  parse-options: detect ambiguous self-negation
  parse-options: normalize arg and long_name before comparison
  parse-options: rearrange long_name matching code

 parse-options.c               | 137 ++++++++++++++++++----------------
 t/t0040-parse-options.sh      |  16 ++++
 t/t1502-rev-parse-parseopt.sh |  11 +++
 3 files changed, 100 insertions(+), 64 deletions(-)

=2D-
2.44.0

