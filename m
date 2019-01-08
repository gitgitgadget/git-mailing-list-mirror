Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846BE1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 02:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfAHCsD (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 21:48:03 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37043 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfAHCsC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 21:48:02 -0500
Received: by mail-qk1-f201.google.com with SMTP id s70so2045240qks.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 18:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MzGPOc6NVl+jJbFdWBR+ksAAgtvR7G3y2XdsJpRnQYY=;
        b=H1RqD5mm4CYT5scuHqQP24M1aWLcRV2uGFYWWw/X7HO1jUK9td+dj/mshADA2+/zFL
         jJHQMxuU+qRqt1K2rhNzp/ahDgKR6w+btztLSzRpKjY04eGVkRTwjA23BS9jtPdZQvDl
         0h3mPJeoCBNRw4EjTTt9ABsfWxm80dqPULN79xDhhKpuNy4UZyojuY1QZNK2G4nb/v/6
         AkHjgVVp8aOGVOZo6Jj2cs9MAT0baLJSJMidvmkNKigINLvrUOI0csu4KKhVUF3/ffMn
         FNmtM9i+8OPP/F4dwFdSwF5cHrdN7icS8d+Laqr7UwgKebiaePoWJUd/82rBZbu5VEZW
         E1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MzGPOc6NVl+jJbFdWBR+ksAAgtvR7G3y2XdsJpRnQYY=;
        b=LIuMuap0Dltee2+lCzFaFm7oIXoFrkK5rPE0kWVVgMVEhQ8z24tiodeI/+j8SJgz8O
         XGbJhXYIW3jxngY6rPgK0g/nJBVTfQz1kiPAajo5Xgn6I9Fy/HPhw8FHfRUwZOqEg5zx
         9kVhXphrjt63VlDC3UBoMieQLkv1xRGqVQqzfeMqRACPxR+5T1asLhx17/S6Ary9r+yd
         EXmhFN7Tj/1H0kiPwQ2aBsE9D6mGUtCdrTnpo23Gzx+l3PHnKzJdVFsnbHXOBiaALqXC
         RIr7yZSkZvHUZrZZ5yKiOwAIBTuRKrK9K9Pla9kolxYbcirxblAtp+oKUNooWbIieJed
         td0A==
X-Gm-Message-State: AA+aEWbQStrZiHYutdBNrfhKAnr5PYJAyPsMORfceGKO1INicyc8Y0w6
        5BWapM9vk5MIY4mACTSFkzocfhQKNN70i9Y2tQI=
X-Google-Smtp-Source: AFSGD/U/wXFjAbbDVvj5POlC07CUwjfhZvw18NQgR+AjQ3V4ugf+mNURBexb6g/5c4tJsZYjpcGkHzzlBA6WvL1bn4Y=
X-Received: by 2002:ac8:4307:: with SMTP id z7mr46012772qtm.7.1546915681719;
 Mon, 07 Jan 2019 18:48:01 -0800 (PST)
Date:   Mon,  7 Jan 2019 18:47:38 -0800
In-Reply-To: <20190108024741.62176-1-masayasuzuki@google.com>
Message-Id: <20190108024741.62176-3-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181229194447.157763-1-masayasuzuki@google.com> <20190108024741.62176-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 2/5] http: enable keep_error for HTTP requests
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

curl stops parsing a response when it sees a bad HTTP status code and it
has CURLOPT_FAILONERROR set. This prevents GIT_CURL_VERBOSE to show HTTP
headers on error.

keep_error is an option to receive the HTTP response body for those
error responses. By enabling this option, curl will process the HTTP
response headers, and they're shown if GIT_CURL_VERBOSE is set.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 http.c        | 30 +++++++++++++-----------------
 http.h        |  1 -
 remote-curl.c |  1 -
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/http.c b/http.c
index 06450da96e..a72db87723 100644
--- a/http.c
+++ b/http.c
@@ -1876,8 +1876,6 @@ static int http_request(const char *url,
 	strbuf_addstr(&buf, "Pragma:");
 	if (options && options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
-	if (options && options->keep_error)
-		curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
@@ -1895,6 +1893,7 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
+	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
 	ret = run_one_slot(slot, &results);
 
@@ -1989,22 +1988,19 @@ static int http_request_reauth(const char *url,
 		return ret;
 
 	/*
-	 * If we are using KEEP_ERROR, the previous request may have
-	 * put cruft into our output stream; we should clear it out before
-	 * making our next request.
+	 * The previous request may have put cruft into our output stream; we
+	 * should clear it out before making our next request.
 	 */
-	if (options && options->keep_error) {
-		switch (target) {
-		case HTTP_REQUEST_STRBUF:
-			strbuf_reset(result);
-			break;
-		case HTTP_REQUEST_FILE:
-			fflush(result);
-			ftruncate(fileno(result), 0);
-			break;
-		default:
-			BUG("Unknown http_request target");
-		}
+	switch (target) {
+	case HTTP_REQUEST_STRBUF:
+		strbuf_reset(result);
+		break;
+	case HTTP_REQUEST_FILE:
+		fflush(result);
+		ftruncate(fileno(result), 0);
+		break;
+	default:
+		BUG("Unknown http_request target");
 	}
 
 	credential_fill(&http_auth);
diff --git a/http.h b/http.h
index d305ca1dc7..eebf40688c 100644
--- a/http.h
+++ b/http.h
@@ -146,7 +146,6 @@ extern char *get_remote_object_url(const char *url, const char *hex,
 /* Options for http_get_*() */
 struct http_get_options {
 	unsigned no_cache:1,
-		 keep_error:1,
 		 initial_request:1;
 
 	/* If non-NULL, returns the content-type of the response. */
diff --git a/remote-curl.c b/remote-curl.c
index 1220dffcdc..d8eda2380a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -380,7 +380,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	http_options.extra_headers = &extra_headers;
 	http_options.initial_request = 1;
 	http_options.no_cache = 1;
-	http_options.keep_error = 1;
 
 	http_ret = http_get_strbuf(refs_url.buf, &buffer, &http_options);
 	switch (http_ret) {
-- 
2.20.1.97.g81188d93c3-goog

