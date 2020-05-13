Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA5DC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164DA205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="poMhFgga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390598AbgEMTNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390588AbgEMTNA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:13:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836DEC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:13:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i62so856813ybc.11
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8F6xDckkOakXEp5gZKjehDdJH7YrD+m+yewgY4GBvhY=;
        b=poMhFggaYAdqhnCvsuQFsUTRgYXv85TJFrdEzjKU8LXflKivtW8elIjn3KRN5f9nBE
         BpSDMW0m1QIihuxWjjK1McnYWDj/2kXLC4znr+1dHQJFkbnSaSTxuqJk480GcLdpnnCu
         EcSgbATzJWFqIif/UaRp8mr5mJZKp706dq2IwtY+gCOl+kvNUy9Nd2cWwyRTlmoywDL6
         jXXrIJQ7uoAE1qiaQcGHvKueZgzImngb0jJ9JLHtnTP5s6bOea/lZQajEECyd5jjRX1Z
         bL55nL97uTa9qVJq7NrsNXP+MFs3WJZ0doZ1uEtugSp4gAfkujNDKtC/cKA9aXlf/8Ah
         x/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8F6xDckkOakXEp5gZKjehDdJH7YrD+m+yewgY4GBvhY=;
        b=ZLQR+lIk7mkWQTj3EAZIJcxC/SAdUxvAdg5pcHeo+KjKOWpdTcwtYqDr/cWgZsgEpf
         tKRMk/CJLSx+birXjRVJx9dxB7a8b30Vp4ZSbvvL7kJ5ad9Pcwn0wV634MSCWoBQCFLs
         Sj47kVWo/lCzA8Dia+O+pxP8QrMERgwd+5KNI8wkP4PFcdD1iz5UlRLVyzrEvBTDcp7O
         KmWpZ+FFwQn2Wm1KLEdsrMu0uAAgf1Fkdes1lf+Z9KqmHIsv8vdeIOICnoFlQDCubsvs
         v4SBfTZiX6XhFjd0Tc4gxBTVim4zRlgDVWz2+VJQGd/7OKz8t0e91JTXBWXiLAhwtPOR
         AgUA==
X-Gm-Message-State: AOAM530z9n1JBpzTnYrVKQY5P0pCPIxoZVednUL2xvxkdH/EEH/V7/x7
        dzng27Jbb1sO4PbsNkizgkP1KRODVCAW7QzHzvA73ipeUDTKbofRtbX8VBY0ldH5SW+eAOT9RGn
        /Kndspq0xt9tVLsM69RFfCO5Z5wGWrkzgelxcGo2Q5YSw635bhnJaTrDx+cyncTU5PLLG/MNSHf
        T4
X-Google-Smtp-Source: ABdhPJw7n73+YwCsX9Ayv2IPZncYzrsQ9cDeGA0lch/FKMdQAqoHhgZH73IkjbgVrmwc76SFF24+RuW5lZGz8JRO8UB7
X-Received: by 2002:a25:e8a:: with SMTP id 132mr832897ybo.425.1589397179583;
 Wed, 13 May 2020 12:12:59 -0700 (PDT)
Date:   Wed, 13 May 2020 12:12:48 -0700
In-Reply-To: <cover.1589394456.git.jonathantanmy@google.com>
Message-Id: <f5a29e8fa1c97a80237b2f1414536c75a9911060.1589394456.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1589218693.git.jonathantanmy@google.com> <cover.1589394456.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v2 3/3] http, imap-send: stop using CURLOPT_VERBOSE
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        sandals@crustytoothpaste.net, gitster@pobox.com, peff@peff.net
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
index af98cd7dc2..43a440bae4 100644
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
index 77eac95d64..d0cea72cbd 100644
--- a/http.c
+++ b/http.c
@@ -806,6 +806,12 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
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
@@ -996,7 +1002,7 @@ static CURL *get_curl_handle(void)
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
index eeecfe01d7..209f2f8427 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -207,6 +207,18 @@ test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_REDACT_A
 	grep "Authorization: Basic [0-9a-zA-Z+/]" trace
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
@@ -464,6 +476,18 @@ test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
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

