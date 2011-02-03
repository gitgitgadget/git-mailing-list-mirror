From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH 3/3] Add support for -p/--patch to git-commit
Date: Wed,  2 Feb 2011 21:25:32 -0800
Message-ID: <1296710732-12493-4-git-send-email-conrad.irwin@gmail.com>
References: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Cc: conrad.irwin@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 06:25:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkrhX-0001mN-Eb
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1BCFZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:25:43 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53209 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab1BCFZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:25:41 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so331867yxt.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 21:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BCFfW8mQi/+FQ/AqBY80rAnFNiKwIDkO210b9ZVIc34=;
        b=VJibRYdh5W75VfRNlCN6cKlEz4U8QOvS/JXXix+oQ91CJJb3xRY8NXkjeG4wo3hEjM
         du7PLUMQwXzM/mnTobglD9mlzreBK/zD8Y5ztVHCt34/pH3N5vXFCmT9zlo1vZH5ALcO
         ot91ci6RKfR5KxzpIKbCEqa7cGsuy6fmN+h5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fG3g1qmGRL2FGRNHTFHLo40PDC06m6I2ptfGfV07+8eaQvHfFO9RIvaaEnxQY6qPq4
         sV1At4qTEtIvDpjmA/kpU2li+FKkvMWmK1FowQlmi1keVpD2ylrKq+tHEkVwxeb2okDT
         a65yPwKSc+sWvTjrSGS9QQj5mnS81FkXmo7Kw=
Received: by 10.100.238.8 with SMTP id l8mr6393285anh.119.1296710741005;
        Wed, 02 Feb 2011 21:25:41 -0800 (PST)
Received: from scarlatti.dunvegan.biz ([173.228.114.197])
        by mx.google.com with ESMTPS id b11sm523522ana.38.2011.02.02.21.25.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 21:25:40 -0800 (PST)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.72)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1PkrhK-0003H1-Nk; Wed, 02 Feb 2011 21:25:38 -0800
X-Mailer: git-send-email 1.7.4.1.g1c7a9.dirty
In-Reply-To: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165952>

The --interactive flag is already shared by git add and git commit,
share the -p and --patch flags too.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 Documentation/git-commit.txt |   25 ++++++++++++++++---------
 builtin/add.c                |    6 +++---
 builtin/commit.c             |   10 +++++++---
 commit.h                     |    2 +-
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index ca755db..81156f0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,11 +8,12 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
-	   [--reset-author] [--allow-empty] [--allow-empty-message] [--no-verify]
-	   [-e] [--author=<author>] [--date=<date>] [--cleanup=<mode>]
-	   [--status | --no-status] [-i | -o] [--] [<file>...]
+'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
+	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
+	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
+	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
+	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
+	   [-i | -o] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -39,10 +40,10 @@ The content to be added can be specified in several ways:
    that have been removed from the working tree, and then perform the
    actual commit;
 
-5. by using the --interactive switch with the 'commit' command to decide one
-   by one which files should be part of the commit, before finalizing the
-   operation.  Currently, this is done by invoking 'git add --interactive'
-   on a temporary index.
+5. by using the --interactive or --patch switches with the 'commit' command
+   to decide one by one which files or hunks should be part of the commit,
+   before finalizing the operation.  Currently, this is done by invoking
+   'git add --interactive' or 'git add --patch' on a temporary index.
 
 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
@@ -60,6 +61,12 @@ OPTIONS
 	been modified and deleted, but new files you have not
 	told git about are not affected.
 
+-p::
+--patch::
+	Use the interactive patch selection interface to chose
+	which changes to commit. See linkgit:git-add[1] for
+	details.
+
 -C <commit>::
 --reuse-message=<commit>::
 	Take an existing commit object, and reuse the log message
diff --git a/builtin/add.c b/builtin/add.c
index 12b964e..3d074b3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -242,7 +242,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	return status;
 }
 
-int interactive_add(int argc, const char **argv, const char *prefix)
+int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 {
 	const char **pathspec = NULL;
 
@@ -253,7 +253,7 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	}
 
 	return run_add_interactive(NULL,
-				   patch_interactive ? "--patch" : NULL,
+				   patch ? "--patch" : NULL,
 				   pathspec);
 }
 
@@ -378,7 +378,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-		exit(interactive_add(argc - 1, argv + 1, prefix));
+		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
 
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
diff --git a/builtin/commit.c b/builtin/commit.c
index 592c2d2..0c53dc9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -70,7 +70,7 @@ static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, edit_flag, also, interactive, patch_interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -138,6 +138,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
 	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactively add changes"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
@@ -316,7 +317,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 		old_index_env = getenv(INDEX_ENVIRONMENT);
 		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
 
-		if (interactive_add(argc, argv, prefix) != 0)
+		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die("interactive add failed");
 
 		if (old_index_env && *old_index_env)
@@ -989,8 +990,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			use_message_buffer = xstrdup(commit->buffer);
 	}
 
+	if (patch_interactive)
+		interactive = 1;
+
 	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.");
+		die("Only one of --include/--only/--all/--interactive/--patch can be used.");
 	if (argc == 0 && (also || (only && !amend)))
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
diff --git a/commit.h b/commit.h
index eb6c5af..951c22e 100644
--- a/commit.h
+++ b/commit.h
@@ -160,7 +160,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(int argc, const char **argv, const char *prefix);
+extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
 			       const char **pathspec);
 
-- 
1.7.4.1.g1c7a9.dirty
