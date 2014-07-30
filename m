From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 1/5] refs.c: move reflog updates into its own function
Date: Wed, 30 Jul 2014 14:55:37 -0700
Message-ID: <1406757341-4096-2-git-send-email-sahlberg@google.com>
References: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbqo-00087L-LH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbaG3Vzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:55:49 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:44226 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbaG3Vzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:55:44 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so251484yhl.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v/YVrn6Zin+5yE96YDTV98l0upV4Ilm68790E02y8Ao=;
        b=itnc/7iigjhz9hla1ksYW5wXzovwvFgSOvf1OE3MG5O56VAyXaeIyZXQx6liAQZJhk
         XhY3/Uu3yLWoqmT667l54E6trsrthSbCSzIrxZi8zWKIVpvOB8wty3BOVXLHKVtpp3bG
         up9mT7EyIJevSy/qX/MB/xwmFTVEFGVlr6VF6iHcTiq5pym9sUmmTTbI2TMuFR1MdPSR
         ALOrUOlbGHGxxoV7+lM09KQBvpmCSWVPqbVpmUNOuKrD+rBleDJ5mouIlzPVEng1LVvi
         GfQc0x9GVLUczzsVVBf3KunAsvuiI7wrsyK597EFR0dUZGSZyi0mSHF4o5hR/nZiAXsB
         DZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v/YVrn6Zin+5yE96YDTV98l0upV4Ilm68790E02y8Ao=;
        b=bOMrwvH7cmP7td4l4Vkjtse6tskfokMQy8twB4y5wj3FzwXuuZzQ+p+ixhahUwUHjW
         5NDSBePp3/nBVwUD9jF/uitfdOR5E1/8PuaqF1hf+IT8PCGg69TNQq2+OHM+pyNiks+h
         DllA2i4cj9rO2h5JO4ubgRia8cbNdgQuPUaAxTVAvmwp5+Iyc2h9JwQTghhjzceNWkr4
         GAeJmih3mEmJlHuOlqFQp/Q2wBM3w13HsK3yPgN2ZK1NEtP7Kdfv6af0VaOhwy9E9ICn
         h++0ZJtOuZCj/IM4pMm/BhGmDycFwPCikmTmKwiBtbFcQ6UMIZRLcQHt9+Zfh2OeDoZC
         0Y9A==
X-Gm-Message-State: ALoCoQmNUeKYE6pT6ADJZoNOtNIFNBQ/hhdeqOHAAB/A8sD35ZZQFNiSaqCFpHHP3n3r06jZ0VOz
X-Received: by 10.236.29.37 with SMTP id h25mr2514175yha.8.1406757343390;
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si224353yhp.6.2014.07.30.14.55.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1FE505A4437;
	Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AC784E075A; Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254528>

write_ref_sha1 tries to update the reflog while updating the ref.
Move these reflog changes out into its own function so that we can do the
same thing if we write a sha1 ref differently, for example by writing a ref
to the packed refs file instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 62 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 3e98ca1..ed65f4a 100644
--- a/refs.c
+++ b/refs.c
@@ -2880,6 +2880,39 @@ static int is_branch(const char *refname)
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
@@ -2923,34 +2956,10 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -3659,7 +3668,8 @@ int transaction_commit(struct ref_transaction *transaction,
 			continue;
 		if (get_packed_ref(update->refname))
 			continue;
-		if (!resolve_ref_unsafe(update->refname, sha1, 1, NULL))
+		if (!resolve_ref_unsafe(update->refname, sha1,
+					RESOLVE_REF_READING, NULL))
 			continue;
 
 		add_packed_ref(update->refname, sha1);
-- 
2.0.1.523.g0041e8a
