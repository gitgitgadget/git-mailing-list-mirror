Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403C28F4
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312184; cv=none; b=QXTePtOPbOifgTRBwAH1Ph5kGgPAnRAZYPsjvMWnBMBjbMniWKziVfstIC+1bDxXwP9AVh7X8xOQ8noWb6ZmgDpooYOabEq1st1DlDE5eU3qHTAVbW4IOanw01YqIIYHaXrnjjkZDCkpuwjhPQrXTknFz/2E5VJ7y+jb9DhAINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312184; c=relaxed/simple;
	bh=8TxfuBxsWtpSLU/4F9w2T/UCfwNMMCASchJnroJ1l/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oigOh2GWOLsa/DGuiY/dA37ip0hU6az/bjw+rQR/ImRfL7jbiuzYoW5+JP0Z57774emvj5KsUyGy6maBuyk1Nt/XRBjGNJOkbcsxMJrv10xXai+LRLWJGXC9fF10Xfob9EJDGm+ktMTkAmQBh1zfNtS9w8WIlnfGezESKUFuytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=O2b4DC9J; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O2b4DC9J"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 200A35D4E5;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=8TxfuBxsWtpSLU/4F9w2T/UCfwNMMCASchJnroJ1l/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=O2b4DC9JGeMPttLe61/YJAt8meWaSIycQykVCII/8vqVGtIIKYNkF1LAzz13QM6EG
	 F3YubSTztbwDIb3NlqCtRx9yHCwWWNiLURRDSZ0EqAkAqTi6Jxgzoutz4fYaWpPbQa
	 OCxVap+PhPiGE8aX3n+h1HYi0HPZojHs/VeCeHYkQnSDb/4wwUH6Xy7b3DsuIsgIEG
	 c4zclt+fkjf3sULUFHpOCJHUltZoJQdm9L66CS5H0PoUwV2bDn6Tg8fU7MnzpJF9O2
	 uULmIVvoUXFDWT42RjrXLYhtHewO8ZOV18Nvy7xSejxOaY3fIZ9JLs6isioullfqUQ
	 7BziKwxjxmnO4EFdFUP+ecMEhJTfU74c5JnQzjRgg9Wl2kGztvp5adDqagZLTiDLZ8
	 Asiuytep61s/bywtshRAPj76E002WBnscyV+BAyODSNfF5mjTul8voKxXhLtHBvMYr
	 mRe2GBEvNaeSvtAiezNnbk4+VFAJAGldrhRdpwpzXFP/SU1Pv/R
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 04/16] credential: add a field for pre-encoded credentials
Date: Wed, 17 Apr 2024 00:02:28 +0000
Message-ID: <20240417000240.3611948-5-sandals@crustytoothpaste.net>
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
