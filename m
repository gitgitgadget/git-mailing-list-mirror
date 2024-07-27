Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDA4A05
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058623; cv=none; b=dnaSkIkRtaHhrpz/Mo8n/nOf6cvNN1bZUFRWjn+p5ON8lCZ0rZK2j3Xm+cjPI4uqamrYNnA3u1VPQqMJ76Svq7ZRVwEYqTmGC1m82t2zmYleW+yqq8sH1BPUhFMsrtBkjkuzp45jkeYJV8y9JMRw+8LDZonKWbZEcCxZ/oRhnrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058623; c=relaxed/simple;
	bh=f/zEj2Q8nYAd0LgZGNGp1BBaw/9NlFMvyDydHW0xqA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhMV8SPLlnA1R402qEZ2/Lx3nGV+BsgU9JQX62B/lot0BaVZmAKI6MfBYl+Rf+ECju4d8ajvBmC2OH1CwktfMEmVdw00oWKiiUO/6yrBfpSLB9bLMSTPUszmTv6clb64CeXgmOKV8pTblpzE7pz3VrvX1pHK4OhTGxmZrHXKBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=i4aj9gU0; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="i4aj9gU0"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Xa5PsVwc3l0ATXa5Uszqvy; Sat, 27 Jul 2024 05:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1722058524;
	bh=f/zEj2Q8nYAd0LgZGNGp1BBaw/9NlFMvyDydHW0xqA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i4aj9gU0qUZAwyqSpHF3oGzCNzuKurNKxwjnzPexB3a7WkvxkYGWUsx0sMlpmqRbS
	 MliV+uF6fKpqM0hadh8UuBkWvGH81PnQZ4rOgIuxk6Yf6jqL0hs1W4yIiVtmk4/H9o
	 rh8JpXUHtU4qLl+y9hQ96qz2WHPqqNbsP8ETOIh1WEVEqEZQ8MaTmDOnQqJ4zzT4y+
	 H8y7tJTPKoq7E/IRLX5pJp57IPiSWi0ePSjqI2QScWpPf3aBEADu7omwa5+jr9anG3
	 rAMGgIrPCYP1UoMGxOrPizIEt1yTi/pyxOAFXTj8SfS5dX7aumRU70pNqK6Tc0yPxq
	 zMcOaBmkQe8Yw==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=b6u04MGx c=1 sm=1 tr=0 ts=66a4871c
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=A1X0JdhQAAAA:8 a=g-X_pVf7e692ChHf-W0A:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=Df3jFdWbhGDLdZNm0fyq:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/5] t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
Date: Sat, 27 Jul 2024 01:35:05 -0400
Message-ID: <20240727053509.34339-2-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727053509.34339-1-ericsunshine@charter.net>
References: <20240726081522.28015-1-ericsunshine@charter.net>
 <20240727053509.34339-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfALL2qgYNgcLJosD6UCSqRCVA0MXWSKU88g9ZFCCy0U3KxxMiCQuBsQPcaBSpsUf8PW3W9SdhrKnizOrPWrOrtV5NdJEakER+lTzg5a5f5LjT/FVBiAz
 X739psTUNcixZaG+XvH4wI3bBLa3PNVfcOnNNDgnc+z5ZyvD/98ePS8Y5BjTkV0WFfTsn1UudtEqc4Ynh9TYhAtpyUyb9hBzZEAeJAtJALR2f2PxkcT5c/EI
 Z7lJXB6OTaV442cOUOuYezd/Jnie6xCuOE1fcYzwoCV3FK7k7gbIeXh/kPf0DS2qH1t+NcN8VntP6SUqqXCGPOt3RaFh0/SwRxMEiLbr8P6D3gEXVEbgyJv0
 CLgGwdP2

From: Eric Sunshine <sunshine@sunshineco.com>

The behavior of a one-shot environment variable assignment of the form
"VAR=val cmd" is unspecified according to POSIX when "cmd" is a shell
function. Indeed the behavior differs between shell implementations and
even different versions of the same shell. One such problematic behavior
is that, with some shells, the assignment will outlive the invocation of
the function, thus may potentially impact subsequent commands in the
test, as well as subsequent tests. A common way to work around the
problem is to wrap a subshell around the one-shot assignment, thus
ensuring that the assignment is short-lived.

In this test, the subshell is employed precisely for this purpose; other
side-effects of the subshell, such as losing the effect of `test_tick`
which is invoked by `test_commit`, are immaterial.

These days, we can take advantage of `test_commit --author` to more
clearly convey that the test is interested only in overriding the author
of the commit.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3430-rebase-merges.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 36ca126bcd..2aa8593f77 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -392,8 +392,7 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
 
 test_expect_success 'root commits' '
 	git checkout --orphan unrelated &&
-	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
-	 test_commit second-root) &&
+	test_commit --author "Parsnip <root@example.com>" second-root &&
 	test_commit third-root &&
 	cat >script-from-scratch <<-\EOF &&
 	pick third-root
-- 
2.45.2

