From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/16] lockfile: add accessor get_lock_file_path()
Date: Mon, 10 Aug 2015 11:47:39 +0200
Message-ID: <88c2d7f6a06d3f56731875036e6ba98e1b74011e.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjhH-0002BU-7q
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbbHJJsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:08 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47209 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754260AbbHJJsF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:05 -0400
X-AuditID: 12074414-f794f6d000007852-36-55c87351853c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 97.33.30802.15378C55; Mon, 10 Aug 2015 05:48:01 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsws021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:00 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtYfCLUYM1nbouuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGS9mPWAv
	WGlT8WPhTpYGxpsGXYycHBICJhKfb19ngrDFJC7cW88GYgsJXGaU6NzK38XIBWSfYJLY/Xsx
	M0iCTUBXYlFPM1iDiICaxMS2QywgNrNAusSJBe1gtrCAq0Tbvr9gNSwCqhIPr+xkBLF5BaIk
	9uw9DhTnAFomJ7HgQjpImFPAQmJ74wZWiL3mEo/nnWefwMi7gJFhFaNcYk5prm5uYmZOcWqy
	bnFyYl5eapGuhV5uZoleakrpJkZI8IjsYDxyUu4QowAHoxIP74zNx0OFWBPLiitzDzFKcjAp
	ifJa5J8IFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCG58BlONNSaysSi3Kh0lJc7AoifN+W6zu
	JySQnliSmp2aWpBaBJOV4eBQkuC9VwjUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqS
	EQ+Ki/hiYGSApHiA9h4BaectLkjMBYpCtJ5iVJQS590HkhAASWSU5sGNhaWEV4ziQF8K8+4B
	qeIBphO47ldAg5mABtsFgg0uSURISTUw8szf+DHp3Hn2DgH1Wv6bW9cvdz8+nffa5Uurz3Sw
	hL7s2znn3HLVo38erXd9LBAQVudncObunAP8VnLzFTe2rJ+4+OyEpTqpBlZXA2/f3L+8rudi
	6fLo8qjQu9unJsUI6bBvOSxf+Ul2jfEG+VC9pA37/WxWZwmUJ4TNXShpuKqx3z93 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275600>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 15 ++++++++-------
 config.c         | 14 +++++++-------
 lockfile.c       |  7 +++++++
 lockfile.h       |  6 ++++++
 refs.c           |  6 +++---
 shallow.c        |  6 +++---
 6 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..96aee0c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -324,6 +324,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	struct string_list partial;
 	struct pathspec pathspec;
 	int refresh_flags = REFRESH_QUIET;
+	const char *ret;
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
@@ -344,7 +345,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
-		setenv(INDEX_ENVIRONMENT, index_lock.filename.buf, 1);
+		setenv(INDEX_ENVIRONMENT, get_lock_file_path(&index_lock), 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
@@ -355,7 +356,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			unsetenv(INDEX_ENVIRONMENT);
 
 		discard_cache();
-		read_cache_from(index_lock.filename.buf);
+		read_cache_from(get_lock_file_path(&index_lock));
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
@@ -365,7 +366,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			warning(_("Failed to update main cache tree"));
 
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename.buf;
+		return get_lock_file_path(&index_lock);
 	}
 
 	/*
@@ -388,7 +389,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
-		return index_lock.filename.buf;
+		return get_lock_file_path(&index_lock);
 	}
 
 	/*
@@ -475,9 +476,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
-	read_cache_from(false_lock.filename.buf);
-
-	return false_lock.filename.buf;
+	ret = get_lock_file_path(&false_lock);
+	read_cache_from(ret);
+	return ret;
 }
 
 static int run_status(FILE *fp, const char *index_file, const char *prefix, int nowarn,
diff --git a/config.c b/config.c
index ab46462..adf8b53 100644
--- a/config.c
+++ b/config.c
@@ -2056,9 +2056,9 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
-		if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
+		if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
 			error("chmod on %s failed: %s",
-				lock->filename.buf, strerror(errno));
+			      get_lock_file_path(lock), strerror(errno));
 			ret = CONFIG_NO_WRITE;
 			goto out_free;
 		}
@@ -2138,7 +2138,7 @@ out_free:
 	return ret;
 
 write_err_out:
-	ret = write_error(lock->filename.buf);
+	ret = write_error(get_lock_file_path(lock));
 	goto out_free;
 
 }
@@ -2239,9 +2239,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 
 	fstat(fileno(config_file), &st);
 
-	if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
+	if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
 		ret = error("chmod on %s failed: %s",
-				lock->filename.buf, strerror(errno));
+			    get_lock_file_path(lock), strerror(errno));
 		goto out;
 	}
 
@@ -2262,7 +2262,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 				}
 				store.baselen = strlen(new_name);
 				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error(lock->filename.buf);
+					ret = write_error(get_lock_file_path(lock));
 					goto out;
 				}
 				/*
@@ -2288,7 +2288,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 			continue;
 		length = strlen(output);
 		if (write_in_full(out_fd, output, length) != length) {
-			ret = write_error(lock->filename.buf);
+			ret = write_error(get_lock_file_path(lock));
 			goto out;
 		}
 	}
diff --git a/lockfile.c b/lockfile.c
index df9c704..5e954ba 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -364,6 +364,13 @@ FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
 	return lk->fp;
 }
 
+const char *get_lock_file_path(struct lock_file *lk)
+{
+	if (!lk->active)
+		die("BUG: get_lock_file_path() called for unlocked object");
+	return lk->filename.buf;
+}
+
 int get_lock_file_fd(struct lock_file *lk)
 {
 	if (!lk->active)
diff --git a/lockfile.h b/lockfile.h
index d9dfbc9..a204ab6 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -203,6 +203,12 @@ extern NORETURN void unable_to_lock_die(const char *path, int err);
  */
 extern FILE *fdopen_lock_file(struct lock_file *lk, const char *mode);
 
+/*
+ * Return the path of the lockfile. The return value is a pointer to a
+ * field within the lock_file object and should not be freed.
+ */
+extern const char *get_lock_file_path(struct lock_file *lk);
+
 extern int get_lock_file_fd(struct lock_file *lk);
 extern FILE *get_lock_file_fp(struct lock_file *lk);
 
diff --git a/refs.c b/refs.c
index 0f49a62..bf68015 100644
--- a/refs.c
+++ b/refs.c
@@ -3184,7 +3184,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	    write_in_full(fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
-		error("Couldn't write %s", lock->lk->filename.buf);
+		error("Couldn't write %s", get_lock_file_path(lock->lk));
 		unlock_ref(lock);
 		errno = save_errno;
 		return -1;
@@ -4241,7 +4241,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
 		if (!cb.newlog) {
 			error("cannot fdopen %s (%s)",
-			      reflog_lock.filename.buf, strerror(errno));
+			      get_lock_file_path(&reflog_lock), strerror(errno));
 			goto failure;
 		}
 	}
@@ -4271,7 +4271,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") != 1 ||
 			    close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
-					lock->lk->filename.buf);
+					get_lock_file_path(lock->lk));
 			rollback_lock_file(&reflog_lock);
 		} else if (commit_lock_file(&reflog_lock)) {
 			status |= error("unable to commit reflog '%s' (%s)",
diff --git a/shallow.c b/shallow.c
index 257d811..7973e74 100644
--- a/shallow.c
+++ b/shallow.c
@@ -267,8 +267,8 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock->filename.buf);
-		*alternate_shallow_file = shallow_lock->filename.buf;
+				  get_lock_file_path(shallow_lock));
+		*alternate_shallow_file = get_lock_file_path(shallow_lock);
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -314,7 +314,7 @@ void prune_shallow(int show_only)
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  shallow_lock.filename.buf);
+				  get_lock_file_path(&shallow_lock));
 		commit_lock_file(&shallow_lock);
 	} else {
 		unlink(git_path("shallow"));
-- 
2.5.0
