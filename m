From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 10/19] refs.c: verify_lock should set errno to something meaningful
Date: Mon, 14 Jul 2014 13:58:52 -0700
Message-ID: <1405371541-32121-11-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLj-00037o-DT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201AbaGNU7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:36 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:35614 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890AbaGNU7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:06 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so374571pab.5
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=haD/HcvIqMsudvm/aOtgtHV2h6XPp2KgBZnKdP7bj7U=;
        b=pR870PkA52I/hF7yrRjY+0fawOQtPHm7PAk3Saha2kbUDuDPsug/0B801sSzcIjCo9
         SBZO345DEDo0bY/T/axAMj90xgfWJPTdkYSEs0GNNfEPDduL8N5HGgIHNojEdsEfNpYs
         Y639tUve02NHQw5VElwCmoL+nKlu17qZTcNNOkeTUBn3zbDjJSqAJZD1+33lkiUlFZyN
         IQZUf2CIm1pDxIbnou+8/ilvjNlnW9P7oDQJP1RfnorZcI5iYgmR+Go5XghkTDYyDtJf
         L7jvTDr3mYErRSNykysj4x/DYpP6WLxYdHIFIuHvwE0VK+3LHSa9c8bBjs+aaEb74Y2r
         WufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=haD/HcvIqMsudvm/aOtgtHV2h6XPp2KgBZnKdP7bj7U=;
        b=OoPNttY5QMDNUnhP/zVAWQrDrqJ5b99xg1XhQku1f2vk+V8RUwuWEAiwp+GP3i1tkH
         z8IzperEXJi1XFzjdCzrLk76CpQ0DLiCYgwxP30I2hWEd51AD0A1Qv9eIVDm5cdOKc37
         yRoPcURxQajUe8u6lYXSkBLubAtrDAheNzkCeZxWEXdK3Q7P3riTLDtLDxVfATlqsRBI
         Za8jyuSR8Y/7axUWu5n5kKwhKqSfrl6dyBMWs9auKf2aIaDjbKAxlE24Ut0rLCbGn6ol
         YuEgs9Y0ahkBsLiJJHXIKrDQTQJHZG7uIdmfWDi5fFEjtd1K69hvO+qqn2P+X/rR1K8f
         HCjQ==
X-Gm-Message-State: ALoCoQlQ2oWNBxPAsVfV61aFdOlk4axwpOewQsD3HdZm6C5uJJRR/2m9+LqdNJ0eFbXIJ/mOoDQX
X-Received: by 10.68.135.226 with SMTP id pv2mr4353714pbb.9.1405371546009;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si821113yhh.5.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C8FF75A43D4;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A3B7BE0E29; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253526>

Making errno when returning from verify_lock() meaningful, which
should almost but not completely fix

 * a bug in "git fetch"'s s_update_ref, which trusts the result of an
   errno == ENOTDIR check to detect D/F conflicts

ENOTDIR makes sense as a sign that a file was in the way of a
directory we wanted to create.  Should "git fetch" also look for
ENOTEMPTY or EEXIST to catch cases where a directory was in the way
of a file to be created?

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 ++++
 refs.h | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9ea519c..a48f805 100644
--- a/refs.c
+++ b/refs.c
@@ -1932,18 +1932,22 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	return 0;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
 	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
+		errno = save_errno;
 		return NULL;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
+		errno = EBUSY;
 		return NULL;
 	}
 	return lock;
diff --git a/refs.h b/refs.h
index 82cc5cb..8d6cac7 100644
--- a/refs.h
+++ b/refs.h
@@ -137,11 +137,15 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
+/*
+ * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * On failure errno is set to something meaningful.
+ */
 extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
+/* errno is set to something meaningful on failure */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.1.546.gf603308
