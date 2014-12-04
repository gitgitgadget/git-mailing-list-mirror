From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/13] refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
Date: Thu,  4 Dec 2014 00:29:19 -0800
Message-ID: <1417681763-32334-10-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:29:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnP-0005j2-23
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbaLDI3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:51 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:47448 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaLDI3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:45 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so15445228ieb.17
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d30VCKujqt4em2UIv72WYz30xkd2F4PRba3lY9TLOVs=;
        b=FxqvBejUBgkPBz8CTowN7p7/MMT1nOBtMmAQUbgofi5pUvnu0Jv3fcmgTKy2iurK5Y
         RxK84a8lqNGl7ePcSwa8JbCfpc28RuPpP7v2gbTy7UlXhK39e/eGl650m2g983q0Xd+Q
         6qcMDLT3BstBDzXm/b1Gj5CpnnAJufr62bF90xV51gLrwKoIBwkn6/rQbe3PZPRjg+ww
         ZKcZE7fmanL1EnsR0QHbQZA7D07InzIa4DnMT+pcpA4YPW14WtQutJD/J9f8q6a2O0lO
         rWOpMBdK/bHlcC7yv+wpnRKDqiQVOGEgXZ1adKJtvJeakQ09sWQ8oR1SOp4fKoELjLCf
         FeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d30VCKujqt4em2UIv72WYz30xkd2F4PRba3lY9TLOVs=;
        b=IqRRVP1nghMA4jVp7kI8gA6lnD0e63OT912nsZW8hTiTVT4v0wT4/FN2sWZ6Px3TZ9
         2MZHh9TrPO78KNqCrRK5u3Qla9qvtOvuTXmPt+RsMAJ/UKCg8Z5jKG+0iZhKxEtzfyBg
         NvJ6ErOg2yjXnTHVsYb1wndWKjUJJ1jPV/5xk9g1SWECE/NMWen8SfoPdvyIUtu4RT/a
         BPyD6pJkKqTjf4QWZuLMyNqTl7wmPtEcZUZ3J5nmsSkSwzqeQBSAxvoUohyPuiHXRQAD
         9o3djjhMo1yeytq+Eh1ks5/eNZ9yQ2XVFEWg/bdEEBgHDtPeZQbDi3ASHpL2Ev/mcCGp
         7mzA==
X-Gm-Message-State: ALoCoQkyozq0UNIgSDHcv6iREbQSNQKL2neFzqUEcFUuHF0Agc5bf20rtxOPpazqhvLQr4QwU6LO
X-Received: by 10.50.142.98 with SMTP id rv2mr209368igb.19.1417681784868;
        Thu, 04 Dec 2014 00:29:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id h126sm8006795ioh.9.2014.12.04.00.29.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:44 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260738>

From: Ronnie Sahlberg <sahlberg@google.com>

unlock|close|commit_ref can be made static since there are no more external
callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index bdd3f75..1468c00 100644
--- a/refs.c
+++ b/refs.c
@@ -2090,6 +2090,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	return 0;
 }
 
+static void unlock_ref(struct ref_lock *lock)
+{
+	/* Do not free lock->lk -- atexit() still looks at them */
+	if (lock->lk)
+		rollback_lock_file(lock->lk);
+	free(lock->ref_name);
+	free(lock->orig_ref_name);
+	free(lock);
+}
+
 /* This function should make sure errno is meaningful on error */
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
@@ -2888,7 +2898,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2896,7 +2906,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2904,16 +2914,6 @@ int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-void unlock_ref(struct ref_lock *lock)
-{
-	/* Do not free lock->lk -- atexit() still looks at them */
-	if (lock->lk)
-		rollback_lock_file(lock->lk);
-	free(lock->ref_name);
-	free(lock->orig_ref_name);
-	free(lock);
-}
-
 /*
  * copy the reflog message msg to buf, which has been allocated sufficiently
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
diff --git a/refs.h b/refs.h
index 0c75217..fdbdea6 100644
--- a/refs.h
+++ b/refs.h
@@ -198,15 +198,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
 
-/** Close the file descriptor owned by a lock and return the status */
-extern int close_ref(struct ref_lock *lock);
-
-/** Close and commit the ref locked by the lock */
-extern int commit_ref(struct ref_lock *lock);
-
-/** Release any lock taken but not written. **/
-extern void unlock_ref(struct ref_lock *lock);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
 		       unsigned long at_time, int cnt,
-- 
2.2.0
