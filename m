From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: [PATCH] http: support curl < 7.10.7
Date: Tue, 3 Feb 2015 18:30:08 +0100
Message-ID: <1422984608-3822-1-git-send-email-tgc@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:30:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIhIq-0005D2-3X
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 18:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbbBCRaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 12:30:15 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:3106 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756088AbbBCRaL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2015 12:30:11 -0500
Received: from throll.localdomain (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.389.2; Tue, 3 Feb 2015 18:30:08 +0100
Received: by throll.localdomain (Postfix, from userid 3000)	id 1B4C0400EC1;
 Tue,  3 Feb 2015 18:30:08 +0100 (CET)
X-Mailer: git-send-email 2.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263326>

Commit dd61399 introduced support for http proxies that require
authentication but it relies on the CURL_PROXYAUTH option which was
added in curl 7.10.7.
This makes sure proxy authentication is only enabled if libcurl can
support it.

Signed-off-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
---

RHEL3 ships with curl 7.10.6 so without this change it is not possible
to build with http support.

 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index 040f362..4e4dd92 100644
--- a/http.c
+++ b/http.c
@@ -369,7 +369,9 @@ static CURL *get_curl_handle(void)
 
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+#if LIBCURL_VERSION_NUM >= 0x070a07
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+#endif
 	}
 
 	set_curl_keepalive(result);
-- 
2.2.2
