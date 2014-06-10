From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 09/48] refs.c: make sure log_ref_setup returns a meaningful errno
Date: Tue, 10 Jun 2014 15:28:57 -0700
Message-ID: <1402439376-25839-10-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaa-0006or-AI
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbaFJWcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:32:17 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:34627 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so603697pdb.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRG2qm9BYg0lVfoxAJiBkFoIPMlnEdoYgIqHZ9cW9+c=;
        b=ogTBpeZazkGCRcIfyIVg/r7L/gcQ2cAefhn53/QwbF37szXXjn+0OWynPRI65z47AD
         k6HaY0uJUt3tOwDTHEm1fSK7v5/VmLTjtLqri+JJSgPTNVO9E2a+FMDh0WJMDHRjkau4
         P4udULyWyhT4DKkijbXQhTZM7t8XYjfw4n4v96B+WGjqZpM3ugODT8/to18XuNO1YZTT
         EfDsxJrG3nnIBtKWl05Y1DbPswx61j2vpFDfyidoylHpx2uZtnEC2upxrVRMNnsazAob
         cG/V17GsTPiLgGnVUJCP72jph2b9raoB3Z3JUzx8FC4sjWnEPFHdouWv1iHhs5FWJ7xx
         ZLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRG2qm9BYg0lVfoxAJiBkFoIPMlnEdoYgIqHZ9cW9+c=;
        b=aYmtQbdG2hEYxMvoArgIk2DAK3ApMOGuxRw+CcVJldR1x9Wp9Xkih+zWBzH2q+HQY+
         3E73lUc7flSt+dCjuDJkVGT1w3BPjX52N4qvmbCYEIuPDRbuOGexwj/gNDmVhFAwhhbU
         EiJ8EFc0exuIxqzEydbXznVy22PsGKms3JlQASpv0Cozfr7qFih6kgbmFT9AmdMKn2lo
         e1F6T+0UYrDNZ/yGHN2X81YccXuMCR8hPWPcmAwa87d7QyGLwbH2YZXWkgrj79NQ2aGW
         HiM8N7OUiMZVajZuagmFTpRr2wSYzHUuaLSy6N++X0u5mq7uQOg0O7ZFAvrDtLuPdgzn
         zs0w==
X-Gm-Message-State: ALoCoQkrQirxvS/QLnjA8wG6tGutSxf8x/PU0cb4cGKu/HCUnH3IkcpWXjiDPXPgNWNRfGrFUwS/
X-Received: by 10.68.180.132 with SMTP id do4mr4932117pbc.4.1402439380563;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1394549yhl.7.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5F3A431C763;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 175AFE06A0; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251292>

Making errno when returning from log_ref_setup() meaningful,

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 29 ++++++++++++++++++++---------
 refs.h |  4 +++-
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index b4b05bd..6f85bd8 100644
--- a/refs.c
+++ b/refs.c
@@ -2723,6 +2723,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
+/* This function must set a meaningful errno on failure */
 int log_ref_setup(const char *refname, char *logfile, int bufsize)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
@@ -2733,9 +2734,12 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
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
 
@@ -2746,15 +2750,22 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				return error("There are still logs under '%s'",
-					     logfile);
-			}
+				int save_errno = errno;
+				error("There are still logs under '%s'",
+				      logfile);
+				errno = save_errno;
+				return -1;
+ 			}
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
index 948cc53..979c12f 100644
--- a/refs.h
+++ b/refs.h
@@ -154,7 +154,9 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
-/** Setup reflog before using. **/
+/*
+ * Setup reflog before using. Set errno to something meaningful on failure.
+ */
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
 /** Reads log for the value of ref during at_time. **/
-- 
2.0.0.574.g30c2c5e
