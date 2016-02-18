From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 06/27] refs: add do_for_each_per_worktree_ref
Date: Thu, 18 Feb 2016 00:17:29 -0500
Message-ID: <1455772670-21142-7-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzD-0001D0-GE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424805AbcBRFSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:38 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:32853 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424477AbcBRFSe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:34 -0500
Received: by mail-qg0-f41.google.com with SMTP id b35so29343294qge.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngrYDSCWOSJVK333XFS+kLpqMiBG/m9OYbpi7Ez3Mq0=;
        b=i741y3r4qhFyImDIiNsvTh19PH7VWtdzMvksYLLd5uTOdQRlxEjSVTUEe55z6vkXSZ
         EA8+KRMAOZzPdZKT6Hl6C7+8/P/rErTOCLVbRLLu2d+tmmllktNH/uYf+gApISK/Na+N
         lus2AJ5zUC+8V2ueZaInHAHdC36SGaGpfih+sxfM0IQTGPz/cJBSWzjvJBJNOS9FVMiH
         PE+67gF5WTX/dlO+NsJ7EdmfgzUZot8ouZYoZKx/FOOpIQRKmpUHVzwjqvwBWbNfthcX
         oo3FZU63E8/ebCuyQ2VzILdIRWtnW3W5iSN41xTY6ssgKsDt5SHdgt58bFqONgQ7eJ34
         7Twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngrYDSCWOSJVK333XFS+kLpqMiBG/m9OYbpi7Ez3Mq0=;
        b=ee+KXjUjmW4KaS9zn7OqOvbds4Vg2KTKjICfsemOm13WV/gx2UXIHdxOI41wnQCcm8
         GOqu7q3FjACbIJDJspRP4k2RnXRtZ7k5QkmnusBTmQwOmTq8L9hct/PRUXmi6FpFkZyC
         DDuJwcYPqWoexlenVVf+FMdSgdN475mVfzbmg5Ok3vUBKMoRsTQokTPH53CVqD1+bzaA
         S2IcXggnPzMsx3dzS3TzdaMKlBTUuOjLtuLNpK9j8lCnTMqMc6K+11xTGqG+9fhDbEdK
         39WgNT4PjMBE1YWz23+moNCJLPXOwraJopSW5O3K24fC2vTJiSuy7k1hvJhBtbHYWDuL
         T1/Q==
X-Gm-Message-State: AG10YOR3k60Bv304Ko0vGSYAs0tEzyXcgRcTACcVpRf2alsJaxiE+5fX9yC2wyUdym16Hg==
X-Received: by 10.140.102.232 with SMTP id w95mr6588852qge.21.1455772713538;
        Wed, 17 Feb 2016 21:18:33 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:32 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286575>

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
index 34c414b..e94960a 100644
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
 
@@ -1757,6 +1761,18 @@ static int files_do_for_each_ref(const char *submodule, const char *base,
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
index 1caeb61..87b9d80 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -200,6 +200,13 @@ int rename_ref_available(const char *oldname, const char *newname);
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
+/* Only include per-worktree refs in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data);
+
 /*
  * The common backend for the for_each_*ref* functions
  */
-- 
2.4.2.767.g62658d5-twtrsrc
