Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D2352FBF
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161122; cv=none; b=YUp+WqjyTWim2cuWqpr+Ct9Jb+jg2bns6Io9PmQkO41y/Y2Xup117+ABjDtRBYH0ndq/iMdehPIJ8CZr09XSGK2z4kj+WdgCgnBOD3OSFUqD4DR1wXhJyFGkrRQCxWLuAdZgXYw9sa6+lIuoU8nb2ct1Vv6MuPrUhC/0zhHu56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161122; c=relaxed/simple;
	bh=VN2GPmdqt2vH4y0X58V+U/m2ikw9nYhhrwt9ZwEOb28=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ro+41vqu5TuLI7Eb/DIHiG7ZVUDvurBbOnkVWiVIL+oYiS2+ydmwe9RPlLvpbQju96QDTlRPO3GJVvWhfi2PdCiCicSjDdqtMGnaWHFHH7KDb/iaSO9uuLL58s+Kiuzfk4HyQREBIOBqdT07ssvir9EAW4AwGlJgpE1sv5X5duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=ebJTwx0Z; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="ebJTwx0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768161112; x=1768765912; i=tboegi@web.de;
	bh=8cb/V8l79leZnTd+KBnwxGS+NK2CwkgWP8dtbPjtZ8w=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ebJTwx0ZIW//eUEe45WRGqzSidCGKVeyUKmaHS8LlUgi/BcGcWboyhiCDecvE4DC
	 nPJ+oWzRgYLkm+U7jQR45Xde4xY8W14BPwnBzkoEQstSlkyCiYh+fn8N0rTVkHUUB
	 f4xfn6EQQyQZY6oLTXkNZehz40CMrT8cY7fkEDcenN0zLB8V11Q0vTGKD8yqnXD3J
	 3TUxiP9l92QMitVZ8sksWavIOvYjZlo3vJzx61VF36xPkcm+M7KPZ0GcfXhV7qXK6
	 m5eEAqameb51Z80LCCUkr2ZTcmmxl7lzVvlT6J3thjInk+Khfd5GYc69wI07lR+rH
	 iHO1qKwIpAJnDdL1VA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nig-1vmgya2mE8-00GLoZ; Sun, 11
 Jan 2026 20:51:52 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v2 2/2] utf8.c: Enable workaround for iconv under macOS 14/15
Date: Sun, 11 Jan 2026 20:51:51 +0100
Message-ID: <20260111195151.716191-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mP6phFtEZ5jYz48CGXtnva1sOCBpGAwq13Osho7QEyJGLa8HSoM
 4UURxT9K6quxzxaS3JQvX1i9q9vqX0aRs7mQ31ooNY1vyjASlUto2u1AnPaT0I3lhwjW3Bi
 uHa1roeCT98SvvZCQU2larBg+Syxa8XUc14xT/w8bUF52zZxlJmyC9FUNlPPm6whNS+ODgJ
 92PJmoyzzJI9DJM+R1rlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xke5Kmy0Gko=;XLcCPZgXEp/IAotltBE9fPPOE8l
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The previous commit introduced a workaround in utf8.c to deal
with broken iconv implementations.

It is enabled when a MacOS version is used that has a buggy
iconv library and there is no external library provided
(and linked against) from neither MacPorts nor Homebrew nor Fink.
For Homebrew, MacPorts and Fink we check if libiconv exist.
Note that a fresh installation on Fink now defaults to /opt/sw,
so check the new path (only).

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 Makefile         | 16 ++++++++++++++++
 config.mak.uname |  1 +
 2 files changed, 17 insertions(+)

diff --git a/Makefile b/Makefile
index b7eba509c6..8aa489f3b6 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1687,11 +1687,21 @@ ifeq ($(uname_S),Darwin)
 			BASIC_CFLAGS +=3D -I/sw/include
 			BASIC_LDFLAGS +=3D -L/sw/lib
                 endif
+                ifeq ($(shell test -d /opt/sw/lib && echo y),y)
+			BASIC_CFLAGS +=3D -I/opt/sw/include
+			BASIC_LDFLAGS +=3D -L/opt/sw/lib
+			ifeq ($(shell test -e /opt/sw/lib/libiconv.dylib && echo y),y)
+				HAS_GOOD_LIBICONV =3D Yes
+			endif
+                endif
         endif
         ifndef NO_DARWIN_PORTS
                 ifeq ($(shell test -d /opt/local/lib && echo y),y)
 			BASIC_CFLAGS +=3D -I/opt/local/include
 			BASIC_LDFLAGS +=3D -L/opt/local/lib
+			ifeq ($(shell test -e /opt/local/lib/libiconv.dylib && echo y),y)
+				HAS_GOOD_LIBICONV =3D Yes
+			endif
                 endif
         endif
         ifndef NO_APPLE_COMMON_CRYPTO
@@ -1714,6 +1724,7 @@ endif
 ifdef USE_HOMEBREW_LIBICONV
 ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/libiconv && echo y),y)
 	ICONVDIR ?=3D $(HOMEBREW_PREFIX)/opt/libiconv
+	HAS_GOOD_LIBICONV =3D Yes
 endif
 endif
 endif
@@ -1859,6 +1870,11 @@ ifndef NO_ICONV
                 endif
 		EXTLIBS +=3D $(ICONV_LINK) -liconv
         endif
+        ifdef NEEDS_GOOD_LIBICONV
+        ifndef HAS_GOOD_LIBICONV
+                BASIC_CFLAGS +=3D -DICONV_RESTART_RESET
+        endif
+        endif
 endif
 ifdef ICONV_OMITS_BOM
 	BASIC_CFLAGS +=3D -DICONV_OMITS_BOM
diff --git a/config.mak.uname b/config.mak.uname
index 38b35af366..3c35ae33a3 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -157,6 +157,7 @@ ifeq ($(uname_S),Darwin)
         endif
         ifeq ($(shell test "$(DARWIN_MAJOR_VERSION)" -ge 24 && echo 1),1)
 		USE_HOMEBREW_LIBICONV =3D UnfortunatelyYes
+		NEEDS_GOOD_LIBICONV =3D UnfortunatelyYes
         endif
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

