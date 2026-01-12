Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253B2D7DCE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235164; cv=none; b=K624F6gtEzvjqQI2p6Iy9sq2mtBSBen8sijx0Mrz0iVfa2eFq48f89HnFi3l77Qr/WKe+0UMRm4Y2fO//WUcW6gA4MSkJomZ2iWuor9sClcIhfDw3sAOxEWt5CrbX3FbMFkmxtoLR+5mkK+OGsFaAIDk12fdGPjkFrZpGoOFRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235164; c=relaxed/simple;
	bh=MPM697LnGi/zgC+fhJEkcX+c5T8WBduLBsRIFeSF6iM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQtm0sNRfxb3mgaFJt0hSrTgIANfapiVWSPvOTKQeOk5fz3iCyIm9mk0p9KNRiImoS9mqK+XfS+C0b/XqmDx++gpit+muQTxO6LUsS6ynGffc4bFWF967EGClxu9yXgheR2Orkt2IyNgRNCm+hlQhW0PArzyBczZu8yS23KPjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=CG2530x3; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="CG2530x3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768235155; x=1768839955; i=tboegi@web.de;
	bh=raQBekY0vhv+XcB2AiY62YzAvuSF5yPD3gO6h9NsEtU=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CG2530x3fSoO6cy+H2oIfV74FlFixBICqh9zi3o7F52G78m7HtxFNTqLBiR/bMyu
	 ypbz1L0Yt723NhfTYFbL0lFyz1H96MHe67PDJIUeEksVZYY1iwH58/XRa6X6IP7FA
	 uHySauM3HYErikeOYUhEw2Bhil8XhyPs1QxqXslF4L0Z0N4g9aEdY+KIJzk5Xh+qD
	 nJ+s1oferyoYya7zw0519IMj3xz09aP6H5T5IdSmdDvL0zsv5aUv7QpGTFS/AWd6o
	 v4nbuJS3AF9rCrRNrBsXMjC9/Nhaa0Xt1l53FjWnGznDV18T2PMX2OQ5LJ3TcJ3JJ
	 AmUehBFLoI0DGZEtaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1vV88l3ICD-008iKP; Mon, 12
 Jan 2026 17:25:54 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v3 2/2] utf8.c: Enable workaround for iconv under macOS 14/15
Date: Mon, 12 Jan 2026 17:25:53 +0100
Message-ID: <20260112162553.774051-1-tboegi@web.de>
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
X-Provags-ID: V03:K1:V8JUsZ3zJ3zYaEt/cXkKQRrvcB4RFio5cLQW1FcX+XiseZoAVsz
 0ykk4zCjHeafv7U+3KQT06U6UFrOJh1kfS3Z1+fHUcCHY02NhoS5map6ghBp+86RsMZ6brC
 TcSQCPLCJB0c6t1ou6QllFuRlTZyYNIWp9F2QU3Z9i8m8cXjJGCuEhcl+j1eMYPJY7WOP3U
 Vg9Pp5xctPBEzdRyubvgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e8cvKh1+H0Y=;V0IZDquUe0fihk5oqSPR2AqUOCo
 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
 tQma2q3I=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The previous commit introduced a workaround in utf8.c to deal
with broken iconv implementations.

It is enabled when a MacOS version is used that has a buggy
iconv library and there is no external library provided
(and linked against) from neither MacPorts nor Homebrew nor Fink.
For Homebrew, MacPorts and Fink we check if libiconv exist.
Introduce 2 new macros: HAS_GOOD_LIBICONV and NEEDS_GOOD_LIBICONV.

For Homebrew HAS_GOOD_LIBICONV is set when the libiconv directory
exist.
MacPorts can be installed with or without libiconv, so check if
libiconv.dylib exists (which is a softlink)

Fink compiles and installs libiconv by default.
Note that a fresh installation of Fink now defaults to /opt/sw.
Older versions used /sw as default, so leave the check and setting
of BASIC_CFLAGS and BASIC_LDFLAGS as is.
For the new default check for the existance of /opt/sw as well.
Add a check for /opt/sw/lib/libiconv.dylib which sets HAS_GOOD_LIBICONV

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

