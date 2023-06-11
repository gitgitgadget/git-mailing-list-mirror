Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D53C7EE37
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 09:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjFKJF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 05:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 05:05:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0937136
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 02:05:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso23811635e9.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686474353; x=1689066353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ouZoL4QGrMHy1EkWdOFnmzgakHnjGfwC+p74BWowlPg=;
        b=HHyHVWfg1KEVNI6SJVb8mTYDUF5Nx62hNgbrY6dTP7xawqaFnoGtRzRVxHAnPCX5EW
         Hf88OFW5hfLxyc1rg1sUvkWPuGfT9IevttN6YQg3I3IocoB4Q8mtUQX+weQBmtSuJKTC
         k0ZKQS2G7lZLT0Q3URuk+QSH4EoSRr1Fd1oLfchv2LJdAR7KwWbVsAi6dzdgDwX3QaSC
         dfe1Xc9eeIgOFU613l0fBl26wLaibIhg4WULjKi3hrvy/6apC6c81Vc5s3rlwJTEh97m
         EcCbDRK7BDtgxHEaewx97W3LzDJblt0Fs89or1xNfIG7iz7AADgIi67pfkLyrRj0MBbM
         O9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686474353; x=1689066353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouZoL4QGrMHy1EkWdOFnmzgakHnjGfwC+p74BWowlPg=;
        b=TvFIDAUwBGAgft/4qmQpczIgpibN4Bi9/fZ4nnZpjH3e85S7jv/CJa0G5btaPyEkGA
         FgsJ+lFIgEVPysANpnVVIuNgg4yvS0yDiRBhFyas1lV1s+pqqfheHbL5bVK1Rq564aGu
         LEPiX9lfDiLTZPMhwRoYtloO9M8GyXf4K3y2XRVPYt3vcu2MRV+lJ9ARCk3OrCY59iHo
         iwpB111ihqjviYzeWgSXFVgB+WIf0IbIMQSlapKm2ZPRsxlSyVTRo6nT3BHLr1aH3Crw
         lr8F5/JVgFGXfB9+v5ig9jFANnQfIMhPN4eUuaB1yUIrT2xsH3zOQujsZi6JqfwpyBpV
         zhGw==
X-Gm-Message-State: AC+VfDxsEw3SHzbXkUTPekDsw4DLFPvXe3vsUuupEaGW0vxyhQmdfj9b
        YBUpHpj7G3N3KwAa2nFXWyr9KSt6u/U=
X-Google-Smtp-Source: ACHHUZ68TcgLkPvzoBVylai3duADTATZUtreu+VBeDnniW8C7FX/5uLz599U3JVP4SMzpd9ujGrizg==
X-Received: by 2002:a05:600c:5123:b0:3f7:e78e:8a41 with SMTP id o35-20020a05600c512300b003f7e78e8a41mr7994814wms.18.1686474352803;
        Sun, 11 Jun 2023 02:05:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d4683000000b0030aefd11892sm9180999wrq.41.2023.06.11.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 02:05:52 -0700 (PDT)
Message-Id: <pull.1521.git.git.1686474351611.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Jun 2023 09:05:51 +0000
Subject: [PATCH] [RFC] http: reauthenticate on 401 Unauthorized
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

A credential helper may return a bad credential if the user's password
has changed or a personal access token has expired. The user gets
an HTTP 401 Unauthorized error. The user invariably retries the command.

To spare the user from retrying the command, in case of HTTP 401
Unauthorized, call `credential fill` again and reauthenticate. This will
succeed if a helper generates a fresh credential or the user enters a
valid password.

Keep current behaviour of asking user for username and password at
most once. Sanity check that second credential differs from first before
trying it.

Alternatives considered: add a string 'source' field to credential
struct that records which helper (or getpass) populated credential.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    [RFC] http: reauthenticate on 401 Unauthorized
    
    cc. Jeff King peff@peff.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1521%2Fhickford%2Freauth-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1521/hickford/reauth-v1
Pull-Request: https://github.com/git/git/pull/1521

 credential.c                |  1 +
 credential.h                |  4 +++-
 http.c                      | 30 +++++++++++++++++++++++++++---
 t/t5551-http-fetch-smart.sh | 10 ++--------
 t/t5563-simple-http-auth.sh |  3 +++
 5 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/credential.c b/credential.c
index 023b59d5711..00fea51800c 100644
--- a/credential.c
+++ b/credential.c
@@ -379,6 +379,7 @@ void credential_fill(struct credential *c)
 			    c->helpers.items[i].string);
 	}
 
+	c->getpass = 1;
 	credential_getpass(c);
 	if (!c->username && !c->password)
 		die("unable to get password from user");
diff --git a/credential.h b/credential.h
index b8e2936d1dc..c176b05981a 100644
--- a/credential.h
+++ b/credential.h
@@ -134,7 +134,9 @@ struct credential {
 		 configured:1,
 		 quit:1,
 		 use_http_path:1,
-		 username_from_proto:1;
+		 username_from_proto:1,
+		 /* Whether the user has been prompted for username or password. */
+		 getpass:1;
 
 	char *username;
 	char *password;
diff --git a/http.c b/http.c
index bb58bb3e6a3..d2897c4d9d1 100644
--- a/http.c
+++ b/http.c
@@ -1732,7 +1732,11 @@ static int handle_curl_result(struct slot_results *results)
 	else if (results->http_code == 401) {
 		if (http_auth.username && http_auth.password) {
 			credential_reject(&http_auth);
-			return HTTP_NOAUTH;
+			if (http_auth.getpass) {
+				/* Previously prompted user, don't prompt again. */
+				return HTTP_NOAUTH;
+			}
+			return HTTP_REAUTH;
 		} else {
 			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
 			if (results->auth_avail) {
@@ -2125,6 +2129,9 @@ static int http_request_reauth(const char *url,
 			       struct http_get_options *options)
 {
 	int ret = http_request(url, result, target, options);
+	int reauth = 0;
+	char* first_username;
+	char* first_password;
 
 	if (ret != HTTP_OK && ret != HTTP_REAUTH)
 		return ret;
@@ -2140,6 +2147,9 @@ static int http_request_reauth(const char *url,
 	if (ret != HTTP_REAUTH)
 		return ret;
 
+	credential_fill(&http_auth);
+
+reauth:
 	/*
 	 * The previous request may have put cruft into our output stream; we
 	 * should clear it out before making our next request.
@@ -2163,9 +2173,23 @@ static int http_request_reauth(const char *url,
 		BUG("Unknown http_request target");
 	}
 
-	credential_fill(&http_auth);
+	first_username = xstrdup(http_auth.username);
+	first_password = xstrdup(http_auth.password);
+	ret = http_request(url, result, target, options);
+	if (ret == HTTP_REAUTH && reauth++ == 0) {
+		credential_fill(&http_auth);
+		/* Sanity check that second credential differs from first. */
+		if (strcmp(first_username, http_auth.username)
+		|| strcmp(first_password, http_auth.password)) {
+			free(first_username);
+			free(first_password);
+			goto reauth;
+		}
+	}
 
-	return http_request(url, result, target, options);
+	free(first_username);
+	free(first_password);
+	return ret;
 }
 
 int http_get_strbuf(const char *url,
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 21b7767cbd3..be2e76133c1 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -589,14 +589,8 @@ test_expect_success 'http auth forgets bogus credentials' '
 		echo "password=bogus"
 	} | git credential approve &&
 
-	# we expect this to use the bogus values and fail, never even
-	# prompting the user...
-	set_askpass user@host pass@host &&
-	test_must_fail git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
-	expect_askpass none &&
-
-	# ...but now we should have forgotten the bad value, causing
-	# us to prompt the user again.
+	# we expect this to use the bogus values and fail, forget the bad value,
+	# then reauthenticate, prompting the user
 	set_askpass user@host pass@host &&
 	git ls-remote "$HTTPD_URL/auth/smart/repo.git" >/dev/null &&
 	expect_askpass both user@host
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index ab8a721ccc7..1e7e426bc65 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -111,6 +111,9 @@ test_expect_success 'access using basic auth invalid credentials' '
 	protocol=http
 	host=$HTTPD_DEST
 	wwwauth[]=Basic realm="example.com"
+	protocol=http
+	host=$HTTPD_DEST
+	wwwauth[]=Basic realm="example.com"
 	EOF
 
 	expect_credential_query erase <<-EOF

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
