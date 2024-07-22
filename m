Received: from impout008.msg.chrl.nc.charter.net (impout008aa.msg.chrl.nc.charter.net [47.43.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613F1BC3C
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631693; cv=none; b=sTBOLI7+zkHXFnx10DuS+nSmkcSmTy4oHDyuAKEKfWHSubeLU1rwiABtF630ROdXTpajk5VB5Q49972KQ/J6u40bSoUe6LUeXMCAjYhCh0tpiPC1WxUc6TEQP4HTSWFAJ9c4RDXAZCuQW7AZdd4aZYFJqh4iFh8p3jJN1OM6H3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631693; c=relaxed/simple;
	bh=9hui7ZJ3B0mbh/Zlqagvhp9c3aTthchduINltJ1Sht0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDXohG/xYc4UsDUYuJ7G4mN71LVoLyG9oL0LrvhXiF/Y1HV40TRPH8YZw5g0U5MshSYbU3VpKKvam6jF7P8QRuPO0/BF4bnIjwUj9xYCr5AHDUoLLHx5fLgAwGll4hT+TTx3WP0bXUBs+7bvdW0vvbQhhRciYGZijdBYFKbuJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=qPmAn0Ri; arc=none smtp.client-ip=47.43.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="qPmAn0Ri"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Vn1PsPWKO6kyQVn1WsyViu; Mon, 22 Jul 2024 06:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721631594;
	bh=9hui7ZJ3B0mbh/Zlqagvhp9c3aTthchduINltJ1Sht0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qPmAn0RiD55c6ZHd7bm3QxoS3wRavPCNp6jb8y0v5GMsGyR9Nh+qEPrVK560RZQ6W
	 VQc444qSgAUx1UawAdGu0z7X4EE5StcuVTX39NP7IEZh2NUeSRRKusOi5L1B19X+ym
	 u3XaC8xIMmj9jpDrdsgeWdxVOMEznjTjS6l2oRMUkEweP5B7Fob5575y4G5jGmvRnH
	 cDb9vjsG6sqKJLqaPgjlmoDT+VlczxVa0XoRpLKpTXkrUqV8eQSka6OBwDJ7wILOrY
	 Ua9FXFboLUvBQRi/Hh07LUK3Z/OLsMFTX9FToLsYtHTIhLxRLsDTnt2jkBtNqkM16x
	 mTYHHRDsRK9UQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=bKkQIu+Z c=1 sm=1 tr=0 ts=669e036a
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=iqTJSk_ugSLm26MjKVEA:9 a=rRh7KEUCiO8A:10 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/4] t4034: fix use of one-shot variable assignment with shell function
Date: Mon, 22 Jul 2024 02:59:12 -0400
Message-ID: <20240722065915.80760-3-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722065915.80760-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJwrnF6cpF/Rj557ejoMhU3bvAdfl2R/9zhDR144l0NPN+KmCnUzHiSChEn4t0dN53xbwtB/u65B3HDOV00PYLAzWb8E9tD43W89Ckd4FZAmBdjNwvUx
 ZORQyFKFOpNWxtLLd304N6e2JJ+LFu+Xu3vRZRzZi5zuvKEZS5AI72Zzi4HUhDXZVT2ujYDJs2BtZlOGcz9rpl0zre15nwkdsr1uBEbgM3PdLyCULfcPiYl3
 8eQLNqYicB/YKdMcOOVl6Q2bsksSJbCoNtY69GcgEtvuDAqNDYFMsvltMgiAwDTT

From: Eric Sunshine <sunshine@sunshineco.com>

Unlike "VAR=val cmd" one-shot environment variable assignments which
exist only for the invocation of 'cmd', those assigned by "VAR=val
shell-func" exist within the running shell and continue to do so until
the process exits (or are explicitly unset). In most cases, it is
unlikely that this behavior was intended by the test author, and, even
if those leaked assignments do not impact other tests today, they can
negatively impact tests added later by authors unaware that the variable
assignments are still hanging around. Address this shortcoming by
ensuring that the assignments are short-lived.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4034-diff-words.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 74586f3813..4dcd7e9925 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -70,7 +70,7 @@ test_language_driver () {
 		word_diff --color-words
 	'
 	test_expect_success "diff driver '$lang' in Islandic" '
-		LANG=is_IS.UTF-8 LANGUAGE=is LC_ALL="$is_IS_locale" \
+		test_env LANG=is_IS.UTF-8 LANGUAGE=is LC_ALL="$is_IS_locale" \
 		word_diff --color-words
 	'
 }
-- 
2.45.2

