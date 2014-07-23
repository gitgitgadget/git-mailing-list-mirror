From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 12/15] refs.c: rename log_ref_setup to create_reflog
Date: Wed, 23 Jul 2014 10:03:52 -0700
Message-ID: <1406135035-26441-13-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxk-0004JU-9C
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbaGWREM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:12 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:42785 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so406103pde.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uU5u/UsQP1gZmn91aXKFgujr6UIc6jbwmtgmmWmyY0Y=;
        b=c41MBHIvxStcLfFiKkzpNaccIz2z+EsFztxBj68FJZVKJMBhw2EW0X/VnIUEInYW6H
         bqjqcg+Vs7Dg08S7TC1ASxOT/q7ClscPMk9EnMU93PWxp0VJcG8s8SED1moVp98POSF0
         UJpztX2ExC/SP6UB+XbhbIgsXCE9VS/6xzB7bKq128iHH4W+ZpMdzg2tCSoqfrjl/jUO
         VH59uquSlulT6ouKvqMJijpR/6wEIM4JICBdWzbKkcDNf6JRob5TVHZGMEWPS1onbsq4
         DRhmF2zRzZgjrSI9G7wZrArD8sZ24qD4u7mAIFlo6HHiGylZpLrlKpq/WkviDZCKbHfy
         Mtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uU5u/UsQP1gZmn91aXKFgujr6UIc6jbwmtgmmWmyY0Y=;
        b=S2h8CFrQQjqwfA1cZOq+OxT7XHLuiaxO67ljVz/lvPfDKTVdZhgi92UVbqejX4lp+u
         wi0V3vwat6PRzD3eqn+t8FLy146x27FSl8gcDE7ZRHqKBq+460zxew24qmdGaECJgw50
         UTKOYHoS5TsfdFoYtbDDOPFgTlPoMixR7H19/xJPISo5sIXnb91GXKvLpnGz6YeNUe1V
         JwSrkVu7uAfF1d7+6QmZOllNaoFkmqyBSMo0PMs3d08q/4Ikpo1NYOvDJPYh4z/6NEkj
         VcvzgPc3vSHb8ki13fEDsRDCt4LhM7cEDEKj8c/ip1mTqA6yTTe9IIIgOBJrDZhLfP2B
         1haA==
X-Gm-Message-State: ALoCoQkjoC73BZVl8soq2tiRaZK72YlTQYQ5/Au5o7J5josjV5oNgDNiwqE66eZCZOkHIYpxAjx3
X-Received: by 10.67.23.231 with SMTP id id7mr1264844pad.8.1406135038933;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si487058yhe.2.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A534531C34D;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 81681E0AA8; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254081>

log_ref_setup is used to do several semi-related things :
* sometimes it will create a new reflog including missing parent directories
  and cleaning up any conflicting stale directories in the path.
* fill in a filename buffer for the full path to the reflog.
* unconditionally re-adjust the permissions for the file.

This function is only called from two places: checkout.c where it is always
used to create a reflog and refs.c:log_ref_write where it sometimes are
used to create a reflog and sometimes just used to fill in the filename.

Rename log_ref_setup to create_reflog and change it to only take the
refname as argument to make its signature similar to delete_reflog and
reflog_exists. Change create_reflog to ignore log_all_ref_updates and
"unconditionally" create the reflog when called. Since checkout.c always
wants to create a reflog we can call create_reflog directly and avoid the
temp-and-log_all_ref_update dance.

In log_ref_write, only call create_reflog iff we want to create a reflog
and if the reflog does not yet exist. This means that for the common case
where the log already exists we now only need to perform a single lstat()
instead of a open(O_CREAT)+lstat()+close().

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c |  8 +-------
 refs.c             | 22 +++++++++++++---------
 refs.h             |  8 +++-----
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f1dc56e..808c58f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -583,19 +583,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
-				int temp;
-				char log_file[PATH_MAX];
 				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
 
-				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
-				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
+				if (create_reflog(ref_name)) {
 					fprintf(stderr, _("Can not do reflog for '%s'\n"),
 					    opts->new_orphan_branch);
-					log_all_ref_updates = temp;
 					return;
 				}
-				log_all_ref_updates = temp;
 			}
 		}
 		else
diff --git a/refs.c b/refs.c
index 4231fad..b7940e0 100644
--- a/refs.c
+++ b/refs.c
@@ -2819,16 +2819,16 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function must set a meaningful errno on failure */
-int log_ref_setup(const char *refname, char *logfile, int bufsize)
+int create_reflog(const char *refname)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
+	char logfile[PATH_MAX];
 
-	git_snpath(logfile, bufsize, "logs/%s", refname);
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
+	git_snpath(logfile, sizeof(logfile), "logs/%s", refname);
+	if (starts_with(refname, "refs/heads/") ||
+	    starts_with(refname, "refs/remotes/") ||
+	    starts_with(refname, "refs/notes/") ||
+	    !strcmp(refname, "HEAD")) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			int save_errno = errno;
 			error("unable to create directory for %s", logfile);
@@ -2897,16 +2897,20 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, oflags = O_APPEND | O_WRONLY;
+	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, log_file, sizeof(log_file));
+	if (log_all_ref_updates && !reflog_exists(refname))
+		result = create_reflog(refname);
+
 	if (result)
 		return result;
 
+	git_snpath(log_file, sizeof(log_file), "logs/%s", refname);
+
 	logfd = open(log_file, oflags);
 	if (logfd < 0)
 		return 0;
diff --git a/refs.h b/refs.h
index 9ad12fe..6763f69 100644
--- a/refs.h
+++ b/refs.h
@@ -196,11 +196,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/*
- * Setup reflog before using. Set errno to something meaningful on failure.
- */
-int log_ref_setup(const char *refname, char *logfile, int bufsize);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 		       unsigned char *sha1, char **msg,
@@ -209,6 +204,9 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/** Create reflog. Set errno to something meaningful on failure. */
+extern int create_reflog(const char *refname);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.0.1.508.g763ab16
