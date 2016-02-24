From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 09/32] refs: add do_for_each_per_worktree_ref
Date: Wed, 24 Feb 2016 17:58:41 -0500
Message-ID: <1456354744-8022-10-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPM-0003fn-KX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759158AbcBXW7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:35 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34361 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759040AbcBXW7X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:23 -0500
Received: by mail-qk0-f177.google.com with SMTP id x1so13254695qkc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9X6zGagJ29k9ljbwuHUPSuj2RhqGHZfzTepP8WGFG2s=;
        b=Bkpy9I2s3hb0cOMY83GLE+nVM+23N4nmsrcWnkGz8K4MCiW0RM0J7e8CqLwDBVKAY5
         kw4X4fRKX83NNngw3ZFQg19pTH7y2z6fu7SAzIGDHfkzlZSy/WzStdCkXSSh9FuY/6xP
         B49XT4pUgNbEmT/1hKY99G3AUgyvEfjMoFgKW88zHk+gWMi3ai9ACEZvq+OGyO3dE660
         KjdYnoB8gFeyaoqIxZjG6E9wKSzhuv1J8rjfikyVCknbPF5jjuOZ5ebKpkLlbIUE3Z7d
         lOfagU3QE6QXwyrMvqfe2HGwI1ZlsODNEUAJZqWf7YVF/27hg6GcSKXtj8W8CDe4KvpT
         5x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9X6zGagJ29k9ljbwuHUPSuj2RhqGHZfzTepP8WGFG2s=;
        b=UDZZPkjs2wBV39BoIVt88ft+Vw1KCNHjM42c3ofV7Uu6kp7KgWkaXkhsVEb4CtoGVC
         NN+f5FhQ5WgZqxXbRg6/PEEcGQDKJFnqU9gSm9bcUvrwhLiJ1Gt+8w0B3ucE26qxqjnY
         b4rpcXYYdGw6OQNiLXjIDsb3rIb3j5zgzXnMPFNRDoGZ7dSxs3M+sQJ1gh8++gc+ao+j
         LD/mOBj0koRKyzmsp9yY7lh1VSuFI2mvXRpiyshfmZ5dNEx5gXDtxm3uPzJDiS4q4z8h
         RBf67UVyo2iwikCo9egqBfCgV9JsupD2QViwc1psxmpbRGzEPd7ADYhnPX9aeknwPx1F
         bOfA==
X-Gm-Message-State: AG10YOStu0BNXj++4yB44OZ6egJvHweJ4yEuNBNF8jtI3c5Cn1FvBJ+wIhWLywK0cnj0IA==
X-Received: by 10.55.80.9 with SMTP id e9mr51322650qkb.94.1456354762823;
        Wed, 24 Feb 2016 14:59:22 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:21 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287245>

Alternate refs backends might still use files to store per-worktree
refs.  So the files backend's ref-loading infrastructure should be
available to those backends, just for use on per-worktree refs.  Add
do_for_each_per_worktree_ref, which iterates over per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 16 ++++++++++++++++
 refs/refs-internal.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index db9e948..d315f40 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -565,6 +565,10 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
+	if (data->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+	    ref_type(entry->name) != REF_TYPE_PER_WORKTREE)
+		return 0;
+
 	if (!starts_with(entry->name, data->base))
 		return 0;
 
@@ -1701,6 +1705,18 @@ static int files_do_for_each_ref(const char *submodule, const char *base,
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
