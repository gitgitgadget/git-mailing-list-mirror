From: Enrique Tobis <Enrique.Tobis@twosigma.com>
Subject: [PATCH] http: always use any proxy auth method available
Date: Fri, 26 Jun 2015 18:19:04 +0000
Message-ID: <FCAB894186380D42A07AFFFA5A1282B8F1EC65FD@EXMBNJE2.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>,
	'Nelson Benitez Leon' <nbenitezl@gmail.com>
To: "'gitster@pobox.com'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 20:25:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8YJq-0002Z5-9P
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 20:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbbFZSZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 14:25:38 -0400
Received: from mxl2.aoa.dmz.twosigma.com ([208.77.215.146]:56181 "EHLO
	mxl2.aoa.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbFZSZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 14:25:36 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2015 14:25:36 EDT
Received: by mxl2.aoa.dmz.twosigma.com (Postfix, from userid 111)
	id A64DB600B4; Fri, 26 Jun 2015 18:19:06 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	mxl2.aoa.dmz.twosigma.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9 autolearn=no
	version=3.3.2
Received: from EXHTNJE2.ad.twosigma.com (exhtnje2.ad.twosigma.com [172.20.32.80])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mxl2.aoa.dmz.twosigma.com (Postfix) with ESMTPS id CFB8E600B0;
	Fri, 26 Jun 2015 18:19:05 +0000 (GMT)
Received: from EXMBNJE2.ad.twosigma.com ([169.254.2.157]) by
 EXHTNJE2.ad.twosigma.com ([172.20.32.80]) with mapi id 14.03.0224.002; Fri,
 26 Jun 2015 14:19:05 -0400
Thread-Topic: [PATCH] http: always use any proxy auth method available
Thread-Index: AdCwOo62xtSDc71ITZiaogSfyRcNiA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.60.10]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272811>

By default, libcurl honors some environment variables that specify a
proxy (e.g. http_proxy, https_proxy). Also by default, libcurl will
only try to authenticate with a proxy using the Basic method. This
change makes libcurl always try the most secure proxy authentication
method available. As a consequence, you can use environment variables
to instruct git to use a proxy that uses an authentication method
different from Basic (e.g. Negotiate).

Signed-off-by: Enrique A. Tobis <etobis@twosigma.com>
---
 http.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index f0c5bbc..e9c6fdd 100644
--- a/http.c
+++ b/http.c
@@ -416,10 +416,10 @@ static CURL *get_curl_handle(void)
 
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+	}
 #if LIBCURL_VERSION_NUM >= 0x070a07
-		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 #endif
-	}
 
 	set_curl_keepalive(result);
 
-- 
1.7.3
