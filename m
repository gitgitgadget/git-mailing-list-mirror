From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 09/48] refs.c: make sure log_ref_setup returns a meaningful errno
Date: Fri, 20 Jun 2014 07:42:50 -0700
Message-ID: <1403275409-28173-10-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05p-0004LJ-Bn
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbaFTOq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:59 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:49449 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so506789qcz.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bbu7bmP0waJaVSvU0SSO/JyZBaXuQ1RBE5t5V3ocj3M=;
        b=eq6kI0kLOGJCb0bJvXR6AOzL5HlqXX+evnRqZ6aU7AIhOFSuAUonAyMJOdixe7pMhA
         igD2Kc7AqbgDWr9pLb5aieQsokXv5pV6ZXl/uiWSf68lSj5jrH99IBxxZa0q3SjSMUaq
         BjY+bcN5/tz1L/b1kKkuzZvs3hnzB+nBVz09UimO1cZEqv2MEDwPrUjXg/Mi8ozWEkwN
         PDWnVcGKWiIwg2WAPAvmdN8r5FQnT9KScCNgJi2QFS1kf5MME7oGHuJzvDu2Kfs58bMN
         rz2MHx/DTCcszYvLErDv2bMoVN9LckOEvp3bVknfWjBBawBA1moaTj1ojI6BnG1ss1xw
         /azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bbu7bmP0waJaVSvU0SSO/JyZBaXuQ1RBE5t5V3ocj3M=;
        b=a3c6Z/Bi/c41ceet4ypkldj8RnWgAe0j/c1EwsAuvrloudhNSD7XT4dhLQ5EnUOReo
         1lyYCWYdgbIk1nzvoF01Bq1lGkNlPM9UsNSj2kEin9HFqWT1QF30Nxzv29J/YexnCTvU
         brtEgd9igFFmaIfBzp5VKIn2e2a6qQfNwTZeRzG9aiRAxJp9EkELWg/jj2iS0hBSeYC/
         JbXxWZcfiSBY7qD/9hC1AyFMpWoX1N03vRHsNoh3MfpTL8EPha2h2l7Kjvz7lVLUoGen
         PgvVDHitw2YIBUA7tOseJALLR1D4/iwNp5Qnvor+tnwq4MnDLPZIr4owAXFx/dIjtiPa
         r7/w==
X-Gm-Message-State: ALoCoQmfZ3YtIJ1cgqyrZRhOmrZQPlSLlWejuxjCLtdUu8VG1RNq9M6PlgQLO2MT6RsB0EHLFzKV
X-Received: by 10.236.150.114 with SMTP id y78mr1448188yhj.7.1403275412389;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si591921yhe.2.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 404E45A40F4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 00CB1E0873; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252270>

Making errno when returning from log_ref_setup() meaningful,

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 +++++++++++++++++++--------
 refs.h |  4 +++-
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 67a0217..9ea519c 100644
--- a/refs.c
+++ b/refs.c
@@ -2751,6 +2751,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+/* This function must set a meaningful errno on failure */
 int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
@@ -2761,9 +2762,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile) < 0)
-			return error("unable to create directory for %s",
-				     logfile);
+		if (safe_create_leading_directories(logfile) < 0) {
+			int save_errno = errno;
+			error("unable to create directory for %s", logfile);
+			errno = save_errno;
+			return -1;
+		}
 		oflags |= O_CREAT;
 	}
 
@@ -2774,15 +2778,22 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				return error("There are still logs under '%s'",
-					     logfile);
+				int save_errno = errno;
+				error("There are still logs under '%s'",
+				      logfile);
+				errno = save_errno;
+				return -1;
 			}
 			logfd = open(logfile, oflags, 0666);
 		}
 
-		if (logfd < 0)
-			return error("Unable to append to %s: %s",
-				     logfile, strerror(errno));
+		if (logfd < 0) {
+			int save_errno = errno;
+			error("Unable to append to %s: %s", logfile,
+			      strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
 	}
 
 	adjust_shared_perm(logfile);
diff --git a/refs.h b/refs.h
index 65f7637..82cc5cb 100644
--- a/refs.h
+++ b/refs.h
@@ -158,7 +158,9 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
-/** Setup reflog before using. **/
+/*
+ * Setup reflog before using. Set errno to something meaningful on failure.
+ */
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
-- 
2.0.0.420.g181e020.dirty
