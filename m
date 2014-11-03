From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 7/7] refs.c: add an err argument to create_symref
Date: Mon,  3 Nov 2014 11:12:32 -0800
Message-ID: <1415041952-19637-8-git-send-email-sahlberg@google.com>
References: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlN3m-0006YQ-0T
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbaKCTMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:12:49 -0500
Received: from mail-ie0-f202.google.com ([209.85.223.202]:57852 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbaKCTMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:12:36 -0500
Received: by mail-ie0-f202.google.com with SMTP id tr6so829223ieb.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eelSEO1ML9fbvi169rAjkQ/F/nvyUQQd9aDJesZgPnc=;
        b=leX0OknD/CGGrspE9llCbU9ewGpEp+KoasoQ/6+vQEWa6H08OYBSc30b2hF66hSrg4
         BctYysxEqbV4pOo0fTJEz+gggogVT+STXP7vLM3qbnQgqMmfj0mGuR1E3Seg/A6SnqRT
         93nWnl9lj+7izmJ11jQ9/MQg7VxnMfOo3K15mc0+Q3ArRBRboxVPkizJY4e35v8wqF78
         111Pmop0j9pCLJyDqBz595n43yAVE3VVm7WVsKocqyKCQdcjS6B/GtDfjJCp+TU+hafY
         gS4LYBFdYgT7PJ0fc926vLSg7940RUkKr/X155XqbZllF3rEQlcx14CZIe7UVNC7QCb1
         obvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eelSEO1ML9fbvi169rAjkQ/F/nvyUQQd9aDJesZgPnc=;
        b=ArG2CjmOx/tGKT+FPrdgR0TdzGKg+7vc6/DgDrl9hZjQ1DFqd/5mV27ei64eBr6EwN
         pFiXAk8XsNW9W36sJvtWAzoGkc2fiGul0E9ujGsOHROFhtvw+mvzGvJmKCl+HdDXrKQG
         7NVWGu1iz6gH13lphTAUqLpTuwLMQQfZrL5CuKkwxSXUeqb2HpG02NlO6XHVDj3r8R2m
         n9RdUHTn4Bcxdo3+23gIUTr0uVpBu8x2uGqdKeiKxQKlvBtJHHuJ0IBfexTZuECN04sQ
         v8wyEDRRFsBRDj6e5YPUiNoOuPmUYyqDAm4J1QUUbFzi/f/jgLFmWRZFUFGOMlZs2wGE
         Vtyw==
X-Gm-Message-State: ALoCoQmAfagtdD+8vmbCLcFuNLG6kCTi0lydpwmN60azyQZiZjGaOTj/GvkcgFfEGfXzcCv8biEc
X-Received: by 10.42.200.206 with SMTP id ex14mr34808225icb.4.1415041955755;
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si977317yhf.0.2014.11.03.11.12.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:12:35 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id SeM8fCKn.1; Mon, 03 Nov 2014 11:12:35 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 52C03E0C1B; Mon,  3 Nov 2014 11:12:34 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041952-19637-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 5577b5b..17b6ae8 100644
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
index 04ed571..e63004d 100644
--- a/refs.c
+++ b/refs.c
@@ -3109,20 +3109,22 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -3135,26 +3137,29 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 
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
@@ -3166,10 +3171,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
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
index 78af3a6..40fd294 100644
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
