From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/6] refs.c: remove lock_fd from struct ref_lock
Date: Fri, 23 Jan 2015 12:03:59 -0800
Message-ID: <1422043442-30676-4-git-send-email-sbeller@google.com>
References: <54C0E76D.5070104@alum.mit.edu>
 <1422043442-30676-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Fri Jan 23 21:05:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkTq-0007MZ-9x
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbbAWUFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:05:16 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:52253 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbbAWUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:05:09 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so3869130igk.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RjxIejZFlg7T1o+M+avgJFyxICsVfb2UdpWFrvxSKG0=;
        b=X/BzjxTM4COmGpxx7cqw3H+y6zRKYk05oUhelbz1Xl+a7r4K9W8i9772Z49djfGxrV
         MVgHxyZug38pA7je0E07wMfj8kSAZU3yg8xNVZ38NBgpeyJVrZLvJOXknIe9R43mlVkK
         X2iuKejBa7PjA6e96EqNcX3zclavBKT0BxioIYVEriH3hCSiJyfdkVox2xNdcL9hrRth
         3JUTmmwq5M1dkCmBBTjkDceuTpJx6scRWac0BvJ98JGanFhbuCZjaX9dhP9ZBSLM2Bv2
         wxbtxOhBXeRMsWxAZZlL5IC8Bj8Vw03rZ9GTdq28xipUhzfc475sZydy7Q9ltP69HBEJ
         euPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RjxIejZFlg7T1o+M+avgJFyxICsVfb2UdpWFrvxSKG0=;
        b=Sv2aYGO0fDGCbNY0A1/6tWZMwhYgQxHDiAT7ZqRB7j0zhDzadAzxpso3Pm1E/XBBrD
         KrpU88TyW1/WRazKbD+aJPmZ37qp/cGolilBvKqWCxTMYltyQxSYrjl3w8gvLZuBxsVC
         WzGAuo3KSrC/4sSd4it+1KMFy2defFIbh5OxE7qKOMVhg6rJ0Tpoifd2HVhMWf2zncec
         91gRhfVFS4/qvfHBis8IE3W6PyADmENKws6XSARtqiAOPHXSIdhRIJY1MKokvvrOKyqC
         cUVU76+2n6qjUhja+PEdgUYKK+uEHriUjy3M9NCWzK01DEOEmCD2kkYkduE9pkN+wC3h
         IgkA==
X-Gm-Message-State: ALoCoQmiMpYACBbQneZpXnbfhTPnlSMljF3UP0Qh9b//uvlurtJT1+yLqe/JH9G2PDws3EH71cam
X-Received: by 10.50.25.166 with SMTP id d6mr3843680igg.41.1422043508189;
        Fri, 23 Jan 2015 12:05:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:40d0:e4e:2e83:8781])
        by mx.google.com with ESMTPSA id k125sm1360167ioe.29.2015.01.23.12.05.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 12:05:07 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1422043442-30676-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262955>

The 'lock_fd' is the same as 'lk->fd'. No need to store it twice so remove
it. You may argue this introduces more coupling as we need to know more
about the internals of the lock file mechanism, but this will be solved in
a later patch.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes:
    v2->v3:
    no changes

 refs.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 14e52ca..4066752 100644
--- a/refs.c
+++ b/refs.c
@@ -11,7 +11,6 @@ struct ref_lock {
 	char *orig_ref_name;
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
-	int lock_fd;
 	int force_write;
 };
 
@@ -2259,7 +2258,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int attempts_remaining = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
-	lock->lock_fd = -1;
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
@@ -2335,8 +2333,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		goto error_return;
 	}
 
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
-	if (lock->lock_fd < 0) {
+	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
+		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2904,7 +2902,6 @@ static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -2912,7 +2909,6 @@ static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -3090,8 +3086,8 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -4047,9 +4043,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			(write_in_full(lock->lock_fd,
+			(write_in_full(lock->lk->fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
+			 write_str_in_full(lock->lk->fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
-- 
2.2.1.62.g3f15098
