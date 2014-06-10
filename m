From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 10/48] refs.c: verify_lock should set errno to something meaningful
Date: Tue, 10 Jun 2014 15:28:58 -0700
Message-ID: <1402439376-25839-11-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUa8-0006OG-KG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbaFJWbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:45 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:54904 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so206446iec.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vcgYcaH8T6JWHtTLQ8nFwENz0Y4vCJHGTFUMDsgp6nQ=;
        b=UBCuXoPcFfdB6MVwthwtfQ/VvLJsuABvmsuj3sHWoCYEQt4TMZ8M1+xW5mwq6rP9nf
         JZPN9/7lbgQgS8pFOfHjVBtYKhbE4tdHjLi6w5n83+yisb0gQhR/n6Db0CRdht+iDFzc
         gO8K7dQt6o0Sxvnau6fmaBc2dksgXIQv42pFdd4iRoGYalgViyPIq1pe08dhmBHUdYE4
         6hOmdPHOJDAPPhO029Q2vavokC+ckOyulYzkxGC6ZbClrmYbt+rS6xLrl8inSId1kg72
         lTAmeXzjQvYw2bOmlATVUi8hPxIwvh5WBa4niEYZ87ZYYq48SiBKBp75h0LRPC2v3yMf
         WFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vcgYcaH8T6JWHtTLQ8nFwENz0Y4vCJHGTFUMDsgp6nQ=;
        b=gRQ5MnxXFnkzEotwGuwTd/sWQSxzRg2HYLV8VTNR0FVx005Gs/OkGxjHeJ5fYkZ69q
         c1cDjHl3DWhW5hFyo0Wzz++AjbbtyoraHZfbAjZNp8Sv9ORiBHi0M5udQq5gD1kWJRBg
         rdes+zS51tdh1t83w9qlQnvBfmq3wb7QwK32cXj8/175NFLE5c/LrI98+4WwvE++I8A8
         hHk1a13doZgMfsyzFrTzyfjR7wnE7TGsDkd1WjIUtcAHY2YluioxrfbIg0dh6oKU1F/h
         nU+rguy5N2QvSuJrVRLu7MoXFqgqzGNQJLJe2ns4qKvfsgG+m4qWxu+G4dZxxMlrArIx
         zCnw==
X-Gm-Message-State: ALoCoQlHD4l1Td+ePNBVS0zHlmCtAhu6YfPs0kZWxLojfnQ8EHrrITRTVxqDwUzD3KDyZlkTK+QR
X-Received: by 10.42.233.133 with SMTP id jy5mr376360icb.32.1402439380514;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1395391yhk.4.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5AEFA31C750;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0CF5AE0A0A; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251284>

Making errno when returning from verify_lock() meaningful, which
should almost but not completely fix

 * a bug in "git fetch"'s s_update_ref, which trusts the result of an
   errno == ENOTDIR check to detect D/F conflicts

ENOTDIR makes sense as a sign that a file was in the way of a
directory we wanted to create.  Should "git fetch" also look for
ENOTEMPTY or EEXIST to catch cases where a directory was in the way
of a file to be created?

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 ++++
 refs.h | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6f85bd8..3631a3b 100644
--- a/refs.c
+++ b/refs.c
@@ -1904,18 +1904,22 @@ int refname_match(const char *abbrev_name, const char *full_name)
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
index 979c12f..3ddd618 100644
--- a/refs.h
+++ b/refs.h
@@ -133,11 +133,15 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
+/*
+ * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * On failure errno is set to something meaningfull.
+ */
 extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
+/* errno is set to something meaningful on failure */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.574.g30c2c5e
