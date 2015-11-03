From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 12/25] refs: move check_refname_format to the common code
Date: Tue,  3 Nov 2015 08:39:56 +0100
Message-ID: <4dad486935e0752408c29ab20ec4acd74a35d1e4.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWCp-0007Ij-LV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbbKCHkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:33 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48281 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752677AbbKCHkb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:31 -0500
X-AuditID: 12074411-f797e6d000007df3-ec-563864ee5458
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.B5.32243.EE468365; Tue,  3 Nov 2015 02:40:30 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd9016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:29 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPsuxSLM4Mp0aYv5m04wWnRd6Way
	aOi9wmxxe8V8Zot/E2ocWD3+vv/A5LFgU6nHxUvKHgue32f3+LxJLoA1itsmKbGkLDgzPU/f
	LoE74/riuILj9hUtRw8zNTB+0e9i5OSQEDCR+LWwmQnCFpO4cG89WxcjF4eQwGVGiea7b5kg
	nGNMEhPX/GAHqWIT0JVY1APRISKgJjGx7RALSBGzwCJGidY308ESwgI+Eoc+rWIBsVkEVCXO
	/loJZvMKREnsnHqaBWKdnMSU++1g9ZwCFhIP7v4BWyAkYC6x6d4ytgmMvAsYGVYxyiXmlObq
	5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihASU4A7GGSflDjEKcDAq8fAuWGIeJsSaWFZc
	mXuIUZKDSUmUd12MRZgQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6CQKAcb0piZVVqUT5MSpqD
	RUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCdyIwcoQEi1LTUyvSMnNKENJMHJwgw7mkRIpT
	81JSixJLSzLiQbERXwyMDpAUD9Delckge4sLEnOBohCtpxgVpcR5J4MkBEASGaV5cGNhaeIV
	ozjQl8K8F0CqeIApBq77FdBgJqDB4dtMQQaXJCKkpBoYdZI2RE/rc321O+xmZuPS52aKq1dl
	LJdJsc2b4WHCrJ+5T/3thEXdTNnveeLdv5c/Xn3lUaNA4trEd30RUhV/ziU+v1H4Qf/rHh2W
	yAvurFcKJPXma7NLno85HnryOxPnktCc+oB408vreFc0X9o+53b0CvULp3VS32wx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280758>

From: Ronnie Sahlberg <sahlberg@google.com>

This function does not contain any backend specific code so move it to
the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 109 ---------------------------------------------------
 refs/refs.c          | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f84fa9e..545075f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -14,27 +14,6 @@ struct ref_lock {
 };
 
 /*
- * How to handle various characters in refnames:
- * 0: An acceptable character for refs
- * 1: End-of-component
- * 2: ., look for a preceding . to reject .. in refs
- * 3: {, look for a preceding @ to reject @{ in refs
- * 4: A bad character: ASCII control characters, and
- *    ":", "?", "[", "\", "^", "~", SP, or TAB
- * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
- */
-static unsigned char refname_disposition[256] = {
-	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
-};
-
-/*
  * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
  * refs (i.e., because the reference is about to be deleted anyway).
  */
@@ -69,94 +48,6 @@ static unsigned char refname_disposition[256] = {
  * value to ref_update::flags
  */
 
-/*
- * Try to read one refname component from the front of refname.
- * Return the length of the component found, or -1 if the component is
- * not legal.  It is legal if it is something reasonable to have under
- * ".git/refs/"; We do not like it if:
- *
- * - any path component of it begins with ".", or
- * - it has double dots "..", or
- * - it has ASCII control characters, or
- * - it has ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
- * - it has "*" anywhere unless REFNAME_REFSPEC_PATTERN is set, or
- * - it ends with a "/", or
- * - it ends with ".lock", or
- * - it contains a "@{" portion
- */
-static int check_refname_component(const char *refname, int *flags)
-{
-	const char *cp;
-	char last = '\0';
-
-	for (cp = refname; ; cp++) {
-		int ch = *cp & 255;
-		unsigned char disp = refname_disposition[ch];
-		switch (disp) {
-		case 1:
-			goto out;
-		case 2:
-			if (last == '.')
-				return -1; /* Refname contains "..". */
-			break;
-		case 3:
-			if (last == '@')
-				return -1; /* Refname contains "@{". */
-			break;
-		case 4:
-			return -1;
-		case 5:
-			if (!(*flags & REFNAME_REFSPEC_PATTERN))
-				return -1; /* refspec can't be a pattern */
-
-			/*
-			 * Unset the pattern flag so that we only accept
-			 * a single asterisk for one side of refspec.
-			 */
-			*flags &= ~ REFNAME_REFSPEC_PATTERN;
-			break;
-		}
-		last = ch;
-	}
-out:
-	if (cp == refname)
-		return 0; /* Component has zero length. */
-	if (refname[0] == '.')
-		return -1; /* Component starts with '.'. */
-	if (cp - refname >= LOCK_SUFFIX_LEN &&
-	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
-		return -1; /* Refname ends with ".lock". */
-	return cp - refname;
-}
-
-int check_refname_format(const char *refname, int flags)
-{
-	int component_len, component_count = 0;
-
-	if (!strcmp(refname, "@"))
-		/* Refname is a single character '@'. */
-		return -1;
-
-	while (1) {
-		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, &flags);
-		if (component_len <= 0)
-			return -1;
-
-		component_count++;
-		if (refname[component_len] == '\0')
-			break;
-		/* Skip to next component. */
-		refname += component_len + 1;
-	}
-
-	if (refname[component_len - 1] == '.')
-		return -1; /* Refname ends with '.'. */
-	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
-		return -1; /* Refname has only one component. */
-	return 0;
-}
-
 struct ref_entry;
 
 /*
diff --git a/refs/refs.c b/refs/refs.c
index 56dee05..bc7e159 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -622,3 +622,112 @@ char *resolve_refdup(const char *refname, int resolve_flags,
 	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
 						  sha1, flags));
 }
+
+/*
+ * How to handle various characters in refnames:
+ * 0: An acceptable character for refs
+ * 1: End-of-component
+ * 2: ., look for a preceding . to reject .. in refs
+ * 3: {, look for a preceding @ to reject @{ in refs
+ * 4: A bad character: ASCII control characters, and
+ *    ":", "?", "[", "\", "^", "~", SP, or TAB
+ * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
+ */
+static unsigned char refname_disposition[256] = {
+	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
+};
+
+/*
+ * Try to read one refname component from the front of refname.
+ * Return the length of the component found, or -1 if the component is
+ * not legal.  It is legal if it is something reasonable to have under
+ * ".git/refs/"; We do not like it if:
+ *
+ * - any path component of it begins with ".", or
+ * - it has double dots "..", or
+ * - it has ASCII control characters, or
+ * - it has ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
+ * - it has "*" anywhere unless REFNAME_REFSPEC_PATTERN is set, or
+ * - it ends with a "/", or
+ * - it ends with ".lock", or
+ * - it contains a "@{" portion
+ */
+static int check_refname_component(const char *refname, int *flags)
+{
+	const char *cp;
+	char last = '\0';
+
+	for (cp = refname; ; cp++) {
+		int ch = *cp & 255;
+		unsigned char disp = refname_disposition[ch];
+		switch (disp) {
+		case 1:
+			goto out;
+		case 2:
+			if (last == '.')
+				return -1; /* Refname contains "..". */
+			break;
+		case 3:
+			if (last == '@')
+				return -1; /* Refname contains "@{". */
+			break;
+		case 4:
+			return -1;
+		case 5:
+			if (!(*flags & REFNAME_REFSPEC_PATTERN))
+				return -1; /* refspec can't be a pattern */
+
+			/*
+			 * Unset the pattern flag so that we only accept
+			 * a single asterisk for one side of refspec.
+			 */
+			*flags &= ~ REFNAME_REFSPEC_PATTERN;
+			break;
+		}
+		last = ch;
+	}
+out:
+	if (cp == refname)
+		return 0; /* Component has zero length. */
+	if (refname[0] == '.')
+		return -1; /* Component starts with '.'. */
+	if (cp - refname >= LOCK_SUFFIX_LEN &&
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
+		return -1; /* Refname ends with ".lock". */
+	return cp - refname;
+}
+
+int check_refname_format(const char *refname, int flags)
+{
+	int component_len, component_count = 0;
+
+	if (!strcmp(refname, "@"))
+		/* Refname is a single character '@'. */
+		return -1;
+
+	while (1) {
+		/* We are at the start of a path component. */
+		component_len = check_refname_component(refname, &flags);
+		if (component_len <= 0)
+			return -1;
+
+		component_count++;
+		if (refname[component_len] == '\0')
+			break;
+		/* Skip to next component. */
+		refname += component_len + 1;
+	}
+
+	if (refname[component_len - 1] == '.')
+		return -1; /* Refname ends with '.'. */
+	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
+		return -1; /* Refname has only one component. */
+	return 0;
+}
-- 
2.6.2
