Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219D1E489
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535059; cv=none; b=XDo40+PfoLcP+mMN+3nrJ5aVzk4oqd8CDCXZHw46/jsHLJVygpW40skR5u4xdT13dY3krgxQ5RzIJitcIslOIDIt7SKOVfdf3dDv3/Kliq1wb3+2SsPyQAGNPzEva5N4sKELg9ZCVvGC7ecgdDtu41n1n+iMQWzkEyYVegZaMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535059; c=relaxed/simple;
	bh=AQ3uBqfRePE8Mwoh8kbgl4ERKhjs1BbZMYn43w+sWMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyBCBNqjb/2Pu0ZxCuWLC2hsRaGoIUXiqRzX1pLui7OZYuCs7pkdlzLxVgK6vzw2WYQYqZODOksxzlVNieCRcjTJNqScYFizZKRUqpeklVgbx9mfoUBXKV5CL2i7lGnREsufdEFlZzwqt8ODMuFpJ0DqGiL5MGAAZiV5Mf5uB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Pw9HrJLq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Pw9HrJLq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1719534467;
	bh=AQ3uBqfRePE8Mwoh8kbgl4ERKhjs1BbZMYn43w+sWMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Pw9HrJLqgikYNrAWrya/wRURK3TQ+zEbDKL4mvA/W47xVTG/5xGkf+PoAlunqPH+d
	 2P/9NYQHGZ2CQjmmFG2aoA1lkIv/7KaUMqsM+LNioTDSjf7V1UD1ApobP5XLq6V5nW
	 lwVH97iKPD7hYyNfaPFiWCAhszco9uwl8qKAht/JMU2eu6gXRnUoTZWXSV+/1ZGxQF
	 2paQg11Tn028dv/Z1MLZEfySbw3TYpPfjp1B6ufZ+jAmcUdDBseB+NUzkwkOTYcyFG
	 emhB6FAQDJXqNtgouf1O/Ia6I2WZ8S7dhcZ0NXn+cQJ2FpDJbbBKylT3xdzCydav3b
	 7Kx2Tt/3hM6imRnnVwg9SVxlX10sLRKZDF+/HtYD04n2ba0v5vx3ekw7XyIXzrgPB/
	 yZqwoL/rohYYffCnsPZ0NEfuMAgwk710fG00bAIpKyGONdZ+3rvzUeg4H+drvkjOjL
	 7HINJXREVpcl+wHCMqLB0nSUBkgbWfRfiqRs8zryKdfkqZdnp4x
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 46A63263AA;
	Fri, 28 Jun 2024 00:27:47 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] http: allow authenticating proactively
Date: Fri, 28 Jun 2024 00:27:42 +0000
Message-ID: <20240628002742.3421311-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
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
 Documentation/config/http.txt |  15 +++++
 http.c                        |  59 +++++++++++++++--
 t/t5563-simple-http-auth.sh   | 116 ++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b86..2bacb2b862 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -56,6 +56,21 @@ http.emptyAuth::
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
+* `auto` - Don't request any scheme from the helper.
+--
+
 http.delegation::
 	Control GSSAPI credential delegation. The delegation is disabled
 	by default in libcurl since version 7.21.7. Set parameter to tell
diff --git a/http.c b/http.c
index 2dea2d03da..2e54eddb45 100644
--- a/http.c
+++ b/http.c
@@ -106,12 +106,19 @@ static struct {
 };
 #endif
 
+enum proactive_auth {
+	PROACTIVE_AUTH_NONE,
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
 
@@ -146,6 +153,11 @@ static int http_schannel_check_revoke = 1;
  */
 static int http_schannel_use_ssl_cainfo;
 
+static int always_auth_proactively(void)
+{
+	return http_proactive_auth != PROACTIVE_AUTH_NONE && http_proactive_auth != PROACTIVE_AUTH_IF_CREDENTIALS;
+}
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -537,6 +549,18 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp("http.proactiveauth", var)) {
+		if (value && !strcmp(value, "auto"))
+			http_proactive_auth = PROACTIVE_AUTH_AUTO;
+		else if (value && !strcmp(value, "basic"))
+			http_proactive_auth = PROACTIVE_AUTH_BASIC;
+		else if (!value)
+			http_proactive_auth = PROACTIVE_AUTH_NONE;
+		else
+			warning(_("Unknown value %s for http.proactiveauth"), value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, ctx, data);
 }
@@ -578,14 +602,29 @@ static void init_curl_http_auth(CURL *result)
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
@@ -1048,7 +1087,7 @@ static CURL *get_curl_handle(void)
 #endif
 	}
 
-	if (http_proactive_auth)
+	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
 		init_curl_http_auth(result);
 
 	if (getenv("GIT_SSL_VERSION"))
@@ -1292,7 +1331,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
 
-	http_proactive_auth = proactive_auth;
+	if (proactive_auth && http_proactive_auth == PROACTIVE_AUTH_NONE)
+		http_proactive_auth = PROACTIVE_AUTH_IF_CREDENTIALS;
 
 	if (remote && remote->http_proxy)
 		curl_http_proxy = xstrdup(remote->http_proxy);
@@ -1788,6 +1828,8 @@ static int handle_curl_result(struct slot_results *results)
 				return HTTP_REAUTH;
 			}
 			credential_reject(&http_auth);
+			if (always_auth_proactively())
+				http_proactive_auth = PROACTIVE_AUTH_NONE;
 			return HTTP_NOAUTH;
 		} else {
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
@@ -2184,7 +2226,12 @@ static int http_request_reauth(const char *url,
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
 
