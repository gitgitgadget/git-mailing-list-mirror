From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 12/14] refs.c: rename log_ref_setup to create_reflog
Date: Mon, 16 Jun 2014 09:51:43 -0700
Message-ID: <1402937505-6091-13-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa98-00035X-EA
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbaFPQwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:05 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:41669 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbaFPQvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:52 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so853045veb.0
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9Uyc4S1oF0sbg/w8qPhgzygVK3+XSOixpqYoqIfv+g=;
        b=UlSNqaqkIkS2kV8p7v2cmUwcQadElAMYz69p+wg+Xth4EvbYvGE5pkQNqs0gk9RYpp
         Iu5O1yB6aj6P6bP3y6/MTBlQXhb94q9Tpn2KEn2SXhrl4ET+p/Mze4A8VYR90pn8aBJy
         r4ko3EkY2CiIraVEC3r3tzzMO3M+AtAInWMo1/a7AdndTw2uMZ1japW5J2B1+847kKLM
         1AEzvth/nzqgaVNYHkyT6f8EtfSRB6MyjC8mK4YwtMvtRjmI+XjpyjKPsVgq2A8jZ396
         Vvjv0c+cNx4YX/oDwaEBPFb0SomKsJhQHp1tylqX3peu6v/mHNrXdl5zbxxKOJKrDPKK
         i4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9Uyc4S1oF0sbg/w8qPhgzygVK3+XSOixpqYoqIfv+g=;
        b=Nbd5VI2s6aVZt2zYO2xZEKbZuiRMM8c2QPzwhtLTYF1t+LiSyD7rDU7tzN9GGMTMqP
         1h0BBL/zhaESNkiWaNbATWP++HAQrokckczsyn14A7hYJByEPLZYivWgvA4hhdQ7xMUF
         QFcuji5nzYIGIoQ5dHN7MXhO6LzPv2z5J7DDUjq8Ni0V/t3PkBzSyJxjtJRjgRQOX68i
         3XoI74OZH4erNK50T/Ge8hfYJQmEw1xN5QtoGT2Pp0PPppMK0YuqHAjD47QJP2Wb4Yi9
         NE03j2Y0A7WMkfWgFsfDTpF+vKg2RyG1Yctooj1r2+M80bPN5B3NZ6VyKrRmOfuDlbai
         gpjQ==
X-Gm-Message-State: ALoCoQlwtO8jaoJHWxaDXmc7zjVukq1Gj0FMTR88cwqqtvR0cb094iDkWX2IBGJI69eOfYBuDqWO
X-Received: by 10.224.64.198 with SMTP id f6mr3776331qai.3.1402937510074;
        Mon, 16 Jun 2014 09:51:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si984635yhm.0.2014.06.16.09.51.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:50 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C81A531C683;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 64D93E0AF7; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251726>

log_ref_setup is used to do several semi-related things :
* sometimes it will create a new reflog including missing parent directories
  and cleaning up any conflicting stale directories in the path.
* fill in a filename buffer for the full path to the reflog.
* unconditionally re-adjust the permissions for the file.

This function is only called from two places: checkout.c where it is always
used to create a reflog and from refs.c:log_ref_write where it sometimes is
used to create a reflog and sometimes just used to fill in the filename.

Rename log_ref_setup to create_reflog and change it to only take the
refname as argument to make its signature similar to delete_reflog and
reflog_exists. Change create_reflog to ignore log_all_ref_updates and
"unconditionally" create the reflog when called. Since checkout.c always
wants to create a reflog we can call create_reflog directly and avoid the
temp-and-log_all_ref_update dance.

In log_ref_write, only call create_reflog iff we want to create a reflog
and if the reflog does not yet exist. This means that for the common case
where we want to create a reflog which already exists we now only need to
perform a single lstat() to see that the log already exists instead of
performing, for every single update, open(O_CREAT)+lstat()+close().

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c |  8 +-----
 refs.c             | 78 ++++++++++++++++++++++++++++++------------------------
 refs.h             |  8 +++---
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9cbe7d1..c37c4dc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -597,17 +597,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
-				int temp;
-				struct strbuf log_file = STRBUF_INIT;
 				int ret;
 				const char *ref_name;
 
 				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
-				temp = log_all_ref_updates;
-				log_all_ref_updates = 1;
-				ret = log_ref_setup(ref_name, &log_file);
-				log_all_ref_updates = temp;
-				strbuf_release(&log_file);
+				ret = create_reflog(ref_name);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s'\n"),
 					    opts->new_orphan_branch);
diff --git a/refs.c b/refs.c
index 4069da1..f579d63 100644
--- a/refs.c
+++ b/refs.c
@@ -2839,54 +2839,60 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function must set a meaningful errno on failure */
-int log_ref_setup(const char *refname, struct strbuf *logfile)
+int create_reflog(const char *refname)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
-
-	strbuf_git_path(logfile, "logs/%s", refname);
-	if (log_all_ref_updates &&
-	    (starts_with(refname, "refs/heads/") ||
-	     starts_with(refname, "refs/remotes/") ||
-	     starts_with(refname, "refs/notes/") ||
-	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile->buf) < 0) {
-			int save_errno = errno;
+	struct strbuf logfile = STRBUF_INIT;
+	int save_errno, ret = 0;
+
+	strbuf_git_path(&logfile, "logs/%s", refname);
+	if (starts_with(refname, "refs/heads/") ||
+	    starts_with(refname, "refs/remotes/") ||
+	    starts_with(refname, "refs/notes/") ||
+	    !strcmp(refname, "HEAD")) {
+		if (safe_create_leading_directories(logfile.buf) < 0) {
+			save_errno = errno;
 			error("unable to create directory for %s",
-			      logfile->buf);
-			errno = save_errno;
-			return -1;
+			      logfile.buf);
+			ret = -1;
+			goto cleanup;
 		}
 		oflags |= O_CREAT;
 	}
 
-	logfd = open(logfile->buf, oflags, 0666);
+	logfd = open(logfile.buf, oflags, 0666);
 	if (logfd < 0) {
-		if (!(oflags & O_CREAT) && errno == ENOENT)
-			return 0;
+		if (!(oflags & O_CREAT) && errno == ENOENT) {
+       			goto cleanup;
+		}
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
-			if (remove_empty_directories(logfile->buf)) {
-				int save_errno = errno;
+			if (remove_empty_directories(logfile.buf)) {
+				save_errno = errno;
 				error("There are still logs under '%s'",
-				      logfile->buf);
-				errno = save_errno;
-				return -1;
+				      logfile.buf);
+				ret = -1;
+				goto cleanup;
  			}
-			logfd = open(logfile->buf, oflags, 0666);
+			logfd = open(logfile.buf, oflags, 0666);
 		}
 
 		if (logfd < 0) {
-			int save_errno = errno;
+			save_errno = errno;
 			error("Unable to append to %s: %s",
-			      logfile->buf, strerror(errno));
-			errno = save_errno;
-			return -1;
+			      logfile.buf, strerror(errno));
+			ret = -1;
+			goto cleanup;
 		}
 	}
 
-	adjust_shared_perm(logfile->buf);
+	adjust_shared_perm(logfile.buf);
 	close(logfd);
-	return 0;
+ cleanup:
+	strbuf_release(&logfile);
+	if (ret)
+		errno = save_errno;
+	return ret;
 }
 
 static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
@@ -2918,19 +2924,21 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
-	int logfd, result, oflags = O_APPEND | O_WRONLY;
+	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
 	struct strbuf sb_log_file = STRBUF_INIT;
-	const char *log_file;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, &sb_log_file);
+	if (log_all_ref_updates && !reflog_exists(refname))
+		result = create_reflog(refname);
+
 	if (result)
 		goto done;
-	log_file = sb_log_file.buf;
 
-	logfd = open(log_file, oflags);
+	strbuf_git_path(&sb_log_file, "logs/%s", refname);
+
+	logfd = open(sb_log_file.buf, oflags);
 	if (logfd < 0)
 		goto done;
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
@@ -2938,12 +2946,12 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	if (result) {
 		int save_errno = errno;
 		close(logfd);
-		error("Unable to append to %s", log_file);
+		error("Unable to append to %s", sb_log_file.buf);
 		errno = save_errno;
 		result = -1;
 	} else if (close(logfd)) {
 		int save_errno = errno;
-		error("Unable to append to %s", log_file);
+		error("Unable to append to %s", sb_log_file.buf);
 		errno = save_errno;
 		result = -1;
 	}
diff --git a/refs.h b/refs.h
index e321721..c19ca82 100644
--- a/refs.h
+++ b/refs.h
@@ -202,11 +202,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/*
- * Setup reflog before using. Set errno to something meaningful on failure.
- */
-int log_ref_setup(const char *refname, struct strbuf *logfile);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 		       unsigned char *sha1, char **msg,
@@ -215,6 +210,9 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/** Create reflog. Set errno to something meaningful on failure. */
+extern int create_reflog(const char *refname);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.0.0.770.gd892650.dirty
