Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50618643
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058624; cv=none; b=pRCG93c3v9gAk/dyXxdy7ExP4CucB+HPnTosA5W77PRlcDHdHUa7x07PFmQaSWM/8IuIDJDepN6Tl7uuTvWWL+s4HKaPNelP+Pa0cJoyXWysKu0ZWsJoVBU936R7D4iCenKhFDhZQTVUzHaFc+h/9B6xLuGcEKOv0uHd7NV18to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058624; c=relaxed/simple;
	bh=P15zAzVOaT//fKV13JnbXzzP6hN0uwUzzuuzckT4lRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR7Gwr33YVSO8J2TXWtaTDnTa9MrGKLAMHgHwJ/Yl9CvXxmtdJkaEPITx1BBnzgXxeqmenaue/OQgGQ7kI8pQ6zuWr0ulqbq3xLNxFhrLmkx40LqbBfWE7GhoUDacsmYU8pNAXq4geulBZJesiwpyDDLtXcOStaDEqCITkik9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=Z/ygiZ9/; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="Z/ygiZ9/"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Xa5PsVwc3l0ATXa5VszqwX; Sat, 27 Jul 2024 05:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1722058526;
	bh=P15zAzVOaT//fKV13JnbXzzP6hN0uwUzzuuzckT4lRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/ygiZ9/dQMIPGcAT8X0USShebMaTWf2/aolB/DtWkhGVSt1kJ8njUqHK/9ampRzl
	 ESAt0E55xfsG0PYMVcNsXUi4wcXuAW1PdmApKvcaWrVVMxA+hg20HJCT009P1Eedo8
	 Yk3RBpeCJJoTzVKhyBV3CGbs7NYX/N9QT6rOsFXTsD0WmZ8sIIsmHSi2vt9Y82aBoz
	 XTJ9n2qDpD/3OJu9NLpSDai3mBsnvrTN/D35oFpJVgwh8UDw02b2SMkAFGQbKD1Rb6
	 Gld/PACOHMn70KSCoUA33ucB+8atam+sydlb0GkqHoQv9wqLN1ZXhDnPNTP86ROpxC
	 V1aX51+Rd+ylg==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=b6u04MGx c=1 sm=1 tr=0 ts=66a4871e
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=xjmMxo3dIE4o5O_OhqsA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/5] check-non-portable-shell: suggest alternative for `VAR=val shell-func`
Date: Sat, 27 Jul 2024 01:35:08 -0400
Message-ID: <20240727053509.34339-5-ericsunshine@charter.net>
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
X-CMAE-Envelope: MS4xfBJY2PIqsITYWAVvn4y+J5Jc2KoYlau1VQl6LMdL6dirhj0Rle7wBJ1s54b1HW6wCoOi8kch1LJoq+kWB9MsQPqlv0IQaYtJclDtDVh3oOQGwv2eACNy
 B9GS0RfaFQRIrrCnVyWZECWqY1bbuiRZgbP1xaHtVgy1VFGUjFyjoRpzhTSQpFAFSYNKOKkGbg+ecqh+7od3bTzOpMuYzl3i4hj1vOZKnpA2wrcRCuJBVJ8L
 /wrX8OB/lt8RovtK7//QLMIJ0iG/53nbq1+ZaxLGqzcBNUkTJhGFLnr2rP2oCyFYPCaZkLvrlsrb6ubms5rveiYdbQ4lkUJ6Hb/vYqgkKByxAWCJJGVH0gZ1
 7s8zIzV0

From: Eric Sunshine <sunshine@sunshineco.com>

Most problems reported by check-non-portable-shell are accompanied by
advice suggesting how the test author can repair the problem. For
instance:

    error: egrep/fgrep obsolescent (use grep -E/-F)

However, when one-shot variable assignment is detected when calling a
shell function (i.e. `VAR=val shell-func`), the problem is reported, but
no advice is given. The lack of advice is particularly egregious since
neither the problem nor the workaround are likely well-known by
newcomers to the project writing tests for the first time. Address this
shortcoming by recommending the use of `test_env` which is tailor made
for this specific use-case.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 179efaa39d..903af14294 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -50,7 +50,7 @@ sub err {
 	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
 		err q(quote "$val" in 'local var=$val');
 	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
-		err '"FOO=bar shell_func" is not portable';
+		err '"FOO=bar shell_func" is not portable (use test_env FOO=bar shell_func)';
 	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.45.2

