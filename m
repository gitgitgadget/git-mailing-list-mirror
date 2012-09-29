From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/9] longest_ancestor_length(): always add a slash to the end of prefixes
Date: Sat, 29 Sep 2012 08:15:59 +0200
Message-ID: <1348899362-4057-7-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqMB-0002Xr-5g
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758468Ab2I2GQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:36 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:61775 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758315Ab2I2GQc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:32 -0400
X-AuditID: 1207440d-b7f236d000000943-42-5066924035aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C2.2B.02371.04296605; Sat, 29 Sep 2012 02:16:32 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G743026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:31 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqOswKS3A4OdzIYuuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M5Y
	2h1V8Je74mLLEsYGxhWcXYycHBICJhJt3ZtZIWwxiQv31rN1MXJxCAlcZpTY+XsDE4Rzlkmi
	b/8uJpAqNgFdiUU9zWC2iICaxMS2QywgRcwCkxglejY8YAdJCAvESFw6sRbMZhFQldi2pxus
	gVfAWWL327tMEOsUJX58X8MMYnMKuEj87pkOdoYQUM2jvXdYJzDyLmBkWMUol5hTmqubm5iZ
	U5yarFucnJiXl1qka6SXm1mil5pSuokREki8Oxj/r5M5xCjAwajEw6t5PDVAiDWxrLgy9xCj
	JAeTkijv5wlpAUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeDOKgcp5UxIrq1KL8mFS0hwsSuK8
	akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8hhOBhgoWpaanVqRl5pQgpJk4OEEEF8gGHqANLCCF
	vMUFibnFmekQRacYFaXEeUVAEgIgiYzSPLgBsJh/xSgO9I8wrxBIFQ8wXcB1vwIazAQ0eOmm
	JJDBJYkIKakGRv/i3qTkvQ2Xg628zsdVruRemmw+c0a2xMfgvvsr/n39+Tzx9qILTSFL7mfZ
	up1XUjCyFj3VeG9GeuVdnUnbr6XvD9/5uPHaXWaOZec19i0yOH9I1X7JiymXAlfOvystzrl5
	5h7Rt/2t+2qENx/Lf7dlxg5Rh2tBSXaznNdsS8/pcOKNLeAqnabEUpyRaKjFXFSc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206639>

Previously we stripped off any slashes that were present.  Instead,
add a slash if it is missing.  This removes the need for an extra
check that path has a slash following the prefix and makes the
handling of the root directory more natural, making the way clear to
use string_list_longest_prefix().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index b255a74..a56c64a 100644
--- a/path.c
+++ b/path.c
@@ -570,7 +570,7 @@ int normalize_path_copy(char *dst, const char *src)
 
 static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 {
-	char buf[PATH_MAX+1];
+	char buf[PATH_MAX+2];
 	const char *ceil = item->string;
 	int len = strlen(ceil);
 
@@ -579,8 +579,10 @@ static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 	if (normalize_path_copy(buf, ceil) < 0)
 		return 0;
 	len = strlen(buf);
-	if (len > 0 && buf[len-1] == '/')
-		buf[--len] = '\0';
+	if (len == 0 || buf[len-1] != '/') {
+		buf[len++] = '/';
+		buf[len++] = '\0';
+	}
 	free(item->string);
 	item->string = xstrdup(buf);
 	return 1;
@@ -615,9 +617,8 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 		int len = strlen(ceil);
 
 		if (!strncmp(path, ceil, len) &&
-		    path[len] == '/' &&
-		    len > max_len) {
-			max_len = len;
+		    len - 1 > max_len) {
+			max_len = len - 1;
 		}
 	}
 
-- 
1.7.11.3
