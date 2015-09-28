From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 37/43] refs: move some defines from refs-be-files.c to refs.h
Date: Mon, 28 Sep 2015 18:02:12 -0400
Message-ID: <1443477738-32023-38-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWo-0001ih-CC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbbI1WEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:04 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36480 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbbI1WDe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:34 -0400
Received: by qkcf65 with SMTP id f65so74210359qkc.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OM+2/B/DLBRwC3xbtUamlI//5kGKotXhSlYEOU1RIFI=;
        b=fIH/RAvgmDSwUfNqoqNifkccLkPkzhDbqkcskmr9Gl7fxTaPwISBcZFoOKwIQtjciz
         UtDJ03+pxzUIB2PtmHYwE4m81X1RnU6aaKPEvdY/vOILkyYptdY14cqSJKtDDPT/HjYB
         3WLiFdeW3mqcG9m6IfXUO0AaVj0zrjDx6fgPbwRiXrlscLHjwKpSKwajGEuTQAYGeZhs
         oi0IGNLvFCqlT2IJn9OoWxKPkjdvIoSbRnVFjF5kUVBEeQdS3MzP1WlT+OFShlXhhCqF
         FurY6tYenLgPypY/OFf4a8gDp5bvvsi4GnhVmE7maWno9ojPRwHZqjklUt6Efbqo6m1N
         kclQ==
X-Gm-Message-State: ALoCoQlx8QF0b9ALuzRH9cOG/eFGFJZTaYDBwxl0wWSxgFABaF/9EqY+uGWrO/zNZEfjZr6a1xaY
X-Received: by 10.55.198.77 with SMTP id b74mr15688650qkj.8.1443477813255;
        Mon, 28 Sep 2015 15:03:33 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278776>

This allows them to be used by other ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 24 ------------------------
 refs.h          | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 3bcfab3..2727943 100644
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
index 823983b..d8ae9af 100644
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
2.4.2.644.g97b850b-twtrsrc
