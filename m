Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97234B1A0
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161115; cv=none; b=Q/pC0v9o0gUfuyDx8A2stYR1eH1acZXr0MOZkKiP2Xtlk2QND3p2y4dyDDnAw/XLH2Da82/UzzX1RwDbHH58hvegk47qgdcUegKcdTyUuDbo+Sld99K5EfSyiNlFp+rxwbE+rzRfCxGwnRRSA+vRL+1mbArp1vUXiwiIbVC+6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161115; c=relaxed/simple;
	bh=ob+rI+rG2sk00VopvfhlfqrB42SwS+mjV/GK+fWj0nw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijDtrBlzTJ7G6mWXeFOrD+MxvWKUpBDqTbJ22fhcxWhKRD9G7OnV9uYo+zd+1zLyZ2/FLqX7DqBDfDL/EM1uEgZ2nV0on2tM0b+UQlTJWqZSQj5Oz9Y81k8hqxtO20hUfC/UlvUVNVv5pkYjIev7rUqY9msUBrPKgmVlG/chKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=eR4yYI8Q; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="eR4yYI8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768161111; x=1768765911; i=tboegi@web.de;
	bh=rZ8uHECcwrNVTcy78utj0abAfQ93M/k/zGyvJ4RNwIo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eR4yYI8QptOMY5vKgxP5Wzv0fe2pRBeM1VsaOTO1BF0ETD5hTgiaBhW6lGtbpwwF
	 jK7ZY7SFxm+QN+4BOftHfo/zmMAIIia5Cm+DDp/i9gE+4oLN3T3YUx9OC6YNsAMzM
	 shmnwk7T0IAVk2XcwMEPd/UPJ4Ry2wplBbLrSz1ZkNkNvKItpbUMsKIBcuufRJAua
	 c17sycdWY3WhGEJnRl5I0hrFRP3EazO8skNmX6joihdL0sCBp/iChVXNEvA7YlbI9
	 N0xvKXOWRX/pZ/gS3nNoTic6YckQ0rWxwIfBe5JXg7Ecl+Qc5JgRuwnA+kULLAfl7
	 S9fcHd6JHZm8sd6qSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1vTeWc0huT-00PY6s; Sun, 11
 Jan 2026 20:51:51 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v2 1/2] utf8.c: Prepare workaround for iconv under macOS 14/15
Date: Sun, 11 Jan 2026 20:51:49 +0100
Message-ID: <20260111195149.716177-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JTnLhINJfhh9hFMmqcH5mzG58E3EjQz/ZkqxcGaQbaGWp9gP18/
 bRBD67g6pC5vCk/7SJHsh4nbX1jwE03kOnd/Q66iaGvfDcL+Q3T+C926h+XXj9opl1LY243
 7G/L3nCWTAY3uytYAGay+7TTt8gDHI1xYGO1ZmwiBzflk4qxGe5Hp0wDTSVAhf5IeJSO0HR
 kk22PtctleK8VbyFtATQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/X1wnThnDSg=;SrL7UqDYNQlaAv+/WDZhn1zXWfX
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

MacOS14 (Sonoma) has started to ship an iconv library with bugs.
The same bugs exists even in MacOS 15 (Sequoia)

A bug report running the Git test suite says:

three tests of t3900 fail on macOS 26.1 for me:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

Here's the verbose output of the first one:

=2D---- snip! -----
expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
                compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.t=
xt

=2D-- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +=
0000
+++ current     2025-12-08 21:52:45.786161909 +0000
@@ -1,4 +1,4 @@
 =E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5

 =E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=84=
=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
-=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
+=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3$0$j$m$X!#
not ok 17 - ISO-2022-JP should be shown in UTF-8 now
1..17
=2D---- snap! -----

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

