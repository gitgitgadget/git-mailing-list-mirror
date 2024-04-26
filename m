Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E8171A5
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714169528; cv=none; b=GBhzyGmSiRT2o/aQJDnlnQeah5m992QKT8XtUxF2FoPA3sP8kB2QwHve1zjSTzTeHc7wSxpG3AKJRPNK7ffm2EE9+N+mIp6+UriwQTDmTmY5ocbhFC2Ay7RvdMgpZHVfDEQyyf18/zkZeTC6Wy0GYDy3RuAVKZIfAdMgEkvLNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714169528; c=relaxed/simple;
	bh=O7bIPRlz8WPlJIKUOea85gL0cr7hkZRMM3RUFMyQ15c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e32uJksFbq+YO2/ozqv163L2cEREU+TPQnIbWococyJ1EDYqaTw9TeNZjR1cBrrI6R6TrImjNmuQ2gqkirULlgq20ANKdJqIkMjxTatITAb9fWAQCQtGpFzIbDsKh72ONybbZqycJjJRVdX7Pl2x0/Y6HoyPaLHcnVDuMysDBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RGWL86Sd; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RGWL86Sd"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 66B445B2D3;
	Fri, 26 Apr 2024 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714169523;
	bh=O7bIPRlz8WPlJIKUOea85gL0cr7hkZRMM3RUFMyQ15c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=RGWL86SdWK2wJYBGh7pbhewxj60w1AvaxlPGFr3Jq4LBPXTpxaKU4kqTrBGT64lO+
	 5jPYE5lEF4Z02hcZc4KAvtfRouyOYTVvSFhLTB/yvSzTGzUclq8TnthbRcEop9kt/v
	 sMFHALYrCy4Zsv5p2j2wq2qR9HbZbl01pmN71FkNhUQauFke/Ck2hnT1hty0oWJmhu
	 6AM/aenCIWsh4un91fjqJYHcjxqE8NjyjWHKK8vi8kEVUTrJzv0snpi6RO8f2WqiDp
	 5LBVMVjfbFCoE6KrLTe0KlqSjeqVZ3UJDhuBNMrpdY28mD20tiLmuzGosZwOxTPKff
	 +UCgKXm34Q13lBlWh0qIlQUPECUoyOmRuKP9RWVJx2Cb8MRpaYQO1wjCFIGZ+0kaTC
	 BFzOIeu/Py1xpj0oUu5PvsvnEMBZh4KmUsx4Mv0ilqtjo14wLMyrr2hkaqrLoSJ93N
	 2XIy7pGSCooAbHJaYTz2dSFGkbzUiY4mx7tS1beDfy1AMnEDnjt
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t4046: avoid continue in &&-chain for zsh
Date: Fri, 26 Apr 2024 22:11:53 +0000
Message-ID: <20240426221154.2194139-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240426221154.2194139-1-sandals@crustytoothpaste.net>
References: <20240426221154.2194139-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zsh has a bug in which the keyword "continue" within an &&-chain is not
effective and the code following it is executed nonetheless.
Fortunately, this bug has been fixed upstream in 12e5db145 ("51608:
Don't execute commands after "continue &&"", 2023-03-29).  However, zsh
releases very infrequently, so it is not present in a stable release
yet.

That, combined with the fact that almost all zsh users get their shell
from their OS vendor, means that it will likely be a long time before
this problem is fixed for most users.  We have other workarounds in
place for FreeBSD ash and dash, so it shouldn't be too difficult to add
one here, either.

Replace the existing code with a test and if-block, which comes only at
the cost of an additional indentation, and leaves the code a little more
idiomatic anyway.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4046-diff-unmerged.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index ffaf69335f..fb8c51746e 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -20,13 +20,15 @@ test_expect_success setup '
 			for t in o x
 			do
 				path="$b$o$t" &&
-				case "$path" in ooo) continue ;; esac &&
-				paths="$paths$path " &&
-				p="	$path" &&
-				case "$b" in x) echo "$m1$p" ;; esac &&
-				case "$o" in x) echo "$m2$p" ;; esac &&
-				case "$t" in x) echo "$m3$p" ;; esac ||
-				return 1
+				if test "$path" != ooo
+				then
+					paths="$paths$path " &&
+					p="	$path" &&
+					case "$b" in x) echo "$m1$p" ;; esac &&
+					case "$o" in x) echo "$m2$p" ;; esac &&
+					case "$t" in x) echo "$m3$p" ;; esac ||
+					return 1
+				fi
 			done
 		done
 	done >ls-files-s.expect &&
