From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] refs.c: remove lock_fd from struct ref_lock
Date: Tue, 14 Apr 2015 15:25:08 -0700
Message-ID: <1429050308-9617-4-git-send-email-sbeller@google.com>
References: <1429050308-9617-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Apr 15 00:25:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9H0-00043M-51
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbbDNWZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:25:31 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:32861 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbbDNWZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:25:25 -0400
Received: by igbpi8 with SMTP id pi8so56128639igb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 15:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FsHFZZPokj/duzPIYeX0LQURoXlopC5OKLjcXQS+lSg=;
        b=MyjomVeBQSV3rvUhq+0X9xMHroiqpXjHZxMmzrJBCLgmuunXI4HjWEImZ1I/68Su5V
         7QHP/mczNsi+6s7LpiE6f9+7pb3sDlxvdCfLwXkxxJw7Gs65/zk3b1QIFhW4NGsVydpv
         zbhfNytwyM/oj9aRDpY05r4nEl4+nNVYo9hND+SBxtetBve+oufq7lG2eskBqVPRcLuI
         0yAIV2ssIv594TZTtpYECP4kSXmqGpxCe/Mh/kbccyrY+6sX2dFBtAj5ngYPVTekan61
         MILuFa1eXzq0srB43/zRGCMYRkWg6ObfL24qUtsYUSandoG0RHAy97X3RHidi+pgqhlw
         4aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FsHFZZPokj/duzPIYeX0LQURoXlopC5OKLjcXQS+lSg=;
        b=NtwR0KRG7JYfzFVvLNHVhmyKi45VOG5aIL4RWBXiE87nXVGGdoDNVAzWDsMguBJAGt
         UikY7elb0m8IDSyim9Gt25YSxjH528OEEiGdFhgR8s9IgF+5bD8ccdIACTUCwIkw5gDr
         4jPT1tasgHXIFrTFn9oRf7vP/tNZvYgi7DnshS5+tPdUP2jqqEP1ndrz8AWhBwza/R98
         Vb5PJ4+U1gQLXWrkbit5WaZmMWRUE7tznOwARwwhvTQTsrLl9KzWjqwzAKN2BAfOyGv4
         E7H5ZVkhXptoWMqsSVHft7YrxJeUboeDxGX9+gm7FqwT6mYrUlOEzR2nCOYlopgGFgZe
         RY+Q==
X-Gm-Message-State: ALoCoQnJuQGWSRFOiuT/a/W7eWf99+Gl2DGptHHHJJwVo9TZZU5aLm+miOTD1bO1lzTUFKZ8SobG
X-Received: by 10.43.13.71 with SMTP id pl7mr29202227icb.31.1429050324448;
        Tue, 14 Apr 2015 15:25:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:f14f:277:5d87:2236])
        by mx.google.com with ESMTPSA id p76sm1244742iop.14.2015.04.14.15.25.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 15:25:23 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1429050308-9617-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267166>

The 'lock_fd' is the same as 'lk->fd'. No need to store it twice so remove
it. You may argue this introduces more coupling as we need to know more
about the internals of the lock file mechanism, but this will be solved in
a later patch.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.3.0.81.gc37f363
