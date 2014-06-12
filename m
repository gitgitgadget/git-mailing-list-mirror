From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 10/48] refs.c: verify_lock should set errno to something meaningful
Date: Thu, 12 Jun 2014 10:21:01 -0700
Message-ID: <1402593699-13983-11-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hZ-00074t-8H
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbaFLRVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:54 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:60628 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so309674obb.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e4DUFnQkbzums/Nuw1KH+u1adRtYQyFT7eyno8L9SLM=;
        b=L7hQLGmFI3XDi4hNKQtLettS0d9sV09hJOSHsf8SAgLJrNmj1LEIFaEAXpSAUmCDOl
         XYkvgcjdgayhNdvSSkv4Rwpp4NJdWIZKp+a4pOJMX9bacSGFMMBpHUr9ZCzKWbrVVKg4
         jMJieISlreYgONzq7U2JEuB8YfJ+3G0NdCzeOmb+odm/M2jNtBL215MJzZg4GGJDbkCV
         d5S3uJFAmc/jS6JXXE0ZCNjmO7He5TawsVbd6ttZUG8xHFqEUIWHNyb5TZhas00UF2jV
         hVBmuNepK5GMsn/ubHMdoPog6EJpyRs2rKX2LZ1U8fNkRJBZAXgSVzFBDZDNcIywIiEl
         uUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e4DUFnQkbzums/Nuw1KH+u1adRtYQyFT7eyno8L9SLM=;
        b=cwqECXHu5ceK4a5PRssSPbcSw362WhaCPZYH0OyMK6DZIOCHdU4eSwlRCve5tlyl6h
         q0IO90MW2U7G1OFeW8GmlYje1XUi2WSuOGOJYN3NQ2t7OD37losdPlUxMIQuSzftS+yw
         FRLDSxKowHFR4DJNEF+4A02wGJz4MqJKeL7KdCPw73+dOxnAnG5cPMUwEggghiwZ+PJr
         6O14mz8rNlvihLxiVoMDTm/IKaUSegrUNqDh3kFqTdqo+JkzraK3woqbATw4aWs0biPt
         eJwT9ROapv4ey/ccuyrTG0P/VObIJ3CTM0StaV/PFgZSonZatYg/zT84VU6EW3EsfxhK
         n0Fg==
X-Gm-Message-State: ALoCoQnWe9m/5HQEr0eDfPPke0DcV/MZABepeZEJLQqHSQe5j48sFf4mvlNyNQoiMXxOmJRDbb3y
X-Received: by 10.182.27.40 with SMTP id q8mr751727obg.22.1402593703217;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si113142yhg.2.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 114575A4813;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BD950E01A0; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251423>

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
2.0.0.599.g83ced0e
