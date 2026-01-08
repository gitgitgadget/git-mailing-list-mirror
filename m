Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C12FBDFF
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894018; cv=none; b=ZOn6kGEf/r3lH0XljvaTCREOQD5K1jwwngLGczPJGSr/OoX7KjlUq90FlaJzZ9UHvcLp/mdnIchhyeLr1WQZGN+xsjyFNiDt34wqIYAmCJT7lotgIqUL0tvBmv+u/CziK6zUsQZXnpCtyuNU6ugXOTNw74jmDb7jFtTycosSjzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894018; c=relaxed/simple;
	bh=HwYJVHldo5ZmF1YAxvw7Xh3yvUExJfjiC9r3tFveSNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fk3qaA4HfvDW3DkaKp2FSAyUjbl12OZZWTIwOFNBW6ArsSlFZphGEg/+UBfiam3GkAoMTa2pWMEbyYXLVeDu4AZ618sDtm319vVREf5y3gS0UJoSxZnBPk9MnznnZbsYUhK4IxNE7wNPUKqs1qWCjinKKXSXBVUI7MXpl6gyQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=W56e9/GO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="W56e9/GO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767894014; x=1768498814; i=tboegi@web.de;
	bh=YwGkv1IS1WF/9lWeV7qjJvqHTtxQjlqtewEbY158vEo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W56e9/GOVTQrPbEWLwGQWBZXrvmVLCb0ivP87d9pwMNcfmamFFSvUWr+pC/6SM5b
	 4tlL3C9h7nXzVgLX9eu4KNZO1vKowXablt02JD9oyxiRfVvWz6bsJXElJ5FClSpNJ
	 8ELyXknfnGo6LCDYGr8n2kTxfCx/R3AwoldDTAJbiikpMdqX5KLt2h+HnMKf3nY+6
	 ReRhKAJgtuf+ToVltrwRiOGPPT7Hlm2/Cdke9+RbqExPq8rWOLC1peyJWHX8b3dIy
	 ZOFtBh8JdBuJwcn3dCx7qZfbMjHEvTB6dDU0LPCAVXqsuDiYyWgQuBpaCSTzGN0ME
	 dl6i/Cq2IkMVot0VVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnpKq-1wEaF222BO-00hN5O; Thu, 08
 Jan 2026 18:40:14 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v1 2/2] utf8.c: Enable workaround for iconv under macOS 14/15
Date: Thu,  8 Jan 2026 18:40:12 +0100
Message-ID: <20260108174012.471706-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/ujxcOslg0fSj1i3RMOnJhCOYGlN+CWpk7dkRyU+zYbUOdvOyNd
 tPLh7w3iMFaIOjyuuvIZVZD7qZOALPAFwb+HK02VN91QczxwM0jjTdUnOg6tx5GPA9wfcoh
 vccIchqdu37wRQ5ctNc0F0fzAdG8AfdNUf8sSdOaeqZ2AIXMUJHsIKmKozaGGKtqb4f5J90
 qHMZYrrZjKegNSe1REf8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QuwamWEhrRA=;akEKUy0pKeDVB3BQPiaRPo3JT67
 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

From: Torsten B=C3=B6gershausen <tboegi@web.de>

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

