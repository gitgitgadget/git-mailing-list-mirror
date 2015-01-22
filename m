From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] refs.c: remove committing the ref from write_ref_sha1
Date: Thu, 22 Jan 2015 15:11:36 -0800
Message-ID: <1421968297-25407-5-git-send-email-sbeller@google.com>
References: <54C0DDE7.8030708@alum.mit.edu>
 <1421968297-25407-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org, ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Jan 23 00:12:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQux-0001fS-UG
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbbAVXL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:11:57 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:64710 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbbAVXLq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:11:46 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so20933582igb.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z3LFW6OSvUmw3zZqwVp1OOg3Mp1V9ZkDeNaNLo7BdVA=;
        b=HhB370V2K1tQuF5XPP9hEdaZzKP+8PF/mwnZ6fJ3Nvn2RttF5ygftCaolpb32N3LSD
         gIkwcykLa21kd6viPj+zkhlnnshHGCzZn2B7E1DOUHjUqk6E9AwwVjYgCcx8N7a03XOm
         fYbaaDRmrOO+ZSHtFVuxDYnmINv/r8Q8I7JApQeLRCrnuoDWF+Q5F+SLTpBt0+pdKV1U
         1R0/dsqSlV+P9mjNIibn86xllpdmSPSQJLTrLf6uuPliUAF9dVmswpzFQaBQ9n+NwQXA
         Atc/M+cS4r/G6Z7+jVgzGsGNXsScy5qwQLJDZX1awTX18k1gBz2BfpTdr9a6ZTCkV6JI
         UNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z3LFW6OSvUmw3zZqwVp1OOg3Mp1V9ZkDeNaNLo7BdVA=;
        b=mYwX/SG08RSV+lF/1HUiZQvrdbkguucXvDvKQovO4Ly0vRsXuQfQ+R7MYArGfu/2/f
         FAk66KgmUcggxVNBhfDgaZokklwWxOodm83Z870ycz1RcfGCVscUUhSPATbtdZRymqyc
         4S20559lkz6CnIhml+k1ScyGQpRBa5n+te9rfIc2YKIQtF+mOuffMTDUZ9xWtKO6zx+s
         G3PY5BHFacbpYCipPPi4n/zXdVamrZSvst2DtVuuqGxbAR70zZrQklYa+kxR+K92hulR
         8j2yurTx/pR0QFoCXAeCApg88Ub8qsllDjhpEX9LjaPCqcn8UlQEBGbBvXk6plJPeur1
         oIbA==
X-Gm-Message-State: ALoCoQmhSKlhD1+ZWWwW5F9yrDKXNwNL8KDzPhHdzVeGIyJQvQEYZjVpg8Pc2wuLWcmmJL9yea+v
X-Received: by 10.43.34.137 with SMTP id ss9mr6277406icb.11.1421968305432;
        Thu, 22 Jan 2015 15:11:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e0f4:42de:391f:3cc5])
        by mx.google.com with ESMTPSA id gd4sm3882425igd.11.2015.01.22.15.11.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 15:11:45 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421968297-25407-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262891>

This makes write_ref_sha1 only write the the lock file, committing
needs to be done outside of that function. This will help us change
the ref_transaction_commit in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 6f3cd7b..c108c95 100644
--- a/refs.c
+++ b/refs.c
@@ -2815,8 +2815,11 @@ static int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-static int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
 {
+	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
+		return 0;
+
 	if (commit_lock_file(lock->lk))
 		return -1;
 	return 0;
@@ -2879,7 +2882,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	}
 	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
-	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+	if (write_ref_sha1(lock, orig_sha1, logmsg)
+	    || commit_ref(lock, orig_sha1)) {
 		unlock_ref(lock);
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
@@ -2898,8 +2902,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	lock->force_write = 1;
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_sha1(lock, orig_sha1, NULL))
+	if (write_ref_sha1(lock, orig_sha1, NULL)
+	    || commit_ref(lock, orig_sha1))
 		error("unable to write current sha1 into %s", oldrefname);
+
 	unlock_ref(lock);
 	log_all_ref_updates = flag;
 
@@ -3137,10 +3143,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
 	}
-	if (commit_ref(lock)) {
-		error("Couldn't set %s", lock->ref_name);
-		return -1;
-	}
 	return 0;
 }
 
@@ -3775,7 +3777,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (!is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
-					   update->msg)) {
+					   update->msg)
+			    || commit_ref(update->lock, update->new_sha1)) {
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
@@ -4064,7 +4067,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("unable to commit reflog '%s' (%s)",
 					log_file, strerror(errno));
-		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
+		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF)
+			    && commit_ref(lock, cb.last_kept_sha1)) {
 			status |= error("couldn't set %s", lock->ref_name);
 		}
 	}
-- 
2.2.1.62.g3f15098
