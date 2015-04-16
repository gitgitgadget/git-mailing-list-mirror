From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] refs.c: remove lock_fd from struct ref_lock
Date: Thu, 16 Apr 2015 16:17:37 -0700
Message-ID: <1429226259-21622-2-git-send-email-sbeller@google.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Apr 17 01:18:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yit2t-00013M-QR
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 01:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbbDPXSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 19:18:00 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37637 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbbDPXR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 19:17:57 -0400
Received: by igblo3 with SMTP id lo3so1795914igb.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7eFyjUbhOj97RTxlzi+Qy6fU2iTL+W0tzktEcvwgL+E=;
        b=jhuqc8iJAauyKgHLzE5/cq0V8eZPjsUvynoLqO2jSTEB/e2KyPbHMtgK0khW9SCxug
         0KW/dqfQtKErA1sdrUhxnKWSrbvR5MmnCEEQE0dGneO78g1Wm/zqOygKahDg9evGynDB
         T2/AEoK2j74E+BuOd/Bvn2kPmA+tXK2m5pDFVyVsCYV0vXgPAV4vgLORWF7viCN36RhN
         i7XlKZI2/6wfo3WYHp0YRO9gGeOP63YpfydLBvT2onQf+Piy7B0wtvIHbWq4UVKCuVdD
         Ry9ksSDXbSu5R92EWPFo/P+fgPKJSHGEaIAAmmG33jPUbNjRz0hGUi158hTYVP2HFXVB
         dkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7eFyjUbhOj97RTxlzi+Qy6fU2iTL+W0tzktEcvwgL+E=;
        b=X38cxlPPBMDgKnxK8P7O/Dv6NNOdkeRXr+4XTs/r96SFkI3HXF0Cv1t+BBIpb/O4td
         5giTjKVD0nn6KTGbahUhLuw9xC5VlmiztDQ9stu8YEsAJDOueVUEmwozGUMQ6HgVTcQH
         Kfe8hPQBILuLZYvFeO+SIPF6wyPK9sPGeaTjIEcIrncGXRvethl11/0xTRpgpOsN9ZNY
         BYKZYQc4wJSuwa9EBuQday8joGXuE21j7dwb4F7qhIsSP71aeIvTkYFMBMzL4wd13hdY
         z9IkLhl4FDlYtCzD0ruVnm4Gbr/SfQVm63A9aqCFWyTVS7o8f+tg3aXsQ5TdOx67ctCr
         yZgw==
X-Gm-Message-State: ALoCoQn8VcX5PxuTwc3+OnFCdkZAKTOTv2r13IK7of0zDKKyizfgouqayJMm/PvdANV5nq95lGu+
X-Received: by 10.50.66.230 with SMTP id i6mr787863igt.22.1429226276609;
        Thu, 16 Apr 2015 16:17:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:fdc7:e96c:1b25:2317])
        by mx.google.com with ESMTPSA id w3sm350388igz.1.2015.04.16.16.17.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Apr 2015 16:17:56 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1429226259-21622-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267340>

The 'lock_fd' is the same as 'lk->fd'. No need to store it twice so remove
it.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 47e4e53..4f495bd 100644
--- a/refs.c
+++ b/refs.c
@@ -11,7 +11,6 @@ struct ref_lock {
 	char *orig_ref_name;
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
-	int lock_fd;
 };
 
 /*
@@ -2284,7 +2283,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int attempts_remaining = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
-	lock->lock_fd = -1;
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
@@ -2356,8 +2354,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		goto error_return;
 	}
 
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
-	if (lock->lock_fd < 0) {
+	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
 		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
@@ -2868,7 +2865,6 @@ static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -2876,7 +2872,6 @@ static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -3046,8 +3041,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full(lock->lock_fd, &term, 1) != 1 ||
+	if (write_in_full(lock->lk->fd, sha1_to_hex(sha1), 40) != 40 ||
+	    write_in_full(lock->lk->fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename.buf);
@@ -4084,9 +4079,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if (update &&
-			(write_in_full(lock->lock_fd,
+			   (write_in_full(lock->lk->fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
+			 write_str_in_full(lock->lk->fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
-- 
2.3.0.81.gc37f363
