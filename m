Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03010C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 00:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKIAwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKIAwg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 19:52:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4023C6E9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 16:52:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id t1so9827358wmi.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 16:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mp+wHiA0B34/skw2roN7Kh1x8wAJeMLCs2C4bAeVsk=;
        b=M8Dxz71qe7QRbNMhkp8CpOQLBnvneDI+jEOfMMhTzr8mKtufYFlAEP5selT0MC+VFQ
         i2Ectqceu3aiBQtYrkZAl+Ob+KE4ZmPJWNicgjPQYw4YeOZs3Q3q9eGZlXJNgyVF4ULV
         p32hi9/tT4wMaNTZgTVwtKTpo1pszIA8bC/Djme1QJAUMYsCC3EuQS8L2GtrC90USCbC
         ID0rwP6axkcuMSGbGW17JaIIGmqzyAkDX884AWhMbjV9U2PHBdI2bhkhTRVTwEpkbmJ0
         W2HxMDHu2QOXQoLjDYGYSpQvUw4IAul1sid/Sl860cN6Hk65TzHOeuIBGWjf4vrbqJV/
         KQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Mp+wHiA0B34/skw2roN7Kh1x8wAJeMLCs2C4bAeVsk=;
        b=rVqbAyhu651J2I1vb0JtucqZhKQVV/ymBuen1TNuXRLIVGfJZQO54sv0xjzCHJtya5
         fVM919vtfAnvScfkS9cn+3vSaOv5rtnnTKXbT/r1fMgEO1KHwrs+l6uPjGEUgsUF3POh
         YmiuQOJd78SAL2oLE5TTvqB60P5LXlO7qGx35MVWtEByqutxCYiWdy8O4fM23pwXfQAR
         9kaCrHrXx/4M3CTi7wsDCxoOcS2l3x2h8Vqlz/b8xGwG/nSfX071o3LF+csxliE+Xjlj
         RYpdHDoxugHvYstimQSD/wwAxlastGZtP5Ns4G4umHUOGHbkFLhd60szm4DCi2GAdyka
         h29A==
X-Gm-Message-State: ACrzQf3s9K3Ekcbewzvl1K9zHhsMOzb5OjRaJVcyO/EVkVIsmAtgpbmj
        6JEO4NSpTTAMYTRTHPWjvRFDktKW1Q0=
X-Google-Smtp-Source: AMsMyM4+YRDEoalzzJqfMbO88AxC486LvXs6YbQqYfJOJLQD5pISZtC7Kun6myEvL7ygYO5914BesA==
X-Received: by 2002:a05:600c:a09:b0:3b5:2f6b:c7c5 with SMTP id z9-20020a05600c0a0900b003b52f6bc7c5mr38690370wmp.141.1667955153102;
        Tue, 08 Nov 2022 16:52:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az14-20020a05600c600e00b003cfa80443a0sm9401206wmb.35.2022.11.08.16.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:52:32 -0800 (PST)
Message-Id: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 00:52:31 +0000
Subject: [PATCH] http: redact curl h2h3 headers in info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

With GIT_TRACE_CURL=1 or GIT_CURL_VERBOSE=1, sensitive headers like
"Authorization" and "Cookie" get redacted. However, since [1], curl's
h2h3 module also prints headers in its "info", which don't get redacted.
For example,

  echo 'github.com	TRUE	/	FALSE	1698960413304	o	foo=bar' >cookiefile &&
  GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 git \
    -c 'http.cookiefile=cookiefile' \
    -c 'http.version=' \
    ls-remote https://github.com/git/git refs/heads/main 2>output &&
  grep 'cookie' output

produces output like:

  23:04:16.920495 http.c:678              == Info: h2h3 [cookie: o=foo=bar]
  23:04:16.920562 http.c:637              => Send header: cookie: o=<redacted>

Teach http.c to check for h2h3 headers in info and redact them using the
existing header redaction logic.

[1] https://github.com/curl/curl/commit/f8c3724aa90472c0e617ddbbc420aa199971eb77

Signed-off-by: Glen Choo <chooglen@google.com>
---
    http: redact curl h2h3 headers in info
    
    I initially sent this to the security list, but the general impression
    is that this isn't sensitive enough for an embargoed fix, so this is
    better discussed in the open instead.
    
    Since this comes from curl's HTTP2.0/3.0 module, this can be mitigated
    by setting http.version to 1.X, e.g. "git -c http.version=HTTP/1.1".
    
    According to [1], the susceptible curl versions appear to be 7.86.0,
    7.85.0, 7.84.0, 7.83.1, 7.83.0, 7.82.0, but I'm not sure which platforms
    are vulnerable.
    
    This patch fixes the issue on my machine running curl 7.85.0, so I think
    it is okay to merge as-is. That said, I would strongly prefer to add
    tests, but I haven't figured out how. In particular:
    
     * Do we have a way of using HTTP/2.0 in our tests? A cursory glance at
       our httpd config suggests that we only use HTTP/1.1.
     * How could we set up end-to-end tests to ensure that we're testing
       this against affected versions of curl? To avoid regressions, I'd
       also prefer to test against future versions of curl too.
    
    [1]
    https://github.com/curl/curl/commit/f8c3724aa90472c0e617ddbbc420aa199971eb77

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1377%2Fchooglen%2Fhttp%2Fredact-h2h3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1377/chooglen/http/redact-h2h3-v1
Pull-Request: https://github.com/git/git/pull/1377

 http.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 5d0502f51fd..cbcc7c3f5b6 100644
--- a/http.c
+++ b/http.c
@@ -560,8 +560,10 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
-static void redact_sensitive_header(struct strbuf *header)
+/* Return 0 if redactions been made, 1 otherwise. */
+static int redact_sensitive_header(struct strbuf *header)
 {
+	int ret = 1;
 	const char *sensitive_header;
 
 	if (trace_curl_redact &&
@@ -575,6 +577,7 @@ static void redact_sensitive_header(struct strbuf *header)
 		/* Everything else is opaque and possibly sensitive */
 		strbuf_setlen(header,  sensitive_header - header->buf);
 		strbuf_addstr(header, " <redacted>");
+		ret = 0;
 	} else if (trace_curl_redact &&
 		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
@@ -612,6 +615,27 @@ static void redact_sensitive_header(struct strbuf *header)
 
 		strbuf_setlen(header, sensitive_header - header->buf);
 		strbuf_addbuf(header, &redacted_header);
+		ret = 0;
+	}
+	return ret;
+}
+
+/* Redact headers in info */
+static void redact_sensitive_info_header(struct strbuf *header)
+{
+	const char *sensitive_header;
+
+	if (trace_curl_redact &&
+	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
+		struct strbuf inner = STRBUF_INIT;
+
+		/* Drop the trailing "]" */
+		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
+		if (!redact_sensitive_header(&inner)) {
+			strbuf_setlen(header, strlen("h2h3 ["));
+			strbuf_addbuf(header, &inner);
+			strbuf_addch(header, ']');
+		}
 	}
 }
 
@@ -668,6 +692,18 @@ static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)
 	strbuf_release(&out);
 }
 
+static void curl_print_info(char *data, size_t size)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_add(&buf, data, size);
+
+	redact_sensitive_info_header(&buf);
+	trace_printf_key(&trace_curl, "== Info: %s", buf.buf);
+
+	strbuf_release(&buf);
+}
+
 static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
 {
 	const char *text;
@@ -675,7 +711,7 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 
 	switch (type) {
 	case CURLINFO_TEXT:
-		trace_printf_key(&trace_curl, "== Info: %s", data);
+		curl_print_info(data, size);
 		break;
 	case CURLINFO_HEADER_OUT:
 		text = "=> Send header";

base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
-- 
gitgitgadget
