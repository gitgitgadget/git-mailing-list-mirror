Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351B28F4
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740275715; cv=none; b=CbKx0/RFHrZJoYrmw2LVE5N+LNs6znFCoiKTgAg5PL03dAH2uIwZkPpzfasmS6BqCW+JADyAbaGQqfwiOWzeybTcgRYYwZklPHQGv0OWt+Wm1NVNh4Kp90/4tcx+2qPcwfG8KChXrON5GKdIQvsDbv5o03vGGVGZ5MUpDpOlYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740275715; c=relaxed/simple;
	bh=o1ffVx6xjGLp4x3KzgJ8Bmf5CznHEAFkpN4PGA8lGoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjoLXE5xHNwP5HxL2wDib8gCUoDl+6qoHQuMm6/VTBAMYZE1FZSOn1gl2v97DWyvKAhxbb/Q/AScd9XhtMWuDEYdiYFCn0WWh6O/SXr/dbNqkghecun2dsbOTO5Z59yco3kHcJNkWUYLtSsJEh9rHZLr+3qXvrWcqvd6+2xPN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Wj/32zT8; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Wj/32zT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1740275704;
	bh=o1ffVx6xjGLp4x3KzgJ8Bmf5CznHEAFkpN4PGA8lGoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Wj/32zT8ZK1jBdtC7Ef4Pj9194CCRJr8zsrNC4SwIxmp6PR9vSxqURCuhEAMGldKn
	 sVQoAAq4s9ia4mMim80MiLU0nLJ/BcpirGGQ7o8DpmAILBmUD7J1iJ31aR/wDchAQw
	 ouiveBuXZuzHmMYLowPbcS3Bs2VMrlD9X1HMjsu8hL5kwjljU6G5XleyFqxWpAWBDl
	 ZRK8eSBycsBSP/R+memal5LT6axYUSZHKzYJmLhFA7IMAqu9QRe2zx4yepcwp0gRSf
	 T09wdyFMAmnJr4QyEaH96UfA7ZDpsIBa9WDm2vsWKUy4oKKqCBkm1iva2vg/hpjZJJ
	 YOBaPkDeFHWlOChhsvZn1o9tMXbmJryV51nG9tgoZc8rJL807B8NDbpGndlj5IW1iY
	 Ohj08d+p76tDSuE97C1W3qi4Eh/zP5JyokGi53liAGvwEfMLDv/rKrso01IHiBta0E
	 yoDIqKjQFht+74/VYJCIUaEDfWYVx6tGR196Y40yUd7ap8yGJQX
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ABB0F2448F;
	Sun, 23 Feb 2025 01:55:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Georg <peter.georg@physik.uni-regensburg.de>
Subject: [PATCH 1/1] http: allow using netrc for WebDAV-based HTTP protocol
Date: Sun, 23 Feb 2025 01:53:31 +0000
Message-ID: <20250223015331.588161-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.48.0.rc1.219.gb6b6757d772
In-Reply-To: <20250223015331.588161-1-sandals@crustytoothpaste.net>
References: <Z7UPYY24uk7lLzeP@tapette.crustytoothpaste.net>
 <20250223015331.588161-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an extended period of time, we've enabled libcurl's netrc
functionality, which will read credentials from the netrc file if none
are provided.  Unfortunately, we have also not documented this fact or
written any tests for it, but people have come to rely on it.

In 610cbc1dfb ("http: allow authenticating proactively", 2024-07-10), we
accidentally broke the ability of users to use the netrc file for the
WebDAV-based HTTP protocol.  Notably, it works on the initial request
but does not work on subsequent requests, which causes failures because
that version of the protocol will necessarily make multiple requests.

This happens because curl_empty_auth_enabled never returns -1, only 0 or
1, and so if http.proactiveAuth is not enabled, the username and
password are always set to empty credentials, which prevents libcurl's
fallback to netrc from working.  However, in other cases, the server
continues to get a 401 response and the credential helper is invoked,
which is the normal behavior, so this was not noticed earlier.

To fix this, change the condition to check for enabling empty auth and
also not having proactive auth enabled, which should result in the
username and password not being set to a single colon in the typical
case, and thus the netrc file being used.

Reported-by: Peter Georg <peter.georg@physik.uni-regensburg.de>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http.c                      |  3 +--
 t/t5540-http-push-webdav.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index f4504133e8..0c9a872809 100644
--- a/http.c
+++ b/http.c
@@ -598,8 +598,7 @@ static void init_curl_http_auth(CURL *result)
 {
 	if ((!http_auth.username || !*http_auth.username) &&
 	    (!http_auth.credential || !*http_auth.credential)) {
-		int empty_auth = curl_empty_auth_enabled();
-		if ((empty_auth != -1 && !always_auth_proactively()) || empty_auth == 1) {
+		if (!always_auth_proactively() && curl_empty_auth_enabled()) {
 			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
 			return;
 		} else if (!always_auth_proactively()) {
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 37db3dec0c..3fa05ff185 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -201,4 +201,14 @@ test_expect_failure 'push to password-protected repository (no user in URL)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push to password-protected repository (netrc)' '
+	test_commit pw-netrc &&
+	echo "default login user@host password pass@host" >"$HOME/.netrc" &&
+	GIT_TRACE=1 GIT_CURL_VERBOSE=1 git push "$HTTPD_URL/auth/dumb/test_repo.git" HEAD &&
+	git rev-parse --verify HEAD >expect &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/test_repo.git" \
+		rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
