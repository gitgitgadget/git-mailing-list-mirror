From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2 1/2] http: allow selection of proxy authentication method
Date: Tue, 26 Jan 2016 13:02:47 +0000
Message-ID: <1453813368-8990-1-git-send-email-gitter.spiros@gmail.com>
Cc: k.franke@science-computing.de,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 14:03:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO3Gz-0001SD-Df
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 14:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933960AbcAZNC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 08:02:56 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34205 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbcAZNCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 08:02:54 -0500
Received: by mail-wm0-f49.google.com with SMTP id u188so105285964wmu.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 05:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AaDJeESFCCGQJMKOUVLF0N8gOYSqgIV7xHt3l24QOo4=;
        b=BNoLlU+0Mqtqv3LG6ObZx52GB4LC1Q/gSXr6ZbGii8Ys0SCq0tMCsG4zRkGJL1SoLD
         9vEOkFhdZVlRtB8l5IQCVD45Y+ZEkvfza0dlMMW1bIJaSEVFtCENzEFcQKX58v2mkarK
         L7ZN0Fnw/KPHyTG80Wl+pCBA7wlFuzcoVQnMEDi5UGj66DWYgMmLrQp3Zsl8a+aZ5u+o
         jeT0lXdc/WA2JoKlgAVRBnzZxUSaj/eSHuKcDshRacQoX4e2hkoLHfcZqb5QbwLcEvs0
         4PYvinH5XdVZwyPvQ6l1nFbs1w0WOUQFJ/QdspXQUUUqY4+MeHfVA71zDamp+Iclay7p
         x3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AaDJeESFCCGQJMKOUVLF0N8gOYSqgIV7xHt3l24QOo4=;
        b=Sek0xvWH8ski2+1mDi4Irm/LAjPEf6QxStk1AqKHWjNtXsqWLS0t/bNTuYxiBZlR/6
         oMMKum5R+cewMoxW48GQq+5y2Ny7PRzGuIbtVbDUI6gSomPhAVJgj9XJrzp/CBzhdaqz
         6a2vHDAyRTglrbmxWrKUUfCgEw92W6Ec9ao2u2QbcNR8CzXzIoVLoa8lKwtnOOb94CxK
         NSncoW5lTeDgdmd75FEgpDFiScEMgAosnraJW0No4UPwxhzgdJtURhDgSOX8VhWru2ES
         F+Trixed2Quf0gbj1i7mBkXf/U8A4Ft9vBvhfuNLXktaB3865ytPTKBfb6nEelxX2OsP
         wI/Q==
X-Gm-Message-State: AG10YOSCWIsR9mtfuqFTAf7SBHPdIxq+JFjn2bQT+pqWEH/HGtsS4ZeqlOEDl7CMR3nn3Q==
X-Received: by 10.194.103.2 with SMTP id fs2mr27107430wjb.36.1453813373271;
        Tue, 26 Jan 2016 05:02:53 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id w194sm10344314wmd.0.2016.01.26.05.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 05:02:52 -0800 (PST)
X-Mailer: git-send-email 2.7.0.77.gc864936
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284811>

From: Knut Franke <k.franke@science-computing.de>

CURLAUTH_ANY does not work with proxies which answer unauthenticated requests
with a 307 redirect to an error page instead of a 407 listing supported
authentication methods. Therefore, allow the authentication method to be set
using the environment variable GIT_HTTP_PROXY_AUTHMETHOD or configuration
variables http.proxyAuthmethod and remote.<name>.proxyAuthmethod (in analogy
to http.proxy and remote.<name>.proxy).

The following values are supported:

* anyauth (default)
* basic
* digest
* negotiate
* ntlm

Signed-off-by: Knut Franke <k.franke@science-computing.de>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Elia Pinto <gitter.spiros@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
This is the second version of the patch,
based on the rebase of kf/http-proxy-auth-methods on origin/next ($gmane/283734).

I have tested that the fix introduced by the commit 6d7afe07
still works properly.
(http://stackoverflow.com/questions/15227130/using-a-socks-proxy-with-git-for-the-http-transport#15228479)

I do not know if it is correct that I add my signed off, if not free to delete it.

 Documentation/config.txt               | 26 ++++++++++++++
 Documentation/technical/api-remote.txt |  4 +++
 http.c                                 | 65 ++++++++++++++++++++++++++++++++--
 remote.c                               |  3 ++
 remote.h                               |  1 +
 5 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877cbc8..0a4d41e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1614,6 +1614,27 @@ http.proxy::
 	`curl(1)`).  This can be overridden on a per-remote basis; see
 	remote.<name>.proxy
 
+http.proxyAuthMethod::
+	Set the method with which to authenticate against the HTTP proxy. This
+	only takes effect if the configured proxy string contains a user name part
+	(i.e. is of the form 'user@host' or 'user@host:port'). This can be
+	overridden on a per-remote basis; see `remote.<name>.proxyAuthMethod`.
+	Both can be overridden by the 'GIT_HTTP_PROXY_AUTHMETHOD' environment
+	variable.  Possible values are:
++
+--
+* `anyauth` - Automatically pick a suitable authentication method. It is
+  assumed that the proxy answers an unauthenticated request with a 407
+  status code and one or more Proxy-authenticate headers with supported
+  authentication methods. This is the default.
+* `basic` - HTTP Basic authentication
+* `digest` - HTTP Digest authentication; this prevents the password from being
+  transmitted to the proxy in clear text
+* `negotiate` - GSS-Negotiate authentication (compare the --negotiate option
+  of `curl(1)`)
+* `ntlm` - NTLM authentication (compare the --ntlm option of `curl(1)`)
+--
+
 http.cookieFile::
 	File containing previously stored cookie lines which should be used
 	in the Git http session, if they match the server. The file format
@@ -2423,6 +2444,11 @@ remote.<name>.proxy::
 	the proxy to use for that remote.  Set to the empty string to
 	disable proxying for that remote.
 
+remote.<name>.proxyAuthMethod::
+	For remotes that require curl (http, https and ftp), the method to use for
+	authenticating against the proxy in use (probably set in
+	`remote.<name>.proxy`). See `http.proxyAuthMethod`.
+
 remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
index 2cfdd22..f10941b 100644
--- a/Documentation/technical/api-remote.txt
+++ b/Documentation/technical/api-remote.txt
@@ -51,6 +51,10 @@ struct remote
 
 	The proxy to use for curl (http, https, ftp, etc.) URLs.
 
+`http_proxy_authmethod`::
+
+	The method used for authenticating against `http_proxy`.
+
 struct remotes can be found by name with remote_get(), and iterated
 through with for_each_remote(). remote_get(NULL) will return the
 default remote, given the current branch and configuration.
diff --git a/http.c b/http.c
index 0da9e66..f46bfc4 100644
--- a/http.c
+++ b/http.c
@@ -62,6 +62,24 @@ static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
+static const char *http_proxy_authmethod;
+static struct {
+	const char *name;
+	long curlauth_param;
+} proxy_authmethods[] = {
+	{ "basic", CURLAUTH_BASIC },
+	{ "digest", CURLAUTH_DIGEST },
+	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
+	{ "ntlm", CURLAUTH_NTLM },
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+	{ "anyauth", CURLAUTH_ANY },
+#endif
+	/*
+	 * CURLAUTH_DIGEST_IE has no corresponding command-line option in
+	 * curl(1) and is not included in CURLAUTH_ANY, so we leave it out
+	 * here, too
+	 */
+};
 static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
@@ -256,6 +274,9 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.proxy", var))
 		return git_config_string(&curl_http_proxy, var, value);
 
+	if (!strcmp("http.proxyauthmethod", var))
+		return git_config_string(&http_proxy_authmethod, var, value);
+
 	if (!strcmp("http.cookiefile", var))
 		return git_config_string(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
@@ -304,6 +325,40 @@ static void init_curl_http_auth(CURL *result)
 #endif
 }
 
+/* *var must be free-able */
+static void var_override(const char **var, char *value)
+{
+	if (value) {
+		free((void *)*var);
+		*var = xstrdup(value);
+	}
+}
+
+static void init_curl_proxy_auth(CURL *result)
+{
+	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
+
+#if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
+	if (http_proxy_authmethod) {
+		int i;
+		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
+			if (!strcmp(http_proxy_authmethod, proxy_authmethods[i].name)) {
+				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
+						proxy_authmethods[i].curlauth_param);
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(proxy_authmethods)) {
+			warning("unsupported proxy authentication method %s: using anyauth",
+					http_proxy_authmethod);
+			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+		}
+	}
+	else
+		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+#endif
+}
+
 static int has_cert_password(void)
 {
 	if (ssl_cert == NULL || ssl_cert_password_required != 1)
@@ -476,9 +531,7 @@ static CURL *get_curl_handle(void)
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
 #endif
 	}
-#if LIBCURL_VERSION_NUM >= 0x070a07
-	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-#endif
+	init_curl_proxy_auth(result);
 
 	set_curl_keepalive(result);
 
@@ -519,6 +572,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote && remote->http_proxy)
 		curl_http_proxy = xstrdup(remote->http_proxy);
 
+	if (remote)
+		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
+
 	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
 
@@ -617,6 +673,9 @@ void http_cleanup(void)
 		curl_http_proxy = NULL;
 	}
 
+	free((void *)http_proxy_authmethod);
+	http_proxy_authmethod = NULL;
+
 	if (cert_auth.password != NULL) {
 		memset(cert_auth.password, 0, strlen(cert_auth.password));
 		free(cert_auth.password);
diff --git a/remote.c b/remote.c
index 9d34b5a..0bb5a69 100644
--- a/remote.c
+++ b/remote.c
@@ -428,6 +428,9 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
+	} else if (!strcmp(subkey, ".proxyauthmethod")) {
+		return git_config_string((const char **)&remote->http_proxy_authmethod,
+					 key, value);
 	} else if (!strcmp(subkey, ".vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
 	}
diff --git a/remote.h b/remote.h
index 4a039ba..4fd7a0f 100644
--- a/remote.h
+++ b/remote.h
@@ -54,6 +54,7 @@ struct remote {
 	 * for curl remotes only
 	 */
 	char *http_proxy;
+	char *http_proxy_authmethod;
 };
 
 struct remote *remote_get(const char *name);
-- 
2.7.0.77.gc864936
