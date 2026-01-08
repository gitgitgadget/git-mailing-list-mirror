Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D432692C
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893022; cv=none; b=V+jp4PirXBhnx5Q5AlRFZLJCT4QiaOfXsWsV3qFHu1cwYwsUIiATU9vJCkTQ1AMjQGs14j2pEQrcUsQAWNTE9HDsMchlIdRgpZ8HJ6QZ8DRDPcmbvQFy62VwovNA1K9K3dNi6n7omD7wthINYWKkMgEbY1icP0VBENB38DHcSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893022; c=relaxed/simple;
	bh=DbdOJyFoDGhq4HyJN7TK4Wr7VnJz5m3JSLoSS0DOveM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SPApOfRTcSM393M8GchR1It7J/fQ9rBomJk/ifrFWloTdWO3jI64L/MgSb7AiuB/6+R/XNetfsk7MnLHsoi5WNSKcETTiXtqFsRTwO99ph5qyfSLmEpjYcvp6H64ZCVZ5n34M7oatPttMIz9shM37TcLnespLabudpu2ATWXe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=YbuVwwJV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="YbuVwwJV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767893012; x=1768497812; i=tboegi@web.de;
	bh=9cgKTqjpgn5z9vSAriQG+1fnFaR5/JfjqsQNr7uur80=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YbuVwwJVvwlSmUOWs3/n7xZxsSca1fGr21XHG/LEwZgb4IbUja4CLwtJQiA8qfXL
	 Wdxuc5sDm8j+Qk2at2doATYMr8U4mVcB7f6tQ2fiKODM35IekpO6frVm7cHblOmuh
	 Zi7qrv6KrCnoxKxjy97K7YXZ6xL1AlwWRGT5PkQpKijUOIm1qjPwA31fY8wTboSkA
	 KVZYlhce/CabAXFLWYoXk38mdwl8UICHydb43wm23H2DplyQ2aAYwALcV5JPNJjIo
	 qv2ilvXiDU+CsuWKIDXiuMRAFZe7F/9Rx0OAA3RSZyJOZCWh4Dhinx2MmP1+NFS5e
	 DhWhsuYtOB3/02JJ3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCut-1vUAqm3SfT-00OjPJ; Thu, 08
 Jan 2026 18:23:31 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <torsten.bogershausen@esss.se>
Subject: [PATCH v1 2/2] utf8.c: Enable workaround for iconv under macOS 14/15
Date: Thu,  8 Jan 2026 18:23:30 +0100
Message-ID: <20260108172330.466146-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gDCHLbivvKWtsLvKbX+3ITC9F2/lCzehRA+ddZlH7rJ6i28bNkr
 vHRtMotnWKCGbw1MVhwtNvGp4jXF0y8Ib1kgoN9qf6krFCZaqcXpv6tI0HlwUKfmGZyxnsh
 6yemaZzJFDpk4ACnLRmzOE+95TMidJkXhFU4Rl6CQ4Hjr8K5uOen0MPKVDCPEgyqqSEhOr0
 yE9iYylT+Z6tVhECo+W9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IY+ioUcfFFc=;Ux5nHWjTTaCgwsJCE2c69qIz6Q1
 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
 EO3S7J9bE2Ej56xBgjXWfroVnjUKF

From: Torsten B=C3=B6gershausen <torsten.bogershausen@esss.se>

The previous commit introduced a workaround in utf8.c to deal
with broken iconv implementations.

It is enabled when
  A MacOS version is used that has a buggy iconv library and
  there is no external library provided (and linked against)
  from neither MacPorts nor Homebrew.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 Makefile         | 7 +++++++
 config.mak.uname | 1 +
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index b7eba509c6..5a3823bb67 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1692,6 +1692,7 @@ ifeq ($(uname_S),Darwin)
                 ifeq ($(shell test -d /opt/local/lib && echo y),y)
 			BASIC_CFLAGS +=3D -I/opt/local/include
 			BASIC_LDFLAGS +=3D -L/opt/local/lib
+			HAS_GOOD_LIBICONV =3D Yes
                 endif
         endif
         ifndef NO_APPLE_COMMON_CRYPTO
@@ -1714,6 +1715,7 @@ endif
 ifdef USE_HOMEBREW_LIBICONV
 ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/libiconv && echo y),y)
 	ICONVDIR ?=3D $(HOMEBREW_PREFIX)/opt/libiconv
+	HAS_GOOD_LIBICONV =3D Yes
 endif
 endif
 endif
@@ -1859,6 +1861,11 @@ ifndef NO_ICONV
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

