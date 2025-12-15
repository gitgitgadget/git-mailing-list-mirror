Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15648313261
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831533; cv=none; b=penCs5qBwdRCJkCaTbM6z0PDjP4bU83KSZ+GuGtHZcsvytZZ6MxPMoW9dmcyUDOn4lIXu5cUpzDHXDXr/gS6T1R5Bp3C7yX4ywDq3cukfgfXpwga88892Tot4iCZenl/IlKk35XTalZVLqd6T2uE5KS8qD63d0ekSakW8cBlYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831533; c=relaxed/simple;
	bh=aaOwgjXeyiALF3DpUCzIBMRbfh3BLw8IY5odmw3tNjk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0rOauHo/1dizX9UvORzciR29UhgwW2AoFjozDujd2sw1cHDdfq3OujdT8YTrizNvZM9Zy9Rh0gqlSLLWSXhMOitAf7xP9qc5QESapYXR//xqf2pjQDg55rdBgo5HM19pIZvFJ0DYaoX91jEYoXdPi/lop0WrqgHtasxkzTBBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=vqWx4FkY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="vqWx4FkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765831522; x=1766436322; i=tboegi@web.de;
	bh=i8LqkOs7Xzaeg6D/kNJRPgY+ZrQIAN50BTh+5Q2jNfQ=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vqWx4FkYyexcXpWH8537E0iOXKkIAry2Zyw92UUXektYqFBEB7kl3AEQCU+Cvp6I
	 lWY1VdDDtjNVcXdNM6ntE53poMk8WF9yELzBcq7whtsAu0VvImE/1SGbv6MwYvKVO
	 rbl7F7AxnScgkImM9ZhukH+AUvuRDqUZeq5Er7TKgRDoR7ZxwwH2pmtKu+2vykMrT
	 RKVdhHqf/DQ4wLNybiWgy7FXFwkM16lVAJPYUYrsYPNrZo+dUqzdm2G/x/ADEpJh2
	 RUkilQOBH/cOa2fBhdMokknluySngmnNj1hv5ZG8aFtmcpsUSrPSwy64EECzTl80T
	 kqfDGKS6zFPm7ggiRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1wHjPO2nWy-00kBb5; Mon, 15
 Dec 2025 21:45:22 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v0 1/3] utf8.c: Prepare workaround for iconv under macOS 14/15
Date: Mon, 15 Dec 2025 21:45:21 +0100
Message-ID: <20251215204521.1946490-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7LRJFD1Sjkq1PGFkgS0ewzUMZpk1au1MkjH84EJezA6nYPaU2Qo
 CSeArEMZWdkzfkGvS0sisyRn+7L+bSwWsaOaCrVU+xmhw+Wv7AbglknRqNUiGr476kEGc3I
 8qlh8SyLNLKcwS1nV0jAO5WIJszQdqWpDwoAvJ74+EdKHhPTi3DC/eJGO6lMUZw7DPoUVqz
 XU5ZpWWbW1N3DjYOrBB6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kyQD1SatIls=;0758BApcUbWE+jAuoVXe7rlVcIo
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
two ways:
a) Link Git against a different version of iconv.
b) Improve the handling when iconv needs a larger output buffer.

a) is already done by default when either Fink [1]
  or MacPorts [2] is installed.
  (And a patch to do the same for homebrew [3] is on its way)
b) is implemented here:
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

Further readings:
https://blog.r-project.org/2024/12/11/problems-with-iconv-on-macos/
https://lists.gnu.org/archive/html/bug-gnulib/2024-05/msg00375.html

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

