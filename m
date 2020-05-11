Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C6C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1FF2070B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 17:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgW6ARK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgEKRnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKRnS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 13:43:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C8C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 10:43:17 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f56so11242240qte.18
        for <git@vger.kernel.org>; Mon, 11 May 2020 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uZtyC5CEDbp7Wsxi9KsmtVtelvDOhtdzI3fHUqU9vUM=;
        b=GgW6ARK95vpRvYnf1VrYHQkGUwXaCR9FQh8iZS7FJWaus0HbB4gj0zdEF27TU8iDJO
         M0r5NLDXpXs+ekE7bZLzr3atJrs2bKQQ8tBPiIKRsooaZ8JhDfGUrsQo6Btvzzp4VbuS
         QYwim3tRgavb0KxaX2b3zQmE7Dh6rgMEzBCVdjHL1b6wDq74GzX7vFHU5RpmGQFAI+u7
         mDPF9l59QrNa/8hcPfBtgIRu9bpcz8+pSlhDYS+AG4egpWhE9ead6azv5R0p+q4cKX8o
         32tjq7GLGsXeWpodTOoSFsIKbN1Y1jITFsFEL/kKxRQSbjEB0AbM5bxPY6tF0y+TbRqr
         Qpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uZtyC5CEDbp7Wsxi9KsmtVtelvDOhtdzI3fHUqU9vUM=;
        b=PtAMs6P3MVRCDuLHHXp4jnDyNPZNTzljmNpy+C2Dp4Q4hqIVAx4/kXMvlzpSZ31Pdo
         DFb2ucufU+fz8QOSOmZFVolPQl0ey6+SQX95B13UE52tTLDYZOLjhSssPedixBJws4Mb
         Or0OMTszXRpvybsI021TmVz8LKFBK5k9UrMBvodu/7q5GGCPArgY2n0M/GnJ9u5gf17p
         ZWi+08sMFnOVCU+zN03/gqRr4lr8rA99lg5hAFDrdaImTCM1TA6ebEsCdR+DWfZ7sptc
         IWvP3kNvvbIbUkf46s0vIA9JW3mIKu46M+x6VfJQd5JMndTOU9DKXoingQsFLxSAYq6D
         rqrg==
X-Gm-Message-State: AOAM531t3x8QvqMryCmqMkCGk2VLEZ3BT3h+IemTcEKdQ2HplsVpF4Qp
        xWlQYEQpTISPj+8x2X2dh9GlSEj1sJOmS/R38jWOy9A7H4QEsw7GPTXXBKQchlbKYea+lH/sX2H
        TC2nf4UEirZJDpi1MU2TH8ca1gNTQ0NltMa8LbEOuf4elxf4Jy9fxsCufGdXkIEhLy4efSjl6D/
        uP
X-Google-Smtp-Source: ABdhPJzQqMDsltFpH6DTU2myFHH1rT/stfaCDfSEoZZAYARg8JLVHfoESC8zt+dYvztzmuz1GxTYeOyRYkqEJQhCn1yV
X-Received: by 2002:ad4:57cb:: with SMTP id y11mr401968qvx.26.1589218996192;
 Mon, 11 May 2020 10:43:16 -0700 (PDT)
Date:   Mon, 11 May 2020 10:43:10 -0700
In-Reply-To: <cover.1589218693.git.jonathantanmy@google.com>
Message-Id: <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1589218693.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever GIT_CURL_VERBOSE is set, teach Git to behave as if
GIT_TRACE_CURL=1 and GIT_TRACE_CURL_NO_DATA=1 is set, instead of setting
CURLOPT_VERBOSE.

This is to prevent inadvertent revelation of sensitive data. In
particular, GIT_CURL_VERBOSE redacts neither the "Authorization" header
nor any cookies specified by GIT_REDACT_COOKIES.

Unifying the tracing mechanism also has the future benefit that any
improvements to the tracing mechanism will benefit both users of
GIT_CURL_VERBOSE and GIT_TRACE_CURL, and we do not need to remember to
implement any improvement twice.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git.txt        |  2 --
 http.c                       |  8 +++++++-
 http.h                       |  7 +++++++
 imap-send.c                  |  2 +-
 t/t5551-http-fetch-smart.sh  | 24 ++++++++++++++++++++++++
 t/t5581-http-curl-verbose.sh |  2 +-
 trace.c                      | 20 ++++++++++++++++----
 trace.h                      |  6 ++++++
 8 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9d6769e95a..427ea70701 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -721,8 +721,6 @@ of clones and fetches.
 	Enables a curl full trace dump of all incoming and outgoing data,
 	including descriptive information, of the git transport protocol.
 	This is similar to doing curl `--trace-ascii` on the command line.
-	This option overrides setting the `GIT_CURL_VERBOSE` environment
-	variable.
 	See `GIT_TRACE` for available trace output options.
 
 `GIT_TRACE_CURL_NO_DATA`::
diff --git a/http.c b/http.c
index 62aa995245..4882c9f5b2 100644
--- a/http.c
+++ b/http.c
@@ -804,6 +804,12 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 	return 0;
 }
 
+void http_trace_curl_no_data(void)
+{
+	trace_override_envvar(&trace_curl, "1");
+	trace_curl_data = 0;
+}
+
 void setup_curl_trace(CURL *handle)
 {
 	if (!trace_want(&trace_curl))
@@ -993,7 +999,7 @@ static CURL *get_curl_handle(void)
 	warning(_("Protocol restrictions not supported with cURL < 7.19.4"));
 #endif
 	if (getenv("GIT_CURL_VERBOSE"))
-		curl_easy_setopt(result, CURLOPT_VERBOSE, 1L);
+		http_trace_curl_no_data();
 	setup_curl_trace(result);
 	if (getenv("GIT_TRACE_CURL_NO_DATA"))
 		trace_curl_data = 0;
diff --git a/http.h b/http.h
index 5e0ad724f9..faf8cbb0d1 100644
--- a/http.h
+++ b/http.h
@@ -252,6 +252,13 @@ int finish_http_object_request(struct http_object_request *freq);
 void abort_http_object_request(struct http_object_request *freq);
 void release_http_object_request(struct http_object_request *freq);
 
+/*
+ * Instead of using environment variables to determine if curl tracing happens,
+ * behave as if GIT_TRACE_CURL=1 and GIT_TRACE_CURL_NO_DATA=1 is set. Call this
+ * before calling setup_curl_trace().
+ */
+void http_trace_curl_no_data(void);
+
 /* setup routine for curl_easy_setopt CURLOPT_DEBUGFUNCTION */
 void setup_curl_trace(CURL *handle);
 #endif /* HTTP_H */
diff --git a/imap-send.c b/imap-send.c
index 6c54d8c29d..52737546f3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1464,7 +1464,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
-		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+		http_trace_curl_no_data();
 	setup_curl_trace(curl);
 
 	return curl;
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index acc8473a72..be01cf7bb2 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -197,6 +197,18 @@ test_expect_success 'GIT_TRACE_CURL redacts auth details' '
 	grep "Authorization: Basic <redacted>" trace
 '
 
+test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
+	rm -rf redact-auth trace &&
+	set_askpass user@host pass@host &&
+	GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth 2>trace &&
+	expect_askpass both user@host &&
+
+	# Ensure that there is no "Basic" followed by a base64 string, but that
+	# the auth details are redacted
+	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
+	grep "Authorization: Basic <redacted>" trace
+'
+
 test_expect_success 'disable dumb http on server' '
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
 		config http.getanyfile false
@@ -454,6 +466,18 @@ test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
 	! grep "Cookie:.*Bar=2" err
 '
 
+test_expect_success 'GIT_REDACT_COOKIES redacts cookies when GIT_CURL_VERBOSE=1' '
+	rm -rf clone &&
+	echo "Set-Cookie: Foo=1" >cookies &&
+	echo "Set-Cookie: Bar=2" >>cookies &&
+	GIT_CURL_VERBOSE=1 GIT_REDACT_COOKIES=Bar,Baz \
+		git -c "http.cookieFile=$(pwd)/cookies" clone \
+		$HTTPD_URL/smart/repo.git clone 2>err &&
+	grep "Cookie:.*Foo=1" err &&
+	grep "Cookie:.*Bar=<redacted>" err &&
+	! grep "Cookie:.*Bar=2" err
+'
+
 test_expect_success 'GIT_REDACT_COOKIES handles empty values' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=" >cookies &&
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index 5129b0724f..927aad0820 100755
--- a/t/t5581-http-curl-verbose.sh
+++ b/t/t5581-http-curl-verbose.sh
@@ -20,7 +20,7 @@ test_expect_success 'failure in git-upload-pack is shown' '
 	test_might_fail env GIT_CURL_VERBOSE=1 \
 		git clone "$HTTPD_URL/error_git_upload_pack/smart/repo.git" \
 		2>curl_log &&
-	grep "< HTTP/1.1 500 Intentional Breakage" curl_log
+	grep "<= Recv header: HTTP/1.1 500 Intentional Breakage" curl_log
 '
 
 test_done
diff --git a/trace.c b/trace.c
index b3ef0e627f..f726686fd9 100644
--- a/trace.c
+++ b/trace.c
@@ -29,7 +29,7 @@ struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
 struct trace_key trace_setup_key = TRACE_KEY_INIT(SETUP);
 
 /* Get a trace file descriptor from "key" env variable. */
-static int get_trace_fd(struct trace_key *key)
+static int get_trace_fd(struct trace_key *key, const char *override_envvar)
 {
 	const char *trace;
 
@@ -37,7 +37,7 @@ static int get_trace_fd(struct trace_key *key)
 	if (key->initialized)
 		return key->fd;
 
-	trace = getenv(key->key);
+	trace = override_envvar ? override_envvar : getenv(key->key);
 
 	if (!trace || !strcmp(trace, "") ||
 	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
@@ -68,6 +68,18 @@ static int get_trace_fd(struct trace_key *key)
 	return key->fd;
 }
 
+void trace_override_envvar(struct trace_key *key, const char *value)
+{
+	trace_disable(key);
+	key->initialized = 0;
+
+	/*
+	 * Invoke get_trace_fd() to initialize key using the given value
+	 * instead of the value of the environment variable.
+	 */
+	get_trace_fd(key, value);
+}
+
 void trace_disable(struct trace_key *key)
 {
 	if (key->need_close)
@@ -112,7 +124,7 @@ static int prepare_trace_line(const char *file, int line,
 
 static void trace_write(struct trace_key *key, const void *buf, unsigned len)
 {
-	if (write_in_full(get_trace_fd(key), buf, len) < 0) {
+	if (write_in_full(get_trace_fd(key, NULL), buf, len) < 0) {
 		warning("unable to write trace for %s: %s",
 			key->key, strerror(errno));
 		trace_disable(key);
@@ -383,7 +395,7 @@ void trace_repo_setup(const char *prefix)
 
 int trace_want(struct trace_key *key)
 {
-	return !!get_trace_fd(key);
+	return !!get_trace_fd(key, NULL);
 }
 
 #if defined(HAVE_CLOCK_GETTIME) && defined(HAVE_CLOCK_MONOTONIC)
diff --git a/trace.h b/trace.h
index 9826618b33..0dbbad0e41 100644
--- a/trace.h
+++ b/trace.h
@@ -101,6 +101,12 @@ void trace_repo_setup(const char *prefix);
  */
 int trace_want(struct trace_key *key);
 
+/**
+ * Enables or disables tracing for the specified key, as if the environment
+ * variable was set to the given value.
+ */
+void trace_override_envvar(struct trace_key *key, const char *value);
+
 /**
  * Disables tracing for the specified key, even if the environment variable
  * was set.
-- 
2.26.2.645.ge9eca65c58-goog

