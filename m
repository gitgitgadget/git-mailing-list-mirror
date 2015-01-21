From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] refs.c: remove lock_fd from struct ref_lock
Date: Wed, 21 Jan 2015 15:23:41 -0800
Message-ID: <1421882625-916-3-git-send-email-sbeller@google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 00:24:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4d9-0000Vt-SN
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbbAUXYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:24:09 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:47913 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbbAUXX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:23:58 -0500
Received: by mail-ig0-f176.google.com with SMTP id hl2so23432950igb.3
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GdvIRUEZWdfK4D3bmKXK2QVGVozu3iOuESKWicTFMR4=;
        b=Ojg3m2ux9vKu/lgp2laMUddQA2mbT57Bi/jnbn7/JIHoDgwQJyAJtKjl010+NFjtm6
         qbBM+nTjeyOQMzYmgWzNqw5CRO7Xljk8GRG67UH+ldkGlWZBGROGUxC62QSVqn3zuN2y
         ZuscfGfSpRPZc+e+NcF1oGpf32fg9GVTbj6y16Lzoh0ApnriHjBdfX2LHOf3xuqKd0Bl
         LmIZcp2iaa+6CBVaZL3Nm2BI7T2Ylc5b8pJzEnoahtqsOUMbc4kWzH3nKyhnJyqogPCT
         t4F7gRlJf76l80SjepQT2W1e1CEX0UoGa6JDyMYyr/JDsszckHwHYUu92oHpaD4ulMRO
         /BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GdvIRUEZWdfK4D3bmKXK2QVGVozu3iOuESKWicTFMR4=;
        b=brZx7wwEpg2oH1N0zaKwfTI4FUwtrycEi2RhzLHoULfHghjwJ7Jh+130LverYLCk/i
         CIvwp6qkRXVccHnpTEW1DFJoxsQrVTR9RAoiPAhLrtF1VX5qmXYzTSMabHn22v7nMLc2
         tdL4QofG2Lrjg83mTWX5BrEGh54LGTUs7z7xp//ds9kiQVXQK3auGdqvuJjj5HlIWUpa
         vAF8ZIMt7b90UtGrG2qLhn6nPnkHZgBQPSC309NB8oB7WThHKDfgkLrmKLJMBgVY8yH0
         Hb+qlxCFcHUA6Oa/o1ie4GSkTciwY2SNhpiHHoTtDfrGDMUBYoGMqFbGoBgtKIweJ0rn
         AAUw==
X-Gm-Message-State: ALoCoQkzvMPSoss+aHbD+7vZLnO2R/IVfS2tYeUp/z+ZA8o9k9pxZp4MdtN1UvLlzY9sh+b3AC0y
X-Received: by 10.43.89.68 with SMTP id bd4mr43506806icc.63.1421882629620;
        Wed, 21 Jan 2015 15:23:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id qd2sm657351igc.22.2015.01.21.15.23.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 15:23:49 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421882625-916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262781>

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
index ab2f2a9..e905f51 100644
--- a/refs.c
+++ b/refs.c
@@ -11,7 +11,6 @@ struct ref_lock {
 	char *orig_ref_name;
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
-	int lock_fd;
 	int force_write;
 };
 
@@ -2262,7 +2261,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int attempts_remaining = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
-	lock->lock_fd = -1;
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
@@ -2338,8 +2336,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		goto error_return;
 	}
 
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
-	if (lock->lock_fd < 0) {
+	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
 		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
@@ -2916,7 +2913,6 @@ static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -2924,7 +2920,6 @@ static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
-	lock->lock_fd = -1;
 	return 0;
 }
 
@@ -3102,8 +3097,8 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -4083,9 +4078,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
