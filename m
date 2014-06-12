From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 09/48] refs.c: make sure log_ref_setup returns a meaningful errno
Date: Thu, 12 Jun 2014 10:21:00 -0700
Message-ID: <1402593699-13983-10-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8jk-0000uD-43
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750AbaFLRYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:24:24 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:50733 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so310410oac.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gqv6rtkJvOg4m+Hz2PkLzdtY+lf6j4n1HrI0CaSApjs=;
        b=QLQ0qZRkMG+HHV9G1EqQFBANM5hiKlXuwVkFGl9Nv+eo9DodmO7Di5EyH90qZagjxt
         W3dsYafRrEHuB7ardHhGlq2CtlwfLERhE9o9YKzmleRi3isJmleWtKljd6U4SXilL5vM
         sFENFFy/IXrpxajB1RQmv7In40z2djxDSJrzNVUlyRlvMhq8nJQ2wXc+H424nfTzI4IT
         6ufhJOiUrJo1AeRU2pTao3xm9H4QA4gm+K7Sup+MZ+0wUyUyUdh4OP/Rsj/NH+jP7yZY
         guJ3LpkSNB5LMWVlwc9t/WoamC1fYPbdSfCXQdY2CU5YrI+Z00gPRzrRAXbrc/kIcpnw
         KEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gqv6rtkJvOg4m+Hz2PkLzdtY+lf6j4n1HrI0CaSApjs=;
        b=aQGHHrw+WYBm+CjddL2YelRxUDguCT9HRiIJ3gAfbmqGXKLtOk5JHXKglF8cwO7P+U
         AtFUomPQpp+lkV3MjT1cAyoTbalaf6P7yMNwkQuX8CGi0YKyuLKPfCPHo9TFTLCrT2E+
         arsbj9BJBE1Akt2XGW+AobruU4yBd0OEnRAJr/8l/tXU3ZxEbfIvrTMZWoDALU4EF+Rx
         5rJAKG/YIgHoqIQKY3XdLhYMDRzrbcKmK1HTr22B4jYfE7g/2yhA9MaASCpYLT+WpSg6
         8vXFqaBtv7wOC1gWu6db7ecfUTVyFhfPqaoSqrbINmp9Ld2UtmiNN3jagGnE0kaCzlYi
         N9RA==
X-Gm-Message-State: ALoCoQmWCPFpKqLGv9eMbw/7WMw6TSd0O3FTUTX5HExtXFte1j+Bl3poISrTt5u4yEVmvNwI4OVe
X-Received: by 10.42.26.77 with SMTP id e13mr20427600icc.7.1402593703248;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si113766yhm.0.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1ADF431C65C;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C9E92E09AC; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251459>

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
2.0.0.599.g83ced0e
