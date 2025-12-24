Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660826158B
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766563392; cv=none; b=VBulo/MpYzFSluId8eD2wh2ttcCTapkMvvJ3R1oP2F7TWWwL4HRkUsGOjpYOgCHZvdy74DnEi7a16+rnCMvfYTe+bsX9uk5J2uE21bUqBe8m6gMJs1SGp04Ro2hSmdcshEcPYKLCJgpuP6OvK4GZOyh8G5VYVxvFMaZDa9dS9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766563392; c=relaxed/simple;
	bh=I3JJaFc0vLRjgfLNy5yRZrl5uVCuk/kLiRSxcOkVp0U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZflQsIoH8IJv/0wveRqz57S3YCUsDoHOOgHS9SgnaoTBk86amIJ2gdcSXkMpCHunfhuYr+xMLg8iWGvINN3Qs9cT/RYtx54NQJa9Leu4g5VIjU8vO3QpHSWOjRK0QLfm6e2cXaEBhZe7WRkeL0D7N44l7Hj3pnRojJf1BoGjog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JQxAvpD9; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JQxAvpD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766563381; x=1767168181; i=l.s.r@web.de;
	bh=Z6aTZMonPPb1iAD3zftbqSyJ29fSC/vARV+QccWpAg0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JQxAvpD9JkmaRYh3VBSLqto00Djvv+Nodwi3kIDeFAqag4AMSywAcomDYf/cSHsf
	 q2wNcdrrq5Q4AtwFuPqm+yGUJG1gne/9JwSo7hqMlJ2q83bgMN0V42oNsfufzUSEp
	 MxW27hQfbR9wjnLy11VS1SUzuG2vRsyMq8TVie4PrgB3g2MMfHGyRS+2b8sUgQd35
	 F/jov2hZ0a4CxBE5jikRjgfuP0fLv6pbycdMPgC41VTDKaEHHylMmkyIFF7at+LNT
	 JxDeqVuwzuAsbEJSCYowXSG6yDALzWZpDAUye329xjO/2Zw5SqgURJcUd6ZpxEN7Q
	 kJZ3eg5J2lniYUnNvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.2]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK52w-1vF7l53KP8-00Kte8; Wed, 24
 Dec 2025 09:03:01 +0100
Message-ID: <33d65e54-4f02-4167-bc4e-ec0ee36fc786@web.de>
Date: Wed, 24 Dec 2025 09:03:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/2] macOS: use iconv from Homebrew if needed and present
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <ce030c90-f635-42b5-82e1-814cd4c29505@web.de>
Content-Language: en-US
In-Reply-To: <ce030c90-f635-42b5-82e1-814cd4c29505@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q8j5fYcapk1/KYJccvH2asxiL4zKDXxSpzw1pS3OOwRlFDPF+oY
 +r1sPhSuULxUwtM7mnwyeFRiWMc4o7uKXdiXC1HSYTJuQtcPxmqDfhFVPsVZ5TVb+JUofCk
 JFCMRgpy3jeymFSDR+gUUb19hxL149VeqDVXEhGHF1h8NqyRWe5J9JrGlmzBUlz5pmqSCE7
 /V5Pz/jQ/ztzBkZdJjzPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2mQgjVHpaoA=;NiEy8Mx6VYMKOKobbXtHGvD1LT+
 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
 ZHNfDP4VBfWGsoWzemoe

The library function iconv(3) supplied with macOS versions 15.7.2
(Sequoia) and 26.1 (Tahoe) is unreliable when doing conversions from
ISO-2022-JP to UTF-8 in multiple steps; t3900 reports this breakage:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

As a workaround, use libiconv from Homebrew, if available.  Search it in
its default locations: /opt/homebrew for Apple Silicon and /usr/local
for macOS Intel, with the former taking precedence.  Respect ICONVDIR if
already set by the user, though.

Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile         | 12 ++++++++++--
 config.mak.uname |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9aef22c032..b7eba509c6 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -101,12 +101,15 @@ include shared.mak
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
-# Define NO_HOMEBREW if you don't want to use gettext and msgfmt
-# installed by Homebrew.
+# Define NO_HOMEBREW if you don't want to use gettext, libiconv and
+# msgfmt installed by Homebrew.
 #
 # Define HOMEBREW_PREFIX if you have Homebrew installed in a non-default
 # location on macOS or on Linux and want to use it.
 #
+# Define USE_HOMEBREW_LIBICONV to link against libiconv installed by
+# Homebrew, if present.
+#
 # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
 # and do not want to use Apple's CommonCrypto library.  This allows you
 # to provide your own OpenSSL library, for example from MacPorts.
@@ -1708,6 +1711,11 @@ endif
 ifeq ($(shell test -x $(HOMEBREW_PREFIX)/opt/gettext/msgfmt && echo y),y)
 	MSGFMT =3D $(HOMEBREW_PREFIX)/opt/gettext/msgfmt
 endif
+ifdef USE_HOMEBREW_LIBICONV
+ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/libiconv && echo y),y)
+	ICONVDIR ?=3D $(HOMEBREW_PREFIX)/opt/libiconv
+endif
+endif
 endif
 endif
=20
diff --git a/config.mak.uname b/config.mak.uname
index db2a922751..38b35af366 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -124,6 +124,7 @@ ifeq ($(uname_S),Darwin)
 	# - MacOS 10.0.* and MacOS 10.1.0 =3D Darwin 1.*
 	# - MacOS 10.x.* =3D Darwin (x+4).* for (1 <=3D x)
 	# i.e. "begins with [15678] and a dot" means "10.4.* or older".
+	DARWIN_MAJOR_VERSION =3D $(shell expr "$(uname_R)" : '\([0-9]*\)\.')
         ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV =3D UnfortunatelyYes
 		NO_APPLE_COMMON_CRYPTO =3D YesPlease
@@ -154,6 +155,9 @@ ifeq ($(uname_S),Darwin)
         else
 		HOMEBREW_PREFIX =3D /usr/local
         endif
+        ifeq ($(shell test "$(DARWIN_MAJOR_VERSION)" -ge 24 && echo 1),1)
+		USE_HOMEBREW_LIBICONV =3D UnfortunatelyYes
+        endif
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
=2D-=20
2.52.0
