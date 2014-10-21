From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 7/8] refs.c: add an err argument to create_reflog
Date: Tue, 21 Oct 2014 13:46:39 -0700
Message-ID: <1413924400-15418-8-git-send-email-sahlberg@google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:47:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggLD-0005Ti-8V
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933543AbaJUUrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:47:04 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:46718 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933497AbaJUUqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:45 -0400
Received: by mail-qc0-f202.google.com with SMTP id i17so201424qcy.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pl76G0VaKGva30myAnUvFC1oha0Qh6YTga0oLdT3xxU=;
        b=gQ2dOLQ0+mOG3nh6CJ9NSi2V244XjmvenIiA+eDFOpbictc1Zby/DK0GOrirXRGKb3
         wyoscjUeY7SIo8jMQxtfwbPaP/xICwJ8TuN0CZ0qCnWeUmDwi5v077DjynZrfZHODGss
         FGjAZg+F1VYnO1ABnmC4vrJx1x3B1QMAXrn0my0rjnvgZi+lLFRW5fPj/C0Xtzg9cCoI
         D6jABPJI1F5p8LfPVSTVyggSF/E8mk+BT6jhJIKwjhGxzjbPW0B21hKfd0UVxsw4HmgS
         Aink6kWdmxBVlw0acpCqkfgXT1O1fho6nNaoK/jBovkVs38sO4Svce8tBF7Be1OCtKtZ
         RyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pl76G0VaKGva30myAnUvFC1oha0Qh6YTga0oLdT3xxU=;
        b=FI9lotJSMNKvlBwedNpy398YYvJ9L5RM1jFVXIog8xo/FoqIPSykdq+fDPznKVODQs
         JO7fevyFQH39mLopQBwT50f5Amkp5hXiL3mBHKAgO0VXA2EmGH1AZxdrcsywIZcXgqCY
         lTJ0QTbVnQYYTmwP5Vb9zBmLr9FNl23k117GJ7IFwYkOlFPog5hrbJdKWwpHyBqcn8Af
         RMvfF0S8arZ+LreOlbKqbLjIjsIU8RFdzfDlP9vJ7Nq1JLuJpCkTN+BRm4dJg1kZ/XQ9
         EbxXW/IMp0Ef+cZmFe4j8AZdjTBzy8bW65dM1CBhGOMCQLEuJPHjhZiHDyedvIGeYKmt
         lsOA==
X-Gm-Message-State: ALoCoQkzqLDtxCInazvqoML5r104uZQQU5IzuvUB3ZObbrfmyM3+MRjY0OXk+beYwqCveeArYtoL
X-Received: by 10.236.14.9 with SMTP id c9mr24259991yhc.18.1413924404670;
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n22si597286yhd.1.2014.10.21.13.46.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id RZGtkOQC.1; Tue, 21 Oct 2014 13:46:44 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9B994E102D; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add err argument to create_reflog that can explain the reason for a
failure. This then eliminates the need to manage errno through this
function since we can just add strerror(errno) to the err string when
meaningful. No callers relied on errno from this function for anything
else than the error message.

log_ref_write is a private function that calls create_reflog. Update
this function to also take an err argument and pass it back to the caller.
This again eliminates the need to manage errno in this function.

Update the private function write_sha1_update_reflog to also take an
err argument.

Change-Id: I8f796a8c0c5f5d3f26e3e59fbc6421c894a4e814
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/checkout.c |  8 +++---
 refs.c             | 71 +++++++++++++++++++++++++++---------------------------
 refs.h             |  4 +--
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 60a68f7..d9cb9c3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -590,10 +590,12 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
+				struct strbuf err = STRBUF_INIT;
 
-				if (create_reflog(ref_name)) {
-					fprintf(stderr, _("Can not do reflog for '%s'\n"),
-					    opts->new_orphan_branch);
+				if (create_reflog(ref_name, &err)) {
+					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
+					opts->new_orphan_branch, err.buf);
+					strbuf_release(&err);
 					return;
 				}
 			}
diff --git a/refs.c b/refs.c
index a5e1eff..4d30623 100644
--- a/refs.c
+++ b/refs.c
@@ -2889,8 +2889,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-/* This function must set a meaningful errno on failure */
-int create_reflog(const char *refname)
+int create_reflog(const char *refname, struct strbuf *err)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char logfile[PATH_MAX];
@@ -2901,9 +2900,8 @@ int create_reflog(const char *refname)
 	    starts_with(refname, "refs/notes/") ||
 	    !strcmp(refname, "HEAD")) {
 		if (safe_create_leading_directories(logfile) < 0) {
-			int save_errno = errno;
-			error("unable to create directory for %s", logfile);
-			errno = save_errno;
+			strbuf_addf(err, "unable to create directory for %s. "
+				    "%s", logfile, strerror(errno));
 			return -1;
 		}
 		oflags |= O_CREAT;
@@ -2916,20 +2914,16 @@ int create_reflog(const char *refname)
 
 		if ((oflags & O_CREAT) && errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				int save_errno = errno;
-				error("There are still logs under '%s'",
-				      logfile);
-				errno = save_errno;
+				strbuf_addf(err, "There are still logs under "
+					    "'%s'", logfile);
 				return -1;
 			}
 			logfd = open(logfile, oflags, 0666);
 		}
 
 		if (logfd < 0) {
-			int save_errno = errno;
-			error("Unable to append to %s: %s", logfile,
-			      strerror(errno));
-			errno = save_errno;
+			strbuf_addf(err, "Unable to append to %s: %s",
+				    logfile, strerror(errno));
 			return -1;
 		}
 	}
@@ -2966,7 +2960,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 }
 
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+			 const unsigned char *new_sha1, const char *msg,
+			 struct strbuf *err)
 {
 	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
@@ -2975,7 +2970,7 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 		log_all_ref_updates = !is_bare_repository();
 
 	if (log_all_ref_updates && !reflog_exists(refname))
-		result = create_reflog(refname);
+		result = create_reflog(refname, err);
 
 	if (result)
 		return result;
@@ -2988,16 +2983,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		int save_errno = errno;
 		close(logfd);
-		error("Unable to append to %s", log_file);
-		errno = save_errno;
+		strbuf_addf(err, "Unable to append to %s. %s", log_file,
+			    strerror(errno));
 		return -1;
 	}
 	if (close(logfd)) {
-		int save_errno = errno;
-		error("Unable to append to %s", log_file);
-		errno = save_errno;
+		strbuf_addf(err, "Unable to append to %s. %s", log_file,
+			    strerror(errno));
 		return -1;
 	}
 	return 0;
@@ -3009,12 +3002,12 @@ int is_branch(const char *refname)
 }
 
 static int write_sha1_update_reflog(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+				    const unsigned char *sha1,
+				    const char *logmsg, struct strbuf *err)
 {
-	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
+	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg, err) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-		unlock_ref(lock);
+	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg, err) < 0)) {
 		return -1;
 	}
 	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
@@ -3036,8 +3029,11 @@ static int write_sha1_update_reflog(struct ref_lock *lock,
 		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
-		    !strcmp(head_ref, lock->ref_name))
-			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
+		    !strcmp(head_ref, lock->ref_name) &&
+		    log_ref_write("HEAD", lock->old_sha1, sha1, logmsg, err)) {
+			error("%s", err->buf);
+			strbuf_release(err);
+		}
 	}
 	return 0;
 }
@@ -3051,6 +3047,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 {
 	static char term = '\n';
 	struct object *o;
+	struct strbuf err = STRBUF_INIT;
 
 	if (!lock) {
 		errno = EINVAL;
@@ -3085,8 +3082,10 @@ static int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
-	if (write_sha1_update_reflog(lock, sha1, logmsg)) {
+	if (write_sha1_update_reflog(lock, sha1, logmsg, &err)) {
 		unlock_ref(lock);
+		error("%s", err.buf);
+		strbuf_release(&err);
 		return -1;
 	}
 	if (commit_ref(lock)) {
@@ -3106,6 +3105,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
 	unsigned char old_sha1[20], new_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (logmsg && read_ref(ref_target, old_sha1))
 		hashclr(old_sha1);
@@ -3154,9 +3154,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 #ifndef NO_SYMLINK_HEAD
 	done:
 #endif
-	if (logmsg && !read_ref(refs_heads_master, new_sha1))
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);
-
+	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
+	    log_ref_write(ref_target, old_sha1, new_sha1, logmsg, &err))
+		error("%s", err.buf);
+	
+	strbuf_release(&err);
 	free(git_HEAD);
 	return 0;
 }
@@ -3904,10 +3906,7 @@ int transaction_commit(struct transaction *transaction,
 			goto cleanup;
 		}
 		if (write_sha1_update_reflog(update->lock, update->new_sha1,
-					     update->msg)) {
-			if (err)
-				strbuf_addf(err, "Failed to update log '%s'.",
-					    update->refname);
+					     update->msg, err)) {
 			ret = -1;
 			goto cleanup;
 		}
@@ -3944,7 +3943,7 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		}
 		if (log_all_ref_updates && !reflog_exists(update->refname) &&
-		    create_reflog(update->refname)) {
+		    create_reflog(update->refname, err)) {
 			ret = -1;
 			if (err)
 				strbuf_addf(err, "Failed to setup reflog for "
diff --git a/refs.h b/refs.h
index be16c08..1851fff 100644
--- a/refs.h
+++ b/refs.h
@@ -170,8 +170,8 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
-/** Create reflog. Set errno to something meaningful on failure. */
-extern int create_reflog(const char *refname);
+/** Create reflog. Fill in err on failure. */
+extern int create_reflog(const char *refname, struct strbuf *err);
 
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
-- 
2.1.0.rc2.206.gedb03e5
