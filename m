From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 8/8] refs.c: add an err argument to create_symref
Date: Tue, 21 Oct 2014 13:46:40 -0700
Message-ID: <1413924400-15418-9-git-send-email-sahlberg@google.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:47:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKl-0005CL-TH
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933533AbaJUUrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:47:03 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:60731 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbaJUUqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:45 -0400
Received: by mail-qc0-f202.google.com with SMTP id i17so202491qcy.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pF6IdhbPLKScB5U1uSFO886U8A33cV5LV8VSTwUCaRI=;
        b=m8IPuZ/jYeKxxDHu2ISwKnGEVGn84EQrFqPJ1a/WnnZ9Q+PsEhkiErscHf0M1cEAMA
         jEW6p+/MTM3f1ki3mZcbs6FX+sg1AtnUFPHEjYZutw+FR0sN2GKh6w6r3zjK3mQTkH2n
         coQ4znCTbWM/nEMRqrVRag+/PF9bQMMH5FhedhMeVoECZWiYWfPuyyliqNE7tTnYT9Y1
         9F8A4aPAtB8PpDZc+2mLdaXlO+e1MG+i35OT0VGQ2wRJ1W96Br1pClgYl+WvUNGVnAFC
         dJqLdYSmi+sLVJDGwox22L1YwRawzpXZFE90i4NCj8ThoQZokAL1E57Lu4uYfQ3sPGj9
         O1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pF6IdhbPLKScB5U1uSFO886U8A33cV5LV8VSTwUCaRI=;
        b=e2Xry+XXKMqT39ML4LRtAk3t9eWVIjY2SbLn0Nrl7yJf4oIjsJZIT7h7bPgkzL0dJu
         i+pvnBHXUOFhG91f5x1TG+3fkTU26CLn9p8ju3hSh/7S51PP/rH/E3m3CDvZt6gOd5nC
         zurpPX0DJDuq9BAu5A63VE8ByfJomRd+W6GG94N+XmneaarpfZyzaeGWGhZj5v1b0rA1
         cP7ahVGg54QxYlTPjX0uvXqtSLLK/ABcbagREMe7wT2xBg3s3xBz8SfQDFfRl9T2G5uA
         zgj9NNTlUYzq8EaTHZC+Pu9zjQY+kxEeAmyX5d0gynqqPL9VuC+Me7vhAnDgjLlQGcT7
         4qcQ==
X-Gm-Message-State: ALoCoQkA9yOyx0WKDfDksjIGVZbgpDwde7nbIuQTyTk5KXQZwSngYdo9VT1sqtuHwoyitkfNItFf
X-Received: by 10.52.99.226 with SMTP id et2mr24140013vdb.8.1413924404688;
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n63si595352yho.5.2014.10.21.13.46.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id cFUaeKdd.1; Tue, 21 Oct 2014 13:46:44 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A1CE2E1109; Tue, 21 Oct 2014 13:46:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413924400-15418-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change-Id: I812e7600fb648df429df8a2c84745de4f5875626
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/branch.c       |  7 +++++--
 builtin/checkout.c     | 13 ++++++++++---
 builtin/clone.c        | 15 +++++++++++----
 builtin/init-db.c      |  8 ++++++--
 builtin/notes.c        |  7 ++++---
 builtin/remote.c       | 26 ++++++++++++++++++--------
 builtin/symbolic-ref.c |  6 +++++-
 cache.h                |  1 -
 refs.c                 | 30 ++++++++++++++++++------------
 refs.h                 |  1 +
 10 files changed, 78 insertions(+), 36 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 04f57d4..ab6d9f4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -698,6 +698,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int recovery = 0;
 	int clobber_head_ok;
 
@@ -734,8 +735,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
 
 	/* no need to pass logmsg here as HEAD didn't really move */
-	if (!strcmp(oldname, head) && create_symref("HEAD", newref.buf, NULL))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+	if (!strcmp(oldname, head) &&
+	    create_symref("HEAD", newref.buf, NULL, &err))
+		die(_("Branch renamed to %s, but HEAD is not updated!. %s"),
+		    newname, err.buf);
 
 	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
 	strbuf_release(&oldref);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d9cb9c3..1efe353 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -634,7 +634,10 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
 	} else if (new->path) {	/* Switch branches. */
-		create_symref("HEAD", new->path, msg.buf);
+		if (create_symref("HEAD", new->path, msg.buf, &err)) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+		}
 		if (!opts->quiet) {
 			if (old->path && !strcmp(new->path, old->path)) {
 				if (opts->new_branch_force)
@@ -1020,12 +1023,16 @@ static int parse_branchname_arg(int argc, const char **argv,
 static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 {
 	int status;
-	struct strbuf branch_ref = STRBUF_INIT;
+	struct strbuf branch_ref = STRBUF_INIT, err = STRBUF_INIT;
 
 	if (!opts->new_branch)
 		die(_("You are on a branch yet to be born"));
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
-	status = create_symref("HEAD", branch_ref.buf, "checkout -b");
+	status = create_symref("HEAD", branch_ref.buf, "checkout -b", &err);
+	if (status) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+	}
 	strbuf_release(&branch_ref);
 	if (!opts->quiet)
 		fprintf(stderr, _("Switched to a new branch '%s'\n"),
diff --git a/builtin/clone.c b/builtin/clone.c
index e0a671d..1c92e84 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -565,6 +565,7 @@ static void update_remote_refs(const struct ref *refs,
 			       int check_connectivity)
 {
 	const struct ref *rm = mapped_refs;
+	struct strbuf err = STRBUF_INIT;
 
 	if (check_connectivity) {
 		if (transport->progress)
@@ -586,9 +587,12 @@ static void update_remote_refs(const struct ref *refs,
 		struct strbuf head_ref = STRBUF_INIT;
 		strbuf_addstr(&head_ref, branch_top);
 		strbuf_addstr(&head_ref, "HEAD");
-		create_symref(head_ref.buf,
-			      remote_head_points_at->peer_ref->name,
-			      msg);
+		if (create_symref(head_ref.buf,
+				  remote_head_points_at->peer_ref->name,
+				  msg, &err)) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+		}
 	}
 }
 
@@ -599,7 +603,10 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	const char *head;
 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
-		create_symref("HEAD", our->name, NULL);
+		if (create_symref("HEAD", our->name, NULL, &err)) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+		}
 		if (!option_bare) {
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, &err);
 			install_branch_config(0, head, option_origin, our->name);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 587a505..d6cdee8 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "refs.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -187,6 +188,7 @@ static int create_default_files(const char *template_path)
 	char junk[2];
 	int reinit;
 	int filemode;
+	struct strbuf err = STRBUF_INIT;
 
 	if (len > sizeof(path)-50)
 		die(_("insane git directory %s"), git_dir);
@@ -236,8 +238,10 @@ static int create_default_files(const char *template_path)
 	strcpy(path + len, "HEAD");
 	reinit = (!access(path, R_OK)
 		  || readlink(path, junk, sizeof(junk)-1) != -1);
-	if (!reinit) {
-		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
+	if (!reinit &&
+	    create_symref("HEAD", "refs/heads/master", NULL, &err)) {
+			error("%s", err.buf);
+			strbuf_release(&err);
 			exit(1);
 	}
 
diff --git a/builtin/notes.c b/builtin/notes.c
index b9fec39..f6d4696 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -821,9 +821,10 @@ static int merge(int argc, const char **argv, const char *prefix)
 			       0, &err))
 			die("%s", err.buf);
 		/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
-			die("Failed to store link to current notes ref (%s)",
-			    default_notes_ref());
+		if (create_symref("NOTES_MERGE_REF", default_notes_ref(),
+				  NULL, &err))
+			die("Failed to store link to current notes ref (%s). "
+			    "%s", default_notes_ref(), err.buf);
 		printf("Automatic notes merge failed. Fix conflicts in %s and "
 		       "commit the result with 'git notes merge --commit', or "
 		       "abort the merge with 'git notes merge --abort'.\n",
diff --git a/builtin/remote.c b/builtin/remote.c
index 42702d7..d9632df 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -147,6 +147,7 @@ static int add(int argc, const char **argv)
 	const char *master = NULL;
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	const char *name, *url;
 	int i;
 
@@ -230,8 +231,12 @@ static int add(int argc, const char **argv)
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
 
-		if (create_symref(buf.buf, buf2.buf, "remote add"))
-			return error(_("Could not setup master '%s'"), master);
+		if (create_symref(buf.buf, buf2.buf, "remote add", &err)) {
+			error(_("Could not setup master '%s'. %s"),
+			      master, err.buf);
+			strbuf_release(&err);
+			return -1;
+		}
 	}
 
 	strbuf_release(&buf);
@@ -617,8 +622,8 @@ static int mv(int argc, const char **argv)
 		OPT_END()
 	};
 	struct remote *oldremote, *newremote;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
-		old_remote_context = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
+	struct strbuf old_remote_context = STRBUF_INIT, err = STRBUF_INIT;
 	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
 	struct rename_info rename;
 	int i, refspec_updated = 0;
@@ -742,8 +747,8 @@ static int mv(int argc, const char **argv)
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
-		if (create_symref(buf.buf, buf2.buf, buf3.buf))
-			die(_("creating '%s' failed"), buf.buf);
+		if (create_symref(buf.buf, buf2.buf, buf3.buf, &err))
+			die(_("creating '%s' failed. %s"), buf.buf, err.buf);
 	}
 	return 0;
 }
@@ -1260,6 +1265,7 @@ static int set_head(int argc, const char **argv)
 {
 	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	char *head_name = NULL;
 
 	struct option options[] = {
@@ -1302,8 +1308,12 @@ static int set_head(int argc, const char **argv)
 		/* make sure it's valid */
 		if (!ref_exists(buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
-			result |= error(_("Could not setup %s"), buf.buf);
+		else if (create_symref(buf.buf, buf2.buf, "remote set-head",
+				       &err)) {
+			error(_("Could not setup %s. %s"), buf.buf, err.buf);
+			strbuf_release(&err);
+			result = -1;
+		}
 		if (opt_a)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 29fb3f1..f9ca959 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -35,6 +35,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 {
 	int quiet = 0, delete = 0, shorten = 0, ret = 0;
 	const char *msg = NULL;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet,
 			N_("suppress error message for non-symbolic (detached) refs")),
@@ -67,7 +68,10 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "HEAD") &&
 		    !starts_with(argv[1], "refs/"))
 			die("Refusing to point HEAD outside of refs/");
-		create_symref(argv[0], argv[1], msg);
+		if (create_symref(argv[0], argv[1], msg, &err)) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+		}
 		break;
 	default:
 		usage_with_options(git_symbolic_ref_usage, options);
diff --git a/cache.h b/cache.h
index 61e61af..3443da7 100644
--- a/cache.h
+++ b/cache.h
@@ -1026,7 +1026,6 @@ extern int get_sha1_mb(const char *str, unsigned char *sha1);
  */
 extern int refname_match(const char *abbrev_name, const char *full_name);
 
-extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
 
 extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
diff --git a/refs.c b/refs.c
index 4d30623..5400868 100644
--- a/refs.c
+++ b/refs.c
@@ -3098,20 +3098,22 @@ static int write_ref_sha1(struct ref_lock *lock,
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
+		  const char *logmsg, struct strbuf *err)
 {
 	const char *lockpath;
 	char ref[1000];
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
 	unsigned char old_sha1[20], new_sha1[20];
-	struct strbuf err = STRBUF_INIT;
 
 	if (logmsg && read_ref(ref_target, old_sha1))
 		hashclr(old_sha1);
 
-	if (safe_create_leading_directories(git_HEAD) < 0)
-		return error("unable to create directory for %s", git_HEAD);
+	if (safe_create_leading_directories(git_HEAD) < 0) {
+		strbuf_addf(err, "unable to create directory for %s.",
+			    git_HEAD);
+		return -1;
+	}
 
 #ifndef NO_SYMLINK_HEAD
 	if (prefer_symlink_refs) {
@@ -3124,26 +3126,29 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 
 	len = snprintf(ref, sizeof(ref), "ref: %s\n", refs_heads_master);
 	if (sizeof(ref) <= len) {
-		error("refname too long: %s", refs_heads_master);
+		strbuf_addf(err, "refname too long: %s", refs_heads_master);
 		goto error_free_return;
 	}
 	lockpath = mkpath("%s.lock", git_HEAD);
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0) {
-		error("Unable to open %s for writing", lockpath);
+		strbuf_addf(err, "Unable to open %s for writing. %s", lockpath,
+			    strerror(errno));
 		goto error_free_return;
 	}
 	written = write_in_full(fd, ref, len);
 	if (close(fd) != 0 || written != len) {
-		error("Unable to write to %s", lockpath);
+		strbuf_addf(err, "Unable to write to %s. %s", lockpath,
+			    strerror(errno));
 		goto error_unlink_return;
 	}
 	if (rename(lockpath, git_HEAD) < 0) {
-		error("Unable to create %s", git_HEAD);
+		strbuf_addf(err, "Unable to create %s. %s", git_HEAD,
+			    strerror(errno));
 		goto error_unlink_return;
 	}
 	if (adjust_shared_perm(git_HEAD)) {
-		error("Unable to fix permissions on %s", lockpath);
+		strbuf_addf(err, "Unable to fix permissions on %s", lockpath);
 	error_unlink_return:
 		unlink_or_warn(lockpath);
 	error_free_return:
@@ -3155,10 +3160,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	done:
 #endif
 	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
-	    log_ref_write(ref_target, old_sha1, new_sha1, logmsg, &err))
-		error("%s", err.buf);
+	    log_ref_write(ref_target, old_sha1, new_sha1, logmsg, err)) {
+		error("%s", err->buf);
+		strbuf_release(err);
+	}
 	
-	strbuf_release(&err);
 	free(git_HEAD);
 	return 0;
 }
diff --git a/refs.h b/refs.h
index 1851fff..8148ab6 100644
--- a/refs.h
+++ b/refs.h
@@ -116,6 +116,7 @@ static inline const char *has_glob_specials(const char *pattern)
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
 
+extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg, struct strbuf *err);
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
-- 
2.1.0.rc2.206.gedb03e5
