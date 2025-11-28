Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C126A33B
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292877; cv=none; b=D5u+qzrdWUOye2cmx4mt4GJxbz3r9eRG3Wxv0806HntbYa89O3ukUXkfmKX9p8clI6Deex7Gkc1pPysDrUSaBx8uj/wOsJUT/5A+7qxur3ItGf9KyeuKmFBm8xgf2cnTCTex9ERx8FT0Eu3zOpdemZxyEfPsZ7PGx8KWZuPBSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292877; c=relaxed/simple;
	bh=mdHw8kcV+tmv7ohLb+qOy7Dtcy9J/TVz5ykYxpRpzvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0/P4fcCFivmm5TcJsnJDscoEcD5TFLHcBDLxbd2nMebkshCNZ729rKnLx+UTnNPJVjzNGmebzXFK1mVPWIhhB6Zf/DN3ockhQE+Y7wCuIqpGcTJICnNVsOJ+SqrEj5CmtYmMnmHda+CGw+NcG2+Z69HERX0cviHtSHYFU/RfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hLPgMybK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hLPgMybK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764292873;
	bh=mdHw8kcV+tmv7ohLb+qOy7Dtcy9J/TVz5ykYxpRpzvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=hLPgMybK0z2BiZ30Kitdqs2Aj/4hDloEulu7YeIRqMBk1lU3yJRn6zaVL3xKD/uBn
	 nNUOa6Ic+jW9T0iZx+toOEeAh/jux2dWXLmSpPbiJ3ok8cz9Lk8sSMPSA6tU7Bi2aX
	 G2ebaa3TeWxFNgHPcBMoA6MwogODFWNUwkvNIf/7GoFsU4iIo8St/ne8EF9ducR/eY
	 zWOnt6imBr94VDGgPRyaXyXlRUORRnPsXcRJxpjp/LVIoG/q7wOo1kW9OYeDD7fd7f
	 k/ODNels2J86JlE/vH4nUK/NXb5L1WPpdGyghWdInZC4jjiyUsjoAmCrgMJ1t6vBk/
	 JW0L0hSeYUWZmYIScBqDBqlYqmeJq44yAsfNioqJdCvmKdMXKK7QnyO6avIZrDNj7i
	 iH5/i9PuTqbIJiUyPkw7lSYYzow+IFsUWzmLHQhmrP7AmCfWGME8yVg28aoUJNrqHc
	 P5DiZie89myraCZhE5uD5pjWrcFP794i1FcJt5XCou5ialyXQMU
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d48d:a8fd:1e1f:2dee])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5E3E8219D2;
	Fri, 28 Nov 2025 01:21:13 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] t5564: fix test hang under zsh's sh mode
Date: Fri, 28 Nov 2025 01:21:06 +0000
Message-ID: <20251128012107.101431-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251128012107.101431-1-sandals@crustytoothpaste.net>
References: <20251128012107.101431-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test starts a SOCKS server in Perl in the background and then kills
it after the tests are done.  However, when using zsh (in sh mode) in
the tests, the start_socks function hangs until the background process
is killed.

Note that this does not reproduce in a simple shell script, so there is
likely some interaction between job handling, our heavy use of eval in
the test framework, and possibly other complexities of our test
framework.  What is clear, however, is that switching from a compound
statement to a subshell fixes the problem entirely and the test passes
with no problem, so do that.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5564-http-proxy.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index c3903faf2d..3bcbdef409 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -40,10 +40,10 @@ test_expect_success 'clone can prompt for proxy password' '
 
 start_socks() {
 	mkfifo socks_output &&
-	{
+	(
 		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
 		echo $! > "$TRASH_DIRECTORY/socks.pid"
-	} &&
+	) &&
 	read line <socks_output &&
 	test "$line" = ready
 }
