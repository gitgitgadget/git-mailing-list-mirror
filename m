From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/5] refs.c: remove lock_fd from struct ref_lock
Date: Wed, 21 Jan 2015 18:32:07 -0800
Message-ID: <1421893929-7447-4-git-send-email-sbeller@google.com>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 03:33:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE7Zt-0008I7-QC
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 03:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbbAVCc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 21:32:56 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:57335 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbbAVCcS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 21:32:18 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so283778igb.5
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 18:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GrVT1Bbvgle76i6W4ghANBoX4LvTwAeUbsQUi4r62bg=;
        b=VJsaimwyN5KcWDwDUTFzoXiYhiXuLagE2MWIBd27KrzdlUrUoLDKT6dhTS+IrkzKXe
         MFbPEDp9BLOocpf8gfhGRjCxyoIRMnd8mxwMH6gJIlHS8pSHkmPKauWySAVGwMQmnuuY
         CTFZra75/f2Cx069cCfWPOrKolVeB/jRlyvDsGmvdXduEyH18YxcuhLZU0QxyjYbwBVs
         4Qk9FtCDLVk+u8/nAQaHgwNzPZEpHWhOG401Xl0Za2io2Ze/bV+5CdfvFq6FjpeQjT0s
         eLX1IuDQEYt7GRHLmF4TJIK6WLDz9cVyHTNOPEKEDFAVGq3lx2L1M9g20QrCIOUDcoTi
         ZJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GrVT1Bbvgle76i6W4ghANBoX4LvTwAeUbsQUi4r62bg=;
        b=BZwyRsa0vMWDzuwBtkgrYKsiwnC3g1Z5XlIs/uoVgBdTi7bDm8wKKEJBE6NYUrOkee
         ALeh/1F0mvnFkJOCl1XGrmykG0n+GwYy4fV/q+W9Iyfbvx4z7RmzN5BrsKyvWC903QYG
         8183vFw6g9jjHgmH2X1draGZ3asvUTJcmvvNjw7BwSbmlgPs1+pATh6KNIV32rLqND7I
         cbAT8UQvRvlDXZaO7xH0jL8HYmOAZYNo+fbskATlNgS8dGSOjgJ0LQYegiHZPjMGfrwv
         uvJPBOL1CmO3vsPx/X/C2codDFOGDTAQq5MC3EurqxSYPPeG8sennkjTUgXYgT3n0EVk
         PM/Q==
X-Gm-Message-State: ALoCoQn2rfSeMWindFcf5PRWsqenW5+gfBySUq2yjUOU4Vj85k59vXIE0qTeJmI+twstU2Busdly
X-Received: by 10.50.138.226 with SMTP id qt2mr33258837igb.1.1421893936448;
        Wed, 21 Jan 2015 18:32:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id aw9sm1162432igc.18.2015.01.21.18.32.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 18:32:16 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421893929-7447-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262796>

The 'lock_fd' is the same as 'lk->fd'. No need to store it twice so remove
it. You may argue this introduces more coupling as we need to know more
about the internals of the lock file mechanism, but this will be solved in
a later patch.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 14e52ca..2472e61 100644
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
@@ -2335,8 +2333,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		goto error_return;
 	}
 
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
-	if (lock->lock_fd < 0) {
+	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2904,7 +2901,6 @@ static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -2912,7 +2908,6 @@ static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -3090,8 +3085,8 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -4047,9 +4042,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
