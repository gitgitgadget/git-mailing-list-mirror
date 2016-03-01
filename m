From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 19/33] refs: allow log-only updates
Date: Mon, 29 Feb 2016 19:52:52 -0500
Message-ID: <1456793586-22082-20-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZq-0007Ie-K1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbcCAAxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:51 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34564 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcCAAxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:48 -0500
Received: by mail-qg0-f51.google.com with SMTP id b67so130618841qgb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtMu0Xo9yikWjeiPaAH4gK0K7KgIgH5FKpFNVpM9+SY=;
        b=uNbuf9/AS91tmrxGJTsb6DlxZ5+wuBEeEL7f170u6Okwv2x43f4cFpKPYTwzB10W5D
         3Nh8fpbrgbkxcMJ3oA8iiJgSZBJZ+RreXp0oHzGhOxaIUGN2+baVKdIdrQ9K+LhXXJNS
         pX5ksx+KvwI2Gte/tfWFRKUWAnay/tcbW/cm6/WZEZdMzvrOTJgM8MiBadPJs4BUCvoe
         brtxqpVN6zlDLXoQCkc+fP8efdkYgno1xiTuA3Xi+IC1FKhmlcUrMIVH+MebQ5VUE/Y7
         zqOnfMFT163w4Q/R1nk6sxiHSVNMk+xeKY6rh9mv3pricdDjkacqzCjOzZbX+sFPasXm
         v+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtMu0Xo9yikWjeiPaAH4gK0K7KgIgH5FKpFNVpM9+SY=;
        b=LFUZb3XJZE8EMcRygUKpTgDFNhwm7c/h/40JGP+myvsU0xnneRstnqb/6d0iEwCax5
         lXhsEE572K5LPWoIrqOjfXDRpizfZI2SK3OzejE5KX8SOrUdQ+K8M7PN+cjYAEQqgqCl
         zc8ydtQYkZW82XsHDQxK6Pk9wglVpIoFjFd62smGDkgC3ZyPtJGTjVSCzUBBIqftpL5A
         z71rkgzIuDyu+++5f8/rhuQeLvY0cUFWC5KgbUmX7EmKQwEv50emJUEcNwp/MNy4PxAG
         3UQZ0+kjQ2JCX8iBQTaATkVHHMlFAobK7gJgjQDOucK19miPMGNCTA8zn2wGOfi5Ww3o
         ZMKg==
X-Gm-Message-State: AD7BkJJGYtPph+TlOdtjQ1KMIT/l4gmNem993IXcg2HLvgCB3usmbLV5HTPt5QaVWQg7cg==
X-Received: by 10.140.147.134 with SMTP id 128mr23845463qht.54.1456793628096;
        Mon, 29 Feb 2016 16:53:48 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:47 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287962>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 15 ++++++++++-----
 refs/refs-internal.h |  7 +++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1f565cb..189b86e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2702,7 +2702,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3056,7 +3056,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3086,7 +3087,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags |= REF_NEEDS_COMMIT;
 			}
 		}
-		if (!(update->flags & REF_NEEDS_COMMIT)) {
+
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    !(update->flags & REF_NEEDS_COMMIT)) {
 			/*
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
@@ -3103,7 +3106,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3123,7 +3127,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 94d162e..dd76246 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -43,6 +43,13 @@
  */
 
 /*
+ * Used as a flag in ref_update::flags when we want to log a ref
+ * update but not actually perform it.  This is used when a symbolic
+ * ref update is split up.
+ */
+#define REF_LOG_ONLY 0x80
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
-- 
2.4.2.767.g62658d5-twtrsrc
