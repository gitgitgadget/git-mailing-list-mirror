Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D951F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeBGBOf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:35 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:42332 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBGBOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:33 -0500
Received: by mail-yw0-f202.google.com with SMTP id x68so4454823ywx.9
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=RL6VJ9rsoOJeza0cCnbY7USIzF9CZEWRigIAFaGR7Fg=;
        b=r9Km2SI0VoKdVDmSvmbIWUjwafG2POT+1QYRNeIAxUBTrX7ndmDvFgkuyPapCzaCZ8
         NxkJq4nTA4BgEvr4pGkcokOCHMHHGP+UAMKWBa8n0VcBqIHUmGH94MqxxhiNaXop7xwc
         4mx/RuCDsB03KIzch6Qh3kRh3Q7UcnPUiMZfD8KDOtvQl0ujZjE9OQJv2J+dCw8Oe4tA
         +9eKz7BZdkZqIVj/3281YOHleCbrDhBR7FR8RlergI4UJ7lP/3cF93YDFfacNMdxi10I
         9OJ5NwQKWLnp6kdCTlCMx3iUHz3/VCfWlM1VMCzgMLU5LkKAAxsNAk/RwOMtElH8OsZk
         BStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=RL6VJ9rsoOJeza0cCnbY7USIzF9CZEWRigIAFaGR7Fg=;
        b=njuqCeVKTAXbvPhnrK/aEU4cht8JWbN61eB3EfVXCyToC8tOIThpDcaZccNx7u1G/s
         1elwT1+67VzMmHAM/dz9HCI98pxZIWIiUWGXorp605LOr2yJ9UfqdVgoa+v7AJ6QejP1
         4QbccTb2yaYIGyr7ANYMd1B/8C0VnmfcFE6VSgUGFrt2bzSLpq3lQdHL44ZnO9b4sn2I
         ackhbgB7Z3aMACa5IZFvibC2rMbIjrxyQ3n5LvrGU8EtgCJEh6CDNnLbbGsurIE/DTzL
         gD87wVYm0EIzXJl2iauaixz5xhvh2+YY2nYueFJvZDjBaBl1aRTtmmYGMQ9dVcBIbcnF
         votQ==
X-Gm-Message-State: APf1xPCeXhyZzkz9Pbv9h5GqsHhDYPfkvfwaX8qfdKHkxVTbp4n+FgFu
        H1FvrsnczXGThtFXiroNoM9IQcLdnGuSLjkseYwvVftGjt4Str/s39hDpqXIk2G+6yCweCN08UA
        hzzrWM5EKR7OpOq1RBtAZzciEED4TzD0ghtCrz6+308WB4kKlJSuthP/DEQ==
X-Google-Smtp-Source: AH8x227ati8soXw0Bop6Mtfq1DXGVnUgftWOFq15XyDV3CMSp/T+eaTIoGP49sm1GxuK5kdKrGyy3L8KJfE=
MIME-Version: 1.0
X-Received: by 10.129.118.72 with SMTP id j8mr2039250ywk.16.1517966073230;
 Tue, 06 Feb 2018 17:14:33 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:10 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-34-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 33/35] http: don't always add Git-Protocol header
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
2.16.0.rc1.238.g530d649a79-goog

