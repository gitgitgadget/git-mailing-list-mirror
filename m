Received: from impout002.msg.chrl.nc.charter.net (impout002aa.msg.chrl.nc.charter.net [47.43.20.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9A137C27
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231810; cv=none; b=JIo1FBWG16msWeD3NDoR/u/BzScSgomdkARcUIOzevt6Gq+GnHMpAIh/itV3w1j6HFNpGgMDZyrUd6oWEV+FZoZieThr1pWkEC1JWGfQC0RNbD/SeZhwOw6HN/G0EeJc3AKiIXz8UUXBECEJIGj4cBgZUIMAWLYU6HML0qwPCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231810; c=relaxed/simple;
	bh=7587w9jyCAQ0zpXz3sTZrRCR6J8sKuMuU7jbspxxDNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sW8yEc5RHbLBl2m8HHQ34NiJsv4E8UGmYJwvSiNtWBpTMVNc5puaZAcPNF4f/zzbzuPay4p4fmRxa9MLzHUY75pBZPAJ3c/iWt0x0hDZK9AessL8dKI2VkPZq4AxOCiZp+9q44Pt352DOi80fmcjXyTLxsYOn+HcQC+g/58mHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=E0K/xEWY; arc=none smtp.client-ip=47.43.20.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="E0K/xEWY"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id 98GYsTho2i0hy98GdsQjS2; Mon, 20 May 2024 19:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1716231712;
	bh=7587w9jyCAQ0zpXz3sTZrRCR6J8sKuMuU7jbspxxDNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E0K/xEWY8YN9LutJqvFN0g5LSZl9K/8I7MrRUURC2vF+YtEpnEXWAkqoMGTMMWzE6
	 /yUz6lKcMPRgWSPbq2gT3fqWKEz7fPxKUCEv5XDlM7JJkZIbJEozzDJjmp8jpVl3Vy
	 LElapbTNP09fymPiE5XdYXfTw6Do6AnXezpkNj0kd1AxiPt22FMxESj0FuJjGL+5Vu
	 itIKCGlo7eQLvToafTBe+t+PPHy6dFK+51ijxfd5NsE80cC6yUH/BMPRe6TuGiAisx
	 qegyvzdRNbBodinj8ZB0tCSzPOlOzNJR2Q1siIi5wA+WoFEU29L0g86QS/LHH6jy39
	 WAmDa19r/4D0Q==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=Wf8KaVhX c=1 sm=1 tr=0 ts=664b9e20
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=XVdubl8vyDbsfP2rsRcA:9 a=jYKBPJSq9nmHKCndOPe9:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
Date: Mon, 20 May 2024 15:01:30 -0400
Message-ID: <20240520190131.94904-3-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520190131.94904-1-ericsunshine@charter.net>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfB7QGDXEuRasyztpVK8MLyBevEnVIZTSKmZgSiUFVNlOxDg/bgblh71gFwbx61n+lFLCiQX5j+VeFnMLhDCPdm+InoGvdYwQKsxgLyDioA9K/Og/MESM
 qnuMWUWGh2o2e9FBl9nynopGWqDc6VPyraCWhBhzFZvTp/YkupdfTrIDFM75WZ7DJlua2lypYaWjwzV0Sfp7YyAfSU37A8wnaMg7vIKcDk4vmshLNM80bv31
 9xTs8QjoaWXtXmgqiOa4OkondmFlbMgWBdmnoIpdFhuxU1/cT3wEgR8QcXFZ90fst/jdXwaBLTsjGp04+aGyog==

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On SPARC systems running Linux, individual processors are denoted with
"CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:". As a
result, the regexp in ncores() matches 0 times. Address this shortcoming
by extending the regexp to also match lines with "CPUnn:".

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
[es: simplified regexp; tweaked commit message]
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index d9a2691889..d593cb95e7 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -724,7 +724,7 @@ sub ncores {
 	if (open my $fh, '<', '/proc/cpuinfo') {
 		my $cpuinfo = do { local $/; <$fh> };
 		close($fh);
-		my @matches = ($cpuinfo =~ /^processor[\s\d]*:/mg);
+		my @matches = ($cpuinfo =~ /^(processor|CPU)[\s\d]*:/mg);
 		return @matches ? scalar(@matches) : 1;
 	}
 	# macOS & BSD
-- 
2.45.1

