Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CD5CAC
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312186; cv=none; b=NKIQti0tJ6JpABfGLDMEKfrwm9u6yhZI+Aow/3dQM3UyZvlvwUPF2ml3XkDnau/4vGWGT0ud/KeIP4Fo9+CeGfM9HvnZqnU/Va1ijWHSNxwKkPsj1qTDcZ/4PaSEV/Aw6JosXu3kHsVKnyIYNwaxC7o2UGq6SsrJO4aPT0yheeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312186; c=relaxed/simple;
	bh=EeEPRneNl6VOvGHk/XXoZ2Trj3rBaOJciYEUHGKIzxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQQuw0EAZg8v3zOIYP0zIkIxdSj8O/Lq8h/TdXgtmBoyStRqvl4fikF+WbTUb57jwr0qDeZwbFCX5vZt5NfM7hlHq6E73ONUiJ3wScJYwb2NUtYQVMczztE41zVMbyn7GDb2y9CKq5H77sm/jjJtCdpj3CWQQUN2d1TkFu48U08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=WGlrrZba; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WGlrrZba"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7ED505D4EB;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=EeEPRneNl6VOvGHk/XXoZ2Trj3rBaOJciYEUHGKIzxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=WGlrrZbaYNxo0O2ZUBYlU4WtYGNX+a30rx+XEj4cYj2aPGoTEBM9+J09Lj6L9Rtt/
	 g1fLLYNmHmdAKvLmdjwLsIV1I3v85veNXBW9cL7HdtKucqD4y8i2LAxGaYrAdJIVRI
	 EAV6YaBEHTw/R+EJEWTsVtBr+jdsmLBdYgeMqV17ZCkzDt1bWmltiiPUa+PRHZhmQs
	 V9oZBp839IVqw2fkH7SAi8vr0Ghst0g3Vt9Pjm33ZSWCAuXGO4i86sLl6viqonHHTC
	 tmc+gEs9cdDfMSrZurJbCSOjfv+DO5jUVYVHDDHbuN0F2g0wqINA7gWr3Xsi7Hyqxn
	 tGKcokwMp60Ce9FjCvjXpPL3CMkVL7FU8Wffa8sZiCqszg6EEr0/EwJAENfmOgn0ls
	 Vof/Ib3DzJOzfkEqljpZyaJElz+hQ1UvShF9nvz8JpkUEeDrdW4AQPwizWwxfiFEH6
	 DW5mXzJFAn6kdCNve1nevVZLhvuqj4yBW24a0oQdNduhk/UjveL
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 10/16] credential: enable state capability
Date: Wed, 17 Apr 2024 00:02:34 +0000
Message-ID: <20240417000240.3611948-11-sandals@crustytoothpaste.net>
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

Now that we've implemented the state capability, let's send it along by
default when filling credentials so we can make use of it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 credential.c                |  1 +
 t/t5563-simple-http-auth.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/credential.c b/credential.c
index 48826fb5a2..c93de92f65 100644
--- a/credential.c
+++ b/credential.c
@@ -56,6 +56,7 @@ void credential_set_all_capabilities(struct credential *c,
 				     enum credential_op_type op_type)
 {
 	credential_set_capability(&c->capa_authtype, op_type);
+	credential_set_capability(&c->capa_state, op_type);
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
