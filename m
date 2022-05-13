Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F63BC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 07:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377721AbiEMHNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377724AbiEMHMs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 03:12:48 -0400
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 00:12:46 PDT
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625581C15FA
        for <git@vger.kernel.org>; Fri, 13 May 2022 00:12:45 -0700 (PDT)
Received: by psionic.psi5.com (Postfix, from userid 1002)
        id 813BE3F1B6; Fri, 13 May 2022 09:04:42 +0200 (CEST)
From:   Simon.Richter@hogyros.de
To:     git@vger.kernel.org
Cc:     Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 1/3] Rename proxy_authmethods -> authmethods
Date:   Fri, 13 May 2022 09:04:14 +0200
Message-Id: <20220513070416.37235-2-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513070416.37235-1-Simon.Richter@hogyros.de>
References: <20220513070416.37235-1-Simon.Richter@hogyros.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Richter <Simon.Richter@hogyros.de>

Curl also allows specifying a list of acceptable auth methods for the
request itself, so this isn't specific to proxy authentication.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 http.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/http.c b/http.c
index 229da4d148..318dc5daea 100644
--- a/http.c
+++ b/http.c
@@ -79,7 +79,7 @@ static int proxy_ssl_cert_password_required;
 static struct {
 	const char *name;
 	long curlauth_param;
-} proxy_authmethods[] = {
+} authmethods[] = {
 	{ "basic", CURLAUTH_BASIC },
 	{ "digest", CURLAUTH_DIGEST },
 	{ "negotiate", CURLAUTH_GSSNEGOTIATE },
@@ -470,14 +470,14 @@ static void init_curl_proxy_auth(CURL *result)
 
 	if (http_proxy_authmethod) {
 		int i;
-		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
-			if (!strcmp(http_proxy_authmethod, proxy_authmethods[i].name)) {
+		for (i = 0; i < ARRAY_SIZE(authmethods); i++) {
+			if (!strcmp(http_proxy_authmethod, authmethods[i].name)) {
 				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
-						proxy_authmethods[i].curlauth_param);
+						authmethods[i].curlauth_param);
 				break;
 			}
 		}
-		if (i == ARRAY_SIZE(proxy_authmethods)) {
+		if (i == ARRAY_SIZE(authmethods)) {
 			warning("unsupported proxy authentication method %s: using anyauth",
 					http_proxy_authmethod);
 			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-- 
2.30.2

