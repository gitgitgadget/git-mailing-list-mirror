Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82528487BE
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810287; cv=none; b=qLoZ7FBYA+TZOv+W5QLmCarFXuwhTEnLZztvq6XGA+cbiowIYtzMx/d3zGK8m81osdNSOC1zO54RDt09qbMEnsBiyc33RjAUqFcogtMkRS3ddQuGqNcaln3SuquINCHPrBKLnQq6+mNR7xWOSaDcCSLzF82ec5MhZgPZ5BNZOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810287; c=relaxed/simple;
	bh=Nds33saJzzY1UNPZ69vw35wHgwdWlaG0fInbPvL1h8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABryRMYt0XaAMzTcKGjuJof826u9/FPZzsywU8CzhQm+AZgu9ISWmaHbved/Mzp1ObsW60H7MS7IOn4OjiMLrNyKEvYwZxA0dofqUEUNnv4V5VtA0dyMAUD3EH4kYiL6Xlj1UHdt6U+3e4K564N6k8JtPWXma5NUysjBZlLEw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=voi0QnT7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="voi0QnT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810277; x=1709415077; i=l.s.r@web.de;
	bh=Nds33saJzzY1UNPZ69vw35wHgwdWlaG0fInbPvL1h8I=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=voi0QnT75DIv6uiNmZFPidV945RUUE1n8oVgMZ/oGHC2mwvZs9OjumH7ibKYM/Y7
	 dp8Hvm4Z++E1QIGRrsxDg9qwL4HGXqmxOrr39RBNLDhVZG8kaiLa/ljDKelvCcQoP
	 tZVJfnqUYRlJgqFmWofCym2kG4MIayHDgdcFmImjfavLuKMi++b7huLHSCosO2SVb
	 LnUeskg3LoAfiLzx5Uw0yBrXnQdnkPFQ44B6GOm3hSX4sH8ilyYO4y/LhAwjJmitI
	 YPk3iBFxtrmbAQkhZc1RDMtLIYOm6JCyWDNRv1iwnMAt36hOn3W8glEoROmPr5xrq
	 O0i9Qb8dio6r7FGkWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MUCut-1rUooY1ITT-00RKFN for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:31:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 2/6] parse-options: set arg of abbreviated option lazily
Date: Sat, 24 Feb 2024 22:29:49 +0100
Message-ID: <20240224212953.44026-3-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224212953.44026-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I/NNLmVmlxgGsiQA3wbCF6WkrP4YQmEMEfD+CqCZBhs0vroCjI2
 QHV7IE2lvcKxn6n8JdLh4NjUsogjQx9rakbrMABR8hpamO+Hrj+rEjfX3WMFFTHAeJIj8AD
 ZYHRWlnOk/xxfQt5jaGc94EGvtv4pZEeVdqnVN+sbCxWtn4z0T2MukxwQWWtFPwxtcjJ+og
 4Ron2SxbPPzX6uD8oQitg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dD5Q6L/5qRw=;eLkPAPRusOxs620jUS2UIYbVGuk
 7xtUNHTA+djCTA1lNtqzFqk/zChYSqhuTNwBAYJlA9hJDouLADBKtIcFZZXjC8A0WdDtyeWdT
 nsrg7x1hIlRsfu4/yFAJvFOyV2XMx0MlYHFSOjanI0vo9vK+rhNKmA3epKQwiipKTFM7EPn9u
 7N/JJIPqFrIuU8N4C5/PTdA+BuOgC116fTIOBM13mlCXZpB423Ne7pOWhtFWK12MyWjrLX8QW
 Sb6bT0rPH5SXmtcrZfloO8Flph94cgwvH8r1oejz3jQeFl7hUBN231ddZAXmgUT5NafMuK5I8
 fS8TtgEcxPd4DJcYTa8eCYqh0BgCYQlrIztBJPsAIkp87sPgZ3vlxW3lJ7rVXFanDd9jny3TV
 QbYUyDpVrwciHobpu9Nk+mDTPeO5WkUQvCZYe5R4p7m8ZHldKVse7a9Elbg/7ESf7Oulx59mq
 I9UpJc0uihnB7nDZ8iEC9Bms9jXY51FoTrp0Jh9j7Zw67wSsuM0EzNYDl9xx5+2gaEb4tZrqf
 kbwzh6hRzXKRi1ei71gMVbGoOCFkfAoWdgy3fGMOJAn5SISQq5OR37GyK4iMBo5wcwLi9dvO7
 MBytvbyaycuG+EpZ9JQlY4l7GyPzWduR/PVHCyxh81jsuIah6Du8lcHn0+7QpK3rP6OY7ZkAp
 6K7Z44LHNyTVmEyCx0mwqrkmuTcgA6NE48J7KAL5MFQBLMYy2GXQSUcaWXli4qcfr/+XvQ4NS
 TV3WdpDHIcqfOfldrarcP3ZY/omZQq/A7RKIgXJDB7CTlDbHUJrzKpKLJGhIkTWXlDM9RiduO
 jdh6eenAUivb2GZat3T2cgiIJ0oh+7ixDlbeR85dk5lcc=

Postpone setting the opt pointer until we're about to call get_value(),
which uses it.  There's no point in setting it eagerly for every
abbreviated candidate option, which may turn out to be ambiguous.
Removing this assignment from the loop doesn't noticeably improve the
performance, but allows further simplification.
=2D--
 parse-options.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e4ce33ea48..056c6b30e9 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -391,8 +391,6 @@ static enum parse_opt_result parse_long_opt(
 					ambiguous_option =3D abbrev_option;
 					ambiguous_flags =3D abbrev_flags;
 				}
-				if (*arg_end)
-					p->opt =3D arg_end + 1;
 				abbrev_option =3D options;
 				abbrev_flags =3D flags ^ opt_flags;
 				continue;
@@ -441,8 +439,11 @@ static enum parse_opt_result parse_long_opt(
 			abbrev_option->long_name);
 		return PARSE_OPT_HELP;
 	}
-	if (abbrev_option)
+	if (abbrev_option) {
+		if (*arg_end)
+			p->opt =3D arg_end + 1;
 		return get_value(p, abbrev_option, abbrev_flags);
+	}
 	return PARSE_OPT_UNKNOWN;
 }

=2D-
2.44.0

