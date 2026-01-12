Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC08364EA2
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235159; cv=none; b=svmhkNbdA98CUO0G1WjvZ47g7bTbmBn/24umA40SSufQy/wjuRSY5N9x/YGn2b7N+mPVsdR+bkQNU2m/l6em526d7M8KOFkB5Geo3PNrDigT3PWrXJgAqyKixbyb3JLnBFGzeiUJfTwCa10yCiWkWbCWMX1V43WiACl6/atvfbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235159; c=relaxed/simple;
	bh=PM5GktQpl1jWpfX/8CdV4BEAS2pz/9XQp8UhMjBgFoY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfyYD1mzQ+RbzZCZGv+sZoy05rILjOgGes16NJPrA5n01BVFPi31VShbDtSDpHcd8f1vR9Rnob9iZaGIvS8ikKwU2pRWv0UuOi4asLZ59si9Uay4G/u9XCspJs6MwRsfhAeSJ2pIjGV1cFzaR3gDRvMtaI2N82ix1Hp2kVpbnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=iJcDj9bM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="iJcDj9bM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768235153; x=1768839953; i=tboegi@web.de;
	bh=MglM6CxQhokuF8wCaNstjIIOn+yW3azhNt/JODPv9is=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iJcDj9bM1v/wvVoVNPobhLpL2m6Ow2lwSylYkxUKeSjGlwEZ5mi7zr4O/nuE8mzj
	 5PgDFd2uHDNUK+iItxgt5bfyw2eks9id3vV1CDPDf/PY0DdgAyaF4Km6rERaQMNff
	 TFMLf6iZAy+xZD0v0D0zX5EfbK6F129TVRSD6v+s74qOmCF5MK6NDZTnDcgnGhg8X
	 BXvFrnoTVm9u/EMGuAcN62BDtHxOrsPFiCxzVCKmkTvaScl2E380T6GaL1hsdK2Wl
	 OX/1L4J5K7QUbzJ559LaxdwfR7988L6H3C+RutJla0d+YR/yTzWt7H/4eKPfaeWSz
	 1hyCmOCkzMtlLQYVFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1vmEl012fj-00GWhS; Mon, 12
 Jan 2026 17:25:53 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v3 1/2] utf8.c: Prepare workaround for iconv under macOS 14/15
Date: Mon, 12 Jan 2026 17:25:51 +0100
Message-ID: <20260112162551.774037-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7UmOxj6eQP7nOzGfPiYTQt72PQmxV3UXYp2CVdynoCL82AK7U4Q
 yDGGL9byEA6tqDWiVPr43/cSQYmHeXsrKUwajS7pjnmP8IdJf117KBVS84fksopagK0GlZY
 QrpBfZmtq7jhBtYfrGvtsk1LF4Q8jfCw19UaZ1DVAhlG638FWNPPC08YKeZEzkjDE9xpdLp
 dIxQv2sKZJQOWS+iDhd2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J7Iv5n/ccz4=;tLopLeTUBync+q9cTSyghR2LVd8
 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
 VprQVvem1AWeH9MDk4/jQ7C5ju5TW

From: Torsten B=C3=B6gershausen <tboegi@web.de>

MacOS14 (Sonoma) has started to ship an iconv library with bugs.
The same bugs exists even in MacOS 15 (Sequoia)

A bug report running the Git test suite says:

three tests of t3900 fail on macOS 26.1 for me:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

Here's the verbose output of the first one:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
                compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.t=
xt

 --- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +0=
000
 +++ current     2025-12-08 21:52:45.786161909 +0000
@@ -1,5 +1,5 @@
 =E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5

 =E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=84=
=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
 -=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
 +=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3$0$j$m$X!#
not ok 17 - ISO-2022-JP should be shown in UTF-8 now
1..17
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

compare_with runs git show to display a commit message, which in this
case here was encoded using ISO-2022-JP and is supposed to be reencoded
to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
is from the original ISO-2022-JP representation.

That botched conversion is done by utf8.c::reencode_string_iconv().  It
calls iconv(3) to do the actual work, initially with an output buffer of
the same size as the input.  If the output needs more space the function
enlarges the buffer and calls iconv(3) again.

iconv(3) won't tell us how much space it needs, but it will report what
part it already managed to convert, so we can increase the buffer and
continue from there.  ISO-2022-JP has escape codes for switching between
character sets, so it's a stateful encoding.  I guess the iconv(3) on my
machine forgets the state at the end of part one and then messes up part
two.

[end of citation]

Working around the buggy iconv shipped with the OS can be done in
two  ways:
a) Link Git against a different version of iconv
b) Improve the handling when iconv needs a larger output buffer

a) is already done by default when either Fink [1] or MacPorts [2]
   or Homebrew [3] is installed.
b) is implemented here, in case that no fixed iconv is available:
   When the output buffer is too short, increase it (as before)
   and start from scratch (this is new).

This workound needs to be enabled with
'#define ICONV_RESTART_RESET'
and a makefile knob will be added in the next commit

Suggested-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

[1] https://www.finkproject.org/
[2] https://www.macports.org/
[3] https://brew.sh/

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 utf8.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/utf8.c b/utf8.c
index 35a0251939..96460cc414 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t in=
sz, iconv_t conv,
 			out =3D xrealloc(out, outalloc);
 			outpos =3D out + sofar;
 			outsz =3D outalloc - sofar - 1;
+#ifdef ICONV_RESTART_RESET
+			/*
+			 * If iconv(3) messes up piecemeal conversions
+			 * then restore the original pointers, sizes,
+			 * and converter state, then retry converting
+			 * the full string using the reallocated buffer.
+			 */
+			insz +=3D cp - (iconv_ibp)in; /* Restore insz */
+			cp =3D (iconv_ibp)in;         /* original start value */
+			outpos =3D out + bom_len;     /* original start value */
+			outsz =3D outalloc - bom_len - 1; /* new len */
+			iconv(conv, NULL, NULL, NULL, NULL); /* reset iconv machinery */
+#endif
 		}
 		else {
 			*outpos =3D '\0';
=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

