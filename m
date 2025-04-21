Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BE1E7660
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257988; cv=none; b=MEwsuN6xemstybqyOy6uXI5loYmrVmtC2j87HBqgDE7yYY9tJl81YNqjMxbNDCJxwhciHDx4zU4qW5IGNXpR0KQoFN78DnGOV3ph4LUVVkZFyLGxSwBWDFoS7nTBph7H1oInDTL8BcEXEvULU5rEnfEctYXoNqkvITfNIEFnDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257988; c=relaxed/simple;
	bh=t5rKhmA7X0FP96/L+2YVNeSASFS/gza7d+ImwUr5yz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc7Mw0JvpIkdwz5vJMd8GX5MNwJ8z0KFX1Cf295ABmFmeWLbkoDh6ncjYWxfSTtRrkRCgMjL+JmLuU2BwJ53mgBtGEq5OXXjqyg8Zuz/ds1ra5axDJvORM0YrK2gltxR5X8pzXlVOfsymY7Q+rDWu3lpCulkiGJmEUUpSAhGr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 89EFD342FB5;
	Mon, 21 Apr 2025 17:53:05 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/6] meson: check for getpagesize before using it
Date: Mon, 21 Apr 2025 13:51:46 -0400
Message-ID: <20250421175247.240971-2-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421175247.240971-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
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
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 6c147c22a4..f5d9ffcd7f 100644
--- a/meson.build
+++ b/meson.build
@@ -1300,6 +1300,8 @@ checkfuncs = [
   'mkdtemp',
   # no compat
   'initgroups',
+  # no compat
+  'getpagesize',
 ]
 
 if host_machine.system() == 'windows'
-- 
2.49.0

