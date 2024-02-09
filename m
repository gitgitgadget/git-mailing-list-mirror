Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [88.99.235.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD739FE2
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.235.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517931; cv=none; b=L/qs3wNI4tkCN3g2HG7OiJA3K2C3FZl50F79qqArGlKJlLLPJSxy76rF6Y3SFe08LNxs0w+NocWwI6dEkCS9wdDETCNBEA8T1Gf/U8pARPt7YjbBT5sMj2BeG7+BwDWoEhcpZi0hbeO6gufzxyKOPN/6I2pusLR9ZYMFO7h8va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517931; c=relaxed/simple;
	bh=YL0oQ5zRLMbVSkP4YBpFwSiGYCu33CX8P/5pp9XhVF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izjMG9Y29IwxyZFQF9MMxrN1PL8QWkDu3cVHkf2/0rqtUPDQQh6F5wjJtYbrRUD/NbSQv5eqYIp4k1jSgEHiRDvIgvKnsEpOjbo4ld6ziFVTwQsJeW55Gw4zoaRC5cB8i7MrbQW9JE9y0CntthROoH9WWnZo/aPSf6NzT/0EsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=leda.eworm.de; arc=none smtp.client-ip=88.99.235.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leda.eworm.de
Received: from leda.eworm.de (p54b7914d.dip0.t-ipconnect.de [84.183.145.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 4DE3518D5F4;
	Fri,  9 Feb 2024 23:26:30 +0100 (CET)
Received: by leda.eworm.de (Postfix, from userid 1000)
	id 8D0A7185AB1; Fri,  9 Feb 2024 23:26:29 +0100 (CET)
From: Christian Hesse <list@eworm.de>
To: Git Mailing List <git@vger.kernel.org>
Cc: Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] imap-send: include strbuf.h
Date: Fri,  9 Feb 2024 23:26:22 +0100
Message-ID: <20240209222622.102208-1-list@eworm.de>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hesse <mail@eworm.de>

We had this fixed in 3307f7dde2ae8f5281d0782f7291a073c9b1cdc2,
and it broke again in eea0e59ffbed6e33d171ace5be13cde9faa41639.

We make liberal use of the strbuf API functions and types, but the
inclusion of <strbuf.h> comes indirectly by including <http.h>,
which does not happen if you build with NO_CURL.

This time make the include conditional... Does that prevent from
loosing it again?

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 imap-send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index f2e1947e63..cae494c663 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -34,6 +34,8 @@ typedef void *SSL;
 #endif
 #ifdef USE_CURL_FOR_IMAP_SEND
 #include "http.h"
+#else
+#include "strbuf.h"
 #endif
 
 #if defined(USE_CURL_FOR_IMAP_SEND)
-- 
2.43.1

