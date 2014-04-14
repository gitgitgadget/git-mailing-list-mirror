From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 25/25] trim_last_path_elm(): replace last_path_elm()
Date: Mon, 14 Apr 2014 15:54:55 +0200
Message-ID: <1397483695-10888-26-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMp-0001AN-RO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbaDNN4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:56:06 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49201 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755213AbaDNNzu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:50 -0400
X-AuditID: 12074411-f79ab6d000002f0e-2b-534be8e6d940
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.A6.12046.6E8EB435; Mon, 14 Apr 2014 09:55:50 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09P010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:48 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqPvshXewwbM+bouuK91MFg29V5gt
	Vv6ssbi9Yj6zxa/DT9gtfrT0MFucedPIaNHZ8ZXRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/F
	D7w8Pm+S87j7fyeTx+1n21gCOKK4bZISS8qCM9Pz9O0SuDMe/J3PXLBVqOLvhlfsDYz/eLsY
	OTkkBEwklnfMYIOwxSQu3FsPZHNxCAlcZpR4c+soC4RzkkniUtt9FpAqNgFdiUU9zUwgtoiA
	msTEtkNgRcwC7UwSh3b0giWEBdwl7rQdYO5i5OBgEVCV+PLRDiTMK+Aq8XzDe6htchInj01m
	BSnhBIov/JAFEhYScJG4+2UK6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL
	9FJTSjcxQkJRcAfjjJNyhxgFOBiVeHg75ngHC7EmlhVX5h5ilORgUhLlzbgBFOJLyk+pzEgs
	zogvKs1JLT7EKMHBrCTC67oVKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV
	4eBQkuA1BsackGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB2pv0
	HGRvcUFiLlAUovUUo6KUOG8JSEIAJJFRmgc3FpZgXjGKA30pzCsBsp0HmJzgul8BDWYCGszS
	Dja4JBEhJdXAOH3Lz4kni5/we07eXHFTgP+G5ht7rhutpU1MzxcGqv2fU3+q867QTYHzLw32
	SFrrun52Mjzt80TDWUjQyr6BZ637p4crhUS/hPf1xScs1fhzca3Zp7OyXZ8nvLoc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246235>

Rewrite last_path_elm() to take a strbuf parameter and to trim off the
last path name element in place rather than returning a pointer to the
beginning of the last path name element.  This simplifies the function
a bit and makes it integrate better with its caller, which is also
strbuf-based.  Rename the function accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 65f56ef..2515577 100644
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
+static void trim_last_path_elm(struct strbuf *path)
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
+			trim_last_path_elm(path);
 
 		strbuf_addbuf(path, &link);
 	}
-- 
1.9.1
