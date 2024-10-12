Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A0199249
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744082; cv=none; b=Bk/PJQ5Go0fhLUdiXr+1iMQ7an8tPZnRLcLJWCGecsjv05YT9EewhU9brXqg+97eu/TSwcrsWMJO007c+LvmAwjLqCKGM75t4WCN7aaoOSnZusOHDJWqIoPsrRUJPF2wKchcaPukUoc6ymbpK3s84uZGqcnw52C6qOSEiy3C2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744082; c=relaxed/simple;
	bh=+KQDex6zgzXayC1voSzS3PubzHizET4B6Pf6dw+s1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4WoOxA57ok1NoOL1lDFdyPpoAkA3d0WYqt7J1/szAHa1uzgWjBByOVgZRGajhLz+l2eXjysMVGk8k3BsHpd8FwIckM4guRjOD06P8WGmoN80MQPla7z3pcVU7w25+gDgvuSQ1G5Ndl/ySWEjr6X+BK2N9kJDjqI1WmBbfTCF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XiQHZHAD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XiQHZHAD"
Received: from localhost (SENIOR-HOUSE-TOMBSTONE.MIT.EDU [18.9.64.17])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49CEf1de009310;
	Sat, 12 Oct 2024 10:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728744065; bh=2LW/Bl6q0mpjDUOONJBpu8nBk1qRPDUygA9En60Tn8k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XiQHZHAD88E+9RKerAsxFY4HOGMMBuEoa4pam5LhO8mVDtF30bN1aB/soGMD+mHHS
	 +a7qHVgwldP35q8Jb0GU4PAvzm76md4xrpRerbSZA+Nq8yxOIiDQHkcP7DP98cIw6w
	 f6JYFfpuk6hOJ1iWMdAeibfKMDufBS9hVvhWhim5WwlZSZTW8C7woizjg+gheSkYhV
	 o/9kEzhEqmhSQDzKWT86+++1rOI+3JeUMa6c3Zzc4ycqLb9tECcB0VF5uVP9ydXxsx
	 dhBLyFADuR5G7m+/WKy/86aHCwmcXc1S6XP5yaCn2kaXNT2fHzL0WJwXGapHBT7GnR
	 8r+27utKdyDZQ==
From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: asedeno@mit.edu
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, ps@pks.im,
        =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@google.com>
Subject: [PATCH] Makefile: adjust sed command for generating "clar-decls.h"
Date: Sat, 12 Oct 2024 10:40:27 -0400
Message-ID: <20241012144027.2573690-1-asedeno@mit.edu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
References: <CAOO-Oz0+sOpF6YQHSu0ytCO5TL+Anpr1k_9vQx6hebr624WjMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This moves the end-of-line marker out of the captured group, matching
the start-of-line marker and for some reason fixing generation of
"clar-decls.h" on some older, more esoteric platforms.

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
Signed-off-by: Alejandro R. Sedeño <asedeno@google.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2dde1fd2b8..87c1f9e220 100644
--- a/Makefile
+++ b/Makefile
@@ -3906,7 +3906,7 @@ GIT-TEST-SUITES: FORCE
 
 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
 	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
-		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
+		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$$/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
 	done >$@
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
-- 
2.39.5

