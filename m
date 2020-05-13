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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786E9C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2536B2054F
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BV6OhcPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbgEMTM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390588AbgEMTM7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:12:59 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3FC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:12:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b7so519059qkk.6
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rk25Qngqf87losHmTmrScdq2cP+siG5cCYmqHvFGzHY=;
        b=BV6OhcPguIRSDtWcYuhSFMi+Tosbg98W6CL5HC/8BYnA8/Poe1NVgjZnuM7Q74P0C0
         Z6EdDKPv7fBlmbeOLz3iJa5bsmUA2lYJfVx4UlW0gCIYpoIAD6NobHZWOochpj109SJy
         g41eD01S9JaUDUizLtdqNFTVxpZKWmbQ+TIYHL9lFa3dnQIw6O1E4tlLXo8VsYjDRZEk
         7H3zR7sFlfVr98u6I2l/xcnL9oTQDhsYoxvv6WAoDPU8KO+aiJyC9MPVX7GujxQ2XOAA
         QAyC+qtAlxV99YAXXuSYuCPqqBW/UoekPrC1zymTy5m3pmqFqxUVP3TRD9juYWd+SWBa
         Yx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rk25Qngqf87losHmTmrScdq2cP+siG5cCYmqHvFGzHY=;
        b=UcJTehaDvQ731SBPgqKhA/2I0+pqsI+7Z4zdzGFYnk/Ox6QCqs4tcJDNoYKMDt3/4y
         iC8YSZK1Ron8+ufvMGm95QaccKOnE0MOSDORZs5GLv7FMMW/EflFU/dFutxb1qAFjkVW
         3ZHZNnSQyAsPJOnFnLl6tjrF66ZZ+VQdosCyLUj85VRxBcSLSo3fb/cB9GEOnLRMmmu2
         w5IQwbJLovyB4nEsXFQ9sKtPgwxHUtugCDSKMWyZdopkM0TgDmxRmpT1eBAdGhJqu+nd
         ekMAjqU8bNiVPdoRuYJ0YivRjrxqGdHiI2VoaBK9dkY8C7RjtohBJ7FvcxZg9z2u9f0f
         4kWw==
X-Gm-Message-State: AOAM532lwvWvvzB8ZiE1mk1EfJZjYcCq0Fi13Bts/FHB7CCzrRyhn48h
        pdXuh7tKBW0gakCC2JVpEqg4qChe8VXRI7MIi7/itJQRGBVsx1uBXM0Ot9lGRo/on6COm1cTzrZ
        B2ciyJjyECeoWus7DsSFm97tkYzha+16PmxOZR4ZdpxhSh8hC4bY+yoTbg9v10V3ZcCHgtihNqs
        4a
X-Google-Smtp-Source: ABdhPJxTvo4mZEWeQ+DSgZP3C7ovJJXk793pCVjjZQAePys93OJxnFlUoqxO/X9rsTco4GHcOYV0jdS8ghNy38LHnmaf
X-Received: by 2002:a0c:e403:: with SMTP id o3mr1152804qvl.24.1589397178014;
 Wed, 13 May 2020 12:12:58 -0700 (PDT)
Date:   Wed, 13 May 2020 12:12:47 -0700
In-Reply-To: <cover.1589394456.git.jonathantanmy@google.com>
Message-Id: <8c70a45b24861290b64d4487383bdfa5960332ab.1589394456.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1589218693.git.jonathantanmy@google.com> <cover.1589394456.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v2 2/3] http: make GIT_TRACE_CURL auth redaction optional
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        sandals@crustytoothpaste.net, gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, auth headers are redacted when a trace is output through
GIT_TRACE_CURL. Allow the user to inhibit this redaction through an
environment variable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git.txt       |  6 ++++++
 http.c                      | 11 +++++++++--
 t/t5551-http-fetch-smart.sh | 10 ++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9d6769e95a..af98cd7dc2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -777,6 +777,12 @@ for full details.
 	See `GIT_TRACE2` for available trace output options and
 	link:technical/api-trace2.html[Trace2 documentation] for full details.
 
+`GIT_REDACT_AUTHORIZATION`::
+	By default, when a curl trace is enabled (see `GIT_TRACE_CURL` above),
+	the values of "Authorization:" and "Proxy-Authorization:" headers in
+	the trace are redacted. Set this variable to `0` to prevent this
+	redaction.
+
 `GIT_REDACT_COOKIES`::
 	This can be set to a comma-separated list of strings. When a curl trace
 	is enabled (see `GIT_TRACE_CURL` above), whenever a "Cookies:" header
diff --git a/http.c b/http.c
index 62aa995245..77eac95d64 100644
--- a/http.c
+++ b/http.c
@@ -18,6 +18,7 @@
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
+static int trace_curl_redact_authorization = 1;
 static struct string_list cookies_to_redact = STRING_LIST_INIT_DUP;
 #if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
@@ -642,8 +643,9 @@ static void redact_sensitive_header(struct strbuf *header)
 {
 	const char *sensitive_header;
 
-	if (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
-	    skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_header)) {
+	if (trace_curl_redact_authorization &&
+	    (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
+	     skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
 		/* The first token is the type, which is OK to log */
 		while (isspace(*sensitive_header))
 			sensitive_header++;
@@ -859,6 +861,7 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
 static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
+	const char *redact_authorization_envvar;
 
 	if (!result)
 		die("curl_easy_init failed");
@@ -997,6 +1000,10 @@ static CURL *get_curl_handle(void)
 	setup_curl_trace(result);
 	if (getenv("GIT_TRACE_CURL_NO_DATA"))
 		trace_curl_data = 0;
+	redact_authorization_envvar = getenv("GIT_REDACT_AUTHORIZATION");
+	if (redact_authorization_envvar &&
+	    !strcmp(redact_authorization_envvar, "0"))
+		trace_curl_redact_authorization = 0;
 	if (getenv("GIT_REDACT_COOKIES")) {
 		string_list_split(&cookies_to_redact,
 				  getenv("GIT_REDACT_COOKIES"), ',', -1);
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index acc8473a72..eeecfe01d7 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -197,6 +197,16 @@ test_expect_success 'GIT_TRACE_CURL redacts auth details' '
 	grep "Authorization: Basic <redacted>" trace
 '
 
+test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_REDACT_AUTHORIZATION=0' '
+	rm -rf redact-auth trace &&
+	set_askpass user@host pass@host &&
+	GIT_REDACT_AUTHORIZATION=0 GIT_TRACE_CURL="$(pwd)/trace" \
+		git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
+	expect_askpass both user@host &&
+
+	grep "Authorization: Basic [0-9a-zA-Z+/]" trace
+'
+
 test_expect_success 'disable dumb http on server' '
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
 		config http.getanyfile false
-- 
2.26.2.645.ge9eca65c58-goog

