From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 6/7] refs.c: add an err argument to create_reflog
Date: Mon,  3 Nov 2014 11:12:31 -0800
Message-ID: <1415041952-19637-7-git-send-email-sahlberg@google.com>
References: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:13:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlN41-0006hD-L1
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbaKCTMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:12:52 -0500
Received: from mail-ob0-f201.google.com ([209.85.214.201]:64384 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbaKCTMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:12:35 -0500
Received: by mail-ob0-f201.google.com with SMTP id nt9so1729496obb.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yWc2vL3P5jWy6QGxHnhIJB4uRxaD9cZULQGycW9jVss=;
        b=Cqt/M6c3Co1FIO/aBlztrohbum0KB8zFicf9jdVG2ZOp2a9qT6Pfta61JEPDdWeC9I
         tbXNPzzL8ibsZModGTRmRPdij3eCV8VGXcCM4HYqsg1r4qnsX/fdTzqvXIjMWi/pe4WY
         AO60Y44tDFVtV3QIbVEJ/yq5Lf5VgWvXyLg8MeO8s8v11hULmORGMo5sQC06zmfXwHUx
         gwI9p5r2uwByeNkP54M3/bPk72j3nGASiEUtHV5Sp7kNevNZNQaU0aQeIr+uss724qd/
         zuYVkrV8K/VoqJe5EV9hyc2dorsluw+NNIGuV1Z9Je+bUEz263fRmlnvxKp86FbQ8gvl
         LwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yWc2vL3P5jWy6QGxHnhIJB4uRxaD9cZULQGycW9jVss=;
        b=IjpHacotqwn2s87IJV5x6cz5br0xIr9xlsIdjmxCkupTpt/t+WgVR/ro41usVCF6TV
         uv2s0hQEX8zzfKUt4qxvE81ahji13A8rmy0Jkg5z53uzqEDf4UgU7YV/OF//nB+hN3RK
         bWRBHP+2t22ctt4NPniBXu6oDpbhnJ8v4ttJWOZzIRnN24ClzGqmHzRAVaBqL0RTug+4
         NKss3O7fzheJg7hgCzRZFk8+zyagfSSmyC2jNbGSIXqhDOa3CK2CYG68AluWbbQTIaOr
         j0H48W7iQ4Z+xm5TPZh73t2nzLdF+75zV/0pnPdFVds8MEeQFiDikl9IyUH5oAsplI1O
         yyUA==
X-Gm-Message-State: ALoCoQk6mHN4WHEeVpFzgGYCUWgl9Xh24CLrTpTLp2/5w+eWs75c/KGCDK7cVF0tQRrnp2jLLwIA
X-Received: by 10.182.130.133 with SMTP id oe5mr32237741obb.37.1415041955094;
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 30si495877yhw.1.2014.11.03.11.12.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id kY2VNFcY.1; Mon, 03 Nov 2014 11:12:34 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3159CE0FC4; Mon,  3 Nov 2014 11:12:34 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041952-19637-1-git-send-email-sahlberg@google.com>
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
index c98d594..04ed571 100644
--- a/refs.c
+++ b/refs.c
@@ -2900,8 +2900,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-/* This function must set a meaningful errno on failure */
-int create_reflog(const char *refname)
+int create_reflog(const char *refname, struct strbuf *err)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char logfile[PATH_MAX];
@@ -2912,9 +2911,8 @@ int create_reflog(const char *refname)
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
@@ -2927,20 +2925,16 @@ int create_reflog(const char *refname)
 
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
@@ -2977,7 +2971,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 }
 
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+			 const unsigned char *new_sha1, const char *msg,
+			 struct strbuf *err)
 {
 	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
@@ -2986,7 +2981,7 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 		log_all_ref_updates = !is_bare_repository();
 
 	if (log_all_ref_updates && !reflog_exists(refname))
-		result = create_reflog(refname);
+		result = create_reflog(refname, err);
 
 	if (result)
 		return result;
@@ -2999,16 +2994,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
@@ -3020,12 +3013,12 @@ int is_branch(const char *refname)
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
@@ -3047,8 +3040,11 @@ static int write_sha1_update_reflog(struct ref_lock *lock,
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
@@ -3062,6 +3058,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 {
 	static char term = '\n';
 	struct object *o;
+	struct strbuf err = STRBUF_INIT;
 
 	if (!lock) {
 		errno = EINVAL;
@@ -3096,8 +3093,10 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -3117,6 +3116,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
 	unsigned char old_sha1[20], new_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (logmsg && read_ref(ref_target, old_sha1))
 		hashclr(old_sha1);
@@ -3165,9 +3165,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
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
@@ -3938,10 +3940,7 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3978,7 +3977,7 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		}
 		if (log_all_ref_updates && !reflog_exists(update->refname) &&
-		    create_reflog(update->refname)) {
+		    create_reflog(update->refname, err)) {
 			ret = -1;
 			if (err)
 				strbuf_addf(err, "Failed to setup reflog for "
diff --git a/refs.h b/refs.h
index 7c2f6c0..78af3a6 100644
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
