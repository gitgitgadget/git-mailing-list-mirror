From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 31/38] trim_last_path_component(): replace last_path_elm()
Date: Wed,  1 Oct 2014 12:28:35 +0200
Message-ID: <1412159322-2622-32-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAl-0002zK-OL
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbaJAK3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:44 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42567 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728AbaJAK3n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:43 -0400
X-AuditID: 12074414-f79446d000001f1d-9c-542bd7963cb1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 18.61.07965.697DB245; Wed,  1 Oct 2014 06:29:42 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6U026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:41 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1J12XTvEoLNR36LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oxDDatYC24JVTx4N4upgXE+Xxcj
	J4eEgInEvVffmCBsMYkL99azdTFycQgJXGaUODH/PJRznEliwbMvzCBVbAK6Eot6msE6RATU
	JCa2HWIBKWIWWMwkMeHQJjaQhLCAr8S0qzsYuxg5OFgEVCV2tSWDhHkFXCQOrZzLDLFNTmLD
	7v+MIDYnUHz55WYWEFtIwFlix52vTBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0rXQ
	y80s0UtNKd3ECAlGkR2MR07KHWIU4GBU4uFVSNAOEWJNLCuuzD3EKMnBpCTKu+gSUIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIb/YBoBxvSmJlVWpRPkxKmoNFSZz322J1PyGB9MSS1OzU1ILU
	IpisDAeHkgQvwzWgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQbMQXA6MDJMUD
	tNcZpJ23uCAxFygK0XqKUZdjXee3fiYhlrz8vFQpcd5MkCIBkKKM0jy4FbDU84pRHOhjYd5w
	kCoeYNqCm/QKaAkT0JLkNWBLShIRUlINjJrKjIGv53CLrInN5+JY135sY050aLopZ0p2lI1y
	jhPTvZNin/l2h8csSXf4bH7KuNb59szHn99WLlr+XyDOv5vLhuPrj1/ZvobRqtYX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257723>

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
