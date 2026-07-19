Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D31A6838
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784423336; cv=none; b=GBx+meQq899M6ks8VsMiNdd86sZRv246au3w6vmTRrXge6EMPIrXbIqcG+4ivcShUk9JT662Y/JV62gdr9SIhB4s4EOaDuPbo8+tIPm+Qow//hBx5D1yaSyRtpk8OSwt+9mq7trYyj2etSheK5qI9suF+TQcgC8q/MUdGcpiYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784423336; c=relaxed/simple;
	bh=Kh7cMEhorNaCLDG1+j5cyPIz0Z/a/15UMpgrz5uIKr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZdn/StO7IRhzY+BHsXNH1RZZ5Lp7HyRSwe5Y++z5fNSGgMf/qBQGGostVSzmjqZMju6KtqTTG6VFN95bhKlp1v705wDGLQKMB1HCyvmI5XlRBARvPGaPRcUKMFZTeibPJ8+cbxWI5jwHhL7VMVVMRhdjC0U0ejMTNyMKA4MW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NxGnSO9i; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NxGnSO9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1784423328;
	bh=Kh7cMEhorNaCLDG1+j5cyPIz0Z/a/15UMpgrz5uIKr0=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NxGnSO9iIF7I4rBJ/4nagKFK26H3tDsUFgRlp1DHG3zYxtk0VxlHBhew8Hcjhtdav
	 9ERUOD4iHUuIkuUqQr9DQw80yoKBNjzBy/4LndgptKoHALOmOOviERCAGRux1Kzpqf
	 SMxDfpLFQFb8oYpFJIobbEi5pMIPQp+WJOMZ/aezT5ZQfJLFPzwhJwMLanBUJ9ypRW
	 oI8xnM1bElZMf8B6/d6dfvUeTZyDm0liD/nW1X/UY4M6O8En39BxP+dms1lya/FAFG
	 LWFCD52V1FiDYKNznajn72e19HT02b6mTb05ar8CIRf43TVIr5LfYOru6VFjZKH8eC
	 pfeCZqM9ICDAqT0POMyslhOfP1OQz11ARhcWQRQSI+2Tonu2eUJ9rsX2FS/L1Mk/0i
	 3AqlId5fBvKQtzLF2VVI6l9l74eCQfMQyqgB/fpV/6i7uHvWdwG4o1puyWgsANLhIS
	 pa+3/G2IbYUty7bINRWP8ejTw4JuS0JRRTFDODnQLNjc39gk7Cq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e344:7908:59b:a90a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 00FD9200B0;
	Sun, 19 Jul 2026 01:08:47 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] Rust hash cleanups
Date: Sun, 19 Jul 2026 01:08:40 +0000
Message-ID: <20260719010842.17991-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peff recently sent out a series to fix several memory leaks with our
hashing code when not using the default block algorithm.  This series
follows up with a few fixes to our Rust hash code, which calls the C
code, to fix various memory problems.

brian m. carlson (2):
  hash: initialize context before cloning
  rust: discard hash context when finished

 src/hash.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

