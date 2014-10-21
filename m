From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 12/15] refs.c: rename log_ref_setup to create_reflog
Date: Tue, 21 Oct 2014 12:24:19 -0700
Message-ID: <1413919462-3458-13-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:24:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf39-0000PF-E8
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbaJUTYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:47 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:55688 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742AbaJUTYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:36 -0400
Received: by mail-pa0-f73.google.com with SMTP id et14so338677pad.4
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OvRlNC+F904g8X+eWMZROignziVHRRwaD69aWE+KYlI=;
        b=jiDr4+UW3z33VMK8x2NCv9nbAuxoSCmb8K3ktU4KJMNr1SQ1/aYsAIbZDUT+QzGYNy
         ipmj0XIkcFrBhj7WaDSTZlPvE1g0aaZTQKaVM7w4VClbRjGqPrHJ9AY8fUlkOOazj+oK
         0PymxGg2zCL5IYaouIG1kzIdg2qSClMGbQIz6Tvh9QnTMxnczTrsLYu2MBrYmSe+woKE
         iPjl+gApy540Vi6SnH/Gdf3/S8a6RBrAtNxXAekn70mHM7nuv89K4z8DvFPkrh8KDzFC
         IoipF+dUb6zPEUiGjjgXqyORB+GIMTVRQtD1R4bhrno7EJHC7QTWPqB0UD3ol/jBRY17
         AGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OvRlNC+F904g8X+eWMZROignziVHRRwaD69aWE+KYlI=;
        b=eZKbcbquGxqpJQ5Ie5MF3Rcl+rFbEDhHc21iB85ZLAbZij6zBQfYRGUcblGW+OUsLv
         hL5pZbohuDg+NKSZ8TTOq8U38KcUiRNZHqJpGPQs8m0FOe7OyW6RK9FvL6uzXP4wc32q
         IYTxwoQCEg5muFULzGXme23Zbq6DRFCyuogITzSwEE+WaYkKd9y+mFN1HZW3huzYnq6V
         kZvpdZCi7BNCmTwx4nYkTSFZ3CpV4WbdXi5SCpRcCPJEZclUX3onsN/OWlgEIk1KPZgn
         eW+6RGPU166qFjLc0Wnzss61xhFZ5v6z0/h4ql5lXC1R3VqGx+IFnniqYhDaagtZDkFK
         izyQ==
X-Gm-Message-State: ALoCoQnki0ujxnXFsEpTH97ne1Tj/WX89wBllYlhzYItHU8fG+Fu4ZJJc1/Y0IJ5WA0Is6PMmFqG
X-Received: by 10.68.180.101 with SMTP id dn5mr23514479pbc.5.1413919476100;
        Tue, 21 Oct 2014 12:24:36 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n63si583534yho.5.2014.10.21.12.24.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id ABxSNHy7.2; Tue, 21 Oct 2014 12:24:35 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C9E62E0BD6; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 8f78d5d7a1e62f04c75524bb3e87aaad24372250 upstream.

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

Change-Id: Ib9493b3b81a97a0e154cc44303a5ed7cdceaaca7
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |  8 +-------
 refs.c             | 22 +++++++++++++---------
 refs.h             |  8 +++-----
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5410dac..8550b6d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -587,19 +587,13 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
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
index 3189f11..952cc66 100644
--- a/refs.c
+++ b/refs.c
@@ -2947,16 +2947,16 @@ static int copy_msg(char *buf, const char *msg)
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
@@ -3025,16 +3025,20 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
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
index 9f70b89..17e3a3c 100644
--- a/refs.h
+++ b/refs.h
@@ -207,11 +207,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/*
- * Setup reflog before using. Set errno to something meaningful on failure.
- */
-int log_ref_setup(const char *refname, char *logfile, int bufsize);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
 		       unsigned long at_time, int cnt,
@@ -221,6 +216,9 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/** Create reflog. Set errno to something meaningful on failure. */
+extern int create_reflog(const char *refname);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.1.0.rc2.206.gedb03e5
