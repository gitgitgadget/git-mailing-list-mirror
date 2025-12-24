Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4529E114
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766563701; cv=none; b=S19qylwJZw6KAStO6IdpueN2Hnpn/n24IZ6RHE6lULdZwTmtrPB73Dbrx3qX42YrZMXhCudA8F/iAO46VuTfqGyIVoQH7GJltYp7yB41s4dUsyaQR9XO6ZSI1qMIhzeHqEfo2AZFz2/A6vW869NnNWC0XEXwjynNV2ahkZ+Em2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766563701; c=relaxed/simple;
	bh=p3Z5pc1darfJaCJ+hHGuOy5I1AriV57nqFu5AR3E7uk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nHr8we8Yr7LLaMXplvwitcIrF2qclZHZpMN9OcXgCrLk0i8HgxTMts9JXBoYR76Tp7JseaE0yQ2472xlTtbt76xvmmQp93RpvkJf1BkUQjGqw6+lbjxnVJlfBxBLrGuzMI4q2ALBsnth6I0CGTbxTHSuhF/i2xsyPDXMe77c4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aBrpjVpd; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aBrpjVpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766563697; x=1767168497; i=l.s.r@web.de;
	bh=8cduhE1cpzH32pcOeAYSbXnrPIVOjv6VZManAwKL4Ls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aBrpjVpdLEXGnTAWZVYA6mRB/LqTGO2SstyDLgb51q8tQLeXhDR51JBTI1Sf3Q60
	 CrJbTIbGOPZz4JjcZyookEzv2l+0v4tTuGAbhHRVDRzsRUQFOXPBVsdoII8hAdBNd
	 gXmLea+8R0FlVgNSn3/6i6cHeuWorC9Bdp4zldRDi1KYvTmsyxxHH/QAtc9dcI/6w
	 aEHp/NPnZUf96Tgzcy/2R1GiG1G7PMWEFTaT9fRmAkYG2LdQG6eQtTQX92RgZVNxj
	 wkv4nS3r9ujwhPv4SdsuSd5zYXN8TQiP1Vl/FvYa7r4Z28ROkCzTTNhhn5OCP0ThE
	 8M6iWqGruS1N1q3TWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.2]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1vXlbA1epG-0027CW; Wed, 24
 Dec 2025 09:02:46 +0100
Message-ID: <1c91caa0-c785-4448-90bd-d09de66dd553@web.de>
Date: Wed, 24 Dec 2025 09:02:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/2] macOS: make Homebrew use configurable
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
X-Provags-ID: V03:K1:tiHt6FsY39DpIAMI4YJiyygH+aLsM2dIKfUTBwF1SupZv2iRG6k
 LxBYfXqF1V2lEmYJ4kbLNzP09mXv7yg6BzpZar3ZSbOv0SDGhXASpb1wck6HZOVxJVLRGUm
 d8o/u6h/Ro91V8ZZkYjBmSehote2iOIb0xrnDjbnY5FBMLAmv2OTuV+m3cg4UqAD7xfkU7V
 pELj/TtK6jAVg2PCnhtmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tvJl54sV2TE=;GJw5xICuK0/INgm91rOCpDSrEH3
 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
 Xwch4h3rcxi8mGaVmWYDXE3UOxfWkyhy8xGOGJ

On macOS we opportunistically use Homebrew-installed versions of
gettext(3) and msgfmt(1).  Make that behavior configurable by providing
make variables to disable Homebrew usage (NO_HOMEBREW) and to allow
using a non-default installation location (HOMEBREW_PREFIX).

Include and link only the gettext keg via the symlink opt/gettext
pointing to its installed version instead of using the Homebrew prefix.
This is simpler and prevents accidentally including other libraries.

Suggested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Suggested-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Makefile         | 18 ++++++++++++++++++
 config.mak.uname | 26 ++++----------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 89d8d73ec0..9aef22c032 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -101,6 +101,12 @@ include shared.mak
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define NO_HOMEBREW if you don't want to use gettext and msgfmt
+# installed by Homebrew.
+#
+# Define HOMEBREW_PREFIX if you have Homebrew installed in a non-default
+# location on macOS or on Linux and want to use it.
+#
 # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
 # and do not want to use Apple's CommonCrypto library.  This allows you
 # to provide your own OpenSSL library, for example from MacPorts.
@@ -1693,6 +1699,18 @@ ifeq ($(uname_S),Darwin)
 	PTHREAD_LIBS =3D
 endif
=20
+ifndef NO_HOMEBREW
+ifdef HOMEBREW_PREFIX
+ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/gettext && echo y),y)
+	BASIC_CFLAGS +=3D -I$(HOMEBREW_PREFIX)/opt/gettext/include
+	BASIC_LDFLAGS +=3D -L$(HOMEBREW_PREFIX)/opt/gettext/lib
+endif
+ifeq ($(shell test -x $(HOMEBREW_PREFIX)/opt/gettext/msgfmt && echo y),y)
+	MSGFMT =3D $(HOMEBREW_PREFIX)/opt/gettext/msgfmt
+endif
+endif
+endif
+
 ifdef NO_LIBGEN_H
 	COMPAT_CFLAGS +=3D -DNO_LIBGEN_H
 	COMPAT_OBJS +=3D compat/basename.o
diff --git a/config.mak.uname b/config.mak.uname
index 1691c6ae6e..db2a922751 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -149,28 +149,10 @@ ifeq ($(uname_S),Darwin)
 	CSPRNG_METHOD =3D arc4random
 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS =3D YesPlease
=20
-	# Workaround for `gettext` being keg-only and not even being linked via
-	# `brew link --force gettext`, should be obsolete as of
-	# https://github.com/Homebrew/homebrew-core/pull/53489
-        ifeq ($(shell test -d /usr/local/opt/gettext/ && echo y),y)
-		BASIC_CFLAGS +=3D -I/usr/local/include -I/usr/local/opt/gettext/include
-		BASIC_LDFLAGS +=3D -L/usr/local/lib -L/usr/local/opt/gettext/lib
-                ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt &=
& echo y),y)
-			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
-                endif
-	# On newer ARM-based machines the default installation path has changed =
to
-	# /opt/homebrew. Include it in our search paths so that the user does no=
t
-	# have to configure this manually.
-	#
-	# Note that we do not employ the same workaround as above where we manua=
lly
-	# add gettext. The issue was fixed more than three years ago by now, and=
 at
-	# that point there haven't been any ARM-based Macs yet.
-        else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
-		BASIC_CFLAGS +=3D -I/opt/homebrew/include
-		BASIC_LDFLAGS +=3D -L/opt/homebrew/lib
-                ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo y)=
,y)
-			MSGFMT =3D /opt/homebrew/bin/msgfmt
-                endif
+        ifeq ($(uname_M),arm64)
+		HOMEBREW_PREFIX =3D /opt/homebrew
+        else
+		HOMEBREW_PREFIX =3D /usr/local
         endif
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
=2D-=20
2.52.0
