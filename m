Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8D3C2F
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312185; cv=none; b=kPeN20Ece5bg1aVsQZWJF2LuSyMq2qbF1XY7WiOAz8I2wJF1Z+NK6UHWF6npaNrDjJ1sYbwwRI4Y+rpAYbOV42BfMgIcIi0Yy24w4OSTUm15q8EW5N5Ssn9RVh5L6XpZrRYp0xB7e+AoF96cn2AzH/uFZEy2VU/owE+jYoiBVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312185; c=relaxed/simple;
	bh=HA0AIlaLL+FWmt3nsi1CR7e7of0upxixtRcsanYODQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aACRE0iu/gAXsIsR85LkkXamrxRFIM2vO0ibcFByiGYQjJQy2PDMFjZM2zTjLS7M2H37dOXXMSTuPu2T6KlisGtqSNWBS0Vz3n6vDqOC9FC9XM1brD5YDY0vvz2Jx/jvaVCLtnrirYCWwswIu/I73u6xlWFZbODBxuda0GHWijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=tb7Bbddy; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tb7Bbddy"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 468795D4E7;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=HA0AIlaLL+FWmt3nsi1CR7e7of0upxixtRcsanYODQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=tb7BbddyZ/jBGvqDWn4bBrVIhpnFuo33AsSfhBNXhnQ3/TtgTCMwD8jsMONkyTOx2
	 EFFKr0dQ/C67tEwg68VhAD8YPQ7R9XazTRM5EBE64AHMv1Q7dEHuY+X1M+n4mBXSNE
	 GkO/5O7u6IIn51TCO7uHUByfCA/z/W0r1bmYsogp7nrpKm5Icr7M08+elawBqvxPjb
	 BTvDAt5lPKEBSzZFLPm+VQjprHne/csFPrFdNlKarRByhKfA5eUA8xpigetAEbE9WM
	 5y/8IDQjHgWiQLHDbWwKjkCsOaJGtQUt1vPfdYzmTrIHvIUXbKOQXoJTgRXZ0Cae3w
	 Nv01fbqd6Ye31eBjwtk3VgGDcQ2Bty/bhSwRzlozb5G9SBcJje/pAuJMBirJ+PZhxw
	 NQ1XNsq8HFfon8m8vH/Rd+2qZOK+jRhVbS7+9vCHV4+/IXO+qWyW+jUGP6D3g1jwHF
	 bUv2Kp1ro2yvRuCpnGnOb4MKhjjsHyGJ9oGzhaA7y6hhQtszWB/
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 06/16] credential: add a field called "ephemeral"
Date: Wed, 17 Apr 2024 00:02:30 +0000
Message-ID: <20240417000240.3611948-7-sandals@crustytoothpaste.net>
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

Now that we have support for a wide variety of types of authentication,
it's important to indicate to other credential helpers whether they
should store credentials, since not every credential helper may
intuitively understand all possible values of the authtype field.  Do so
with a boolean field called "ephemeral", to indicate whether the
credential is expected to be temporary.

For example, in HTTP Digest authentication, the Authorization header
value is based off a nonce.  It isn't useful to store this value
for later use because reusing the credential long term will not result
in successful authentication due to the nonce necessarily differing.

An additional case is potentially short-lived credentials, which may
last only a few hours.  It similarly wouldn't be helper for other
credential helpers to attempt to provide these much later.

We do still pass the value to "git credential store" or "git credential
erase", since it may be helpful to the original helper to know whether
the operation was successful.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 credential.c           |  4 ++++
 credential.h           |  1 +
 t/t0300-credentials.sh | 30 ++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/credential.c b/credential.c
index f5396629df..3531d74346 100644
--- a/credential.c
+++ b/credential.c
@@ -289,6 +289,8 @@ int credential_read(struct credential *c, FILE *fp,
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "ephemeral")) {
+			c->ephemeral = !!git_config_bool("ephemeral", value);
 		} else if (!strcmp(key, "wwwauth[]")) {
 			strvec_push(&c->wwwauth_headers, value);
 		} else if (!strcmp(key, "capability[]") && !strcmp(value, "authtype")) {
@@ -339,6 +341,8 @@ void credential_write(const struct credential *c, FILE *fp,
 		credential_write_item(fp, "capability[]", "authtype", 0);
 		credential_write_item(fp, "authtype", c->authtype, 0);
 		credential_write_item(fp, "credential", c->credential, 0);
+		if (c->ephemeral)
+			credential_write_item(fp, "ephemeral", "1", 0);
 	}
 	credential_write_item(fp, "protocol", c->protocol, 1);
 	credential_write_item(fp, "host", c->host, 1);
diff --git a/credential.h b/credential.h
index b524fdba59..da2a4802b7 100644
--- a/credential.h
+++ b/credential.h
@@ -152,6 +152,7 @@ struct credential {
 	unsigned header_is_last_match:1;
 
 	unsigned approved:1,
+		 ephemeral:1,
 		 configured:1,
 		 quit:1,
 		 use_http_path:1,
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index daf330ddd8..eceb6bbfbe 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -51,6 +51,17 @@ test_expect_success 'setup helper scripts' '
 	test -z "$credential" || echo credential=$credential
 	EOF
 
+	write_script git-credential-verbatim-ephemeral <<-\EOF &&
+	authtype=$1; shift
+	credential=$1; shift
+	. ./dump
+	echo capability[]=authtype
+	test -z "${capability##*authtype*}" || exit 0
+	test -z "$authtype" || echo authtype=$authtype
+	test -z "$credential" || echo credential=$credential
+	echo "ephemeral=1"
+	EOF
+
 	write_script git-credential-verbatim-with-expiry <<-\EOF &&
 	user=$1; shift
 	pass=$1; shift
@@ -99,6 +110,25 @@ test_expect_success 'credential_fill invokes helper with credential' '
 	EOF
 '
 
+test_expect_success 'credential_fill invokes helper with ephemeral credential' '
+	check fill "verbatim-ephemeral Bearer token" <<-\EOF
+	capability[]=authtype
+	protocol=http
+	host=example.com
+	--
+	capability[]=authtype
+	authtype=Bearer
+	credential=token
+	ephemeral=1
+	protocol=http
+	host=example.com
+	--
+	verbatim-ephemeral: get
+	verbatim-ephemeral: capability[]=authtype
+	verbatim-ephemeral: protocol=http
+	verbatim-ephemeral: host=example.com
+	EOF
+'
 
 test_expect_success 'credential_fill invokes multiple helpers' '
 	check fill useless "verbatim foo bar" <<-\EOF
