From: David Turner <dturner@twopensource.com>
Subject: [PATCH 37/43] refs: move some defines from refs-be-files.c to refs.h
Date: Wed,  2 Sep 2015 21:55:07 -0400
Message-ID: <1441245313-11907-38-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:56:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlN-0006a7-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbbICB4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:25 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36327 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932397AbbICB4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:21 -0400
Received: by qgx61 with SMTP id 61so18643939qgx.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9BDR0JnLTVcgbEK6rI93RCGAbnvKRWlU+yVy3EyvjUc=;
        b=TL2CQ9her87raLjEa8lGek4ij+QxM800HkpZSo+agzT5IXgL8brDlHJ8qimhnKA0O0
         Cvup6vjT9C3Kbd671QNP0otNR5NApXnCNqmQOZ1q2AT9WovsMOo6+cQUPrWxfyUKQsJk
         3RtHOcS2xnvEwF8RFt5dWX8Ry4eZ00CvkekS6Gk4PxPca0H5OiMNTocZNoUouTvvcZqY
         Y6DL/dfZmISqf2MJPbKwfEwSjplQsX1rJgH1ruuBiqbDL3g6bxHMvEN0y0wZT8V4c3L3
         RBebbd4cjd6dsnQrdz2oVTdXfM5F61CxS3zjoHOWOdhd2L92p29vzEDnnmQKRxLMv3bO
         P67w==
X-Gm-Message-State: ALoCoQlgt6J7Ksax32cRtprEOa/sSKEQao4mFxwjMcgX8iaKB5hiP87aVe1vrWTXIso/6eyzadto
X-Received: by 10.140.202.204 with SMTP id x195mr18485079qha.7.1441245380549;
        Wed, 02 Sep 2015 18:56:20 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277153>

This allows them to be used by other ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 24 ------------------------
 refs.h          | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 71c39ca..ec7ec8d 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -14,30 +14,6 @@ struct ref_lock {
 };
 
 /*
- * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
- * refs (i.e., because the reference is about to be deleted anyway).
- */
-#define REF_DELETING	0x02
-
-/*
- * Used as a flag in ref_update::flags when a loose ref is being
- * pruned.
- */
-#define REF_ISPRUNING	0x04
-
-/*
- * Used as a flag in ref_update::flags when the reference should be
- * updated to new_sha1.
- */
-#define REF_HAVE_NEW	0x08
-
-/*
- * Used as a flag in ref_update::flags when old_sha1 should be
- * checked.
- */
-#define REF_HAVE_OLD	0x10
-
-/*
  * Used as a flag in ref_update::flags when the lockfile needs to be
  * committed.
  */
diff --git a/refs.h b/refs.h
index fd461e9..e5ef8a3 100644
--- a/refs.h
+++ b/refs.h
@@ -193,6 +193,30 @@ struct ref_transaction {
 #define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
 
 /*
+ * Flag passed to lock_ref_sha1_basic() telling it to tolerate broken
+ * refs (i.e., because the reference is about to be deleted anyway).
+ */
+#define REF_DELETING	0x02
+
+/*
+ * Used as a flag in ref_update::flags when a loose ref is being
+ * pruned.
+ */
+#define REF_ISPRUNING	0x04
+
+/*
+ * Used as a flag in ref_update::flags when the reference should be
+ * updated to new_sha1.
+ */
+#define REF_HAVE_NEW	0x08
+
+/*
+ * Used as a flag in ref_update::flags when old_sha1 should be
+ * checked.
+ */
+#define REF_HAVE_OLD	0x10
+
+/*
  * The signature for the callback function for the for_each_*()
  * functions below.  The memory pointed to by the refname and sha1
  * arguments is only guaranteed to be valid for the duration of a
-- 
2.0.4.315.gad8727a-twtrsrc
