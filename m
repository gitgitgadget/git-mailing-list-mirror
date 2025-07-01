Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7730206D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404968; cv=none; b=t0CvT7UX3zXkqnctJ1CS9oCMc0TeeIh+PbkkJncM0ReKazioPrEyRSanSH6T1AsFnnx/KQja8J9pkTE2FFx1AFNJnMCtrKHMhZ+BYlXPVvRLE+fj6+z+iePbYleRgYgs/ZW8qsLdMTMUCPDr1nJgXxrGwWLGg27/kNQvImXNl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404968; c=relaxed/simple;
	bh=eNAh/riV8FI6mqbACy8oPDuQyKhCUT+Q0wnYoGpD5w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFHbrhy39BZpkR4O2DktrZOPdeLwQODARWqldcBQYi+1daAQpl1wLZzZ4QM0+of30Zc2Ti5Hq+HQmjBeW265yL+7m7NjajIjWxlg30mT4s3w9O7In6CR5zdhc8KszxtA42Bk8KO69kYCp0hFLOCbdCrtnFP80hCGnjmHW0FsTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=WXOgziXa; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WXOgziXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=eNAh/riV8FI6mqbACy8oPDuQyKhCUT+Q0wnYoGpD5w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=WXOgziXaUz9xtuOQ58d7brURZzZMI6czS8MhqQBWemLUP9yyR06cPZy+JS+k2aJLp
	 oVO/fJEDL8RDaQkDNpfwMvSE5TJuVwooWGCmtrrw1bjGIyv0SxOLYgb5b5tVlRDWM8
	 h0JmMBxAFkrTYxEtUZAQHyJMsHLdW9ZyhkJThfJhhz3Po3BSkd9PpH2L/yRC7Ed4Or
	 2D6f9RdYAiCit9Tx79vc/x5RKenJMf2QRH3IV0CsW2xq/InZ8VE6pBuJH2cOc9qtqJ
	 W5apyp7ojxh779kMzJJfN3G6VqEFrHBlu2jyyAxZKtLaSJ42M3IeWrdTEb1xOBhEqt
	 3T4ZO/hpHyHX4e4V8qy+62gekfS7dZHvhPcD9BEn0krdQIBEoF18LsrGG0W5QsPIX3
	 kvIdP58YRDgLmdA3byjtVwTh5/U4kSoqz0gsElvG+Ks7MUtz7f+fWEukOhBf3RIuaO
	 VTV6GzlLmazVSaV9PcVMSAlnMbXygynUJ6j8FaqauZMjZElBBW0
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 68B9D2019B;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 07/11] t1007: choose the built-in hash outside of a repo
Date: Tue,  1 Jul 2025 21:22:33 +0000
Message-ID: <20250701212237.766774-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250701212237.766774-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250701212237.766774-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, the built-in default hash is always SHA-1, but that will
change in a future commit.  Instead of assuming that operating outside
of a repository will always use SHA-1, simply ask test_oid for the
built-in hash instead, which will always be correct.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1007-hash-object.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 64658b3ba5..de076293b6 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -252,9 +252,9 @@ test_expect_success '--literally complains about non-standard types' '
 	test_must_fail git hash-object -t bogus --literally --stdin
 '
 
-test_expect_success '--stdin outside of repository (uses SHA-1)' '
+test_expect_success '--stdin outside of repository (uses default hash)' '
 	nongit git hash-object --stdin <hello >actual &&
-	echo "$(test_oid --hash=sha1 hello)" >expect &&
+	echo "$(test_oid --hash=builtin hello)" >expect &&
 	test_cmp expect actual
 '
 
