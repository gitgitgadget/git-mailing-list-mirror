Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D3D1FAE3
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeCNSdk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:40 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:57630 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbeCNSdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:32 -0400
Received: by mail-it0-f73.google.com with SMTP id y1-v6so3628992iti.7
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=gbFf3CzBVdnAXpFM1+Bs+IiJXvGHhgyVUNk71aRNMNo=;
        b=NB+4Mmv4bcWWCjmKWvlezAf2HaXMdakemCCyKUyyQuXPfHI83MN76DzpWRVKMLPDxJ
         bXjtcwjCjlshwS3dvf2GdPbtPcLXssVzKNPUfVLTpHKGkiamLwmKde20XsZvAxNggl9s
         K4yU3N1eB+eQHMpCZCCjXh7EUClNf6GPc/wxNeatQd9puPrHTAVpidrR4OpMG3T272Us
         H0taxvndF6XQ+sMYSHgnwRn1LV+MjbB3o9MXcCfdYEn4z3+dVsJdNR0kb9BtSz9ryF+B
         nLlURMz1gvULohrG89ObvpsVDbivRoVSILIQ+NvvD6Ag9ji5KXE546w7dp/jldmhnQlm
         lacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=gbFf3CzBVdnAXpFM1+Bs+IiJXvGHhgyVUNk71aRNMNo=;
        b=OmwB189+8XI/7qxFy8UHvRbhsG2KYNjtyhlSIcF3xdwljT8/Ilmzkclo8VVYKG2r2s
         30vrPjqbmCynRjHEYFO+sjFnXusgwvM93mCjoA7i+cj+JOyGYxdSOlBDNyNpZAty+7+A
         c/1aro52qZ1mIhQpNzwCTbhiv6RFzxDvuyNE82tLEE3/3ydkmAfe5w2wt9Kd4Vy/i+8x
         LZs6j3ZTQHcSylMKoBjqThv7Q/UEBpFxizjJ9LlSrmlXRkXdv0dlJuDUUDyS1DpP0xqu
         O0GSaP6YdvOpzI2qPyGfAuovxPSeghv77CEO5JvAN8fKW9xXUEWMAOKqr5dQpzndwSAn
         qiXw==
X-Gm-Message-State: AElRT7EaalmQktL5SRfYO8FJULXmFLVH3PPaTgv77oCW6mgmGvD3eKqk
        lRVB03ixnA1IYTgZocE0MqWyaMvVB+blaDJqivxeym5eMrxriUh/aMXkUsIvBsD5X7E4xljlcyG
        mTDp6nV2hcNm+vQRpW9NuhUC5kNiK5oW73r/9mfZxmwBVdb+/J9HSopnxqQ==
X-Google-Smtp-Source: AG47ELvmruF/sA4L3smrtz7smldMWzcgtFHM0GzEs+yRs+pBgtK1JIYrGsI2U97dn+8wPbKmHYyl59jr2kQ=
MIME-Version: 1.0
X-Received: by 2002:a24:af0b:: with SMTP id t11-v6mr1341152ite.46.1521052411634;
 Wed, 14 Mar 2018 11:33:31 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:09 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-33-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 32/35] http: don't always add Git-Protocol header
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
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
index e1757d62b2..8f1129ac7c 100644
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
index c540358438..b4e9db85bb 100644
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
2.16.2.804.g6dcf76e118-goog

