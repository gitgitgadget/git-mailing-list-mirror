Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F439478F
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343599; cv=none; b=DMpfi+r52zSzP+sTfOOshDCAbm5RjKDAmIldU70VlKG9ly9ncAOjQN4ftKzcsd38/VjNvgOzxskDEErQAHtazIwelc0JAr+YgGPgE9nHxd4K0Wd3oWaEyjRL8nOlsMPzRRf1uQj2vgeXCHLt6wZCQAex/6nJD9D7W4z67Vkwt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343599; c=relaxed/simple;
	bh=l86ogtmEt2WmQ2qxoflM2Xw3SCFs6jTDw8KbRrZXArk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXJUv/h/Fz96QYKa/YPOMj4YZ6itet0YGqKPZsCrvx111Mj6hCljJRjXcKOSJnjEYrQjHcP3NdX9e/mHC2N7UU3Uzjdsm2DBzZxBhS5M82PdD21gZEBdIgOpPQQcCdfR1OBvJgCd8q0sgd6+pk468+9mF3DIQfXW3eMwgnQyva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id D1F67A5DF7;
	Thu, 12 Mar 2026 20:19:02 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OFI3lEhUSks3; Thu, 12 Mar 2026 20:19:02 +0100 (CET)
Received: from end (aamiens-653-1-40-48.w83-192.abo.wanadoo.fr [83.192.199.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id B61DAA4A5A;
	Thu, 12 Mar 2026 20:19:02 +0100 (CET)
Received: from samy by end with local (Exim 4.99.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1w0lYk-00000000jTm-1GgT;
	Thu, 12 Mar 2026 20:19:02 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: git@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] Fix GNU/Hurd build
Date: Thu, 12 Mar 2026 20:19:01 +0100
Message-ID: <20260312191901.174808-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GNU/Hurd does not have a PATH_MAX limitation

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 t/unit-tests/clar/clar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/clar/clar.h b/t/unit-tests/clar/clar.h
index f7e4363022..55b0361d91 100644
--- a/t/unit-tests/clar/clar.h
+++ b/t/unit-tests/clar/clar.h
@@ -11,7 +11,7 @@
 #include <stdlib.h>
 #include <limits.h>
 
-#if defined(_WIN32) && defined(CLAR_WIN32_LONGPATHS)
+#if defined(__GNU__) || defined(_WIN32) && defined(CLAR_WIN32_LONGPATHS)
 # define CLAR_MAX_PATH 4096
 #elif defined(_WIN32)
 # define CLAR_MAX_PATH MAX_PATH
-- 
2.51.0

