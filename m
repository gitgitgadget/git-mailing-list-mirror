From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 09/48] refs.c: make sure log_ref_setup returns a meaningful errno
Date: Mon, 16 Jun 2014 11:03:40 -0700
Message-ID: <1402941859-29354-10-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKf-0007ix-EF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbaFPSI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:28 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:39019 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbaFPSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:23 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so262109pdi.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=md2qT65fvr+Q+dIa5es/HAnp9egAEykSQO7W8Iiuckk=;
        b=kUB1gl2dWSekOZ9lhd5kOkgwfTm6gE+Gg27q8LgYjXiNpi5Ci4B1axOISUJqKr9Wm7
         piv2QRtyExzIe63yIUMzy9A6uiIrk5ybXEmPxjRGFyYx5gAZxySDq1WQprn21Gay7Bu6
         MO0Alg8rx6qE2xZMoDvVpBMdRw9iGX7g1BkWBDQsnIcHRBgwflMsPOBnV9j8ENP1D8xm
         VxDtixeDZr02P3wxSWyHA3b4i+10e6mJoghbOn1keKj2FJW/l7rZKvU7AsCw5ZTUlRy8
         gcWMF+Ohrp9qbAnz2bM2FiRwy9XoA3Wo7Tm0yTQ2QzBMUL5v+Q8Vit15zFmnyxSwHzU3
         A/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=md2qT65fvr+Q+dIa5es/HAnp9egAEykSQO7W8Iiuckk=;
        b=BI1F5cQ/cMIlpNo2VjVQ1hj/0jVh2bV6LSOAYsO2bFRz+EHJHRiaCde4xnQdj8PJud
         O6tBV8L3BC/FZCRhq7qOSDhJ+Ewve1yY3Zt8F7UHqo4fd2bURJ0kH8GuYJgINCpDLoyb
         1yzDQ3u8qwpJMwoxa0xA8Zcr1v4+WZkAI05JFsAnVXenrEI6LNHql+NybOtCHomlbcS5
         edB6UVk+2pRIEwlmsp9SfqLgLig1zBJ2mzOlms6MEDp1GiAegsUAQx9Ku6MP5HfHlt0Y
         tkY5snPHehJrgozzP0FezXhZx6bkDNpOZgx+o/NUPTrrZvKMhlfjdIUM2NnxCNkSrLVN
         MEpA==
X-Gm-Message-State: ALoCoQmnFBd2zbquThUH6FZmWtgqHZerrAcEs+KIducmfoEx60ugYmuNSutwZ2s8n8me7cmgnBzN
X-Received: by 10.66.142.9 with SMTP id rs9mr2514361pab.47.1402941862796;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si997791yhb.3.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9AB2C31C8AC;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5568DE16B4; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251782>

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
2.0.0.282.g3799eda.dirty
