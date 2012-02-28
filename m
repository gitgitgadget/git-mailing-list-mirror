From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 2/3] http: try standard proxy env vars when http.proxy config
 option is not set
Date: Tue, 28 Feb 2012 13:54:34 +0100
Message-ID: <4F4CCE8A.4010800@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 12:57:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Lgf-0004Od-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189Ab2B1L5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 06:57:06 -0500
Received: from luthien2.mpt.es ([213.9.211.102]:4401 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab2B1L5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:57:05 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Feb 2012 06:57:05 EST
Received: from correo.map.es (unknown [10.1.31.68])
	by luthien2.map.es (Postfix) with ESMTP id 43CA224EAB;
	Tue, 28 Feb 2012 12:55:56 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 2A84A1800D2;
	Tue, 28 Feb 2012 12:55:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 43CA224EAB.97758
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331034956.65507@0tZ6JQR8oDyhD4WA+6u81A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191712>

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 8ac8eb6..79cbe50 100644
--- a/http.c
+++ b/http.c
@@ -295,6 +295,16 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
+	if (!curl_http_proxy) {
+		const char *env_proxy;
+		env_proxy = getenv("HTTP_PROXY");
+		if (!env_proxy) {
+			env_proxy = getenv("http_proxy");
+		}
+		if (env_proxy) {
+			curl_http_proxy = xstrdup(env_proxy);
+		}
+	}
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-- 
1.7.7.6
