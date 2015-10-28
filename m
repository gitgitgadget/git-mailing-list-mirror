From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 21/26] refs.c: move peel_object to the common code
Date: Tue, 27 Oct 2015 22:14:22 -0400
Message-ID: <1445998467-11511-22-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:16:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGI8-0002UX-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbbJ1CQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:16:41 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37887 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbbJ1CPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:18 -0400
Received: by igbhv6 with SMTP id hv6so92971238igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+jTytYUvMGkQkvjUqX3sTt3Hd478CY1Tb1hSAwNU+fY=;
        b=2KxTNRtmc1l6enOwvY42D8LHRnMtFqkz5L3v271JS2ywUGxFceGticQbdWNCcIz0aw
         xm9gV5rV5FOxvOSl1gKLfd3uUdDkiMPJhRz0Q0ERsR8dBtybRQtAA7X+jkU556AZvyb6
         0rT+BoH08k7QXiLaoz5PIqJNSAL8/kBX/wWfm/+JgqyHRfNVA41e06ipDcN4icJ+TTRC
         n2ukerAoahd0I98QkSQtOk46FH8Ki2fOfl4TpyyGryE0cs11id8uxGhUPCawUk3GX8UR
         tdy4JQzwfuXiF4eC6jXv3Sr9Qc3hzXGu41EarMlqi757VZWO/MGRRHxGjHivPmyqfhvg
         ZffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+jTytYUvMGkQkvjUqX3sTt3Hd478CY1Tb1hSAwNU+fY=;
        b=JmNz/GZe29N+WCRl1OPBVG7LKuKCVCfmbydnTtGG3e1nHXVThJ48zLep5TAj2+v7jK
         ly7cnzrwyR8esrulEqnu+r7aPE5l4hHKusHDgWEoSsb5NSNNzt90W3k9cbny3pii53q7
         Ous4sgW1f922T8EexgmyMbcFq98/92pOPiV5zMeTil+7dOm58BbPiYDOqUL9VDDpP3q0
         vh0VA4zWQ1/tjYQkZC94RFdklfx1OUQ8Oz5pqJK2S6I87/TcCG4ITcyc4CgmgQfUsAAf
         jyc9yqcq6YTk/JUUSvYaTuHM7zd5Bsc1atRclYto962hDFw7z9um/wmdGaWeoQZcMkXP
         JcXw==
X-Gm-Message-State: ALoCoQmbQKdgcspF/jdjYjdj9eskoFkVOti1sFrWcwqAOWk77K7yfn/JV1h/M3iKzgV/nBT0yTn2
X-Received: by 10.50.79.201 with SMTP id l9mr364535igx.60.1445998517432;
        Tue, 27 Oct 2015 19:15:17 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280345>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 53 -----------------------------------------------------
 refs.c          | 23 +++++++++++++++++++++++
 refs.h          | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index fc8a0a9..23c2f78 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1600,59 +1600,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-enum peel_status {
-	/* object was peeled successfully: */
-	PEEL_PEELED = 0,
-
-	/*
-	 * object cannot be peeled because the named object (or an
-	 * object referred to by a tag in the peel chain), does not
-	 * exist.
-	 */
-	PEEL_INVALID = -1,
-
-	/* object cannot be peeled because it is not a tag: */
-	PEEL_NON_TAG = -2,
-
-	/* ref_entry contains no peeled value because it is a symref: */
-	PEEL_IS_SYMREF = -3,
-
-	/*
-	 * ref_entry cannot be peeled because it is broken (i.e., the
-	 * symbolic reference cannot even be resolved to an object
-	 * name):
-	 */
-	PEEL_BROKEN = -4
-};
-
-/*
- * Peel the named object; i.e., if the object is a tag, resolve the
- * tag recursively until a non-tag is found.  If successful, store the
- * result to sha1 and return PEEL_PEELED.  If the object is not a tag
- * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
- * and leave sha1 unchanged.
- */
-static enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
-{
-	struct object *o = lookup_unknown_object(name);
-
-	if (o->type == OBJ_NONE) {
-		int type = sha1_object_info(name, NULL);
-		if (type < 0 || !object_as_type(o, type, 0))
-			return PEEL_INVALID;
-	}
-
-	if (o->type != OBJ_TAG)
-		return PEEL_NON_TAG;
-
-	o = deref_tag_noverify(o);
-	if (!o)
-		return PEEL_INVALID;
-
-	hashcpy(sha1, o->sha1);
-	return PEEL_PEELED;
-}
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
diff --git a/refs.c b/refs.c
index c31418d..3867549 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,8 @@
 #include "cache.h"
 #include "refs.h"
 #include "lockfile.h"
+#include "object.h"
+#include "tag.h"
 
 static int is_per_worktree_ref(const char *refname)
 {
@@ -994,3 +996,24 @@ int refname_is_safe(const char *refname)
 	}
 	return 1;
 }
+
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
+{
+	struct object *o = lookup_unknown_object(name);
+
+	if (o->type == OBJ_NONE) {
+		int type = sha1_object_info(name, NULL);
+		if (type < 0 || !object_as_type(o, type, 0))
+			return PEEL_INVALID;
+	}
+
+	if (o->type != OBJ_TAG)
+		return PEEL_NON_TAG;
+
+	o = deref_tag_noverify(o);
+	if (!o)
+		return PEEL_INVALID;
+
+	hashcpy(sha1, o->sha1);
+	return PEEL_PEELED;
+}
diff --git a/refs.h b/refs.h
index 4951141..ca60de5 100644
--- a/refs.h
+++ b/refs.h
@@ -76,6 +76,40 @@ extern int is_branch(const char *refname);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
+enum peel_status {
+	/* object was peeled successfully: */
+	PEEL_PEELED = 0,
+
+	/*
+	 * object cannot be peeled because the named object (or an
+	 * object referred to by a tag in the peel chain), does not
+	 * exist.
+	 */
+	PEEL_INVALID = -1,
+
+	/* object cannot be peeled because it is not a tag: */
+	PEEL_NON_TAG = -2,
+
+	/* ref_entry contains no peeled value because it is a symref: */
+	PEEL_IS_SYMREF = -3,
+
+	/*
+	 * ref_entry cannot be peeled because it is broken (i.e., the
+	 * symbolic reference cannot even be resolved to an object
+	 * name):
+	 */
+	PEEL_BROKEN = -4
+};
+
+/*
+ * Peel the named object; i.e., if the object is a tag, resolve the
+ * tag recursively until a non-tag is found.  If successful, store the
+ * result to sha1 and return PEEL_PEELED.  If the object is not a tag
+ * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
+ * and leave sha1 unchanged.
+ */
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
+
 /**
  * Resolve refname in the nested "gitlink" repository that is located
  * at path.  If the resolution is successful, return 0 and set sha1 to
-- 
2.4.2.658.g6d8523e-twtrsrc
