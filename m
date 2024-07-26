Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00477176AB6
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981874; cv=none; b=HpA/ipsMlrpCEblLnycigAGD2lBpbCSbMfrzmBm707Nyk96I0odn3kDcnRDPEsE7s/F6ScZ7L+r3Szlw6rU+xA/o6ZTTmsMPq0DpYi3dC6PNs+Ll2Tv04RK/KJzGNx6WCLoUAxWQdLn+SjpudAZ+0saydu0PWYeQ8Qg48VvKEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981874; c=relaxed/simple;
	bh=P15zAzVOaT//fKV13JnbXzzP6hN0uwUzzuuzckT4lRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qthaiMBDEzzP3wA4hY4sf3Ft4iDIx9JOZpYJ7B6uH614HfXqgw5GFS6gNEEmISq+POdvPPSccG45p5zLAFLUp1ReW0pcT7Wi4x7gWVUyqvMCQBVzcZtPtOyQk67/ojBcNMU1U/4iQpkuuAfeau/z7Dn9wwOZHaFWew1bCc/MNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=by47XiLD; arc=none smtp.client-ip=47.43.20.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="by47XiLD"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id XG7MsyipKvFCWXG7asRqjM; Fri, 26 Jul 2024 08:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721981774;
	bh=P15zAzVOaT//fKV13JnbXzzP6hN0uwUzzuuzckT4lRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=by47XiLDEiUO9gjMp+1AwVUJE8TwINTL2+VLcCgl/bAHV22WbGk2uOd7SF0LacxvK
	 lVjagP7CFQEgTtBN6/reFAwT5+XgvDwrEc6QL3EK637rFjKV6YIvblSo8Sjz9L+QL8
	 sScBDrK5d90V+y9HvC3btKzsnxBWpJE7NYb6MAKj8wcjmvk064JIK+D+nRHUvVo1dQ
	 dDdugcaRX5CZq+MRyQ1oian7otWzETm9ORzSDyjTMu6mhi9yLFK9q/JnRp5Bq7qxjw
	 XEg3RN2Mc95dovm9lkr2ijRPlOMWqD/+6gQKSwqW51sX8R/DsgmqyR8nHiMYtCF7ja
	 GRMbRhklOe5JA==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=O+w/vg9W c=1 sm=1 tr=0 ts=66a35b4e
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=xjmMxo3dIE4o5O_OhqsA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] check-non-portable-shell: suggest alternative for `VAR=val shell-func`
Date: Fri, 26 Jul 2024 04:15:21 -0400
Message-ID: <20240726081522.28015-5-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726081522.28015-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240726081522.28015-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCZ7xnSSVoddY7wDS7a9UL3rdRG1jOIJargj9BEkfqQzFXcaEqnpmVouXaKKtdw7/Jyy+032g33Ixq+rY33GJHdod8FeH2+k7388fg3Q3LptxynKITXz
 Wq1tOO8olzfFH8kZ52m1UrcHVfMpef28wb8iAxwCOxhmrf3gO4mRc58CdyHT9+Ac1B6tErITJQ3f4u2YudTa/gc0Z9AGKdviHV8VYHe03lrpfMK0m/gwPImq
 1SMO5PusgVG7NmdFSEKD0lrr4pjW+7j2nVBgWOhEE2VEpKBynxtr3lRksVFzTVn1J+AkoZe4slZogTckJaZy42nOhWGEedsY2+2tC8XqOFdQyGl4zQal2YRO
 u6iqgkEz

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

