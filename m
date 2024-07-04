Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644FE632
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052280; cv=none; b=uZzCBd5pNEsBPuMilZzXcSLdC5SGNOGT5uIw860qhOS78jvV5dkQbD4ZLzpvpReDXavbW2cNqu3J6fFS7rpxQHpa3JgnMGxd43qqtU0Uaqr3pbH/caCrixv4MIOs33tBncTrNwnOIHs9ErCeOSBYFeMkwrqDic8a94LkxkE6z2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052280; c=relaxed/simple;
	bh=sG82ywIqqU6SyUYjljoG3wQykJlsmee9XlgSF4DR1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgbnoMNMTrCsS3lDlR/0wHMC97ixY/mvgifW1e8b7M1Tjc07lID71iPxRL8tku1X7IugQ7snU3X8Xp7Lcs3Z63DphomoaFNA4oMRTfKtwQDmNIDb3LL2KlYAgLlR7H4FHd3+iUlcXA3VdVVv5Srmz+JqO3TIdDIhfrIWZ3q75nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TNR8e2n4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TNR8e2n4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720052276;
	bh=sG82ywIqqU6SyUYjljoG3wQykJlsmee9XlgSF4DR1Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=TNR8e2n41geIn8+cHfJjuX0vYBwp25riHhlayhx33H7c6WRAmkOOLOm0rLf1mGuBH
	 25EBZhzvm3CLI1R57G3qEJXgTLn3oAQ+yvEDQ2w4i11oQMqy46ZIpjR0X9prJ+LOCQ
	 imnpjgtBVEx8L+VHTtF4ZFKsDrNci68Jly1sPqiUSBqdZKYu/zryfhKX7cJfQlNK5Y
	 AIoGKA3uuhiwx8pRrAZ5g2qg8tmnjpa6H/BJaGulnncw5n782mcKz1o6Wy1zmNMmYH
	 BKh26+6hAzx6ztZCkRMUNPzC0ypjFoHPk6jgknBAdidpUYbqC6+wo5hCfP/DR+HjDV
	 Uq6M72JILjNMiUTDabAO0U284WdpQQtlJliNzJ1+psAaOJzlgcB4/sL2M2suZffcEA
	 dVSYqfJOPMGXJAxaJPKLOcCI25Fro+b4JdfcSCqf0jEPlJLXpd5h1U/5GyQj+k+SgJ
	 VptYITeCKGnvB6KPVqcJGgwD3XH9lqL32qQq7p+jXoFFikQQxaO
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5D25C20999;
	Thu,  4 Jul 2024 00:17:56 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/1] http: allow authenticating proactively
Date: Thu,  4 Jul 2024 00:17:48 +0000
Message-ID: <20240704001748.746429-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240704001748.746429-1-sandals@crustytoothpaste.net>
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
 <20240704001748.746429-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When making a request over HTTP(S), Git only sends authentication if it
receives a 401 response.  Thus, if a repository is open to the public
for reading, Git will typically never ask for authentication for fetches
and clones.

However, there may be times when a user would like to authenticate
nevertheless.  For example, a forge may give higher rate limits to users
who authenticate because they are easier to contact in case of excessive
use.  Or it may be useful for a known heavy user, such as an internal
service, to proactively authenticate so its use can be monitored and, if
necessary, throttled.

Let's make this possible with a new option, "http.proactiveAuth".  This
option specifies a type of authentication which can be used to
authenticate against the host in question.  This is necessary because we
lack the WWW-Authenticate header to provide us details; similarly, we
cannot accept certain types of authentication because we require
information from the server, such as a nonce or challenge, to
successfully authenticate.

If we're in auto mode and we got a username and password, set the
authentication scheme to Basic.  libcurl will not send authentication
proactively unless there's a single choice of allowed authentication,
and we know in this case we didn't get an authtype entry telling us what
scheme to use, or we would have taken a different codepath and written
the header ourselves.  In any event, of the other schemes that libcurl
supports, Digest and NTLM require a nonce or challenge, which means that
they cannot work with proactive auth, and GSSAPI does not use a username
and password at all, so Basic is the only logical choice among the
built-in options.

Note that the existing http_proactive_auth variable signifies proactive
auth if there are already credentials, which is different from the
functionality we're adding, which always seeks credentials even if none
are provided.  Nonetheless, t5540 tests the existing behavior for
WebDAV-based pushes to an open repository without credentials, so we
preserve it.  While at first this may seem an insecure and bizarre
decision, it may be that authentication is done with TLS certificates,
in which case it might actually provide a quite high level of security.
Expand the variable to use an enum to handle the additional cases and a
helper function to distinguish our new cases from the old ones.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/http.txt |  20 ++++++
 http.c                        |  60 ++++++++++++++++--
 t/t5563-simple-http-auth.sh   | 116 ++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b86..9fd6c38252 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -56,6 +56,26 @@ http.emptyAuth::
 	a username in the URL, as libcurl normally requires a username for
 	authentication.
 
+http.proactiveAuth::
+	Attempt authentication without first making an unauthenticated attempt and
+	receiving a 401 response. This can be used to ensure that all requests are
+	authenticated. If `http.emptyAuth` is set to true, this value has no effect.
++
+If the credential helper used specifies an authentication scheme (i.e., via the
+`authtype` field), that value will be used; if a username and password is
+provided without a scheme, then Basic authentication is used.  The value of the
+option determines the scheme requested from the helper. Possible values are:
++
+--
+* `basic` - Request Basic authentication from the helper.
+* `auto` - Allow the helper to pick an appropriate scheme.
+* `none` - Disable proactive authentication.
+--
++
+Note that TLS should always be used with this configuration, since otherwise it
+is easy to accidentally expose plaintext credentials if Basic authentication
+is selected.
+
 http.delegation::
 	Control GSSAPI credential delegation. The delegation is disabled
 	by default in libcurl since version 7.21.7. Set parameter to tell
diff --git a/http.c b/http.c
index 13fa94bef3..3e90b32bb0 100644
--- a/http.c
+++ b/http.c
@@ -108,12 +108,19 @@ static struct {
 };
 #endif
 
+enum proactive_auth {
+	PROACTIVE_AUTH_NONE = 0,
+	PROACTIVE_AUTH_IF_CREDENTIALS,
+	PROACTIVE_AUTH_AUTO,
+	PROACTIVE_AUTH_BASIC,
+};
+
 static struct credential proxy_auth = CREDENTIAL_INIT;
 static const char *curl_proxyuserpwd;
 static char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
-static int http_proactive_auth;
+static enum proactive_auth http_proactive_auth;
 static char *user_agent;
 static int curl_empty_auth = -1;
 
@@ -148,6 +155,12 @@ static int http_schannel_check_revoke = 1;
  */
 static int http_schannel_use_ssl_cainfo;
 
+static int always_auth_proactively(void)
+{
+	return http_proactive_auth != PROACTIVE_AUTH_NONE &&
+	       http_proactive_auth != PROACTIVE_AUTH_IF_CREDENTIALS;
+}
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -539,6 +552,18 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp("http.proactiveauth", var)) {
+		if (value && !strcmp(value, "auto"))
+			http_proactive_auth = PROACTIVE_AUTH_AUTO;
+		else if (value && !strcmp(value, "basic"))
+			http_proactive_auth = PROACTIVE_AUTH_BASIC;
+		else if (value && !strcmp(value, "none"))
+			http_proactive_auth = PROACTIVE_AUTH_NONE;
+		else
+			warning(_("Unknown value for http.proactiveauth"));
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, ctx, data);
 }
@@ -580,14 +605,29 @@ static void init_curl_http_auth(CURL *result)
 {
 	if ((!http_auth.username || !*http_auth.username) &&
 	    (!http_auth.credential || !*http_auth.credential)) {
-		if (curl_empty_auth_enabled())
+		int empty_auth = curl_empty_auth_enabled();
+		if ((empty_auth != -1 && !always_auth_proactively()) || empty_auth == 1) {
 			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
-		return;
+			return;
+		} else if (!always_auth_proactively()) {
+			return;
+		} else if (http_proactive_auth == PROACTIVE_AUTH_BASIC) {
+			strvec_push(&http_auth.wwwauth_headers, "Basic");
+		}
 	}
 
 	credential_fill(&http_auth, 1);
 
 	if (http_auth.password) {
+		if (always_auth_proactively()) {
+			/*
+			 * We got a credential without an authtype and we don't
+			 * know what's available.  Since our only two options at
+			 * the moment are auto (which defaults to basic) and
+			 * basic, use basic for now.
+			 */
+			curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
+		}
 		curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
 		curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
 	}
@@ -1050,7 +1090,7 @@ static CURL *get_curl_handle(void)
 #endif
 	}
 
-	if (http_proactive_auth)
+	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
 		init_curl_http_auth(result);
 
 	if (getenv("GIT_SSL_VERSION"))
@@ -1294,7 +1334,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
 
-	http_proactive_auth = proactive_auth;
+	if (proactive_auth && http_proactive_auth == PROACTIVE_AUTH_NONE)
+		http_proactive_auth = PROACTIVE_AUTH_IF_CREDENTIALS;
 
 	if (remote && remote->http_proxy)
 		curl_http_proxy = xstrdup(remote->http_proxy);
@@ -1790,6 +1831,8 @@ static int handle_curl_result(struct slot_results *results)
 				return HTTP_REAUTH;
 			}
 			credential_reject(&http_auth);
+			if (always_auth_proactively())
+				http_proactive_auth = PROACTIVE_AUTH_NONE;
 			return HTTP_NOAUTH;
 		} else {
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
@@ -2186,7 +2229,12 @@ static int http_request_reauth(const char *url,
 			       struct http_get_options *options)
 {
 	int i = 3;
-	int ret = http_request(url, result, target, options);
+	int ret;
+
+	if (always_auth_proactively())
+		credential_fill(&http_auth, 1);
+
+	ret = http_request(url, result, target, options);
 
 	if (ret != HTTP_OK && ret != HTTP_REAUTH)
 		return ret;
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index 4af796de67..ba03f6a09f 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -178,6 +178,122 @@ test_expect_success 'access using basic auth invalid credentials' '
 	EOF
 '
 
+test_expect_success 'access using basic proactive auth' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=200
+	id=default status=403
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	test_config_global http.proactiveAuth basic &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Basic
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using auto proactive auth with basic default' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	username=alice
+	password=secret-passwd
+	EOF
+
+	# Basic base64(alice:secret-passwd)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
+	EOF
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=200
+	id=default status=403
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	test_config_global http.proactiveAuth auto &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	protocol=http
+	host=$HTTPD_DEST
+	EOF
+
+	expect_credential_query store <<-EOF
+	protocol=http
+	host=$HTTPD_DEST
+	username=alice
+	password=secret-passwd
+	EOF
+'
+
+test_expect_success 'access using auto proactive auth with authtype from credential helper' '
+	test_when_finished "per_test_cleanup" &&
+
+	set_credential_reply get <<-EOF &&
+	capability[]=authtype
+	authtype=Bearer
+	credential=YS1naXQtdG9rZW4=
+	EOF
+
+	# Basic base64(a-git-token)
+	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
+	id=1 creds=Bearer YS1naXQtdG9rZW4=
+	EOF
+
+	CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
+
+	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
+	id=1 status=200
+	id=default status=403
+	EOF
+
+	test_config_global credential.helper test-helper &&
+	test_config_global http.proactiveAuth auto &&
+	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
+
+	expect_credential_query get <<-EOF &&
+	capability[]=authtype
+	capability[]=state
+	protocol=http
+	host=$HTTPD_DEST
+	EOF
+
+	expect_credential_query store <<-EOF
+	capability[]=authtype
+	authtype=Bearer
+	credential=YS1naXQtdG9rZW4=
+	protocol=http
+	host=$HTTPD_DEST
+	EOF
+'
+
 test_expect_success 'access using basic auth with extra challenges' '
 	test_when_finished "per_test_cleanup" &&
 
