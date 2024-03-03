Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C3C14F
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468407; cv=none; b=rWavf+Uf0Ky2wVLsFKg0K4i0FhequjlpiRh79fAV6bByOpt4sHMPVxx8/zLdjr4YR+vlxQ7vMCSC3aePI3QiDLsNlQ1KZeQvpf49gUozwt4IoYgrGwAbQBe6N4ddPuVrmp67zvmoZcu1U0eO0e101NSQNq4832RNOcQ/8ejlW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468407; c=relaxed/simple;
	bh=YOkRuHmMmdR8O7bKwheI7I+15I8BniaowkDjcM69Yao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUWG9Z4fS2m9PfwO54e0NVlM+XQTiE6Xtaf2AJ953JFroo/U22VXeVwFBewqFxuUlOreEsy8zX6H5AYw4jQ/9Rf9HmifcMz0OPJozJkwMQzHoc4mLnxPtqoR/HyQNdy7h8lTGzDePwJB2E0TNDEW3I/cA/z2/MDfz+MXBTtxe4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=X/UHETE+; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="X/UHETE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709468393; x=1710073193; i=l.s.r@web.de;
	bh=YOkRuHmMmdR8O7bKwheI7I+15I8BniaowkDjcM69Yao=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=X/UHETE+gGS0o2B/LI/eaWIf52s83bm9Mc1+XCr8W7n7cB88zKNzlJtBsLORq58+
	 Z3uCitDNM2nHVGOUtbErGHt3JDGljTiWENaSI8gISgl6VEu/PuECg5pB9/vKF3DMr
	 uDt7Eo/UChbJVsQ6kMRIe/UJV7EViIaWeJhQomfmENlEVXi1mJ92NM40S9+S7yreU
	 jGlWSTUvBhhkDaeqLiJTGGO/+SKDn4GDkfLBoJ3x8sizgIhtL54IbI+MFqy9pgfU0
	 8QH0FRyh3hFanlH/wyXiVaed8+E0Mjf9MPuiRiG/fa07W6YiHaLUpb49jDTnfgWdP
	 caGWus6FYtpzQjWLvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mm9VU-1qyrLV0qie-00i4GU for <git@vger.kernel.org>; Sun, 03 Mar 2024 13:19:53
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH v2 0/6] parse-options: long option parsing fixes and cleanup
Date: Sun,  3 Mar 2024 13:19:37 +0100
Message-ID: <20240303121944.20627-1-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224212953.44026-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VKRlJ6MNwJRG18xWjt6/9CKCVtdSJ/scXcNyu+IP2KtNuu8Lksz
 Pyl0Qf25QMbpehaJw4hQKM/QVSukAWbcI4fL6Bo6yscZ1vDVxqpdZM71MisIWDPUF/G6y7y
 SVhp9Q5AtSliYNj5I/3GLJY7Ou1IdzT9rmRGYXlDv7Ra+k6wtbX/bwhx1Z+fcagPoDLIYLI
 Ibehh5Hnm1I0rnBtZG1EQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HgkJcqxngEI=;8F7DClPR9urJKnBOQzCse+tUizW
 YzPnWMwq5wx83FUT4Ts0IDSs2e9g0FepcwI6jpYsaBR6BP0YCg0Bv4mBn881RZjP10sO2yjn4
 HD/jrrj9DejufROQGJsNncLkyTdNv8I+sKi3cITYJ9bulgs+0ag08rOCeDLY4vwkAJMRtJ+hy
 n1B81DtxlWw7A29CSPeraiDVwZrHgO/6zEH8K9dJaybe5UfgAiyxf+TVnYdroM/WgRCdNuiPe
 pzFNCdvrf71GG1YaqRl+t4YqEi1plcsj5TUVkP7ADoneqURJUizdAv346Rdcot8waHQgqP2r2
 UYrbOruw132O6+0VZh46+rUL+Fbnw2msYgYvV6ihMrEYBtPD+9oheON5dyUCScT57ECGlCMrb
 O0RaE8PNRET7zhAY/5GBCEwiVW5HI4xmgN1Fjr+1ETl2dp0IW40+EB+8GonniTGaxd2EBphWV
 gqsrytfV+U20X3q0Qs7vUO2ivtgKhEhOhbYxYvH7K8hpArZWlOwcLpSoKIIRRj5ixO2TRlNre
 +JYEhqPPzUGCb5RtTeR3T61tD6IX11aozO/v0SyP2dVNp6Z0rQWD5H3+72J4aTjzvmL0RLdiV
 24ICeyDyNSwRuO1TadGMXRbMvtksVEArIwri3XUbOKPMF3T6lYkr3GH9iv4SyR2s0/DFGfbBC
 CiuKFx+CwVpBFYFNw3wghAkWodK87FI4DGigHAv6ACtV0FU84lZWs99eaVZOv58Mq7BR7VnIP
 RL+X3lGTHZhPySUHCVYEL4x1Qws0rYIjZ/4EGL4tOjRzDuAH8zCZPQ5VTAgIVgLYQO0wpe/gD
 4q80QVFzl+cdIcfoNXv5o6sfFadHhibG+bLRUGcZmjeb8=

Fix two corner cases in patches 1 and 4, refactor the code in patches 2
and 3 to prepare the second fix, bonus patches 5 and 6 simplify the code
and improve readability.

Changes since v1:
* Added sign-off.

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

