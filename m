Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF3AC43467
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1F720BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoEVDtOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgJMTRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJMTRp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 15:17:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DC6C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:17:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so854676ybh.10
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BBfsiTtx4TLB/Uphsh1a5P1NcnNbUCe3CdTEt+GWi7o=;
        b=SoEVDtOjDnEJa+R7OCP6HkFZkWD2BcaL3XFQ0Jtgqa6YACG4tIcvi6hinsnh17zcy0
         ZFq3lda078JE+b9KzarBcK8hWlHYsSHj2zXO1CRYwBHmNWYQKWTsVBjsBXhO0nkWC0Hh
         bC+eKGpWmj+v+lNhVP2LN+Jz1HXp1/6FmMDMplFeBWSabMz0yegywQA5f4ontgWhbS45
         B6o3XYQ8Y8zrgc7tADfKYEtkYMGyLIWRwNDckHIjrYqOCYYfiRJpJrz5555gA8mu704d
         UubN/N+iEldd2kzMu3Clb0PNrNcmpKPUku6S1Wsgi7Z/ebXDniONju2Mmvcd0xozy1ow
         D2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BBfsiTtx4TLB/Uphsh1a5P1NcnNbUCe3CdTEt+GWi7o=;
        b=dcNbI3GIfX6j4W42VMlJxLBkptrHfspVH3CplWUoSAau2nfTZW+Vk2yB2HHO3J4hz9
         5cy1Tc0vn4DW8QVqi90qjgTUzpNCYBQuxudEAzxi2JBJnTkkKdoW43K9KNnsQwzQblJW
         XSKBNshn9Dwp+AtxwjXv7rO7LLExIkSG3LZhqB3RF4eyUSq8XKhM3rMU/yt9uySesg13
         jnESKaRqFyaDAH1Lm3wYsBZoXdtpcO+ebrEClDfTFrymC393E+PinRYNWm4VOku+oWOC
         iks6wfCqyHapZm1TKMQ0L9TaPDOa2PApezoq675SQj+qc089rRh0ACju4ng4xBNSGeHb
         JaXw==
X-Gm-Message-State: AOAM530Y/Mel4YWbpwwDUTeoTF41NEhqC/0jBh97trKHulh/9D9k0OlT
        GGoRwSQfOiPineu5jwj/m0bnPKQHSdLTxselO/7KRl33Bo/lbneyl5jPhsXnmV6dcLQkHtjnf2D
        jbHcYqt+gZPE8lZmgeZtUBhbXeFZbNAzlOdjCWWgLxbffmDZcGLSlIR/7FDehiVs=
X-Google-Smtp-Source: ABdhPJyCYko+5oG7onFXI5RXpl3cDlWW/70vlOYejHP8tlyJQMOZcvm1fwpyGYYHU2Lg9fHXuHxgdZw6qNY2JA==
Sender: "smcallis via sendgmr" <smcallis@smcallis.bld.corp.google.com>
X-Received: from smcallis.bld.corp.google.com ([2620:15c:183:200:a6ae:11ff:fe11:fc5d])
 (user=smcallis job=sendgmr) by 2002:a5b:44a:: with SMTP id
 s10mr2215865ybp.172.1602616664451; Tue, 13 Oct 2020 12:17:44 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:17:29 -0600
In-Reply-To: <20201013191729.2524700-1-smcallis@google.com>
Message-Id: <20201013191729.2524700-3-smcallis@google.com>
Mime-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 3/3] http: automatically retry some requests
From:   Sean McAllister <smcallis@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com, jrnieder@gmail.com
Cc:     Sean McAllister <smcallis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some HTTP response codes indicate a server state that can support
retrying the request rather than immediately erroring out.  The server
can also provide information about how long to wait before retries to
via the Retry-After header.  So check the server response and retry
some reasonable number of times before erroring out to better accomodate
transient errors.

Exiting immediately becomes irksome when pulling large multi-repo code
bases such as Android or Chromium, as often the entire fetch operation
has to be restarted from the beginning due to an error in one repo. If
we can reduce how often that occurs, then it's a big win.

Signed-off-by: Sean McAllister <smcallis@google.com>
---
 Documentation/config/http.txt |   5 ++
 http.c                        | 124 +++++++++++++++++++++++++++++++++-
 http.h                        |   2 +-
 remote-curl.c                 |   2 +-
 t/t5601-clone.sh              |   6 +-
 5 files changed, 133 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 3968fbb697..5d5baef967 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -260,6 +260,11 @@ http.followRedirects::
 	the base for the follow-up requests, this is generally
 	sufficient. The default is `initial`.
 
+http.retryLimit::
+	Some HTTP status codes (eg: 429, 503) can reasonably be retried if
+	they're encountered.  This value configures the number of retry attempts
+	before giving up.  The default retry limit is 3.
+
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some URLs.
 	For a config key to match a URL, each element of the config key is
diff --git a/http.c b/http.c
index b3c1669388..f0147582f9 100644
--- a/http.c
+++ b/http.c
@@ -92,6 +92,9 @@ static const char *http_proxy_ssl_key;
 static const char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth = CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
+static int http_retry_limit = 3;
+static int http_default_delay_sec = 2;
+static int http_max_delay_sec = 60;
 
 static struct {
 	const char *name;
@@ -219,6 +222,56 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 	return nmemb;
 }
 
+
+/* return 1 for a retryable HTTP code, 0 otherwise */
+static int retryable_code(int code)
+{
+	switch(code) {
+	case 429: /* fallthrough */
+	case 502: /* fallthrough */
+	case 503: /* fallthrough */
+	case 504: return 1;
+	default:  return 0;
+	}
+}
+
+/*
+ * Query the value of an HTTP header.
+ *
+ * If the header is found, then a newly allocate string containing the value
+ * is returned.
+ *
+ * If not found, returns NULL
+ */
+static char* http_header_value(const struct strbuf headers, const char *header)
+{
+	const size_t header_len = strlen(header);
+	const char* beg = headers.buf, *end;
+	const char* ptr = strcasestr(beg, header), *eol;
+
+	while (ptr) {
+		/* headers should have no leading whitespace, and end with ':' */
+		end = ptr + header_len;
+		if ((ptr != beg && ptr[-1] != '\n') || *end != ':') {
+			ptr = strcasestr(end, header);
+			continue;
+		}
+
+		/* skip leading LWS */
+		ptr = end + 1;
+		while (*ptr && isspace(*ptr) && *ptr != '\r')
+			ptr++;
+
+		/* skip trailing LWS */
+		eol = strchrnul(ptr, '\r');
+		while (eol > ptr && isspace(eol[-1]))
+			eol--;
+
+		return xstrndup(ptr, eol-ptr);
+	}
+	return NULL;
+}
+
 static void closedown_active_slot(struct active_request_slot *slot)
 {
 	active_requests--;
@@ -452,6 +505,11 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.retrylimit", var)) {
+		http_retry_limit = git_config_int(var, value);
+		return 0;
+	}
+
 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
 }
@@ -1668,7 +1726,7 @@ static int handle_curl_result(struct slot_results *results)
 }
 
 int run_one_slot(struct active_request_slot *slot,
-		 struct slot_results *results)
+		 struct slot_results *results, int *http_code)
 {
 	slot->results = results;
 	if (!start_active_slot(slot)) {
@@ -1678,6 +1736,8 @@ int run_one_slot(struct active_request_slot *slot,
 	}
 
 	run_active_slot(slot);
+	if (http_code)
+		*http_code = results->http_code;
 	return handle_curl_result(results);
 }
 
@@ -1903,20 +1963,58 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 #define HTTP_REQUEST_STRBUF	0
 #define HTTP_REQUEST_FILE	1
 
+/*
+ * check for a retry-after header in the given headers string, if found, then
+ * honor it, otherwise do an exponential backoff up to the max on the current
+ * delay
+*/
+static int http_retry_after(const struct strbuf headers, int cur_delay_sec)
+{
+	int delay_sec;
+	char *end;
+	char* value = http_header_value(headers, "retry-after");
+
+	if (value) {
+		delay_sec = strtol(value, &end, 0);
+		free(value);
+		if (*value && *end == '\0' && delay_sec >= 0) {
+			if (delay_sec > http_max_delay_sec) {
+				die(Q_("server requested retry after %d second,"
+					   " which is longer than max allowed\n",
+					   "server requested retry after %d seconds,"
+					   " which is longer than max allowed\n", delay_sec),
+					delay_sec);
+			}
+			return delay_sec;
+		}
+	}
+
+	cur_delay_sec *= 2;
+	return cur_delay_sec >= http_max_delay_sec ? http_max_delay_sec : cur_delay_sec;
+}
+
 static int http_request(const char *url,
 			void *result, int target,
 			const struct http_get_options *options)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct curl_slist *headers = http_copy_default_headers();
+	struct curl_slist *headers;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf result_headers = STRBUF_INIT;
 	const char *accept_language;
 	int ret;
+	int retry_cnt = 0;
+	int retry_delay_sec = http_default_delay_sec;
+	int http_code;
 
+retry:
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, &result_headers);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_buffer);
+
 	if (result == NULL) {
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
 	} else {
@@ -1936,6 +2034,7 @@ static int http_request(const char *url,
 
 	accept_language = get_accept_language();
 
+	headers = http_copy_default_headers();
 	if (accept_language)
 		headers = curl_slist_append(headers, accept_language);
 
@@ -1961,7 +2060,26 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
-	ret = run_one_slot(slot, &results);
+	http_code = 0;
+	ret = run_one_slot(slot, &results, &http_code);
+
+	/* remove header data fields since not all slots will use them */
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, NULL);
+
+	if (ret != HTTP_OK) {
+		if (retryable_code(http_code) && retry_cnt < http_retry_limit) {
+			retry_cnt++;
+			retry_delay_sec = http_retry_after(result_headers, retry_delay_sec);
+			warning(Q_("got HTTP response %d, retrying after %d second (%d/%d)\n",
+					   "got HTTP response %d, retrying after %d seconds (%d/%d)\n",
+					   retry_delay_sec),
+				http_code, retry_delay_sec, retry_cnt, http_retry_limit);
+			sleep(retry_delay_sec);
+
+			goto retry;
+		}
+	}
 
 	if (options && options->content_type) {
 		struct strbuf raw = STRBUF_INIT;
diff --git a/http.h b/http.h
index 5de792ef3f..faf9f1060e 100644
--- a/http.h
+++ b/http.h
@@ -99,7 +99,7 @@ void finish_all_active_slots(void);
  *
  */
 int run_one_slot(struct active_request_slot *slot,
-		 struct slot_results *results);
+		 struct slot_results *results, int *http_code);
 
 #ifdef USE_CURL_MULTI
 void fill_active_slots(void);
diff --git a/remote-curl.c b/remote-curl.c
index 7f44fa30fe..2657c95bcb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -805,7 +805,7 @@ static int run_slot(struct active_request_slot *slot,
 	if (!results)
 		results = &results_buf;
 
-	err = run_one_slot(slot, results);
+	err = run_one_slot(slot, results, NULL);
 
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		struct strbuf msg = STRBUF_INIT;
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 72aaed5a93..3965cd265d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -757,13 +757,17 @@ test_expect_success 'partial clone using HTTP' '
 '
 
 test_expect_success 'partial clone using HTTP with redirect' '
-	_NONCE=`gen_nonce` && export _NONCE &&
+	_NONCE=$(gen_nonce) &&
 	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
 	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
 	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
 	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
 '
 
+test_expect_success 'partial clone with retry' '
+	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/$(gen_nonce)/3/429/1/smart/server" 2>err &&
+	test_i18ngrep "got HTTP response 429" err
+'
 
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
-- 
2.28.0.1011.ga647a8990f-goog

