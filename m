Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959E61F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965043AbeB1XYr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:47 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:46931 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964965AbeB1XYo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:44 -0500
Received: by mail-yb0-f201.google.com with SMTP id s65-v6so2379988ybb.13
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rs6mL/upMExI/SS3+Co228lV/3ihstjy6OZE7RApMB4=;
        b=Cq+oTPoFe5T0FYPcjFor+aJC8BkAQY9Hs9ff+P2abVzU1U/aBJzHzXDNgPqqu9FpR7
         2pbRu8tONofGpHjd029ta5HeXHhqiSD/oi6NZfh2YIKfl5LbheX4KbaXhfudCsusx4Ix
         opOdrkccg/B4Mgnzw1VFi2cxtiLneeDiqbI2IW7zC4qCOWx1dZxDQ564Xyu9Uyy24rc6
         JwNCzQGyKnuc3S1ciec43Y9dWhY2u8iscMEE9iQya2y/BIEnrWqhvHPssKMbYpe6KDu0
         E9suDnzBvoECcVX4obtdfyVadWkMWdw2DM+XoWKNzXWbBJYfnZJrya2coL5dAmCEXegw
         0efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rs6mL/upMExI/SS3+Co228lV/3ihstjy6OZE7RApMB4=;
        b=eaFUmSv+JI/FMT44i8chZ1Th5zzHK7aZQZDT51PQoz4suxTqm3DGwtlWmrebvjDOPL
         JuCLsyxQOOZ5y50NdHkq26ZYDk8k94U3li0aBVyhMiwTVRUs651QEh96Ak7zE2fBGj+H
         8Wjl1JAbm4ZaBaW7/tm25Gnedjb31PdLTuXfkOzcESZgJIf6qHPeL0QurSm0MgaD8d6J
         fXIznS3fWpfRyMW0FPSI0HTBnr6HCOdDVmlnce+U2jcBiTvBP6xCPt84CO+UaBLspqJQ
         DDe6UECXAyhF1Jp7dNzziOBmgfeStKqZf8tBUMWKaWyklwi6t2qk3P/IRF2DcG6Lr83D
         fnFg==
X-Gm-Message-State: APf1xPAlkqxpzMKe6h7KiQmb7/sT/N8I/Vqnkjv5D8TED0rRnADmhh2m
        xwUQhpnrA9xPeBb/AF0g1rhXeyRzG6r62tRIddpmJztWwAvOqpgkNjN5AkJJ5Y1gLRztjAm3oCS
        T/75YylR35RcwTtBPpuAB/EeuklAIVSOIrYJBBiT+86zv8Tp2XQ7zXmeVdg==
X-Google-Smtp-Source: AH8x224NLtHK7V152fTbdDpZCKjYDnsl2pr5zFd5cbOECjHoBBVuiS9W019c1F0KTLg7ImFMgAaOEYGa5NQ=
MIME-Version: 1.0
X-Received: by 10.129.84.196 with SMTP id i187mr10654886ywb.126.1519860283478;
 Wed, 28 Feb 2018 15:24:43 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:49 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-33-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 32/35] http: don't always add Git-Protocol header
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of always sending the Git-Protocol header with the configured
version with every http request, explicitly send it when discovering
refs and then only send it on subsequent http requests if the server
understood the version requested.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http.c        | 17 -----------------
 remote-curl.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/http.c b/http.c
index e1757d62b..8f1129ac7 100644
--- a/http.c
+++ b/http.c
@@ -904,21 +904,6 @@ static void set_from_env(const char **var, const char *envname)
 		*var = val;
 }
 
-static void protocol_http_header(void)
-{
-	if (get_protocol_version_config() > 0) {
-		struct strbuf protocol_header = STRBUF_INIT;
-
-		strbuf_addf(&protocol_header, GIT_PROTOCOL_HEADER ": version=%d",
-			    get_protocol_version_config());
-
-
-		extra_http_headers = curl_slist_append(extra_http_headers,
-						       protocol_header.buf);
-		strbuf_release(&protocol_header);
-	}
-}
-
 void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
@@ -949,8 +934,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote)
 		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
 
-	protocol_http_header();
-
 	pragma_header = curl_slist_append(http_copy_default_headers(),
 		"Pragma: no-cache");
 	no_pragma_header = curl_slist_append(http_copy_default_headers(),
diff --git a/remote-curl.c b/remote-curl.c
index c54035843..b4e9db85b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -291,6 +291,19 @@ static int show_http_message(struct strbuf *type, struct strbuf *charset,
 	return 0;
 }
 
+static int get_protocol_http_header(enum protocol_version version,
+				    struct strbuf *header)
+{
+	if (version > 0) {
+		strbuf_addf(header, GIT_PROTOCOL_HEADER ": version=%d",
+			    version);
+
+		return 1;
+	}
+
+	return 0;
+}
+
 static struct discovery *discover_refs(const char *service, int for_push)
 {
 	struct strbuf exp = STRBUF_INIT;
@@ -299,6 +312,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf refs_url = STRBUF_INIT;
 	struct strbuf effective_url = STRBUF_INIT;
+	struct strbuf protocol_header = STRBUF_INIT;
+	struct string_list extra_headers = STRING_LIST_INIT_DUP;
 	struct discovery *last = last_discovery;
 	int http_ret, maybe_smart = 0;
 	struct http_get_options http_options;
@@ -318,11 +333,16 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		strbuf_addf(&refs_url, "service=%s", service);
 	}
 
+	/* Add the extra Git-Protocol header */
+	if (get_protocol_http_header(get_protocol_version_config(), &protocol_header))
+		string_list_append(&extra_headers, protocol_header.buf);
+
 	memset(&http_options, 0, sizeof(http_options));
 	http_options.content_type = &type;
 	http_options.charset = &charset;
 	http_options.effective_url = &effective_url;
 	http_options.base_url = &url;
+	http_options.extra_headers = &extra_headers;
 	http_options.initial_request = 1;
 	http_options.no_cache = 1;
 	http_options.keep_error = 1;
@@ -389,6 +409,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 	strbuf_release(&charset);
 	strbuf_release(&effective_url);
 	strbuf_release(&buffer);
+	strbuf_release(&protocol_header);
+	string_list_clear(&extra_headers, 0);
 	last_discovery = last;
 	return last;
 }
@@ -425,6 +447,7 @@ struct rpc_state {
 	char *service_url;
 	char *hdr_content_type;
 	char *hdr_accept;
+	char *protocol_header;
 	char *buf;
 	size_t alloc;
 	size_t len;
@@ -611,6 +634,10 @@ static int post_rpc(struct rpc_state *rpc)
 	headers = curl_slist_append(headers, needs_100_continue ?
 		"Expect: 100-continue" : "Expect:");
 
+	/* Add the extra Git-Protocol header */
+	if (rpc->protocol_header)
+		headers = curl_slist_append(headers, rpc->protocol_header);
+
 retry:
 	slot = get_active_slot();
 
@@ -751,6 +778,11 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	strbuf_addf(&buf, "Accept: application/x-%s-result", svc);
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
+	if (get_protocol_http_header(heads->version, &buf))
+		rpc->protocol_header = strbuf_detach(&buf, NULL);
+	else
+		rpc->protocol_header = NULL;
+
 	while (!err) {
 		int n = packet_read(rpc->out, NULL, NULL, rpc->buf, rpc->alloc, 0);
 		if (!n)
@@ -778,6 +810,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	free(rpc->service_url);
 	free(rpc->hdr_content_type);
 	free(rpc->hdr_accept);
+	free(rpc->protocol_header);
 	free(rpc->buf);
 	strbuf_release(&buf);
 	return err;
-- 
2.16.2.395.g2e18187dfd-goog

