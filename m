From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 32/39] trim_last_path_component(): replace last_path_elm()
Date: Fri, 26 Sep 2014 12:08:32 +0200
Message-ID: <1411726119-31598-33-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTJ-0004Bi-PG
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbaIZKJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:45 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58136 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755693AbaIZKJn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:43 -0400
X-AuditID: 12074412-f792e6d000005517-d0-54253b667164
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E8.68.21783.66B35245; Fri, 26 Sep 2014 06:09:42 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMH013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:41 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1E2zVg0xmNygadF1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd8ahhlWsBbeEKh68m8XUwDifr4uR
	k0NCwERiztTVbBC2mMSFe+vBbCGBy4wS7ecKuxi5gOxNTBK9J36xgCTYBHQlFvU0M4HYIgJq
	EhPbDrGAFDELLGaSmHBoE1i3sICvRMeUyWANLAKqEnfmPgOL8wq4SnSc7mOC2CYnsWH3f0YQ
	mxMo3rj9GiPEZheJlvWTWSYw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopea
	UrqJERKMQjsY15+UO8QowMGoxMN7Y51KiBBrYllxZe4hRkkOJiVR3i8WqiFCfEn5KZUZicUZ
	8UWlOanFhxglOJiVRHjvGAHleFMSK6tSi/JhUtIcLErivD8Xq/sJCaQnlqRmp6YWpBbBZGU4
	OJQkeK2sgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQbERXwyMDpAUD9BeD5B2
	3uKCxFygKETrKUZdjnWd3/qZhFjy8vNSpcR5j1gCFQmAFGWU5sGtgKWeV4ziQB8L8/qCjOIB
	pi24Sa+AljABLVE6ogyypCQRISXVwDj96Nc+PuVX1rO3rtZztza552/V7pmvu34XT53GO65O
	00uz13V2Tnl4i3X5VNl3bJvEP2ouqL78POFKrwdfaG9R8QyvvL2NMVb2t+bc3Rud 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257519>

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
index 5f5bcff..56ad7e8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -76,32 +76,28 @@ static void remove_lock_file_on_signal(int signo)
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
 
 
@@ -131,14 +127,12 @@ static void resolve_symlink(struct strbuf *path)
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
