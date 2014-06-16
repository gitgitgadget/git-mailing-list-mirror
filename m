From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 10/48] refs.c: verify_lock should set errno to something meaningful
Date: Mon, 16 Jun 2014 11:03:41 -0700
Message-ID: <1402941859-29354-11-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKY-0007cE-OE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbaFPSIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:25 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:44076 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1129264oag.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1zNiOlzo1Z22nlUVaMHH4Xzg4aWRFroO0MLvgJx2xyI=;
        b=bySzOrwwkAMz2f9zcuU7CwNxqpa67YeUYMOole2fsCrbFaOqT5KPhSFLiypg+g5rdS
         0LrAx+ojJM8nvE2GggPh6/bn2oGmqY99p/QEWbhaHASBQXJZuIjIo8A0JUY4MMuUPf75
         xRX+gIQt4bZb0VbFTtyAmZyjcyzRprWvG5aZbpupTvk7urwzINoXrSYzZbn6XE6WIdLF
         cK5cGB/6L/xzUdLdXRnFf8k/SGd3rUASiuGm/zGkNuDin7DvnziWsqxk4NsI2kMo5DBP
         EEaQchqMVS206fhEStgEQXh7mWsv288ZfEPUxpTVPf81aGHwfNcu9kR48cmp6dl7ds5U
         ManQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1zNiOlzo1Z22nlUVaMHH4Xzg4aWRFroO0MLvgJx2xyI=;
        b=iEbFN9Dh4CWHGJ6hgOH81Ebk4YAVPWyXzTjVSoyfrHjryOaAmxKxmwmQcd1RvUjHsC
         F4CmxsYQp+3qD3gBLdvr/pJers0JtXIUmOKmFn/nALbxQv3FIcESZWyrK1ZAaV7zElQI
         Y17HvgEv9ASF57p2i0r2h1wC3mJ5WGJXNmTqOuptyAc6YOUTQ5q24rrw5NGxVm4GSQ9l
         3ia8tLZhc6m2Q47JGVijqX94D2BJNYMU3xjkqIx2saWayvNk9ac0aS6Mp6eijdwfbs4t
         iyYGSgeTIc5PlsduOQ7nrBmuGM8A62gRjN38jIFN0K+bDtrgYWBSyTKyx+SDvHc2/zxB
         SKrQ==
X-Gm-Message-State: ALoCoQkoCTVZCV4KkaVl4v/otalGjFyIjBxibgjo3Sl9YWbOdSVnyvWLbzFmiPKdBn6rstZX/P9L
X-Received: by 10.182.226.166 with SMTP id rt6mr2679562obc.47.1402941862739;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si997133yhj.5.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 92B4431C8AA;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4B098E1718; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251780>

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
2.0.0.282.g3799eda.dirty
