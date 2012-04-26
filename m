From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH] Try an uppercase version of $prot_proxy env var
Date: Thu, 26 Apr 2012 15:16:51 +0200
Message-ID: <4F994AC3.2070708@seap.minhap.es>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com><4F966F0C.6090504@seap.minhap.es> <xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 14:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNNhg-0001ka-EF
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 14:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497Ab2DZMVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 08:21:39 -0400
Received: from luthien2.map.es ([82.150.0.102]:51848 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756472Ab2DZMVj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 08:21:39 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id CE22CB7450;
	Thu, 26 Apr 2012 14:19:35 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 361832C2A5;
	Thu, 26 Apr 2012 14:19:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: CE22CB7450.2C93C
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336047584.94396@ZN+3cMk12FoYWzfaSXIg3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196364>


Try an uppercase version of $prot_proxy env var when thelowercase version 
is not found.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
This is for pu branch where http-proxy-more is located.

 http.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 6a98195..bf9c20e 100644
--- a/http.c
+++ b/http.c
@@ -329,6 +329,13 @@ static CURL *get_curl_handle(const char *url)
 		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
 		env_proxy_var = strbuf_detach(&buf, NULL);
 		env_proxy = getenv(env_proxy_var);
+		if (!env_proxy) {
+			char *p;
+			for (p = env_proxy_var; *p; p++) {
+				*p = toupper(*p);
+			}
+			env_proxy = getenv(env_proxy_var);
+		}
 		if (env_proxy) {
 			read_http_proxy = 1;
 			no_proxy = getenv("no_proxy");
-- 
1.7.7.6
