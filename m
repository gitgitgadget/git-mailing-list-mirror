Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FD7F9
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242796; cv=none; b=cej+vavY+CSkkifa0JrYl8H8nYZKF151sbkNxZwgFTsBqI99+bcgAvkLhBfgVmM90uC0xce1XFQXfcET3ifBUBjnlxFC7QvoK/0HfGMb2qqvLNSeckZ0j/fKkkXleLeWx4Z/8W+MyLCUFmpw32sIn28Fy2/m8T+VW/Lx/QiEL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242796; c=relaxed/simple;
	bh=XmB1wDth2UHFOpBW+uAchrTW+yV6jfNAWG0U+edYu6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfSx5kCCZ8yCtPMYm7dlgOzGMGQ8WxDIE6osPJPV7Ed4zkC+i+9T7lQi1dpX6Or8/bZv5jAIb3X/mE/dg6EqffPceTXWp4jeSs2qgZqHt6t1AcxryoudfCIGc1ZZWijnzjR008RukIfKi+2aecL22qdTnfK6fDVzzP39sFfHgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sfUo87kf; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sfUo87kf"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EA65A5D405;
	Sun, 24 Mar 2024 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242786;
	bh=XmB1wDth2UHFOpBW+uAchrTW+yV6jfNAWG0U+edYu6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=sfUo87kfoV5otLnBbaIJb7FfSPedgh8SHw6eiNgIKqJFAxx8mJopM9t8njERcS/48
	 3f9ZEweGPmGZ1a/fxYGMOE73lcUlQjpsg/8nZYW7If+Nl9SiHFaHLj/jYTVTo8IvrS
	 KF4URQkIbRTj1daqqw3XJ3rud6VGGGYU5cZ84jDI3sqtugfF40Yl9ktj/2JTz0j03d
	 vCbx5/aONRP5IhCLRsoMv0jgM6P3hLE4sOl8dSswwJ/OnadX7DAv44hKIg6AnD7X7G
	 tpLnvG0EHevBn5WgB5iCRzsNQDiZ+f/7a/jTg1LH6KDeRP4/LrI7pgi4a/Qfxir3vU
	 9oVEpATXczw0nLmyYdjjkVvswoJAM1ky2Ojmway12jmgv99xm90DHA+Eri2PV/H559
	 8sB25FIkOJB4fVUHhiJEL7LDDt7r27LObDdkFOm1IgelOE6p4xXkGa9SFUKfJ9eNma
	 /91nVQQ4YjuXJiNOv2RYq0b5hUfKH6W2SiC3MffIK6QIu/cxQx4
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 05/13] credential: gate new fields on capability
Date: Sun, 24 Mar 2024 01:12:53 +0000
Message-ID: <20240324011301.1553072-6-sandals@crustytoothpaste.net>
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

We support the new credential and authtype fields, but we lack a way to
indicate to a credential helper that we'd like them to be used.  Without
some sort of indication, the credential helper doesn't know if it should
try to provide us a username and password, or a pre-encoded credential.
For example, the helper might prefer a more restricted Bearer token if
pre-encoded credentials are possible, but might have to fall back to
more general username and password if not.

Let's provide a simple way to indicate whether Git (or, for that matter,
the helper) is capable of understanding the authtype and credential
fields.  We send this capability when we generate a request, and the
other side may reply to indicate to us that it does, too.

For now, don't enable sending capabilities for the HTTP code.  In a
future commit, we'll introduce appropriate handling for that code,
which requires more in-depth work.

The logic for determining whether a capability is supported may seem
complex, but it is not.  At each stage, we emit the capability to the
following stage if all preceding stages have declared it.  Thus, if the
caller to git credential fill didn't declare it, then we won't send it
to the helper, and if fill's caller did send but the helper doesn't
understand it, then we won't send it on in the response.  If we're an
internal user, then we know about all capabilities and will request
them.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/credential-cache--daemon.c |   2 +-
 builtin/credential-store.c         |   2 +-
 builtin/credential.c               |   6 +-
 credential.c                       |  58 ++++++++++++++--
 credential.h                       |  30 +++++++-
 http.c                             |  10 +--
 imap-send.c                        |   2 +-
 remote-curl.c                      |   4 +-
 t/t0300-credentials.sh             | 107 ++++++++++++++++++++++++++++-
 9 files changed, 197 insertions(+), 24 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 3a6a750a8e..ccbcf99ac1 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -115,7 +115,7 @@ static int read_request(FILE *fh, struct credential *c,
 		return error("client sent bogus timeout line: %s", item.buf);
 	*timeout = atoi(p);
 
-	if (credential_read(c, fh) < 0)
+	if (credential_read(c, fh, CREDENTIAL_OP_HELPER) < 0)
 		return -1;
 	return 0;
 }
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 4a492411bb..494c809332 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -205,7 +205,7 @@ int cmd_credential_store(int argc, const char **argv, const char *prefix)
 	if (!fns.nr)
 		die("unable to set up default path; use --file");
 
-	if (credential_read(&c, stdin) < 0)
+	if (credential_read(&c, stdin, CREDENTIAL_OP_HELPER) < 0)
 		die("unable to read credential");
 
 	if (!strcmp(op, "get"))
diff --git a/builtin/credential.c b/builtin/credential.c
index 7010752987..5123dabcf1 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -17,12 +17,12 @@ int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
 		usage(usage_msg);
 	op = argv[1];
 
-	if (credential_read(&c, stdin) < 0)
+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
 		die("unable to read credential from stdin");
 
 	if (!strcmp(op, "fill")) {
-		credential_fill(&c);
-		credential_write(&c, stdout);
+		credential_fill(&c, 0);
+		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
 	} else if (!strcmp(op, "approve")) {
 		credential_approve(&c);
 	} else if (!strcmp(op, "reject")) {
diff --git a/credential.c b/credential.c
index c521822e5a..f2a26b8672 100644
--- a/credential.c
+++ b/credential.c
@@ -34,6 +34,11 @@ void credential_clear(struct credential *c)
 	credential_init(c);
 }
 
+static void credential_set_all_capabilities(struct credential *c)
+{
+	c->capa_authtype.request_initial = 1;
+}
+
 int credential_match(const struct credential *want,
 		     const struct credential *have, int match_password)
 {
@@ -210,7 +215,39 @@ static void credential_getpass(struct credential *c)
 						 PROMPT_ASKPASS);
 }
 
-int credential_read(struct credential *c, FILE *fp)
+static void credential_set_capability(struct credential_capability *capa, int op_type)
+{
+	switch (op_type) {
+	case CREDENTIAL_OP_INITIAL:
+		capa->request_initial = 1;
+		break;
+	case CREDENTIAL_OP_HELPER:
+		capa->request_helper = 1;
+		break;
+	case CREDENTIAL_OP_RESPONSE:
+		capa->response = 1;
+		break;
+	}
+}
+
+static int credential_has_capability(const struct credential_capability *capa, int op_type)
+{
+	/*
+	 * We're checking here if each previous step indicated that we had the
+	 * capability.  If it did, then we want to pass it along; conversely, if
+	 * it did not, we don't want to report that to our caller.
+	 */
+	switch (op_type) {
+	case CREDENTIAL_OP_HELPER:
+		return capa->request_initial;
+	case CREDENTIAL_OP_RESPONSE:
+		return capa->request_initial && capa->request_helper;
+	default:
+		return 0;
+	}
+}
+
+int credential_read(struct credential *c, FILE *fp, int op_type)
 {
 	struct strbuf line = STRBUF_INIT;
 
@@ -249,6 +286,8 @@ int credential_read(struct credential *c, FILE *fp)
 			c->path = xstrdup(value);
 		} else if (!strcmp(key, "wwwauth[]")) {
 			strvec_push(&c->wwwauth_headers, value);
+		} else if (!strcmp(key, "capability[]") && !strcmp(value, "authtype")) {
+			credential_set_capability(&c->capa_authtype, op_type);
 		} else if (!strcmp(key, "password_expiry_utc")) {
 			errno = 0;
 			c->password_expiry_utc = parse_timestamp(value, NULL, 10);
@@ -288,14 +327,18 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
-void credential_write(const struct credential *c, FILE *fp)
+void credential_write(const struct credential *c, FILE *fp, int op_type)
 {
+	if (credential_has_capability(&c->capa_authtype, op_type)) {
+		credential_write_item(fp, "capability[]", "authtype", 0);
+		credential_write_item(fp, "authtype", c->authtype, 0);
+		credential_write_item(fp, "credential", c->credential, 0);
+	}
 	credential_write_item(fp, "protocol", c->protocol, 1);
 	credential_write_item(fp, "host", c->host, 1);
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
-	credential_write_item(fp, "credential", c->credential, 0);
 	credential_write_item(fp, "oauth_refresh_token", c->oauth_refresh_token, 0);
 	if (c->password_expiry_utc != TIME_MAX) {
 		char *s = xstrfmt("%"PRItime, c->password_expiry_utc);
@@ -304,7 +347,6 @@ void credential_write(const struct credential *c, FILE *fp)
 	}
 	for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
 		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
-	credential_write_item(fp, "authtype", c->authtype, 0);
 }
 
 static int run_credential_helper(struct credential *c,
@@ -327,14 +369,14 @@ static int run_credential_helper(struct credential *c,
 
 	fp = xfdopen(helper.in, "w");
 	sigchain_push(SIGPIPE, SIG_IGN);
-	credential_write(c, fp);
+	credential_write(c, fp, want_output ? CREDENTIAL_OP_HELPER : CREDENTIAL_OP_RESPONSE);
 	fclose(fp);
 	sigchain_pop(SIGPIPE);
 
 	if (want_output) {
 		int r;
 		fp = xfdopen(helper.out, "r");
-		r = credential_read(c, fp);
+		r = credential_read(c, fp, CREDENTIAL_OP_HELPER);
 		fclose(fp);
 		if (r < 0) {
 			finish_command(&helper);
@@ -367,7 +409,7 @@ static int credential_do(struct credential *c, const char *helper,
 	return r;
 }
 
-void credential_fill(struct credential *c)
+void credential_fill(struct credential *c, int all_capabilities)
 {
 	int i;
 
@@ -375,6 +417,8 @@ void credential_fill(struct credential *c)
 		return;
 
 	credential_apply_config(c);
+	if (all_capabilities)
+		credential_set_all_capabilities(c);
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
diff --git a/credential.h b/credential.h
index 9db892cf4d..2051d04c5a 100644
--- a/credential.h
+++ b/credential.h
@@ -93,6 +93,25 @@
  * -----------------------------------------------------------------------
  */
 
+/*
+ * These values define the kind of operation we're performing and the
+ * capabilities at each stage.  The first is either an external request (via git
+ * credential fill) or an internal request (e.g., via the HTTP) code.  The
+ * second is the call to the credential helper, and the third is the response
+ * we're providing.
+ *
+ * At each stage, we will emit the capability only if the previous stage
+ * supported it.
+ */
+#define CREDENTIAL_OP_INITIAL  1
+#define CREDENTIAL_OP_HELPER   2
+#define CREDENTIAL_OP_RESPONSE 3
+
+struct credential_capability {
+	unsigned request_initial:1,
+		 request_helper:1,
+		 response:1;
+};
 
 /**
  * This struct represents a single username/password combination
@@ -136,6 +155,8 @@ struct credential {
 		 use_http_path:1,
 		 username_from_proto:1;
 
+	struct credential_capability capa_authtype;
+
 	char *username;
 	char *password;
 	char *credential;
@@ -174,8 +195,11 @@ void credential_clear(struct credential *);
  * returns, the username and password fields of the credential are
  * guaranteed to be non-NULL. If an error occurs, the function will
  * die().
+ *
+ * If all_capabilities is set, this is an internal user that is prepared
+ * to deal with all known capabilities, and we should advertise that fact.
  */
-void credential_fill(struct credential *);
+void credential_fill(struct credential *, int all_capabilities);
 
 /**
  * Inform the credential subsystem that the provided credentials
@@ -198,8 +222,8 @@ void credential_approve(struct credential *);
  */
 void credential_reject(struct credential *);
 
-int credential_read(struct credential *, FILE *);
-void credential_write(const struct credential *, FILE *);
+int credential_read(struct credential *, FILE *, int);
+void credential_write(const struct credential *, FILE *, int);
 
 /*
  * Parse a url into a credential struct, replacing any existing contents.
diff --git a/http.c b/http.c
index 1c2200da77..4f5df6fb14 100644
--- a/http.c
+++ b/http.c
@@ -569,7 +569,7 @@ static void init_curl_http_auth(CURL *result)
 		return;
 	}
 
-	credential_fill(&http_auth);
+	credential_fill(&http_auth, 0);
 
 	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
 	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
@@ -596,7 +596,7 @@ static void init_curl_proxy_auth(CURL *result)
 {
 	if (proxy_auth.username) {
 		if (!proxy_auth.password)
-			credential_fill(&proxy_auth);
+			credential_fill(&proxy_auth, 0);
 		set_proxyauth_name_password(result);
 	}
 
@@ -630,7 +630,7 @@ static int has_cert_password(void)
 		cert_auth.host = xstrdup("");
 		cert_auth.username = xstrdup("");
 		cert_auth.path = xstrdup(ssl_cert);
-		credential_fill(&cert_auth);
+		credential_fill(&cert_auth, 0);
 	}
 	return 1;
 }
@@ -645,7 +645,7 @@ static int has_proxy_cert_password(void)
 		proxy_cert_auth.host = xstrdup("");
 		proxy_cert_auth.username = xstrdup("");
 		proxy_cert_auth.path = xstrdup(http_proxy_ssl_cert);
-		credential_fill(&proxy_cert_auth);
+		credential_fill(&proxy_cert_auth, 0);
 	}
 	return 1;
 }
@@ -2191,7 +2191,7 @@ static int http_request_reauth(const char *url,
 		BUG("Unknown http_request target");
 	}
 
-	credential_fill(&http_auth);
+	credential_fill(&http_auth, 0);
 
 	return http_request(url, result, target, options);
 }
diff --git a/imap-send.c b/imap-send.c
index f2e1947e63..8c89e866b6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -944,7 +944,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
 
-	credential_fill(cred);
+	credential_fill(cred, 1);
 
 	if (!srvc->user)
 		srvc->user = xstrdup(cred->username);
diff --git a/remote-curl.c b/remote-curl.c
index e37eaa17b7..f96bda2431 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -926,7 +926,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		do {
 			err = probe_rpc(rpc, &results);
 			if (err == HTTP_REAUTH)
-				credential_fill(&http_auth);
+				credential_fill(&http_auth, 0);
 		} while (err == HTTP_REAUTH);
 		if (err != HTTP_OK)
 			return -1;
@@ -1044,7 +1044,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	rpc->any_written = 0;
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
-		credential_fill(&http_auth);
+		credential_fill(&http_auth, 0);
 		curl_slist_free_all(headers);
 		goto retry;
 	}
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 400f6bdbca..8477108b28 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -12,7 +12,13 @@ test_expect_success 'setup helper scripts' '
 	IFS==
 	while read key value; do
 		echo >&2 "$whoami: $key=$value"
-		eval "$key=$value"
+		if test -z "${key%%*\[\]}"
+		then
+			key=${key%%\[\]}
+			eval "$key=\"\$$key $value\""
+		else
+			eval "$key=$value"
+		fi
 	done
 	IFS=$OIFS
 	EOF
@@ -35,6 +41,16 @@ test_expect_success 'setup helper scripts' '
 	test -z "$pass" || echo password=$pass
 	EOF
 
+	write_script git-credential-verbatim-cred <<-\EOF &&
+	authtype=$1; shift
+	credential=$1; shift
+	. ./dump
+	echo capability[]=authtype
+	test -z "${capability##*authtype*}" || return
+	test -z "$authtype" || echo authtype=$authtype
+	test -z "$credential" || echo credential=$credential
+	EOF
+
 	write_script git-credential-verbatim-with-expiry <<-\EOF &&
 	user=$1; shift
 	pass=$1; shift
@@ -64,6 +80,26 @@ test_expect_success 'credential_fill invokes helper' '
 	EOF
 '
 
+test_expect_success 'credential_fill invokes helper with credential' '
+	check fill "verbatim-cred Bearer token" <<-\EOF
+	capability[]=authtype
+	protocol=http
+	host=example.com
+	--
+	capability[]=authtype
+	authtype=Bearer
+	credential=token
+	protocol=http
+	host=example.com
+	--
+	verbatim-cred: get
+	verbatim-cred: capability[]=authtype
+	verbatim-cred: protocol=http
+	verbatim-cred: host=example.com
+	EOF
+'
+
+
 test_expect_success 'credential_fill invokes multiple helpers' '
 	check fill useless "verbatim foo bar" <<-\EOF
 	protocol=http
@@ -83,6 +119,42 @@ test_expect_success 'credential_fill invokes multiple helpers' '
 	EOF
 '
 
+test_expect_success 'credential_fill response does not get capabilities when helpers are incapable' '
+	check fill useless "verbatim foo bar" <<-\EOF
+	capability[]=authtype
+	protocol=http
+	host=example.com
+	--
+	protocol=http
+	host=example.com
+	username=foo
+	password=bar
+	--
+	useless: get
+	useless: capability[]=authtype
+	useless: protocol=http
+	useless: host=example.com
+	verbatim: get
+	verbatim: capability[]=authtype
+	verbatim: protocol=http
+	verbatim: host=example.com
+	EOF
+'
+
+test_expect_success 'credential_fill response does not get capabilities when caller is incapable' '
+	check fill "verbatim-cred Bearer token" <<-\EOF
+	protocol=http
+	host=example.com
+	--
+	protocol=http
+	host=example.com
+	--
+	verbatim-cred: get
+	verbatim-cred: protocol=http
+	verbatim-cred: host=example.com
+	EOF
+'
+
 test_expect_success 'credential_fill stops when we get a full response' '
 	check fill "verbatim one two" "verbatim three four" <<-\EOF
 	protocol=http
@@ -99,6 +171,25 @@ test_expect_success 'credential_fill stops when we get a full response' '
 	EOF
 '
 
+test_expect_success 'credential_fill thinks a credential is a full response' '
+	check fill "verbatim-cred Bearer token" "verbatim three four" <<-\EOF
+	capability[]=authtype
+	protocol=http
+	host=example.com
+	--
+	capability[]=authtype
+	authtype=Bearer
+	credential=token
+	protocol=http
+	host=example.com
+	--
+	verbatim-cred: get
+	verbatim-cred: capability[]=authtype
+	verbatim-cred: protocol=http
+	verbatim-cred: host=example.com
+	EOF
+'
+
 test_expect_success 'credential_fill continues through partial response' '
 	check fill "verbatim one \"\"" "verbatim two three" <<-\EOF
 	protocol=http
@@ -175,6 +266,20 @@ test_expect_success 'credential_fill passes along metadata' '
 	EOF
 '
 
+test_expect_success 'credential_fill produces no credential without capability' '
+	check fill "verbatim-cred Bearer token" <<-\EOF
+	protocol=http
+	host=example.com
+	--
+	protocol=http
+	host=example.com
+	--
+	verbatim-cred: get
+	verbatim-cred: protocol=http
+	verbatim-cred: host=example.com
+	EOF
+'
+
 test_expect_success 'credential_approve calls all helpers' '
 	check approve useless "verbatim one two" <<-\EOF
 	protocol=http
