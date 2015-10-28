From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 13/26] refs.c: move check_refname_format to the common code
Date: Tue, 27 Oct 2015 22:14:14 -0400
Message-ID: <1445998467-11511-14-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGd-00017v-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbJ1CPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:05 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34877 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbbJ1CPD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:03 -0400
Received: by igbkq10 with SMTP id kq10so96958248igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PlaIgEh0JDx4dGj51ejcYEHq6K17BOHPfs9I9zzzX44=;
        b=tqxG/cpT9DsUle1Y/eYIQjSuHfuulhLzoCZW3aHQz67A+N/37BYmjsbSLpRveSWLzL
         bKzTUXq8FJvgSzlry7wNXE+0pUXUFIqvXSzpPP1ZJbgeDIZv3Av8rUnkXIE50UrMrr5N
         J/QuDmK+surPrRLY3iGTNfI8KzFlU4aIXxn476k52zAhtJyot2yVUvldhLeGqCJsOa8g
         DPVSFt+6UvsxTtWlmT00v6CK0L4sJtipIfN1BA1pI4XAQrOiZt7tLKJTPa8XNeCSmXDs
         WjU9mcW8Wn2JUHDH3vsz3AhjW4ogbyenEnucaR5QWyN2C3e+1hdJMlaxLYgxY9LkO8wV
         XpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PlaIgEh0JDx4dGj51ejcYEHq6K17BOHPfs9I9zzzX44=;
        b=ei6mj9gsHHe3e19ivb1VpxtDKmuAmPjixCG7RiTivqO8Hmb+2+Fb4PwYzbAmJoQXDt
         g9M0nZifjOgW7scfwvG8PdmIbAvqitRJczreoIl8GDBHbOoOUW7Ttq/EHWHw9wOsfcHt
         XXh7B43oDH/Vmv10UQJQNmUCfaf8+mlol6SVCQ3QNa2hld/MvapKhp6sDSk3o4v0PPdr
         60o9O5zDV7Q0LjEPnvzbHe+IYjTB3Hs37O+kTZu8jRZEPrNT0EOAuk8yjYkk9QocJdSc
         jpRWwIx+TEkmBwNQaUOm870ELv19rweeMjwTVzw8NhLaUHiLv9TuIo9el5ytfp3RkYn6
         dOCw==
X-Gm-Message-State: ALoCoQmScdXjr7lYMHoO2n2Vnth3l1cNmSuOzeKRN+581HuuVmZYWDx7eJsY8sKp/NUdkXpFCLu7
X-Received: by 10.50.78.194 with SMTP id d2mr332422igx.72.1445998503025;
        Tue, 27 Oct 2015 19:15:03 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280333>

From: Ronnie Sahlberg <sahlberg@google.com>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 109 --------------------------------------------------------
 refs.c          | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index dcb6394..ec6efd7 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
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
diff --git a/refs.c b/refs.c
index b605460..58991a0 100644
--- a/refs.c
+++ b/refs.c
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
2.4.2.658.g6d8523e-twtrsrc
