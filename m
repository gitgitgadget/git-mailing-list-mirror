From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 10/33] refs: add do_for_each_per_worktree_ref
Date: Mon, 29 Feb 2016 19:52:43 -0500
Message-ID: <1456793586-22082-11-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZK-0006xI-SL
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcCAAxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:40 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35690 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbcCAAxi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:38 -0500
Received: by mail-qg0-f54.google.com with SMTP id y89so130584276qge.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMhn843tPJokADcd+VwElYUJvd+o1rIx7tv7QqRH2zo=;
        b=b/DMjd1i4w2djCbOPo2sAqvhYKQI/bdTx8cjU4kfAGodQlLE0FLTr75oYSDQx1skLb
         mpbOo6AEApk1MEKHEj38c/TrwI7y+c+szo7DzvIxJ+2gsV8vR1Zkg/h5ZTYf+q5Z9Cro
         KSTsoFGItc20W7qJUZZM5cy+9tikkTg6F6nkwcD8ohqGexl04jmeLASYHhBbS9q//rWy
         rF7r1M8VVRFTZ5Z8YpThL8w4pfkpBahwDc8D9YPfL9Wxz3Ql7kOpZvi6Szbfz2ie3RW2
         9vQN5gTe5RNf5aTWyy8uf3DhOjUXZliJJ8SJe3Lx2N9xytH/9fBP7m/oqpYmbWLM0k8Y
         YlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMhn843tPJokADcd+VwElYUJvd+o1rIx7tv7QqRH2zo=;
        b=V9G96s46BfpLtusuyaHZhBOsXrjSpapSkF6PwqjDOp2unWFxOW36fOQSaHRwOEoALU
         Fwj2T7EjzRHaKESbOHOlN8AOnCBY6Nm35t8VaTIyA5F8CEujXgjxQ35SWog8hu0zihcR
         pduwd29upmq1oXQYBKgUvV3LRLP5GvA1dCJn3zFIgsFMIBs+sBdpWwQldNUqNfPw6v7d
         Bek0JEJKqf2dDa/LbayyItEnttdbO3uNBClwMpfsfx+CxOQHBSE1gApiZFeXOHeQFcI8
         x5XLf2xXb7wpfyvL/KNryFpxD5SkhawGvUTJ6xqTuPxrqPWU9327pzAbg7++jGAFJhdI
         UCYQ==
X-Gm-Message-State: AD7BkJKioAGi1r9rSTEWmgil63my2NGqixa3D8oLHig2L/tW4rK7jttAYSgNjbReAU8dTw==
X-Received: by 10.140.91.109 with SMTP id y100mr22890004qgd.42.1456793617240;
        Mon, 29 Feb 2016 16:53:37 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:36 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287950>

Alternate refs backends might still use files to store per-worktree
refs.  So the files backend's ref-loading infrastructure should be
available to those backends, just for use on per-worktree refs.  Add
do_for_each_per_worktree_ref, which iterates over per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 16 ++++++++++++++++
 refs/refs-internal.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f3d857a..31f38d0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -560,6 +560,10 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
+	if (data->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+	    ref_type(entry->name) != REF_TYPE_PER_WORKTREE)
+		return 0;
+
 	if (!starts_with(entry->name, data->base))
 		return 0;
 
@@ -1693,6 +1697,18 @@ static int files_do_for_each_ref(const char *submodule, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data)
+{
+	/*
+	 * It's important that this one use the files backend, since
+	 *  that's what controls the per-worktree refs
+	 */
+	return files_do_for_each_ref(submodule, base, fn, trim,
+				     flags | DO_FOR_EACH_PER_WORKTREE_ONLY, cb_data);
+}
+
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3702737..bb0d588 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -203,6 +203,13 @@ int rename_ref_available(const char *oldname, const char *newname);
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
+/* Only include per-worktree refs in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data);
+
 /* refs backends */
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
-- 
2.4.2.767.g62658d5-twtrsrc
