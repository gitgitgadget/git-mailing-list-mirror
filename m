Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B0951F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfAJTe1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:34:27 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54619 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfAJTe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:34:26 -0500
Received: by mail-pg1-f201.google.com with SMTP id p4so6896513pgj.21
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eY6em6pDgr6rn0D5HhNUuT2zomHY3meun22ng88lr68=;
        b=EOcNQA4zuEUkyiGZqY8X9aRWazTdSmrS6m5ZFiXPkp8iTGsXL+FaPYWBa5TVVEDRxD
         9GnHaXUPpE9uXF8JibM7jt1EAN0S6htsaBhLNtaowtmr+vZaxC6lEBlIZw6sfPElfa4R
         ezFJkroiR3U90nlVlcRJtMqp9nurbbP5GiK7OCOTtTtJY1sUJvZtm9d9yQgMNpbrEjEL
         dxxy4cIvj1stk0gSkp2D6QYxNdisLGVUsjjbTmNgUnCqurliP2xtoxg2uyiYfbHMwoJW
         YSOFmmXRi+NELuxSGAa7pA9DZF0uVBc0xU9zWdXzvUWcI1xHgFrtn5n7/oe1ngKQDDkj
         75HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eY6em6pDgr6rn0D5HhNUuT2zomHY3meun22ng88lr68=;
        b=Ay/ez2eQhZKbpIDqFLqS8iiivumcrXY4zP8Wo5WBkrmIsPKWf8Rhw3Kvma+0OoMqIW
         BCcttSC2ghjZEnEudpaRoXqwW42XEhvjhqqaor4XcEKKaAxGldNToqEfJ6x+XZ4vrfaI
         kt+u5wVPtKJE05a8kQVgjKE6DX01MoEb3Fy/axtpOrpZvuMESxj6fST1ScAVHB85SbWD
         DBCYP/aWV9fJtCvLqtR0XQYzJlX3EzeaJxY+xkkEghpaaGQJtChYMoZjzvx/TFAcUbrI
         Duv0NvcaXsFTLjnWVx5GQJ3AztdzVcQbwaX0jeprsws8Pc5fLhX+XD+MVqp0PWSGNzjZ
         hAsw==
X-Gm-Message-State: AJcUukf3c0aYfyqoMWYipw02W5pY1C4NHicGur8oNLRWGS+mZaTaKtGE
        zDJcjww1YSYtAgQ/voG1lHWUNkO5xNgXi7Ck8IQ=
X-Google-Smtp-Source: ALg8bN7Afdx6OuR35LefRmtoXAU72kaH3W6MhLcYnlCW3AymxtnBFw3ogIzmUggZKobMIzaktmjSkTRiDzQcMr1Tav8=
X-Received: by 2002:a65:5b0d:: with SMTP id y13mr3197766pgq.3.1547148865682;
 Thu, 10 Jan 2019 11:34:25 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:33:47 -0800
In-Reply-To: <20190110193350.213327-1-masayasuzuki@google.com>
Message-Id: <20190110193350.213327-3-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20190108024741.62176-1-masayasuzuki@google.com> <20190110193350.213327-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v4 2/5] http: enable keep_error for HTTP requests
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
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
 http.c        | 42 +++++++++++++++++++-----------------------
 http.h        |  1 -
 remote-curl.c |  1 -
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index 4eccf4c5d8..954bebf684 100644
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
 
@@ -1989,29 +1988,26 @@ static int http_request_reauth(const char *url,
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
-			if (fflush(result)) {
-				error_errno("unable to flush a file");
-				return HTTP_START_FAILED;
-			}
-			rewind(result);
-			if (ftruncate(fileno(result), 0) < 0) {
-				error_errno("unable to truncate a file");
-				return HTTP_START_FAILED;
-			}
-			break;
-		default:
-			BUG("Unknown http_request target");
+	switch (target) {
+	case HTTP_REQUEST_STRBUF:
+		strbuf_reset(result);
+		break;
+	case HTTP_REQUEST_FILE:
+		if (fflush(result)) {
+			error_errno("unable to flush a file");
+			return HTTP_START_FAILED;
 		}
+		rewind(result);
+		if (ftruncate(fileno(result), 0) < 0) {
+			error_errno("unable to truncate a file");
+			return HTTP_START_FAILED;
+		}
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

