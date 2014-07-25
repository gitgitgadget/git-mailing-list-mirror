From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/5] refs.c: move reflog updates into its own function
Date: Fri, 25 Jul 2014 10:55:22 -0700
Message-ID: <1406310926-4080-2-git-send-email-sahlberg@google.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 19:55:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjiS-000254-JZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbaGYRzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:55:32 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:33043 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbaGYRza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:55:30 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so1215361pdj.4
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oBUoRvdgmIjixbnCDUnkQk6TV8o3tn1KyzQ1i150Bro=;
        b=FsqePmLTVcZlDsXd4+UuQ9llU7Zp+P3OpPMVce86mhXhZ3TYjeEQluerjJlzj3j2am
         YrVcI21jZO5mrdONs0ktlaEQGeVbVCLWc0DosV/YON6TIsDxQsnpD4YSYo+DvOIr1yJ0
         4MQMmo00H8lvWCezuJd6ppDyEgLzhf99EIjUS/gbEr2GjJQq6uH8onvPWTsGwLF65IFO
         fM+VOGPADepzYs+VSkzuEpskirmgvnQa3n7T+SXnFvhnO1gdKH2C9F+UN1cSi+E1rQfo
         ghpjqaszO1D5nXFQk3ZjaPq6gQ6WTM0+KHK3uJ1L+dWP+LeLN78IXjbE32wMLs+EVMHw
         wh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oBUoRvdgmIjixbnCDUnkQk6TV8o3tn1KyzQ1i150Bro=;
        b=cRkC4IgpC5y2xV/8PYnori048UJTS8q9VnRoTRo9Jw1F2qbh5jeqcgd0bCNRnUbIa2
         bDFSSK86QYt1EUth1Kk8BQNG0qvu56Qf6cDN/JP9VcxHKxt9jYPqEEipcZQuUhEx/++T
         WCCt8Q54VHMvDGWJXtk6+B1mxesgm0jX4MP9aillTcEGOFp0HickPihjn6SLdfc8rqxD
         BZd3l9GCpi0dPeHMaRE1/OSfvWytDQO4FlCoNplFbfRnzfE+D3iSZdHpp6K5b2mTUPKl
         9wdP/13dGSJ7WAzL1kPCUAI4znibzGp4aZ//Ss9UsgSqcjT7t9BLQdX2r6NEruOeZ9Z1
         Zbxw==
X-Gm-Message-State: ALoCoQl8HW6iEoFDd8OkdPaO7EsNNnpYDCYnG76DQKjmVurFop0y4vYCi8ItTYl2Vp1pC6eq+1+k
X-Received: by 10.66.65.202 with SMTP id z10mr8675896pas.45.1406310929952;
        Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z7si186535ign.2.2014.07.25.10.55.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 637A931C43B;
	Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EE273E0600; Fri, 25 Jul 2014 10:55:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.518.g4f5a8ad
In-Reply-To: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254244>

write_ref_sha1 tries to update the reflog while updating the ref.
Move these reflog changes out into its own function so that we can do the
same thing if we write a sha1 ref differently, for example by writing a ref
to the packed refs file instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 62 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 619725a..1048017 100644
--- a/refs.c
+++ b/refs.c
@@ -2869,6 +2869,39 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
+static int write_sha1_update_reflog(struct ref_lock *lock,
+	const unsigned char *sha1, const char *logmsg)
+{
+	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
+	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
+	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
+		return -1;
+	}
+	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+		/*
+		 * Special hack: If a branch is updated directly and HEAD
+		 * points to it (may happen on the remote side of a push
+		 * for example) then logically the HEAD reflog should be
+		 * updated too.
+		 * A generic solution implies reverse symref information,
+		 * but finding all symrefs pointing to the given branch
+		 * would be rather costly for this rare event (the direct
+		 * update of a branch) to be worth it.  So let's cheat and
+		 * check with HEAD only which should cover 99% of all usage
+		 * scenarios (even 100% of the default ones).
+		 */
+		unsigned char head_sha1[20];
+		int head_flag;
+		const char *head_ref;
+		head_ref = resolve_ref_unsafe("HEAD", head_sha1,
+					      RESOLVE_REF_READING, &head_flag);
+		if (head_ref && (head_flag & REF_ISSYMREF) &&
+		    !strcmp(head_ref, lock->ref_name))
+			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
+	}
+	return 0;
+}
+
 /*
  * Writes sha1 into the ref specified by the lock. Makes sure that errno
  * is sane on error.
@@ -2912,34 +2945,10 @@ static int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
-	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
+	if (write_sha1_update_reflog(lock, sha1, logmsg)) {
 		unlock_ref(lock);
 		return -1;
 	}
-	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
-		/*
-		 * Special hack: If a branch is updated directly and HEAD
-		 * points to it (may happen on the remote side of a push
-		 * for example) then logically the HEAD reflog should be
-		 * updated too.
-		 * A generic solution implies reverse symref information,
-		 * but finding all symrefs pointing to the given branch
-		 * would be rather costly for this rare event (the direct
-		 * update of a branch) to be worth it.  So let's cheat and
-		 * check with HEAD only which should cover 99% of all usage
-		 * scenarios (even 100% of the default ones).
-		 */
-		unsigned char head_sha1[20];
-		int head_flag;
-		const char *head_ref;
-		head_ref = resolve_ref_unsafe("HEAD", head_sha1,
-					      RESOLVE_REF_READING, &head_flag);
-		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name))
-			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
-	}
 	if (commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
@@ -3649,7 +3658,8 @@ int transaction_commit(struct ref_transaction *transaction,
 			continue;
 		if (get_packed_ref(update->refname))
 			continue;
-		if (!resolve_ref_unsafe(update->refname, sha1, 1, NULL))
+		if (!resolve_ref_unsafe(update->refname, sha1,
+					RESOLVE_REF_READING, NULL))
 			continue;
 
 		add_packed_ref(update->refname, sha1);
-- 
2.0.1.518.g4f5a8ad
