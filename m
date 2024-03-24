Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFFEC4
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711243212; cv=none; b=VOvmEQRQYOjDk487YmJb9+N8i9TVwSzBNZvAZ1MfN73fRERQU+X8Pph2axhEWpT2wij9subVe1gVXVNSJa8+a+EnabcTDnlI99wzD9uwdRc98aiTCskT/ysBWwWuSvQrqw0VWIMVHeU4p5+2YyFhMw7y9tdIiGYE1CGO4aqLyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711243212; c=relaxed/simple;
	bh=/9gJP+E+JQoaZgFAJNZO8fswMIkX3MIP1Cv0Zg/zORY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyoXLNk4+jUq3Lt3/gDhPd2oSTYtATEPeNfxpjYGO5D1TYAhpaBc6XJMyMBpxTdATdAPemiN8N0W0Sct/3hE0V76U+gv93mhNOYKSh4wbP65z2Uh8VOCY/0HbDfpbw/Iyv+mFj/5I/hneAggf053uyoxLUO9nWemJQFpToKoDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IprqqCtN; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IprqqCtN"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C263E5B470;
	Sun, 24 Mar 2024 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242785;
	bh=/9gJP+E+JQoaZgFAJNZO8fswMIkX3MIP1Cv0Zg/zORY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=IprqqCtN0a+xH49zRj8/ETbHGNY3BDLFOmo3qtR2WP4JxEo2bizeepcd1KtntztIo
	 6SieOJ0lh2uBsgECWZMtwcSUe1ik36GEAIVIf5aUQIGjnL/7gqwTFaGIcXHoO58d1l
	 a5eIuxTvrSmf7EWSYEOD3fc4eqkoxDXr/eNYn3uEIoFlk4HEiaeJmnGMmJas8R0hd/
	 dM1WeHW5mH4KMOjNbS1Z09+xCVrxPpsB4NqYW4yAerHGoCuCjw8+EJ3H1Oj5kgHS2O
	 T9Wb1T8Kc8DqJc8LY4jApGMi9Y2mp+SluYm37yeaFgMkbuAeBfpcXm6vFIncvfdzPx
	 wKSEk8UJtedj7PaR6Kgo5MOzjq/BrdWuAcbDL3JjuKK+SWDOizdDXLzKRrjJDDFVa+
	 tiUwWF/DahwFnfBaPOUx5pbSVDs3Mi5/RGF8ra8h/EYpW7FqnhwXqYUcLcUIwsFuO4
	 W6ZnI7WlmFTja8Yw4Ls01nbUY4SN+rHbGQxqylVBldBHPXWWUoe
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 02/13] remote-curl: reset headers on new request
Date: Sun, 24 Mar 2024 01:12:50 +0000
Message-ID: <20240324011301.1553072-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we retry a post_rpc request, we currently reuse the same headers as
before.  In the future, we'd like to be able to modify them based on the
result we get back, so let's reset them on each retry so we can avoid
sending potentially duplicate headers if the values change.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1161dc7fed..e37eaa17b7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -893,7 +893,7 @@ static curl_off_t xcurl_off_t(size_t len)
 static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_received)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = http_copy_default_headers();
+	struct curl_slist *headers = NULL;
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
@@ -935,6 +935,8 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 			needs_100_continue = 1;
 	}
 
+retry:
+	headers = http_copy_default_headers();
 	headers = curl_slist_append(headers, rpc->hdr_content_type);
 	headers = curl_slist_append(headers, rpc->hdr_accept);
 	headers = curl_slist_append(headers, needs_100_continue ?
@@ -948,7 +950,6 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	if (rpc->protocol_header)
 		headers = curl_slist_append(headers, rpc->protocol_header);
 
-retry:
 	slot = get_active_slot();
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
@@ -1044,6 +1045,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 	err = run_slot(slot, NULL);
 	if (err == HTTP_REAUTH && !large_request) {
 		credential_fill(&http_auth);
+		curl_slist_free_all(headers);
 		goto retry;
 	}
 	if (err != HTTP_OK)
