Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C921509AB
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292877; cv=none; b=i5Y4uL9w1bwhDb85PiXr4F91vaa8unAoDf3hQWZ3Ct4QayHtG9xdUrjfQYAZ1rFCI3PDDJ6u4iz44ljqpi/Yj462lW1B6T7j2l91C5wejVGWR0rDVUlJMsDNSObDJXzFYG1CQ2GMvA24gGAo/iEvOk5XoyD/yzI+M9pi57hsP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292877; c=relaxed/simple;
	bh=egDB8U/xi6FcHkU/Cgh+XKU/pBfsO/2muqGGu2WLcG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBxj1xMbVRUEkdQzPe27H6GjdYjVOV5zvCfXYMRoxWgVsO3j4hNGgz1C83srWmfCYPDxrXMozrmJf3Na3oxXLiyghT4AUTpTwPnT++JZ9lDsKkSX0wfVhF650e+7PD78KW0CMTUKQclhWHvYfe0cK7QFGl4p1gSgMNwbthdSKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LsM4QeGy; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LsM4QeGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764292873;
	bh=egDB8U/xi6FcHkU/Cgh+XKU/pBfsO/2muqGGu2WLcG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=LsM4QeGyOx7095YLVnu/N5osJJPNPeNWu6L7GuYrpHBM7Dz7o03I4Vz52G1NQOtun
	 iR3vn9rw0N+g8fdi0NWL1n2fHCyj2J4Kvx1qqBhYkOwj3QjUOcJNLfEazSD6FKC0D3
	 Q0BnLWPkt4DbyzrkRX+msKKhTOEfJNwgRwDNzq82fiTeTtId66DfJ0xd/ZfNZRdPb2
	 I5jTWfIeOE7gySziwdFbRKpcfb4nGHeaYrZA6NN6m9XrkOlQEkKoFrSzLg0thZ8Of6
	 cRVtVcTX6IDiGAwvHSNOuIcnO355j89gNiRpId8K+X/lzNiPgjl8dTnstIM5sbSziV
	 ppe+mLmKmqPTTyWWwnEkPpOibRjFdT+galrKUgkJeg1IlX2vtE5H5RmWx6Bc6W1eAY
	 2rB0JkusHOqSiKAhfDiJgrWh7OGTl+yLDnb2du9xr3g3vwsIj8TlzF0MwMSSU9LrqP
	 EuPDfD95pobK2+gJDSODBsOf7Hz1k5lW30bxrvs+n/c0ELt2+N/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d48d:a8fd:1e1f:2dee])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 579AC200C2;
	Fri, 28 Nov 2025 01:21:13 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t0614: use numerical comparison with test_line_count
Date: Fri, 28 Nov 2025 01:21:05 +0000
Message-ID: <20251128012107.101431-2-sandals@crustytoothpaste.net>
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

In this comparison, we want to know whether the number of lines is
greater than 1.  Our test_line_count function passes the first argument
as the comparison operator to test, so what we want is a numerical
comparison, not a string comparison.  While this does not produce a
functional problem now, it could very well if we expected two or more
items, in which case the value "10" would not match when it should.

Furthermore, the "<" and ">" comparisons are new in POSIX 1003.1-2024
and we don't want to require such a new version of POSIX since many
popular and supported operating systems were released before that
version of POSIX was released.

Finally, zsh's builtin test operator does not like the greater-than sign
in "test", since it is only supported in the double-bracket extension.
This has been reported and will be addressed in a future version, but
since our code is also technically incorrect, as well as not very
compatible, let's fix it by using a numeric comparison.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0614-reftable-fsck.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 85cc47d67e..677eb9143c 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -20,7 +20,7 @@ test_expect_success "no errors reported on a well formed repository" '
 		done &&
 
 		# The repository should end up with multiple tables.
-		test_line_count ">" 1 .git/reftable/tables.list &&
+		test_line_count -gt 1 .git/reftable/tables.list &&
 
 		git refs verify 2>err &&
 		test_must_be_empty err
