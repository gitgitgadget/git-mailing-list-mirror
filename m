Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B1229B2B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559306; cv=none; b=NMJA7p0+z4RX1mPoHl8Ywfe0Qhg7FTzDBPp/fIQsReX92LRovkT+dkzpx9SIJeuou+5t1c/vDypVvHQLk4d9DbsDycgvbZP+12YlSyf57r+gZLzCU6Zb05VaCNx84eZt8BDzahvP5iuOwG0Mb5IiFCgsFbZg891uSNoc2iXyKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559306; c=relaxed/simple;
	bh=D11mFtNQ/UhSmLQhBP+7+W7hZJQQ6+AKGVK945XSyFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgdsZX5AxoWgqtoXztjHyUQGteORteB8qJ1t37NezmTkanD7wXQLQ05k6hGZtE6nxsgycnkfQw9BXyVHkrzizvsAQVIOoB+6WtwEE93+++pcNUcAI+TYu8YG6PMZXIolp5xGVCQmoW0LOq7wdDmO1gpXnEEdxtIzdMrulBrqDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AA0EE335DEB;
	Fri, 25 Apr 2025 05:35:03 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/6] meson: check for getpagesize before using it
Date: Fri, 25 Apr 2025 01:25:41 -0400
Message-ID: <20250425053345.17288-3-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425053345.17288-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250425053345.17288-1-eschwartz@gentoo.org>
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

v3: rebase now that it is a dict

 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index ed0359b9c9..e575231129 100644
--- a/meson.build
+++ b/meson.build
@@ -1304,6 +1304,8 @@ else
     'mmap' : ['mmap.c'],
     # provided by compat/mingw.c.
     'unsetenv' : ['unsetenv.c'],
+    # provided by compat/mingw.c.
+    'getpagesize' : [],
   }
 endif
 
-- 
2.49.0

