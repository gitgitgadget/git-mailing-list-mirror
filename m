From: Bernhard Reiter <ockham@raz.or.at>
Subject: [PATCH] http.c: die if curl_*_init fails
Date: Wed, 13 Aug 2014 19:31:24 +0200
Message-ID: <53EBA0EC.9000007@raz.or.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050108090600020602030901"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 19:31:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHcOc-0000qp-Px
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 19:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbaHMRb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 13:31:28 -0400
Received: from mhub.domainplanet.at ([92.43.99.119]:58230 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697AbaHMRb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 13:31:27 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 42C5C9D2FA4
	for <git@vger.kernel.org>; Wed, 13 Aug 2014 19:31:25 +0200 (CEST)
Received: from [10.0.0.88] (91-113-43-166.adsl.highway.telekom.at [91.113.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 17C4CBF4F4
	for <git@vger.kernel.org>; Wed, 13 Aug 2014 19:31:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255221>

This is a multi-part message in MIME format.
--------------050108090600020602030901
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
---
 http.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)



--------------050108090600020602030901
Content-Type: text/x-patch;
 name="0002-http.c-die-if-curl_-_init-fails.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-http.c-die-if-curl_-_init-fails.patch"

diff --git a/http.c b/http.c
index c8cd50d..afe4fc5 100644
--- a/http.c
+++ b/http.c
@@ -300,6 +300,9 @@ static CURL *get_curl_handle(void)
 {
 	CURL *result = curl_easy_init();
 
+	if (!result)
+		die("curl_easy_init failed");
+
 	if (!curl_ssl_verify) {
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
@@ -399,7 +402,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	git_config(urlmatch_config_entry, &config);
 	free(normalized_url);
 
-	curl_global_init(CURL_GLOBAL_ALL);
+	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
+		die("curl_global_init failed");
 
 	http_proactive_auth = proactive_auth;
 


--------------050108090600020602030901--
