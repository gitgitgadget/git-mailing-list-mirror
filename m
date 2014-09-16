From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 31/35] trim_last_path_component(): replace last_path_elm()
Date: Tue, 16 Sep 2014 21:33:52 +0200
Message-ID: <1410896036-12750-32-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:35:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWu-0000VY-9D
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbaIPTfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:35:05 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43317 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755040AbaIPTfE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:35:04 -0400
X-AuditID: 1207440e-f79da6d0000002fc-19-541890e7b1e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DC.49.00764.7E098145; Tue, 16 Sep 2014 15:35:03 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcZ001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:35:02 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqPt8gkSIQes9OYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOePLyCVPBLaGKK3f+szUwzufrYuTkkBAwkXj+4wkr
	hC0mceHeerYuRi4OIYHLjBIrlq9jhnBOMEls/naWHaSKTUBXYlFPMxNIQkSgjVFi18XNrCAO
	s0A3o8T7E6eZQKqEBXwlnvz7A2azCKhKPJjxCKybV8BVYu+PV+wQ++QkNuz+z9jFyMHBCRT/
	uq8AxBQScJE4eNdvAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxgh
	gce3g7F9vcwhRgEORiUeXo9H4iFCrIllxZW5hxglOZiURHn/dUuECPEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLh/eELlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDO
	6wdqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFRnwxMDpAUjxAezeDtPMWFyTm
	AkUhWk8x6nKs6/zWzyTEkpeflyolzmsDUiQAUpRRmge3ApZmXjGKA30szLsFpIoHmKLgJr0C
	WsIEtORsjxjIkpJEhJRUA2OJAVu8pC/fH0evLQJ/2mV+LNr7vMum9KGmpeQ8owlKLuUrTXo2
	K9d21GjyFPI8NvLPPJlnuf00t+yPQzMevnkkId0hlvpfoapov4N/1KWQPzaPT4nY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257156>

Rewrite last_path_elm() to take a strbuf parameter and to trim off the
last path name element in place rather than returning a pointer to the
beginning of the last path name element. This simplifies the function
a bit and makes it integrate better with its caller, which is now also
strbuf-based. Rename the function accordingly and a bit less tersely.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index e689a84..3d5ab4f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -91,32 +91,28 @@ static void remove_lock_file_on_signal(int signo)
 }
 
 /*
- * p = absolute or relative path name
+ * path = absolute or relative path name
  *
- * Return a pointer into p showing the beginning of the last path name
- * element.  If p is empty or the root directory ("/"), just return p.
+ * Remove the last path name element from path (leaving the preceding
+ * "/", if any).  If path is empty or the root directory ("/"), set
+ * path to the empty string.
  */
-static char *last_path_elm(char *p)
+static void trim_last_path_component(struct strbuf *path)
 {
-	/* r starts pointing to null at the end of the string */
-	char *r = strchr(p, '\0');
-
-	if (r == p)
-		return p; /* just return empty string */
-
-	r--; /* back up to last non-null character */
+	int i = path->len;
 
 	/* back up past trailing slashes, if any */
-	while (r > p && *r == '/')
-		r--;
+	while (i && path->buf[i - 1] == '/')
+		i--;
 
 	/*
-	 * then go backwards until I hit a slash, or the beginning of
-	 * the string
+	 * then go backwards until a slash, or the beginning of the
+	 * string
 	 */
-	while (r > p && *(r-1) != '/')
-		r--;
-	return r;
+	while (i && path->buf[i - 1] != '/')
+		i--;
+
+	strbuf_setlen(path, i);
 }
 
 
@@ -146,14 +142,12 @@ static void resolve_symlink(struct strbuf *path)
 		if (is_absolute_path(link.buf))
 			/* absolute path simply replaces p */
 			strbuf_reset(path);
-		else {
+		else
 			/*
 			 * link is a relative path, so replace the
 			 * last element of p with it.
 			 */
-			char *r = last_path_elm(path->buf);
-			strbuf_setlen(path, r - path->buf);
-		}
+			trim_last_path_component(path);
 
 		strbuf_addbuf(path, &link);
 	}
-- 
2.1.0
