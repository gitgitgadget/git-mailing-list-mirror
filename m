Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E0A95C
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312187; cv=none; b=Tll/ZukToT3RIweXwWau65reKAWArBlD+x3jPXtrVBR86ltvNCPirbIsrX0rMZvBAwad2LZ9WtRQJF44YP7ivkUVRRxqzh/fchZYp2Xy5gC09zNBeq63kANFnlnbpLhKksHdniVjL9PVwQnHOSsc+MmGekxxY8Q8ZE0lPvBYIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312187; c=relaxed/simple;
	bh=gH31h0+38/Wl1OH8f0S+Es8O4jnRi3WoLtXE8O1GFp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6pzlwoGi5LXV2hus8Id7NH/QmhI9gU/7khoKRwGO/2xN5B9cTnzFpj8/e563/RH1tfRBvGiaHGIE87Ne5i4YNYphBbHZBouZVkhAmazZ2KI2BER8Qi9Aus5KChl/gMPgWK2sX66IEZvNZ3oCtFhJdwQbSOLiyo1nLiy6JYLoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=R7RuSMqC; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="R7RuSMqC"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B90875D6D0;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=gH31h0+38/Wl1OH8f0S+Es8O4jnRi3WoLtXE8O1GFp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=R7RuSMqCGmhFmzoonYgLh1EmjyM0iWTNFk9VSrdM5c1nLxw1KjnA9LBkuEW4386di
	 5RuHM5tV5u/HvKfAudZhzxXsZlOwZ/DMOczi6+S7c/mG9oahSFAAJYTPLsi4Q2UUEY
	 i745f9PWPn4gzc/dD/R9t8ewZhQtY7f4jw1OwNZU65zL1QbRHJjTkio4s0gLIdY0XA
	 L3g3ZN1Ae0Qz3iE/DHtA1b7siXtXeq/tX+mxaEaMKQBeVCIcEWZ0V+AldCfpkc9wGt
	 akq3wsUv0cWgLad1VgBu3iIofjpWfPxt6jeA7VN+xg7pycdF9cnuv6LpL4V0mJnOFI
	 mCsw3WSYM7fKzQjQ7gteCGPxtOwTeONvlSDqJNIoA5Hm9AZ5Yh0ql/ndo2H90ROj7g
	 myP6cXa3oE/QWrwKW88tH1WlUK1hGNsCgUR5rbUk69jYWJyPyUV/VSRAHTmLPPhxxs
	 gncs8AO2F0ZJzXgNpMazN7cnzsjt1c5h4Y15mT8hZ4N2a1NtaWG
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 14/16] t: add credential tests for authtype
Date: Wed, 17 Apr 2024 00:02:38 +0000
Message-ID: <20240417000240.3611948-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240417000240.3611948-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240417000240.3611948-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's helpful to have some basic tests for credential helpers supporting
the authtype and credential fields.  Let's add some tests for this case
so that we can make sure newly supported helpers work correctly.

Note that we explicitly check that credential helpers can produce
different sets of authtype and credential values based on the username.
While the username is not used in the HTTP protocol with authtype and
credential, it can still be specified in the URL and thus may be part of
the protocol.  Additionally, because it is common for users to have
multiple accounts on one service (say, both personal and professional
accounts), it's very helpful to be able to store different credentials
for different accounts in the same helper, and that doesn't become less
useful if one is using, say, Bearer authentication instead of Basic.
Thus, credential helpers should be expected to support this
functionality as basic functionality, so verify here that they do so.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-credential.sh | 123 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 44799c0d38..58b9c74060 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -538,6 +538,129 @@ helper_test_oauth_refresh_token() {
 	'
 }
 
+helper_test_authtype() {
+	HELPER=$1
+
+	test_expect_success "helper ($HELPER) stores authtype and credential" '
+		check approve $HELPER <<-\EOF
+		capability[]=authtype
+		authtype=Bearer
+		credential=random-token
+		protocol=https
+		host=git.example.com
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) gets authtype and credential" '
+		check fill $HELPER <<-\EOF
+		capability[]=authtype
+		protocol=https
+		host=git.example.com
+		--
+		capability[]=authtype
+		authtype=Bearer
+		credential=random-token
+		protocol=https
+		host=git.example.com
+		--
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) stores authtype and credential with username" '
+		check approve $HELPER <<-\EOF
+		capability[]=authtype
+		authtype=Bearer
+		credential=other-token
+		protocol=https
+		host=git.example.com
+		username=foobar
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) gets authtype and credential with username" '
+		check fill $HELPER <<-\EOF
+		capability[]=authtype
+		protocol=https
+		host=git.example.com
+		username=foobar
+		--
+		capability[]=authtype
+		authtype=Bearer
+		credential=other-token
+		protocol=https
+		host=git.example.com
+		username=foobar
+		--
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) does not get authtype and credential with different username" '
+		check fill $HELPER <<-\EOF
+		capability[]=authtype
+		protocol=https
+		host=git.example.com
+		username=barbaz
+		--
+		protocol=https
+		host=git.example.com
+		username=barbaz
+		password=askpass-password
+		--
+		askpass: Password for '\''https://barbaz@git.example.com'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) does not store ephemeral authtype and credential" '
+		check approve $HELPER <<-\EOF &&
+		capability[]=authtype
+		authtype=Bearer
+		credential=git2-token
+		protocol=https
+		host=git2.example.com
+		ephemeral=1
+		EOF
+
+		check fill $HELPER <<-\EOF
+		capability[]=authtype
+		protocol=https
+		host=git2.example.com
+		--
+		protocol=https
+		host=git2.example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://git2.example.com'\'':
+		askpass: Password for '\''https://askpass-username@git2.example.com'\'':
+		EOF
+	'
+
+	test_expect_success "helper ($HELPER) does not store ephemeral username and password" '
+		check approve $HELPER <<-\EOF &&
+		capability[]=authtype
+		protocol=https
+		host=git2.example.com
+		user=barbaz
+		password=secret
+		ephemeral=1
+		EOF
+
+		check fill $HELPER <<-\EOF
+		capability[]=authtype
+		protocol=https
+		host=git2.example.com
+		--
+		protocol=https
+		host=git2.example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://git2.example.com'\'':
+		askpass: Password for '\''https://askpass-username@git2.example.com'\'':
+		EOF
+	'
+}
+
 write_script askpass <<\EOF
 echo >&2 askpass: $*
 what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
