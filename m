From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 10/48] refs.c: verify_lock should set errno to something meaningful
Date: Thu, 19 Jun 2014 08:52:52 -0700
Message-ID: <1403193210-6028-11-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeeu-0006GL-5w
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757958AbaFSPxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:45 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:34536 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so330860qac.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BX4h2u7UN4DUQMxlbFf2toNCFAhrQPJWrSkanVvbo8g=;
        b=LVlA3taWTRu2SlM1Wrx21GWA8vQkC2ZD6Ci4eZD97+pXnWo34FHzjjtwvNc5I5F+Na
         4gMG47uB7+PxeGBN6BjJQCgZUFCK/GjXVezqyIfiB6pimwRHCtAJMeW4Yvt46ircxCiw
         Ua+sI/EKPyli/61v/+AJRanmTNvjU3Vc202rEgt2qscOLa/KkWtJsF07J2GZT78htUgN
         NJfQ10fNwcNPNIMLTzHBdLG3uBVMdr0enZ2OQCmcaP9UUtYPloUD6iv/fLY/SNWhbvsR
         nsdLCo6ecqG9mQoXTy5xJ2IQ1pmTGWmq3wLzt+eA2o7IE7gNS0+HMeEelnYCIz32Ucrm
         ZIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BX4h2u7UN4DUQMxlbFf2toNCFAhrQPJWrSkanVvbo8g=;
        b=edInXTEteGHh/a2X6BEeiV2sT60C/FoZ8H6ZzMyKOxUoWXq0oF4zvlQD1WQVyUhP6Z
         VGsWXLN/DyJ3VqCfIYMcfNG/CpCIq6h3KM0xalHTPiJeVHxANlPTHo8thArBKBucLuBl
         VOM3XDCVGnW1j+hSEJl8rtOlKqJhv+uKM27Pgy4LxcxWItoPagwsQD8Hy+MFg/F9ehNz
         PG7UpMg470cqoWM68ILNCliKdQ8RaFAaX9ycdDc+h5xEeLOXXthwD+0zfodt9obqHPZO
         gpcHXXGWImEJtpxnEzWe/zHXUGUvHQ9c0WINmMxiJsO7hCRX+6ylZ2U0SLAi1pVqdzne
         pl9g==
X-Gm-Message-State: ALoCoQmupe1AQL6W0U7iLmeIVV2h2QlSZXXcP3jUUHRMxQvlmktmFe1vLPVQaiKHhensCK8AknqT
X-Received: by 10.58.151.238 with SMTP id ut14mr2574097veb.11.1403193213269;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si347085yhe.2.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 22D0E5A4552;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BE63DE0AF7; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252118>

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
2.0.0.438.g337c581
