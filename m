Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6A61FF2
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382400; cv=none; b=IY5XT4StjN1e1u6kshSPPw9t9wvCtl0t75IsOd6XLC5vqHavNpQPNf9iJeGZiZ276NYghbfnVA1G8e/n37t0q7YeCA6+e1Vwq2fusLQ7ctuP65HYMligH501g7tcULJ9psDwLAaCI2WGFfuPNsirrQ3kTKFZ5oj+vXdi8TMMtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382400; c=relaxed/simple;
	bh=eNAh/riV8FI6mqbACy8oPDuQyKhCUT+Q0wnYoGpD5w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql48bsRKseGqlUUkaME3sUiwrPMY7DVgpttKoipHi1Tm5ZNGpHkpCNEsv7+eDwZQ8I4+94ZHd36nZeHphFFEVlxLzKkVx1K54HQYXVG3f3efIyylNef4bl8/rIodOUW318Z6KTm/MEd8+beFx6aIT1NLZ69O7ScZ3J9GncmiDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vb/d+edM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vb/d+edM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382395;
	bh=eNAh/riV8FI6mqbACy8oPDuQyKhCUT+Q0wnYoGpD5w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=vb/d+edM2kRqdUQSffCpSF2q/FFCz7o8fW34W89EmwpSNzbsPR3n7DX0W2gpk1WiH
	 pBa2qEMkY/Tt7B/oA2Wrzt3qhfihmk1hkMrcoqJF18ePXg5Ui0Dfc1dI9KUhDtW09D
	 xaC5zfm7lBg5KQIpREvbGejAhQxp0nJU1hhIu42A5VEpZ92xetNaNlN9J6QodfXqly
	 drntM3RCOrSjKB2kZ51m+pi7mJ9Vs2PQ+rUJPenucJ4jUXeTlbRFhBf6x3WA+4xG34
	 F8DXesV08ESDJNN/cs93pficVf8RcAZoKnXRdyWASc1ZEMVasHivLQGKIEjLgmpCJX
	 9jIX6NslOVpxlB627K7xrQmXsg1CqeC2Ibs7MnEIHCFA5w6rVfBp9e8lrmJ8hvC8Ou
	 QY5dI/a7C8VuypznQRr9WZ2Vc8jl6JecTiykt+JqoOqK0KIWg6YBFx9M94uyZpp/QC
	 /3iTKWDBxxC7YtvDv9Cw4iRzzrLGJzjdMsHihqMTJOVLljLlzfk
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id F1B5320198;
	Fri, 20 Jun 2025 01:19:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 07/10] t1007: choose the built-in hash outside of a repo
Date: Fri, 20 Jun 2025 01:19:39 +0000
Message-ID: <20250620011943.586596-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250620011943.586596-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
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
 
