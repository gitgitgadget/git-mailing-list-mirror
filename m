Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E31ECF
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711243213; cv=none; b=thwMehFplPwYCLvVxPHlcmNCpkSUKBEqTl95qp0mhGo6+jb5R/amGX/YBjP3mqGSUx2RW/N90Agmfj8ysMwJ1rR8y7BiAGKqgHu105sK8g15wMVsb0E2YxaxObQ4P4PV5L99FH31DKCMpAZcYOo3KJTXjxw1vZATMAqPMRLfg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711243213; c=relaxed/simple;
	bh=8TxfuBxsWtpSLU/4F9w2T/UCfwNMMCASchJnroJ1l/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al9MPSJ5nq/cGIeKE0CuewF7Vjtfn+kjAvT88ZUxAcvzGckQscaXn6hAnMHEk3BfHbeYuangnZXdXqcsT++s4mvhnkzHewDNRyP841a7smmPYd9ciOIXxZwKnLtS7Tfx7jMLY29Zabzt1Iw8caI49+UjSzvV+fQKczj6pPANFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=s8RJ2Epo; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s8RJ2Epo"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DA9155D3B9;
	Sun, 24 Mar 2024 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242785;
	bh=8TxfuBxsWtpSLU/4F9w2T/UCfwNMMCASchJnroJ1l/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=s8RJ2Epo6pwN55aeaeP/G6LroBAzxY6eToIm79svuO5dAM6uJcdJqJDct2+FL/H53
	 IsQbQNX8btpH0i/7oj5+q9D/3nFyP9wIs/pWVliRF4f6SJg0JFY43YZynmqE1keUof
	 bkViluKFntc/lbNwTx7j9g4Y29VRBuCzte6qM4lfs48LaXxwTjnGURUfEPGgm+Vwia
	 b2CrBmHm9qDXSC7WAwkXSp0c/oESTFpTf16YQfY5BlsLhk9OARNGyFnxprZs73ShpK
	 KuysNPYvnWDY5g59Pd/Fv0IKCZ7ezQa+CQFhXo+h3HdQlxHw+Ieo8dGRyM/MXHNgld
	 cJoduRDp/eQBtM0BJcnv78OCpakVw9QaKrP2gc1AHL8U13aQm9aRrRutbKwKNk1+ie
	 m2sMj0Ck1UZCVXUij3+abYdQwUSaJX0dQT0hY+EZEWUIGmAliciOQWtIhw+Ipx+h3l
	 ZiAnCrMvZ3kMFok0OgpVTNfXESmfj53C3q2ThkSD2OEDOLDRvw3
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 04/13] credential: add a field for pre-encoded credentials
Date: Sun, 24 Mar 2024 01:12:52 +0000
Message-ID: <20240324011301.1553072-5-sandals@crustytoothpaste.net>
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

At the moment, our credential code wants to find a username and password
for access, which, for HTTP, it will pass to libcurl to encode and
process.  However, many users want to use authentication schemes that
libcurl doesn't support, such as Bearer authentication.  In these
schemes, the secret is not a username and password pair, but some sort
of token that meets the production for authentication data in the RFC.

In fact, in general, it's useful to allow our credential helper to have
knowledge about what specifically to put in the protocol header.  Thus,
add a field, credential, which contains data that's preencoded to be
suitable for the protocol in question.  If we have such data, we need
neither a username nor a password, so make that adjustment as well.

It is in theory possible to reuse the password field for this.  However,
if we do so, we must know whether the credential helper supports our new
scheme before sending it data, which necessitates some sort of
capability inquiry, because otherwise an uninformed credential helper
would store our preencoded data as a password, which would fail the next
time we attempted to connect to the remote server.  This design is
substantially simpler, and we can hint to the credential helper that we
support this approach with a simple new field instead of needing to
query it first.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 credential.c | 14 ++++++++++----
 credential.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/credential.c b/credential.c
index 3dec433df5..c521822e5a 100644
--- a/credential.c
+++ b/credential.c
@@ -25,6 +25,7 @@ void credential_clear(struct credential *c)
 	free(c->path);
 	free(c->username);
 	free(c->password);
+	free(c->credential);
 	free(c->oauth_refresh_token);
 	free(c->authtype);
 	string_list_clear(&c->helpers, 0);
@@ -234,6 +235,9 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "password")) {
 			free(c->password);
 			c->password = xstrdup(value);
+		} else if (!strcmp(key, "credential")) {
+			free(c->credential);
+			c->credential = xstrdup(value);
 		} else if (!strcmp(key, "protocol")) {
 			free(c->protocol);
 			c->protocol = xstrdup(value);
@@ -291,6 +295,7 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	credential_write_item(fp, "credential", c->credential, 0);
 	credential_write_item(fp, "oauth_refresh_token", c->oauth_refresh_token, 0);
 	if (c->password_expiry_utc != TIME_MAX) {
 		char *s = xstrfmt("%"PRItime, c->password_expiry_utc);
@@ -366,7 +371,7 @@ void credential_fill(struct credential *c)
 {
 	int i;
 
-	if (c->username && c->password)
+	if ((c->username && c->password) || c->credential)
 		return;
 
 	credential_apply_config(c);
@@ -379,7 +384,7 @@ void credential_fill(struct credential *c)
 			/* Reset expiry to maintain consistency */
 			c->password_expiry_utc = TIME_MAX;
 		}
-		if (c->username && c->password)
+		if ((c->username && c->password) || c->credential)
 			return;
 		if (c->quit)
 			die("credential helper '%s' told us to quit",
@@ -387,7 +392,7 @@ void credential_fill(struct credential *c)
 	}
 
 	credential_getpass(c);
-	if (!c->username && !c->password)
+	if (!c->username && !c->password && !c->credential)
 		die("unable to get password from user");
 }
 
@@ -397,7 +402,7 @@ void credential_approve(struct credential *c)
 
 	if (c->approved)
 		return;
-	if (!c->username || !c->password || c->password_expiry_utc < time(NULL))
+	if (((!c->username || !c->password) && !c->credential) || c->password_expiry_utc < time(NULL))
 		return;
 
 	credential_apply_config(c);
@@ -418,6 +423,7 @@ void credential_reject(struct credential *c)
 
 	FREE_AND_NULL(c->username);
 	FREE_AND_NULL(c->password);
+	FREE_AND_NULL(c->credential);
 	FREE_AND_NULL(c->oauth_refresh_token);
 	c->password_expiry_utc = TIME_MAX;
 	c->approved = 0;
diff --git a/credential.h b/credential.h
index dc96ca0318..9db892cf4d 100644
--- a/credential.h
+++ b/credential.h
@@ -138,6 +138,7 @@ struct credential {
 
 	char *username;
 	char *password;
+	char *credential;
 	char *protocol;
 	char *host;
 	char *path;
