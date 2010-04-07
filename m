From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/2] http: make end_url_with_slash() public
Date: Wed,  7 Apr 2010 23:58:37 +0800
Message-ID: <1270655917-5188-1-git-send-email-rctay89@gmail.com>
References: <p2ube6fef0d1004070857j874c2b60z6a4794d472b0ee8a@mail.gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 17:59:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXed-0002CL-Jd
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813Ab0DGP6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 11:58:54 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:52487 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581Ab0DGP6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 11:58:53 -0400
Received: by bwz1 with SMTP id 1so968846bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v0xIqwEBaQ9YtPi9lSI5/kwuPyL+uJL+aMf13P5qmVc=;
        b=vnrM7neE6UUR1MUrWuNWBAUttArH4de3bzOcTFnVzfG86yutO9HeqwpXMbsqxBylnj
         qUWVU42ATGhBFFv8UhHfxgsGq0dcdjbtzrLwMssfGCUQohFt3Cggy/mKp4Z6P8yXaa+J
         blNLUPyfr0qN2hYcz58OQPrEEeAmDtdfs58gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hjw+WRLs1wxR7cMe14spc6az53BBJotORJmY5tmBQWMIdU1BkHeNftGjpZU0kbI8c4
         NrqrnbnNeWQTafPnkAKCEVJik//sWuZjNLjf4l5tAXBKP4F6wT6jhkha1Sy1vzP7zAcw
         feLNlyce+voVnRZ58VoueqQ4xKWiXLjqs5+do=
Received: by 10.204.32.77 with SMTP id b13mr9545318bkd.113.1270655932035;
        Wed, 07 Apr 2010 08:58:52 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id 14sm7005641bwz.2.2010.04.07.08.58.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 08:58:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <p2ube6fef0d1004070857j874c2b60z6a4794d472b0ee8a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144241>

---
 http.c |    2 +-
 http.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 51253e1..07a03fd 100644
--- a/http.c
+++ b/http.c
@@ -720,7 +720,7 @@ static inline int hex(int v)
 		return 'A' + v - 10;
 }
 
-static void end_url_with_slash(struct strbuf *buf, const char *url)
+void end_url_with_slash(struct strbuf *buf, const char *url)
 {
 	strbuf_addstr(buf, url);
 	if (buf->len && buf->buf[buf->len - 1] != '/')
diff --git a/http.h b/http.h
index 2dd03e8..37a6a6a 100644
--- a/http.h
+++ b/http.h
@@ -117,6 +117,7 @@ extern void append_remote_object_url(struct strbuf *buf, const char *url,
 				     int only_two_digit_prefix);
 extern char *get_remote_object_url(const char *url, const char *hex,
 				   int only_two_digit_prefix);
+extern void end_url_with_slash(struct strbuf *buf, const char *url);
 
 /* Options for http_request_*() */
 #define HTTP_NO_CACHE		1
-- 
1.6.6.1368.g82eeb


>From 38c2aba1e77591d9cd57790d9a993f59659496ae Mon Sep 17 00:00:00 2001
From: Tay Ray Chuan <rctay89@gmail.com>
Date: Wed, 7 Apr 2010 23:44:01 +0800
Subject: [PATCH v2 2/2] remote-curl: ensure that URLs have a trailing slash

---
 remote-curl.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0782756..ae14137 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -9,6 +9,10 @@
 #include "sideband.h"
 
 static struct remote *remote;
+
+/* At assignment-time, we append a trailing slash; always use this as
+ * if it ends with a slash.
+ */
 static const char *url;
 
 struct options {
@@ -101,7 +105,7 @@ static struct discovery* discover_refs(const char *service)
 		return last;
 	free_discovery(last);
 
-	strbuf_addf(&buffer, "%s/info/refs", url);
+	strbuf_addf(&buffer, "%sinfo/refs", url);
 	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
 		is_http = 1;
 		if (!strchr(url, '?'))
@@ -120,7 +124,7 @@ static struct discovery* discover_refs(const char *service)
 		strbuf_reset(&buffer);
 
 		proto_git_candidate = 0;
-		strbuf_addf(&buffer, "%s/info/refs", url);
+		strbuf_addf(&buffer, "%sinfo/refs", url);
 		refs_url = strbuf_detach(&buffer, NULL);
 
 		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
@@ -511,7 +515,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->out = client.out;
 	strbuf_init(&rpc->result, 0);
 
-	strbuf_addf(&buf, "%s/%s", url, svc);
+	strbuf_addf(&buf, "%s%s", url, svc);
 	rpc->service_url = strbuf_detach(&buf, NULL);
 
 	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
@@ -800,11 +804,13 @@ int main(int argc, const char **argv)
 	remote = remote_get(argv[1]);
 
 	if (argc > 2) {
-		url = argv[2];
+		end_url_with_slash(&buf, argv[2]);
 	} else {
-		url = remote->url[0];
+		end_url_with_slash(&buf, remote->url[0]);
 	}
 
+	url = strbuf_detach(&buf, NULL);
+
 	http_init(remote);
 
 	do {
-- 
1.6.6.1368.g82eeb
