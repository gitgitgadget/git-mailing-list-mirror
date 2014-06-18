From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 12/14] refs.c: rename log_ref_setup to create_reflog
Date: Wed, 18 Jun 2014 10:09:04 -0700
Message-ID: <1403111346-18466-13-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMV-0006uT-V0
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbaFRRJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:24 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:40259 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbaFRRJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:11 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so124017pde.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hz9HlObX1xb2kf+IM+v0L0AtO5rmSLgj6bGRvYkGBV8=;
        b=mlynQP8zNAUno9LS97EDXA7TyYDdQCs1rNySPM27HtXq65Ymt2zdo026jptRE997Km
         MFTCO/l0mOoAxFP7tIhHxdtlkFpXP47Yf+PmAipOtT857wrMdOlD94c237OMgjxD+lIv
         ko87PfroY3X/S+LL1kpnDn38lLNiVZDBO4iBxy5G/HzliRy7jrMKWyeVq0bwHl+z3RQD
         +snT/AdFCk+0/xf/zdpo1TW7XGWeFZ9e/HGOPqK/3EGfcuVzjc0rxMVKLoJXT0jAdVZf
         QhUOx11O1DYmQCtg+c38Ct95+xaUvvCUMnsfvXe2AUlRRXsuZety/IOdLnc5PMZ3CqWc
         kLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hz9HlObX1xb2kf+IM+v0L0AtO5rmSLgj6bGRvYkGBV8=;
        b=G9FvqGbE6d+TKwP3eWPHGU/6/Wc8p8tFBVS/UBFXIRTs+ZnONiicoUzWnGsZdwU3Fh
         fr9fv/Vb/P5H9LLGsoHYAacDpkFV7EqnBUZBMNfE2DmZRoLGnEQunsw75/RMcaZSVWsq
         YINSHLAUYOGJOJg+/Y1tzIC6UxsAxjduv3SQU6C7XHh5ltSBnQJQtXJGwpUUjDeDZF6T
         mURLcUa2GWrGfOrqxMJehxjTBG58f+Hosdcb8mWJ1IfsKUBR/3bexZtUb2kzC6nlQn8D
         ElVR9H7MD18U9d1jVJPVZo/aZEtbqdAOVT1M/zyf+KX2zeief8WaK87EO7IgvrSKEejv
         fgEA==
X-Gm-Message-State: ALoCoQnpkbFlno8fWo+GhAABYhO0vAFb/8opE11i4nYaZDJnG6u+s7zW2yYfrluX9PwHguAt3GXf
X-Received: by 10.66.165.165 with SMTP id yz5mr1404459pab.37.1403111350268;
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j5si174157yhi.1.2014.06.18.10.09.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0BA2A5A4796;
	Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B79E8E12AA; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251992>

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
index 1288c49..9653a01 100644
--- a/refs.c
+++ b/refs.c
@@ -2822,16 +2822,16 @@ static int copy_msg(char *buf, const char *msg)
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
@@ -2900,16 +2900,20 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
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
index 0564955..e7892fc 100644
--- a/refs.h
+++ b/refs.h
@@ -203,11 +203,6 @@ extern int commit_ref(struct ref_lock *lock);
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
@@ -216,6 +211,9 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/** Create reflog. Set errno to something meaningful on failure. */
+extern int create_reflog(const char *refname);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.0.0.467.g08c0633
