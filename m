From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 09/48] refs.c: make sure log_ref_setup returns a meaningful errno
Date: Tue, 17 Jun 2014 08:53:23 -0700
Message-ID: <1403020442-31049-10-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:58:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvlr-0008KI-05
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933613AbaFQP56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:57:58 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:47280 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1487162oag.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LnUfnPX83hy3VN5okONSRQnCHvwTENgXTarbViqJVB8=;
        b=O2JZxH7LA1pr8QWj1xLq/QTIuiDREwkN6r2zP+aQrXRYajg4WKQ88HLWkQHiP+kN7x
         wkKyK7G6sZrzZREjZ86YSWMaHgbwgR05klKRpYiMqz5G1ld+3+to6NI62Ui4OXXgvZN1
         MSiqYYsFyX7SrQeRQBbdvsuDwhZSFK7fIDLtfGPpVOGheoonmSfO3f5Q6AQE9tuqFjl1
         BD3WIdSw9kLYgHxCY2ntsgnuLexC9FOo477dWKbo57CRYqcEVUgZQaeMY/BIdgrSibF6
         Q3NbLd8P16zhXjkgHPYPtbpr+HtytRzXpGAokAwq64PhGUsyOEwRn/Iipk00CRvl45Dj
         +l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LnUfnPX83hy3VN5okONSRQnCHvwTENgXTarbViqJVB8=;
        b=mLgwOMtzxm8wXcjZKo1ST2zs/OZ2gt4NGXyfAKQRDKu3PzBrniGwWZpgLqFb9mfQ8o
         HVthTpLkMpvGwhKoJjwOOBApZmYkXxe+KrUOIgkhfZkakh0GfrdpzH5zB12Bfo3lZGpC
         KbJ7odZ8NXEjUyk2QjpOMdNs6JgG3UVLW0J/c9MgxW3ZhbtGhTksB1G0YFcKgyK/f/8N
         q/bIq11Rdddf1iogfIJiOpUIny3brNDqnfS888tVPkxStkDacU3XQNu+y2TRMxIkpOP8
         m3ELlAOFz4ES0JIIc5dpkpQeVszPp14RR+PQf+vBE1imW5A2dsyWCB9luz8PEXGkcFNG
         6MpA==
X-Gm-Message-State: ALoCoQnu+tySIHWcZSTGD3jabC0QWpHiEzUS9+UYpUr9bNKU0+DAbKWBtxd2tlXmclhBd9v5puvk
X-Received: by 10.183.11.102 with SMTP id eh6mr4665705obd.37.1403020444781;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si69091yhi.1.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9E8E531C76F;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4B936E0EE0; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251914>

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
2.0.0.438.gec92e5c
