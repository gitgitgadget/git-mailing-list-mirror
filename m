From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 6/7] refs.c: add an err argument to create_reflog
Date: Fri,  7 Nov 2014 11:42:00 -0800
Message-ID: <1415389321-10386-7-git-send-email-sahlberg@google.com>
References: <1415389321-10386-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:42:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpQO-00074p-1V
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbaKGTmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:42:16 -0500
Received: from mail-qc0-f201.google.com ([209.85.216.201]:56885 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbaKGTmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:42:06 -0500
Received: by mail-qc0-f201.google.com with SMTP id l6so278153qcy.4
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AyTS4abEoaZGomGFgTOLgdPlmv9CRG7EOSdQCp2EMto=;
        b=TdHxg3bAd47yy9rpuTplp44PsbKjAc5WnS9018Y+KFfRHjIvFFVm3d2WCB0/kCKOch
         Yz4rx/rP8LUZNcILFaEc1fGCBBNf3TvOFtLmSZ1MhC9HFwsRqw65GPHeMydOJjHqfDxR
         5l9AcbuO/mQbc0icVIzmU49Byrokf3iQpaia0XmvVDM7O0LqVdzlaA5OrcXvljyBtdc5
         XRxxKbEKk8UfFfXzX+UO9b0Hdv20Nj7ZscBxX94mL//BlQIjxAyItd7jCHCvqk7F18Qq
         DdSuYsiy5bnWca8bpec0iewQyU4Miq//QG0JF1xE0Lz0CjEv3Kh9Cx3BTAmc9wHgGojl
         Bl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AyTS4abEoaZGomGFgTOLgdPlmv9CRG7EOSdQCp2EMto=;
        b=G2EpRoH6Jq2AZFxas+NxnQe3WxoW4y2MXJXiyjy+fGWam13hIvzqa8D383u2UNYXet
         A9wWUMUz/hGAxDL8TCU9Gy536GW1qX1VoYJYofdcv07BxSmth9Ud+kOBBghMsqBBK3dI
         7rYE9BEZXU5SuF0fGxY2W/RHTJjqDdDptO2dReZeWAL9E7TCCX9rQf21cFN0TAGmOhbK
         yvjVqvIY/SV3QqLlb8tcSn7k1lXhyrsfjlQwoyH0XEPkJPTBys94N2RnLAdqX64CzOg6
         vJE6i9Sbz7/Emsas0/Xj5cWjuSJZr1d1hwnSbe28xnojewbuF0rtZBQBhwYV6hkL7xan
         wn1Q==
X-Gm-Message-State: ALoCoQnvAwrzmo3KQx3v+32R0kxMT8NThHWdV3YRUbMaMEPiwuFOmYd5UtygWItD9oQha704ESc2
X-Received: by 10.236.17.233 with SMTP id j69mr10219684yhj.47.1415389324543;
        Fri, 07 Nov 2014 11:42:04 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si404245yhe.3.2014.11.07.11.42.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:42:04 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 7MLofAyS.1; Fri, 07 Nov 2014 11:42:04 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B53D7E033D; Fri,  7 Nov 2014 11:42:03 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389321-10386-1-git-send-email-sahlberg@google.com>
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
index cafb4aa..fc9ace2 100644
--- a/refs.c
+++ b/refs.c
@@ -2895,8 +2895,7 @@ static int copy_msg(char *buf, const char *msg)
 	return cp - buf;
 }
 
-/* This function must set a meaningful errno on failure */
-int create_reflog(const char *refname)
+int create_reflog(const char *refname, struct strbuf *err)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char logfile[PATH_MAX];
@@ -2907,9 +2906,8 @@ int create_reflog(const char *refname)
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
@@ -2922,20 +2920,16 @@ int create_reflog(const char *refname)
 
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
@@ -2972,7 +2966,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 }
 
 static int log_ref_write(const char *refname, const unsigned char *old_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+			 const unsigned char *new_sha1, const char *msg,
+			 struct strbuf *err)
 {
 	int logfd, result = 0, oflags = O_APPEND | O_WRONLY;
 	char log_file[PATH_MAX];
@@ -2981,7 +2976,7 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 		log_all_ref_updates = !is_bare_repository();
 
 	if (log_all_ref_updates && !reflog_exists(refname))
-		result = create_reflog(refname);
+		result = create_reflog(refname, err);
 
 	if (result)
 		return result;
@@ -2994,16 +2989,14 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
@@ -3015,12 +3008,12 @@ int is_branch(const char *refname)
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
@@ -3042,8 +3035,11 @@ static int write_sha1_update_reflog(struct ref_lock *lock,
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
@@ -3057,6 +3053,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 {
 	static char term = '\n';
 	struct object *o;
+	struct strbuf err = STRBUF_INIT;
 
 	if (!lock) {
 		errno = EINVAL;
@@ -3091,8 +3088,10 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -3112,6 +3111,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
 	unsigned char old_sha1[20], new_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (logmsg && read_ref(ref_target, old_sha1))
 		hashclr(old_sha1);
@@ -3160,9 +3160,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
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
@@ -3936,10 +3938,7 @@ int transaction_commit(struct transaction *transaction,
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
@@ -3976,7 +3975,7 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		}
 		if (log_all_ref_updates && !reflog_exists(update->refname) &&
-		    create_reflog(update->refname)) {
+		    create_reflog(update->refname, err)) {
 			ret = -1;
 			if (err)
 				strbuf_addf(err, "Failed to setup reflog for "
diff --git a/refs.h b/refs.h
index 489aa9d..930821e 100644
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
