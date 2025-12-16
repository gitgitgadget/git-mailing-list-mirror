Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB7233DEE0
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911243; cv=none; b=EmtFQQTfJRVOFS01WMZr9ak7OxfKCvJhvS92YZDwiLb3MFX0UT32eD6Y13VsCjOG//9LpE67vkWszGQqZrPU52U5UihigbIlgr7DUcVGXq+1JROSfrbOBHokhoSJrPmMeeM1Rp2pa91shbH75LXpLKDwiKVnGjMiGq0CPCpcPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911243; c=relaxed/simple;
	bh=VZlm2qjkvK5wj6o/FuLmzT9/GZs1g1oksLnJ62V7aEI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=aGujyiw0+5eGQqA+byB82j6MB/RD3Sdb9ZdKGusofg6rJJItBg6EXYzrp4pLT1WM/JIORpOP/5y6OKIFhVdBCWz2s5SRyK7maXVnj0yZy49ZCNjIweYgWBGJba8cffletPwb80opeepi1cmtQ6+chDFwz20dH+rX6rp9z2I2wvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=OqtdHRw0; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="OqtdHRw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765911233; x=1766516033; i=l.s.r@web.de;
	bh=TB8Xhm5w0QgqBh/sw2uPWNG1xUJh/zHVscVwnByRfYc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OqtdHRw0f5PvJcmQCEszHe7fDW1NgwWFKgwpwnMK1WaS7aDUq57sZtiIP5GfMZIJ
	 zGC3tQWPgvSUl5Xa7sQT4+OIzV9z3CIZBt/iaq8jvZMM0ndqwWDNwWX8xCE1NOC6e
	 HHaoOCrNMOsuBwC1zOxj05mrx/DeMr4oPWMEJ4almDxdPBgLjKlEoEvfyo7OIedlV
	 5fV9aCA8ZVZ6AfRqP8U1gvX4XOQ1m6obkbo0KznuTkHQuwFxdSB51wfs1PULT6wmE
	 bRSyNtELpO/acF2aQJ41Tz4tas5XBb3KRgOE/BCmKx2uUwIb/NcFP2tJcpLCG/CoD
	 9xc3ujpjooSWgPfmHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SPD-1vzRkM2o99-012RbN; Tue, 16
 Dec 2025 19:53:53 +0100
Message-ID: <3c85cab3-1e05-4d61-82b0-79659b03d282@web.de>
Date: Tue, 16 Dec 2025 19:53:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/2] macOS: use iconv from Homebrew if present
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Language: en-US
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Git List <git@vger.kernel.org>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Koji Nakamaru <koji.nakamaru@gree.net>,
 Yee Cheng Chin <ychin.macvim@gmail.com>
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qUJGcV8XEnBzXOcuqMC6XVvLJfYJ/jje+lA6q8KtX2YaO7cCh/9
 0Pocm3mqFo8H3xDB0ymFPJkiOkOKTzhgAxtP4Er9Cav7fVQDuvxB8hzsBpeTyAoL7RofCv3
 l8YarN3NpCIatL5Fo+SiEgU1/7JiLGpiKR5817Pxi+IqLyFu6ukZEN3ndL0elF/Juy3+FPt
 HjRBZH2RH1sftnfhzHxng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v3mOG/iO++U=;BQH0uUR8lSuRqiZCLs3tD3NLjmH
 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
 Hbh/CtlroCEA8rkws/d7kqR5r9Vph

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
 Makefile         | 8 ++++++++
 config.mak.uname | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index a97e9e4d7d..307dac3c03 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -112,6 +112,9 @@ include shared.mak
 # Define USE_HOMEBREW_MSGFMT to use the msgfmt command installed by
 # Homebrew to compile message catalogs during build, if present.
 #
+# Define USE_HOMEBREW_LIBICONV to link against libiconv installed by
+# Homebrew, if present.
+#
 # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
 # and do not want to use Apple's CommonCrypto library.  This allows you
 # to provide your own OpenSSL library, for example from MacPorts.
@@ -1717,6 +1720,11 @@ ifeq ($(shell test -x $(HOMEBREW_PREFIX)/opt/gettex=
t/msgfmt && echo y),y)
 	MSGFMT =3D $(HOMEBREW_PREFIX)/opt/gettext/msgfmt
 endif
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
index 54e3a26649..e2e93e9dc5 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -156,6 +156,7 @@ ifeq ($(uname_S),Darwin)
         endif
 	USE_HOMEBREW_GETTEXT =3D YesPlease
 	USE_HOMEBREW_MSGFMT =3D YesPlease
+	USE_HOMEBREW_LIBICONV =3D YesPlease
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
=2D-=20
2.52.0
