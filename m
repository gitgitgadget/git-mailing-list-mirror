From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 15/15] config: rename git_config_set_or_die to git_config_set
Date: Tue, 16 Feb 2016 13:56:42 +0100
Message-ID: <1455627402-752-16-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 13:57:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfC2-0001v0-O8
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbcBPM5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:57:15 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45744 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932213AbcBPM5K (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:57:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 62F0820AC9
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:57:10 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 16 Feb 2016 07:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=hsmL
	3/fDVerWPcZBqcgKz4o6v3g=; b=Lef5d91auACwHWRJ5v5yghdYqyVopfomNKn1
	GLElZXKIrNGGZUn68658guwXdhYi7lWzFtRVOCyreVQesNWNfYcUkRLFauL89MzN
	AaNcasmk6LJbK1UwFRVufxQJXPyUxtRcQgxjYUZ3tCwgs/dCPdy050SLLkO/KMxb
	Rl5kr9o=
X-Sasl-enc: IomcF6YbqdB7+shryT5FRDkbwF8doywiblT2m58rpifc 1455627429
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id E7486680159;
	Tue, 16 Feb 2016 07:57:09 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286346>

Rename git_config_set_or_die functions to git_config_set, leading
to the new default behavior of dying whenever a configuration
error occurs.

By now all callers that shall die on error have been transitioned
to the _or_die variants, thus making this patch a simple rename
of the functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c            |  6 +++---
 builtin/clone.c             |  8 ++++----
 builtin/init-db.c           | 20 ++++++++++----------
 builtin/remote.c            | 32 ++++++++++++++++----------------
 builtin/submodule--helper.c |  4 ++--
 cache.h                     |  8 ++++----
 config.c                    | 24 ++++++++++++------------
 sequencer.c                 | 22 +++++++++++-----------
 submodule.c                 |  6 +++---
 9 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c043cfc..7b45b6b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -594,7 +594,7 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_stripspace(&buf, 1);
 
 	strbuf_addf(&name, "branch.%s.description", branch_name);
-	git_config_set_or_die(name.buf, buf.len ? buf.buf : NULL);
+	git_config_set(name.buf, buf.len ? buf.buf : NULL);
 	strbuf_release(&name);
 	strbuf_release(&buf);
 
@@ -790,10 +790,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
-		git_config_set_multivar_or_die(buf.buf, NULL, NULL, 1);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
-		git_config_set_multivar_or_die(buf.buf, NULL, NULL, 1);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
diff --git a/builtin/clone.c b/builtin/clone.c
index 38094d4..b47c73f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -786,12 +786,12 @@ static void write_refspec_config(const char *src_ref_prefix,
 		/* Configure the remote */
 		if (value.len) {
 			strbuf_addf(&key, "remote.%s.fetch", option_origin);
-			git_config_set_multivar_or_die(key.buf, value.buf, "^$", 0);
+			git_config_set_multivar(key.buf, value.buf, "^$", 0);
 			strbuf_reset(&key);
 
 			if (option_mirror) {
 				strbuf_addf(&key, "remote.%s.mirror", option_origin);
-				git_config_set_or_die(key.buf, "true");
+				git_config_set(key.buf, "true");
 				strbuf_reset(&key);
 			}
 		}
@@ -949,14 +949,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			src_ref_prefix = "refs/";
 		strbuf_addstr(&branch_top, src_ref_prefix);
 
-		git_config_set_or_die("core.bare", "true");
+		git_config_set("core.bare", "true");
 	} else {
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
 	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
-	git_config_set_or_die(key.buf, repo);
+	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
 	if (option_reference.nr)
diff --git a/builtin/init-db.c b/builtin/init-db.c
index ef19048..6223b7d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -227,7 +227,7 @@ static int create_default_files(const char *template_path)
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
 		  "%d", GIT_REPO_VERSION);
-	git_config_set_or_die("core.repositoryformatversion", repo_version_string);
+	git_config_set("core.repositoryformatversion", repo_version_string);
 
 	/* Check filemode trustability */
 	path = git_path_buf(&buf, "config");
@@ -241,18 +241,18 @@ static int create_default_files(const char *template_path)
 		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
 			filemode = 0;
 	}
-	git_config_set_or_die("core.filemode", filemode ? "true" : "false");
+	git_config_set("core.filemode", filemode ? "true" : "false");
 
 	if (is_bare_repository())
-		git_config_set_or_die("core.bare", "true");
+		git_config_set("core.bare", "true");
 	else {
 		const char *work_tree = get_git_work_tree();
-		git_config_set_or_die("core.bare", "false");
+		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
-			git_config_set_or_die("core.logallrefupdates", "true");
+			git_config_set("core.logallrefupdates", "true");
 		if (needs_work_tree_config(get_git_dir(), work_tree))
-			git_config_set_or_die("core.worktree", work_tree);
+			git_config_set("core.worktree", work_tree);
 	}
 
 	if (!reinit) {
@@ -265,12 +265,12 @@ static int create_default_files(const char *template_path)
 		    S_ISLNK(st1.st_mode))
 			unlink(path); /* good */
 		else
-			git_config_set_or_die("core.symlinks", "false");
+			git_config_set("core.symlinks", "false");
 
 		/* Check if the filesystem is case-insensitive */
 		path = git_path_buf(&buf, "CoNfIg");
 		if (!access(path, F_OK))
-			git_config_set_or_die("core.ignorecase", "true");
+			git_config_set("core.ignorecase", "true");
 		probe_utf8_pathname_composition();
 	}
 
@@ -386,8 +386,8 @@ int init_db(const char *template_dir, unsigned int flags)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
 			die("BUG: invalid value for shared_repository");
-		git_config_set_or_die("core.sharedrepository", buf);
-		git_config_set_or_die("receive.denyNonFastforwards", "true");
+		git_config_set("core.sharedrepository", buf);
+		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
 	if (!(flags & INIT_DB_QUIET)) {
diff --git a/builtin/remote.c b/builtin/remote.c
index abd5f67..ecb9b26 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -119,7 +119,7 @@ static void add_branch(const char *key, const char *branchname,
 	else
 		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
 				branchname, remotename, branchname);
-	git_config_set_multivar_or_die(key, tmp->buf, "^$", 0);
+	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
 static const char mirror_advice[] =
@@ -197,7 +197,7 @@ static int add(int argc, const char **argv)
 		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
-	git_config_set_or_die(buf.buf, url);
+	git_config_set(buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		strbuf_reset(&buf);
@@ -213,14 +213,14 @@ static int add(int argc, const char **argv)
 	if (mirror & MIRROR_PUSH) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
-		git_config_set_or_die(buf.buf, "true");
+		git_config_set(buf.buf, "true");
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.tagopt", name);
-		git_config_set_or_die(buf.buf,
-				      fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
+		git_config_set(buf.buf,
+			       fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
 	}
 
 	if (fetch && fetch_remote(name))
@@ -588,15 +588,15 @@ static int migrate_file(struct remote *remote)
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
-		git_config_set_multivar_or_die(buf.buf, remote->url[i], "^$", 0);
+		git_config_set_multivar(buf.buf, remote->url[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push_refspec_nr; i++)
-		git_config_set_multivar_or_die(buf.buf, remote->push_refspec[i], "^$", 0);
+		git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch_refspec_nr; i++)
-		git_config_set_multivar_or_die(buf.buf, remote->fetch_refspec[i], "^$", 0);
+		git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0);
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
@@ -648,7 +648,7 @@ static int mv(int argc, const char **argv)
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
-	git_config_set_multivar_or_die(buf.buf, NULL, NULL, 1);
+	git_config_set_multivar(buf.buf, NULL, NULL, 1);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
@@ -668,7 +668,7 @@ static int mv(int argc, const char **argv)
 				  "\tPlease update the configuration manually if necessary."),
 				buf2.buf);
 
-		git_config_set_multivar_or_die(buf.buf, buf2.buf, "^$", 0);
+		git_config_set_multivar(buf.buf, buf2.buf, "^$", 0);
 	}
 
 	read_branches();
@@ -678,7 +678,7 @@ static int mv(int argc, const char **argv)
 		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
-			git_config_set_or_die(buf.buf, rename.new);
+			git_config_set(buf.buf, rename.new);
 		}
 	}
 
@@ -776,7 +776,7 @@ static int rm(int argc, const char **argv)
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				git_config_set_or_die(buf.buf, NULL);
+				git_config_set(buf.buf, NULL);
 			}
 		}
 	}
@@ -1560,10 +1560,10 @@ static int set_url(int argc, const char **argv)
 	/* Special cases that add new entry. */
 	if ((!oldurl && !delete_mode) || add_mode) {
 		if (add_mode)
-			git_config_set_multivar_or_die(name_buf.buf, newurl,
+			git_config_set_multivar(name_buf.buf, newurl,
 						       "^$", 0);
 		else
-			git_config_set_or_die(name_buf.buf, newurl);
+			git_config_set(name_buf.buf, newurl);
 		strbuf_release(&name_buf);
 
 		return 0;
@@ -1586,9 +1586,9 @@ static int set_url(int argc, const char **argv)
 	regfree(&old_regex);
 
 	if (!delete_mode)
-		git_config_set_multivar_or_die(name_buf.buf, newurl, oldurl, 0);
+		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
 	else
-		git_config_set_multivar_or_die(name_buf.buf, NULL, oldurl, 1);
+		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
 	return 0;
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c7e1ea2..f4c3eff 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -245,8 +245,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
-	git_config_set_in_file_or_die(p, "core.worktree",
-				      relative_path(sb.buf, sm_gitdir, &rel_path));
+	git_config_set_in_file(p, "core.worktree",
+			       relative_path(sb.buf, sm_gitdir, &rel_path));
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
 	free(sm_gitdir);
diff --git a/cache.h b/cache.h
index 2d48aef..63fb85e 100644
--- a/cache.h
+++ b/cache.h
@@ -1526,15 +1526,15 @@ extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
-extern void git_config_set_in_file_or_die(const char *, const char *, const char *);
+extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
-extern void git_config_set_or_die(const char *, const char *);
+extern void git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_key_is_valid(const char *key);
 extern int git_config_set_multivar_gently(const char *, const char *, const char *, int);
-extern void git_config_set_multivar_or_die(const char *, const char *, const char *, int);
+extern void git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
-extern void git_config_set_multivar_in_file_or_die(const char *, const char *, const char *, const char *, int);
+extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
diff --git a/config.c b/config.c
index e7f42da..325c3ea 100644
--- a/config.c
+++ b/config.c
@@ -1831,10 +1831,10 @@ int git_config_set_in_file_gently(const char *config_filename,
 	return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, 0);
 }
 
-void git_config_set_in_file_or_die(const char *config_filename,
-			const char *key, const char *value)
+void git_config_set_in_file(const char *config_filename,
+			    const char *key, const char *value)
 {
-	git_config_set_multivar_in_file_or_die(config_filename, key, value, NULL, 0);
+	git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
 }
 
 int git_config_set_gently(const char *key, const char *value)
@@ -1842,9 +1842,9 @@ int git_config_set_gently(const char *key, const char *value)
 	return git_config_set_multivar_gently(key, value, NULL, 0);
 }
 
-void git_config_set_or_die(const char *key, const char *value)
+void git_config_set(const char *key, const char *value)
 {
-	git_config_set_multivar_or_die(key, value, NULL, 0);
+	git_config_set_multivar(key, value, NULL, 0);
 }
 
 /*
@@ -2191,9 +2191,9 @@ write_err_out:
 
 }
 
-void git_config_set_multivar_in_file_or_die(const char *config_filename,
-				const char *key, const char *value,
-				const char *value_regex, int multi_replace)
+void git_config_set_multivar_in_file(const char *config_filename,
+				     const char *key, const char *value,
+				     const char *value_regex, int multi_replace)
 {
 	if (git_config_set_multivar_in_file_gently(config_filename, key, value,
 						   value_regex, multi_replace) < 0)
@@ -2207,11 +2207,11 @@ int git_config_set_multivar_gently(const char *key, const char *value,
 						      multi_replace);
 }
 
-void git_config_set_multivar_or_die(const char *key, const char *value,
-			const char *value_regex, int multi_replace)
+void git_config_set_multivar(const char *key, const char *value,
+			     const char *value_regex, int multi_replace)
 {
-	git_config_set_multivar_in_file_or_die(NULL, key, value, value_regex,
-					       multi_replace);
+	git_config_set_multivar_in_file(NULL, key, value, value_regex,
+					multi_replace);
 }
 
 static int section_name_match (const char *buf, const char *name)
diff --git a/sequencer.c b/sequencer.c
index 3590248..8048786 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -933,31 +933,31 @@ static void save_opts(struct replay_opts *opts)
 	const char *opts_file = git_path_opts_file();
 
 	if (opts->no_commit)
-		git_config_set_in_file_or_die(opts_file, "options.no-commit", "true");
+		git_config_set_in_file(opts_file, "options.no-commit", "true");
 	if (opts->edit)
-		git_config_set_in_file_or_die(opts_file, "options.edit", "true");
+		git_config_set_in_file(opts_file, "options.edit", "true");
 	if (opts->signoff)
-		git_config_set_in_file_or_die(opts_file, "options.signoff", "true");
+		git_config_set_in_file(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
-		git_config_set_in_file_or_die(opts_file, "options.record-origin", "true");
+		git_config_set_in_file(opts_file, "options.record-origin", "true");
 	if (opts->allow_ff)
-		git_config_set_in_file_or_die(opts_file, "options.allow-ff", "true");
+		git_config_set_in_file(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-		git_config_set_in_file_or_die(opts_file, "options.mainline", buf.buf);
+		git_config_set_in_file(opts_file, "options.mainline", buf.buf);
 		strbuf_release(&buf);
 	}
 	if (opts->strategy)
-		git_config_set_in_file_or_die(opts_file, "options.strategy", opts->strategy);
+		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
 	if (opts->gpg_sign)
-		git_config_set_in_file_or_die(opts_file, "options.gpg-sign", opts->gpg_sign);
+		git_config_set_in_file(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
-			git_config_set_multivar_in_file_or_die(opts_file,
-							       "options.strategy-option",
-							       opts->xopts[i], "^$", 0);
+			git_config_set_multivar_in_file(opts_file,
+							"options.strategy-option",
+							opts->xopts[i], "^$", 0);
 	}
 }
 
diff --git a/submodule.c b/submodule.c
index be8b5cc..b3fc6ac 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1087,9 +1087,9 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
 	strbuf_addf(&file_name, "%s/config", git_dir);
-	git_config_set_in_file_or_die(file_name.buf, "core.worktree",
-				      relative_path(real_work_tree, git_dir,
-						    &rel_path));
+	git_config_set_in_file(file_name.buf, "core.worktree",
+			       relative_path(real_work_tree, git_dir,
+					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-- 
2.7.1
