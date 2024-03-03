Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087CD29B
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468405; cv=none; b=AAxby/M0MI94VVk63Qze7tXGlUMEekm9nVdIIT1gkU79hgdbMQL9B5oe0VuUY4pBGYWpBbK0reVHmcwKF/wC4L0ghEjUjTAENBRM9act9FFBKbrYgT+kjPq18cYWbD6AcjwnLREGk17UlPVPmq8N1ZiUtXqVY7Gqdfd4bab+SuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468405; c=relaxed/simple;
	bh=D0+RSFEIs9sR7ZF3DecpRGqors/RGB0Mzlqvo3OZVQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJAmdaxsF0x/d7WVF6R8dRcFgobwpZv5GJSUdEbyGLdgaaiJmlpBIOKZ0bmXqj75n5XL8NoY6TqjeNP5qDcjjr89TuPuXyK7XErNXd7LZ2kyEICmsT28da4OJF9Xob87Q947KnFhP0g8zgcwFQUjN7yGZUvgGZ6sinI6/a6HALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=sX8bnrgQ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sX8bnrgQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709468393; x=1710073193; i=l.s.r@web.de;
	bh=D0+RSFEIs9sR7ZF3DecpRGqors/RGB0Mzlqvo3OZVQQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=sX8bnrgQmGEp174yXel0dZTsJlmj8c/vIZlgxe065PERV4SHtWdVBrf6qd/rH1rv
	 IccpWX1+5nfKa2KZowdxs8y3evl3E+BReUVghdyD8W3bPzDKLcScmG238OW80Vy7g
	 2jiQ335CVbcKd9+aACwUYKpg44FgJwRubX7isMYFLJ+vjY+m/LdB/T6sH+8Dp9e3S
	 L4+H+RQY1+AKBEHzSv5nhc5cxRS2yf4rnYs1mV6DaFHlB3ULKCuEsVHFsybMpZx2h
	 48ibyPBEzLorD5F1fDEzheB7B0Ryfv1EHLEJiK9Eo2ps1O1mbmM+mD3jDHJ0sVk6/
	 MyJfFOGldKLjMHA1bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MN6FV-1rOGb631Hx-00J9Vz for <git@vger.kernel.org>; Sun, 03 Mar 2024 13:19:53
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH v2 4/6] parse-options: detect ambiguous self-negation
Date: Sun,  3 Mar 2024 13:19:41 +0100
Message-ID: <20240303121944.20627-5-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303121944.20627-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l86F0OcDu6OV2l230yQFE244kJ39Tf42HEBA/NTQRzofYKs8vBp
 8f5u4A+v5/FEJ5B8f+eayREDvByTIXtS2q5H7yuE0BBJbBaPyVF67wZb+n8ffZRVr7l/7UQ
 rhoSt6mg4hOASIQyrj1EvMcoLDXT5y7OoKsXlgzoEwmibcl2bShNiT9K9RMg+jVBQiIPrFq
 q5no7q/ImhwTCfucDjEDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vXmCerxJzsY=;us+bnBP+TM7Ixu/yHwGkWFvpcP8
 UoYYX0BmHvEl4DGgzHa03fIS0RW5yAFLftCltyYn+au8P42PdytXk74w6qX6mI+XIBL6nBW/V
 Tb/AEI2WC5GV14PR9uHUAIPUk6J89niemcuB1AIjYJMBmRipNUgfAv70oesgO8HoYEnyHg33A
 VoTaDkC/OqToPrvkp0Vp2TxxuM5VPe5TwFoXUeIwcsuO945tmcTPyqPm517SZdhNWP4Jy4BUN
 T5JLk6IdP5OBFUXKbZG9FUOUqpEGMSpo0seJ6ZUMi4wHS5DHAakJZpmVntOeaKpCq3jCC3m+v
 dFgLYCd12G/4FN00cDM3788wdX8x0RQWHXdC+ob6Bq4u+JkFjoFJsEMbF7IPXubpD2XzePaJU
 UGQ7CupuGpZPS9i7AQOOJzYfj+uvHn02cibfgQFy5LhtEIcNH9INKFy09N/XP0lsnjBGMyzeH
 S11Ya2elFvScqWSSgkSSAWqAQuGqTih6Vs7aRO7pa0NJYrqzgTbxtMCT/uobEMyMkZ5qbjCtj
 YZwZ5uGdD39RrGp7N5bpabKHYc5yX6qTuRGBdEys1duFtzgCEsyYWvaakalbGi9jVKtcVkqDj
 2vFEWSaW+zhdfRB2GL15lCYou8a3o7LClTPljFkNpCI38BYjUG3mP8QLDo9ZHUCa5QOYhvh0e
 8HyCkK1zYqVQ43RKZXN7clr/5lETz4molvLrbauyYPC0GomiJN9v/WxgpPjcOh5Q5mJcNXO27
 TaDcIKZFJm3WvRTY1ijlNafUzUA/+A0QhmTh/yoRIo/TzZ/ZOLr1MikDnIlw4tAJHYPxsbVI+
 nUtXcqvU1UruCY0jcWxCci2c0ruP+Roql9VwI3asUHAa0=

Git currently does not detect the ambiguity of an option that starts
with "no" like --notes and its negated form if given just --n or --no.
All Git commands with such options have other negatable options, and
we detect the ambiguity with them, so that's currently only a potential
problem for scripts that use git rev-parse --parseopt.

Let's fix it nevertheless, as there's no need for that confusion.  To
detect the ambiguity we have to loosen the check in register_abbrev(),
as an option is considered an alias of itself.  Add non-matching
negation flags as a criterion to recognize an option being ambiguous
with its negated form.

And we need to keep going after finding a non-negated option as an
abbreviated candidate and perform the negation checks in the same
loop.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c               |  3 +--
 t/t1502-rev-parse-parseopt.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 398ebaef14..008c0f32cf 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -363,7 +363,7 @@ static void register_abbrev(struct parse_opt_ctx_t *p,
 	if (p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
 		return;
 	if (abbrev->option &&
-	    !is_alias(p, abbrev->option, option)) {
+	    !(abbrev->flags =3D=3D flags && is_alias(p, abbrev->option, option))=
) {
 		/*
 		 * If this is abbreviated, it is
 		 * ambiguous. So when there is no
@@ -406,7 +406,6 @@ static enum parse_opt_result parse_long_opt(
 			if (!strncmp(long_name, arg, arg_end - arg)) {
 				register_abbrev(p, options, flags ^ opt_flags,
 						&abbrev, &ambiguous);
-				continue;
 			}
 			/* negation allowed? */
 			if (options->flags & PARSE_OPT_NONEG)
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index f0737593c3..b754b9fd74 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -322,4 +322,15 @@ check_invalid_long_option optionspec-neg --no-positiv=
e-only
 check_invalid_long_option optionspec-neg --negative
 check_invalid_long_option optionspec-neg --no-no-negative

+test_expect_success 'ambiguous: --no matches both --noble and --no-noble'=
 '
+	cat >spec <<-\EOF &&
+	some-command [options]
+	--
+	noble The feudal switch.
+	EOF
+	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dfalse \
+	git rev-parse --parseopt -- <spec 2>err --no &&
+	grep "error: ambiguous option: no (could be --noble or --no-noble)" err
+'
+
 test_done
=2D-
2.44.0

