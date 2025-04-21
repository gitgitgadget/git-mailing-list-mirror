Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08B1E7C11
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257990; cv=none; b=Fuu96fxtDLgXPX0/SXrlzQqxcrAMkysC4X3DI8+SrpXgtQrc0NjnkKJvBJHObezdEZz8Nnjpy/nFZfyiSMA4t8QCpokzd0VQ9bxMnwD5renSw7wIoXZ3GYO6QJercrFAhT00QuO7Nry5nKgu47BKtmJc2Hvm4Tih9EAlgiVQ/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257990; c=relaxed/simple;
	bh=x7bWGy2YnmQDfUUI/DksqACdJ/bFIZ8SzTDnhHIyYZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0K18n3OoCj00WtzlE746c2t9pueRyT9uPPMcnvecXY4tTG22L/e4XmSQWqxneUcmv6+B3JgSjZVWkk92D2hwOGgtwa/bddYPSI2cN4Wsw4hHqP7xpHgKS9/GMHfU/N5e4wYHYk6oJIN9rBrCxq3XcAfaz+ee5rbUkkSlpDRhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B552834301F;
	Mon, 21 Apr 2025 17:53:07 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/6] meson: fix typo in function check that prevented checking for hstrerror
Date: Mon, 21 Apr 2025 13:51:49 -0400
Message-ID: <20250421175247.240971-5-eschwartz@gentoo.org>
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

Nowhere in the codebase do we otherwise check for strerror. Nowhere in
the codebase do we make use of -DNO_STRERROR. `strerror` is not a
networking function at all.

We do utilize `hstrerror` though, which is a networking function we
should have been checking here.

Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8fad10379a..1b7e55756b 100644
--- a/meson.build
+++ b/meson.build
@@ -1088,7 +1088,7 @@ else
 endif
 libgit_dependencies += networking_dependencies
 
-foreach symbol : ['inet_ntop', 'inet_pton', 'strerror']
+foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
   if not compiler.has_function(symbol, dependencies: networking_dependencies)
     libgit_c_args += '-DNO_' + symbol.to_upper()
   endif
-- 
2.49.0

