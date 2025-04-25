Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2155C8CE
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540454; cv=none; b=PrFwEINoqKnBcAtNmMPZ/sfAL1AkAGK8vt5IDuqODnDXABxscX54ym4JjCjdVLn+0I2rhFA8NGt741uX5u8YiqxBs6TjjCyZOM66kUJO1IARn2OKQTgLr2LHBy67FPw2cobqydt8Dr1lP5rl3z/Q2duKsFWyRZ9Z6G2EZZbEUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540454; c=relaxed/simple;
	bh=DFxPcOALEyjvYtALP4hGmudQUVjQR1qrqZf4tzdE6jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkFqB3Pyld9RAyvZnrRWXBZdBkxLzY5NNmAsvPgvm76rvdp1Cli5mUABjnqPdQYBCQuRHAzQN4mhN4cecJVTyy+pXfC8ro8xeDXQcz1pGBOHwtpRKYYGIPxYBXUDHoxlFkRUSH76+krh2QXECjocbBTjz1VvrRfwKziz/EC74EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 92B55342FB2;
	Fri, 25 Apr 2025 00:20:51 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] meson: check for getpagesize before using it
Date: Thu, 24 Apr 2025 20:13:31 -0400
Message-ID: <20250425002017.246985-3-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425002017.246985-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425002017.246985-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is deprecated and removed in SUS v3 / POSIX 2001, so various systems
may not include it. Solaris, in particular, carefully refrains from
defining it except inside of a maze of `#ifdef` to make sure you have
kept your nose clean and only used it in code that *targets* SUS v2 or
earlier.

config.mak.uname defines this automatically, though only for QNX.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---

v2: add this only for !windows

 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 6c147c22a4..29c188af99 100644
--- a/meson.build
+++ b/meson.build
@@ -1309,6 +1309,8 @@ else
     'mmap',
     # unsetenv is provided by compat/mingw.c.
     'unsetenv',
+    # no compat, is provided by compat/mingw.c
+    'getpagesize',
   ]
 endif
 
-- 
2.49.0

