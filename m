Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03365C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 21:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C599E2074B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 21:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXYCP1GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgFEVVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEVVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 17:21:42 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9326C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 14:21:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id l184so8793055qkb.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=s1y+FP8XPH1iJst/S21XMnBw1p/joqLZLNr08jtyEbk=;
        b=cXYCP1GRKMl37LlsfUJ+6o3AX/8L4Kbkq66AWAtXmFC7qNezFZQr9/OXk9b2FK1sI1
         IL/l6QgDa3RpXXp5UpH8qVmeSNJYy3io7TM4me3VB3Qm0Qiv2G8V9ChgrwWrmbII8TAV
         qn3B3UTx5NFlw4yNi0frsaKGrLl8o6uUtPALmU/5D9F4mxbYnJjp1guyoLMHD++2bG3/
         Fbo82a+wyq4pmlJDYlTwzb7UcNsekp+dlbnMCoa6w4NY1gydTMrx5bT1zycOqY+cYYmb
         08fGM3rNdcastloiAiq5HpABPNkkPeYAasuOgDARQ9K0A4QV9uyxuHIsq8k+bTJmQzhO
         qQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=s1y+FP8XPH1iJst/S21XMnBw1p/joqLZLNr08jtyEbk=;
        b=AdS/Ps7ZcU3lmQIvt1OurhWot6KWwDt6dwczkd5Pj2M5ceDWXjvU/snhej+NMigQ9O
         5dJ+0tYFEyhdd2lvSuiosdzDfaHS0zSwQ0kT4tNsxBWXWfVILS2g8G+EEx42Py7tfCQn
         XNK9WNQen3MFf8rwnHEBgQJx1eNeAt94b8Qzcxv+PohETk/JcC4ekhreHwdssufwvfaQ
         3ygNZIk0rBMqLHkUb84sVxnY9jPVKkpBnb2PpDiy8W5dLysf0I/LtELMLP0t/u/lxZ0Z
         wXNycZ34uJx7GEwniJOeqqJ4NlLnCWp/ddvlxN8id8EiAwznMgTnMFAGbJtXcGjCsxSB
         5a1w==
X-Gm-Message-State: AOAM5317AHQmml4TVycMM7WxHhezE0Z7tgogya5/vXIxzRGaPqQoja5y
        8lRE7D29wWDCl/YmrLO0i2KAh7sWcktnuOSuYwnwzdVIcYm67o9CKutFfOyg2NSejK03JjDqTVT
        G1c7mc8nh73YyA9vHEQFYzv2TB4rhRbPqvBRasYrkw8K4674w7E0fzVGQ4BhqK2yP63sgF0xcmg
        Fm
X-Google-Smtp-Source: ABdhPJxqa5iot6Aa6noBbkHjKkiohTZmUjgBMWM/m+vTQ5oM0VueQ9k2VIezErMy2c4wDS9AJTRTaxK555a1NuwEKkom
X-Received: by 2002:a0c:f78a:: with SMTP id s10mr11881491qvn.32.1591392099709;
 Fri, 05 Jun 2020 14:21:39 -0700 (PDT)
Date:   Fri,  5 Jun 2020 14:21:36 -0700
Message-Id: <20200605212136.227468-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] http: redact all cookies, teach GIT_TRACE_REDACT=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In trace output (when GIT_TRACE_CURL is true), redact the values of all
HTTP cookies by default. Now that auth headers (since the implementation
of GIT_TRACE_CURL in 74c682d3c6 ("http.c: implement the GIT_TRACE_CURL
environment variable", 2016-05-24)) and cookie values (since this
commit) are redacted by default in these traces, also allow the user to
inhibit these redactions through an environment variable.

Since values of all cookies are now redacted by default,
GIT_REDACT_COOKIES (which previously allowed users to select individual
cookies to redact) now has no effect.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on jt/curl-verbose-on-trace-curl.

Thanks, Junio, for the reminder in What's Cooking.

This is a followup from this email thread:
https://lore.kernel.org/git/cover.1589218693.git.jonathantanmy@google.com/

I took a look at transport_anonymize_url() as requested in [1], which
indeed appears in user-visible output (and could conceivably be used in
debugging). It can be done (just be careful about the different uses -
send-pack uses it to make a push cert, so that can't be changed, but we
can change it when it is used to print a message for the user). But it
doesn't seem useful to me (for HTTP(S), we would be better off looking
at the Authorization header, I think, and for SSH, the password is
either wrong or correct, so I don't think that there is much Git-related
stuff to debug), and I can't think of a good name to give the
environment variable that controls all these. (Right now we have
GIT_TRACE_REDACT, which makes sense because we are redacting a trace.
GIT_HTTP_REDACT would work too, because everything we're redacting is
HTTP-related. But the URL is neither HTTP-specific nor trace-specific.)

Having said that, if we want one single environment variable to redact
everything, it's probably best to do it now. It would be unexpected if
an environment variable suddenly also controls redaction of the URL.

[1] https://lore.kernel.org/git/xmqqlflvtysu.fsf@gitster.c.googlers.com/
---
 Documentation/git.txt       |  9 ++++-----
 http.c                      | 35 +++++++++++-----------------------
 t/t5551-http-fetch-smart.sh | 38 +++++++++++++++++++++++--------------
 3 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 427ea70701..d451f465dc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -775,11 +775,10 @@ for full details.
 	See `GIT_TRACE2` for available trace output options and
 	link:technical/api-trace2.html[Trace2 documentation] for full details.
 
-`GIT_REDACT_COOKIES`::
-	This can be set to a comma-separated list of strings. When a curl trace
-	is enabled (see `GIT_TRACE_CURL` above), whenever a "Cookies:" header
-	sent by the client is dumped, values of cookies whose key is in that
-	list (case-sensitive) are redacted.
+`GIT_TRACE_REDACT`::
+	By default, when tracing is activated, Git redacts the values of
+	cookies, the "Authorization:" header, and the "Proxy-Authorization:"
+	header. Set this variable to `0` to prevent this redaction.
 
 `GIT_LITERAL_PATHSPECS`::
 	Setting this variable to `1` will cause Git to treat all
diff --git a/http.c b/http.c
index 4882c9f5b2..0eb1931a15 100644
--- a/http.c
+++ b/http.c
@@ -18,7 +18,7 @@
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
-static struct string_list cookies_to_redact = STRING_LIST_INIT_DUP;
+static int trace_curl_redact = 1;
 #if LIBCURL_VERSION_NUM >= 0x070a08
 long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
 #else
@@ -642,8 +642,9 @@ static void redact_sensitive_header(struct strbuf *header)
 {
 	const char *sensitive_header;
 
-	if (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
-	    skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_header)) {
+	if (trace_curl_redact &&
+	    (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
+	     skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
 		/* The first token is the type, which is OK to log */
 		while (isspace(*sensitive_header))
 			sensitive_header++;
@@ -652,20 +653,15 @@ static void redact_sensitive_header(struct strbuf *header)
 		/* Everything else is opaque and possibly sensitive */
 		strbuf_setlen(header,  sensitive_header - header->buf);
 		strbuf_addstr(header, " <redacted>");
-	} else if (cookies_to_redact.nr &&
+	} else if (trace_curl_redact &&
 		   skip_prefix(header->buf, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
-		char *cookie;
+		const char *cookie;
 
 		while (isspace(*sensitive_header))
 			sensitive_header++;
 
-		/*
-		 * The contents of header starting from sensitive_header will
-		 * subsequently be overridden, so it is fine to mutate this
-		 * string (hence the assignment to "char *").
-		 */
-		cookie = (char *) sensitive_header;
+		cookie = sensitive_header;
 
 		while (cookie) {
 			char *equals;
@@ -678,14 +674,8 @@ static void redact_sensitive_header(struct strbuf *header)
 				strbuf_addstr(&redacted_header, cookie);
 				continue;
 			}
-			*equals = 0; /* temporarily set to NUL for lookup */
-			if (string_list_lookup(&cookies_to_redact, cookie)) {
-				strbuf_addstr(&redacted_header, cookie);
-				strbuf_addstr(&redacted_header, "=<redacted>");
-			} else {
-				*equals = '=';
-				strbuf_addstr(&redacted_header, cookie);
-			}
+			strbuf_add(&redacted_header, cookie, equals - cookie);
+			strbuf_addstr(&redacted_header, "=<redacted>");
 			if (semicolon) {
 				/*
 				 * There are more cookies. (Or, for some
@@ -1003,11 +993,8 @@ static CURL *get_curl_handle(void)
 	setup_curl_trace(result);
 	if (getenv("GIT_TRACE_CURL_NO_DATA"))
 		trace_curl_data = 0;
-	if (getenv("GIT_REDACT_COOKIES")) {
-		string_list_split(&cookies_to_redact,
-				  getenv("GIT_REDACT_COOKIES"), ',', -1);
-		string_list_sort(&cookies_to_redact);
-	}
+	if (!git_env_bool("GIT_TRACE_REDACT", 1))
+		trace_curl_redact = 0;
 
 	curl_easy_setopt(result, CURLOPT_USERAGENT,
 		user_agent ? user_agent : git_user_agent());
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index be01cf7bb2..e40e9ed52f 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -209,6 +209,16 @@ test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
 	grep "Authorization: Basic <redacted>" trace
 '
 
+test_expect_success 'GIT_TRACE_CURL does not redact auth details if GIT_TRACE_REDACT=0' '
+	rm -rf redact-auth trace &&
+	set_askpass user@host pass@host &&
+	GIT_TRACE_REDACT=0 GIT_TRACE_CURL="$(pwd)/trace" \
+		git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
+	expect_askpass both user@host &&
+
+	grep "Authorization: Basic [0-9a-zA-Z+/]" trace
+'
+
 test_expect_success 'disable dumb http on server' '
 	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
 		config http.getanyfile false
@@ -454,37 +464,37 @@ test_expect_success 'fetch by SHA-1 without tag following' '
 		--no-tags origin $(cat bar_hash)
 '
 
-test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
+test_expect_success 'cookies are redacted by default' '
 	rm -rf clone &&
 	echo "Set-Cookie: Foo=1" >cookies &&
 	echo "Set-Cookie: Bar=2" >>cookies &&
-	GIT_TRACE_CURL=true GIT_REDACT_COOKIES=Bar,Baz \
+	GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep "Cookie:.*Foo=1" err &&
+	grep "Cookie:.*Foo=<redacted>" err &&
 	grep "Cookie:.*Bar=<redacted>" err &&
+	! grep "Cookie:.*Foo=1" err &&
 	! grep "Cookie:.*Bar=2" err
 '
 
-test_expect_success 'GIT_REDACT_COOKIES redacts cookies when GIT_CURL_VERBOSE=1' '
+test_expect_success 'empty values of cookies are also redacted' '
 	rm -rf clone &&
-	echo "Set-Cookie: Foo=1" >cookies &&
-	echo "Set-Cookie: Bar=2" >>cookies &&
-	GIT_CURL_VERBOSE=1 GIT_REDACT_COOKIES=Bar,Baz \
+	echo "Set-Cookie: Foo=" >cookies &&
+	GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep "Cookie:.*Foo=1" err &&
-	grep "Cookie:.*Bar=<redacted>" err &&
-	! grep "Cookie:.*Bar=2" err
+	grep "Cookie:.*Foo=<redacted>" err
 '
 
-test_expect_success 'GIT_REDACT_COOKIES handles empty values' '
+test_expect_success 'GIT_TRACE_REDACT=0 disables cookie redaction' '
 	rm -rf clone &&
-	echo "Set-Cookie: Foo=" >cookies &&
-	GIT_TRACE_CURL=true GIT_REDACT_COOKIES=Foo \
+	echo "Set-Cookie: Foo=1" >cookies &&
+	echo "Set-Cookie: Bar=2" >>cookies &&
+	GIT_TRACE_REDACT=0 GIT_TRACE_CURL=true \
 		git -c "http.cookieFile=$(pwd)/cookies" clone \
 		$HTTPD_URL/smart/repo.git clone 2>err &&
-	grep "Cookie:.*Foo=<redacted>" err
+	grep "Cookie:.*Foo=1" err &&
+	grep "Cookie:.*Bar=2" err
 '
 
 test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
-- 
2.27.0.278.ge193c7cf3a9-goog

