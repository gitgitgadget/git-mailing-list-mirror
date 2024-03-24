Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D271EC4
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242795; cv=none; b=FszKTBUujhKQd6eSk/GwUeBuFCRQkzTOaaAIhYqkbM4XXlZ3ErSHC0WqfcHtK65hMn30kEbmScOr7GOymJx7DP+9FtCDkL8ACN+IcxpvZxxWjoKxqKVp7RYSgIpeeWhQqKGg8Ml5b0UCT7XqdZa9oP+l7IZGlVc2jktAKm9wqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242795; c=relaxed/simple;
	bh=xMhWRt1J+S4TuQXO1QSsMBSmNfSgr2pe2mgv+AZjeMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyxV2MalqN2qZMhogKOoklI/pk2v29SCtitWo7/3DNTJFuvgURR9L2oSs/n3I9tvZyK3zCQHbxFGwDcJgtkwCuhZwh9k+9SUOp9nHXaIBnEMxQ70Dq1tTNDxicbR6JUFo1yzQJfPi/9c7fI/WUwqVIZ+ez4/L/dGWxqvQswnvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FE7/x1kL; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FE7/x1kL"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3E2F65D412;
	Sun, 24 Mar 2024 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242786;
	bh=xMhWRt1J+S4TuQXO1QSsMBSmNfSgr2pe2mgv+AZjeMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=FE7/x1kL0lSv8qwhHbv5nUexQvphbzRjoC1MQTQx6p3QS+uuyWycdrkSE8HaazxC1
	 vgQwy1Z1Sle6VZZUlh0jLchkW5aF4UuLl8mFudV+CuJaDfp62nwBsxxbtFR+II7iYo
	 BoH6Yk3I6y409oKPdmKGBc+devzuuUu/OcqkGGPNlELQzikgytXLmIxr9rZ0bmuTBU
	 bXswQoagOQahWPoRG45WeJbFuczBOY/dvKczTMYtZeSumaUf7o+X8Y+177qHHOEOi8
	 apeKbCSJKbgOgN2T1ejZgflKNf23DASocGBNAYhAAu/XJ9WbpOl7ZndWLTBSquQYdg
	 hlzWbkycDcfNCjR8/XFRGYpTnnsPVODEQkkcEwnAUkQCTioSgSACj03iRSt61ncQSA
	 naA3KRfzV5EE1Tu7bg0QFAS1u4AfSK1nAYhWKXi2xnWEssLREO1DkbofGkugcb8NqB
	 GCd0zcpe3t4ETKzgKCLU8y2kqGXLnDc4KUBxTuMuzyRt3SKPXvA
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 09/13] credential: enable state capability
Date: Sun, 24 Mar 2024 01:12:57 +0000
Message-ID: <20240324011301.1553072-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we've implemented the state capability, let's send it along by
default when filling credentials so we can make use of it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 credential.c                |  1 +
 t/t5563-simple-http-auth.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/credential.c b/credential.c
index 0cd7dd2a00..0ca7c12895 100644
--- a/credential.c
+++ b/credential.c
@@ -38,6 +38,7 @@ void credential_clear(struct credential *c)
 static void credential_set_all_capabilities(struct credential *c)
 {
 	c->capa_authtype.request_initial = 1;
+	c->capa_state.request_initial = 1;
 }
 
 int credential_match(const struct credential *want,
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index b3ed0d9fc2..b098cd0fdf 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -75,6 +75,7 @@ test_expect_success 'access using basic auth' '
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=Basic realm="example.com"
@@ -111,6 +112,7 @@ test_expect_success 'access using basic auth via authtype' '
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=Basic realm="example.com"
@@ -147,6 +149,7 @@ test_expect_success 'access using basic auth invalid credentials' '
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=Basic realm="example.com"
@@ -185,6 +188,7 @@ test_expect_success 'access using basic auth with extra challenges' '
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -224,6 +228,7 @@ test_expect_success 'access using basic auth mixed-case wwwauth header name' '
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=foobar param1="value1" param2="value2"
@@ -268,6 +273,7 @@ test_expect_success 'access using basic auth with wwwauth header continuations'
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -314,6 +320,7 @@ test_expect_success 'access using basic auth with wwwauth header empty continuat
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -356,6 +363,7 @@ test_expect_success 'access using basic auth with wwwauth header mixed line-endi
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -397,6 +405,7 @@ test_expect_success 'access using bearer auth' '
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
@@ -440,6 +449,7 @@ test_expect_success 'access using bearer auth with invalid credentials' '
 
 	expect_credential_query get <<-EOF &&
 	capability[]=authtype
+	capability[]=state
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=FooBar param1="value1" param2="value2"
