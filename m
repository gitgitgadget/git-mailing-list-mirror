From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] http.c: use 'git_config_string' to get 'curl_http_proxy'
Date: Sun,  7 Dec 2008 01:45:37 +0100
Message-ID: <1228610737-8853-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 01:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L97m4-0003Cj-Q7
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 01:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYLGAoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 19:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbYLGAoI
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 19:44:08 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45004 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYLGAoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 19:44:08 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 0524A446CDB;
	Sun,  7 Dec 2008 01:44:05 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 12F8219DC9B; Sun,  7 Dec 2008 01:45:37 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.35.gae26e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102487>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 http.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index ed59b79..ee58799 100644
--- a/http.c
+++ b/http.c
@@ -24,7 +24,7 @@ static const char *ssl_cainfo = NULL;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv = 0;
-static char *curl_http_proxy = NULL;
+static const char *curl_http_proxy = NULL;
 
 static struct curl_slist *pragma_header;
 
@@ -149,11 +149,8 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp("http.proxy", var)) {
-		if (curl_http_proxy == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			curl_http_proxy = xstrdup(value);
-		}
+		if (curl_http_proxy == NULL)
+			return git_config_string(&curl_http_proxy, var, value);
 		return 0;
 	}
 
@@ -309,7 +306,7 @@ void http_cleanup(void)
 	pragma_header = NULL;
 
 	if (curl_http_proxy) {
-		free(curl_http_proxy);
+		free((void *)curl_http_proxy);
 		curl_http_proxy = NULL;
 	}
 }
-- 
1.6.1.rc1.35.gae26e.dirty
