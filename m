From: conrad.irwin@gmail.com
Subject: [PATCH v3 3/3] Add support for -p/--patch to git-commit
Date: Fri,  6 May 2011 23:00:01 -0700
Message-ID: <1304748001-17982-4-git-send-email-conrad.irwin@gmail.com>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Cc: Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:00:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIaZ9-0006Kt-ED
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 08:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab1EGGAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 02:00:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47917 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab1EGGAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 02:00:11 -0400
Received: by pvg12 with SMTP id 12so1706427pvg.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 23:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Uh/flLjsl80WQfGCFmjAneTpVEx3XeQlF5V3CO5YGJE=;
        b=KfFsAJAlOQEdriDKqwtyOh28/cR7GJxkWotCRrxE35bcQbj1O9Xv+ycekgawVBo9Ao
         UXD2pNswxT6Ghsg2TieckUtE2+DSSUyu6cTdEYzN/QZrfDGiLZ+HFNKBBoPTljGM+WIm
         NqkLMeqTBPAHFwZfDw7Mjdi5dnI9/FnVMwCfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iVM09ZSHG7QeQozqA6TYOKRyEM1+d+Ktd6JbWfYsVlqclk8DLmCKNq0DLwT3uSwiEL
         72rvat7tsvOPxRa6MPABveuhQ9OChzl00S7su1JNCuzOigtRKe24HA8iyIr7t8mA4ZS/
         rGqNMub9xD0408uO6e3dIr9f9kGjad1fMUrpo=
Received: by 10.68.28.133 with SMTP id b5mr5750659pbh.264.1304748010101;
        Fri, 06 May 2011 23:00:10 -0700 (PDT)
Received: from scarlatti.dunvegan.biz (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id m7sm2622155pbd.33.2011.05.06.23.00.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 23:00:08 -0700 (PDT)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.75)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1QIaYg-0004gr-Ti; Fri, 06 May 2011 23:00:06 -0700
X-Mailer: git-send-email 1.7.5.188.g4817
In-Reply-To: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173036>

From: Conrad Irwin <conrad.irwin@gmail.com>

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
index ed50271..66918c7 100644
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
index d39a6ab..f02524b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -241,7 +241,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	return status;
 }
 
-int interactive_add(int argc, const char **argv, const char *prefix)
+int interactive_add(int argc, const char **argv, const char *prefix, int patch)
 {
 	const char **pathspec = NULL;
 
@@ -252,7 +252,7 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 	}
 
 	return run_add_interactive(NULL,
-				   patch_interactive ? "--patch" : NULL,
+				   patch ? "--patch" : NULL,
 				   pathspec);
 }
 
@@ -377,7 +377,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
-		exit(interactive_add(argc - 1, argv + 1, prefix));
+		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
 
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
diff --git a/builtin/commit.c b/builtin/commit.c
index 7707af8..008c1ec 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -83,7 +83,7 @@ static const char *template_file;
 static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, edit_flag, also, interactive, patch_interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -152,6 +152,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
 	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactively add changes"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
@@ -360,7 +361,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 		old_index_env = getenv(INDEX_ENVIRONMENT);
 		setenv(INDEX_ENVIRONMENT, index_lock.filename, 1);
 
-		if (interactive_add(argc, argv, prefix) != 0)
+		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
 
 		if (old_index_env && *old_index_env)
@@ -1061,8 +1062,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		author_message_buffer = read_commit_message(author_message);
 	}
 
+	if (patch_interactive)
+		interactive = 1;
+
 	if (!!also + !!only + !!all + !!interactive > 1)
-		die(_("Only one of --include/--only/--all/--interactive can be used."));
+		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend)))
 		die(_("No paths with --include/--only does not make sense."));
 	if (argc == 0 && only && amend)
diff --git a/commit.h b/commit.h
index b3c3bb7..43940e2 100644
--- a/commit.h
+++ b/commit.h
@@ -161,7 +161,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);
 
-extern int interactive_add(int argc, const char **argv, const char *prefix);
+extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mode,
 			       const char **pathspec);
 
-- 
1.7.5.188.g4817
