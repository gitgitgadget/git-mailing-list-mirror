From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 7/7] refs.c: add an err argument to create_symref
Date: Mon, 17 Nov 2014 18:00:40 -0800
Message-ID: <1416276040-5303-8-git-send-email-sbeller@google.com>
References: <1416276040-5303-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 03:01:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqY6N-0000v6-68
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbaKRCA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:00:59 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37606 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbaKRCAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:00:52 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so236269igb.4
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U18t+8lpVbEAd7qmPeIrjB1P7bpj8ET3Uzq95FjdqZs=;
        b=TeWxwRpFrUZy5OuLJQ/pOP2cl7gF4GHjXEedZ5gjg1Yfnc6FhPOu5MZVM4vcTiPYW3
         ZmI1X/Z5bNlbev7LOcQNvxtPSxUb9bRY9OWtg4WICSZOv3NWwSuCJKEboAsbOpQmCMfr
         6ox6Y24a8qJTJCDLNwN0CQgIV95zs6Vs/a3+gHNJRsqcVSBLkrcrqsEhXoS5wNGIN3rC
         Y19WNyDnTGyVViY+sSQhKR7tbRUloUMzaQ9p6gvYSGVBUTiwlAdVhaLUC4J9hUgVaNfL
         vwOwi4ClrbGpBFXQhndud5zRxEIpBai+KcxmrPSb8xzOj4jt/h9ZGF1VgMwD8pUjOWB4
         AJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U18t+8lpVbEAd7qmPeIrjB1P7bpj8ET3Uzq95FjdqZs=;
        b=imn5rvHkU0x+wsykv3viXMHpeM8FPVNWwmA9t5KdJ44UKuYyRte20L/R2+j0Z9EEMs
         aJZ7bu68/rm/85deAXjPMtJPnhxpEK8GUGNoUueWU0MNYB0WRThZ16aKRSLDLAgfdYPO
         4Zn8bw5grzIovUPd3b3Vjv/lVd864B8Q4oeX557gnrGls4/b8GgnFBO20UceUK0+VMtj
         c9dB76hiq/6sOjPSpWODWDvrYnTU7xJwRHnpplkeSmLQ3SItSBNH9OLhN7S/oPnLPiuM
         styPpuFp0hgFd6vhsYpm9vpdotZLKWJJzdk0NcLpWHMbHmsNMx++/cmL8kbk4iPYlGXK
         SbTQ==
X-Gm-Message-State: ALoCoQmSm4slDYaExg9X10LXgbaP2xGph7qdWlNBvwSeZXk9fmaoHtvyciyCxQpowK7BIUKkIr+7
X-Received: by 10.107.131.102 with SMTP id f99mr13279102iod.31.1416276052094;
        Mon, 17 Nov 2014 18:00:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id a138sm7066146ioe.32.2014.11.17.18.00.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:00:51 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416276040-5303-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
index 49a72ac..465818a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -562,6 +562,7 @@ static void update_remote_refs(const struct ref *refs,
 			       int check_connectivity)
 {
 	const struct ref *rm = mapped_refs;
+	struct strbuf err = STRBUF_INIT;
 
 	if (check_connectivity) {
 		if (transport->progress)
@@ -583,9 +584,12 @@ static void update_remote_refs(const struct ref *refs,
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
 
@@ -596,7 +600,10 @@ static void update_head(const struct ref *our, const struct ref *remote,
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
index d2f7cea..da7f12b 100644
--- a/refs.c
+++ b/refs.c
@@ -3104,20 +3104,22 @@ static int write_ref_sha1(struct ref_lock *lock,
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
@@ -3130,26 +3132,29 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 
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
@@ -3161,10 +3166,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
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
index 930821e..6c99a57 100644
--- a/refs.h
+++ b/refs.h
@@ -116,6 +116,7 @@ static inline const char *has_glob_specials(const char *pattern)
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
 
+extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg, struct strbuf *err);
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
-- 
2.2.0.rc2.5.gf7b9fb2
