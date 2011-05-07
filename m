From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH v4 3/3] Add support for -p/--patch to git-commit
Date: Sat,  7 May 2011 10:58:07 -0700
Message-ID: <1304791087-2965-1-git-send-email-conrad.irwin@gmail.com>
References: <BANLkTi=Y5o=KP1LnkKqGq31Sqfn-ZZCGNA@mail.gmail.com>
Cc: Valentin Haenel <valentin@fsfe.org>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 19:58:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIllh-0005La-8U
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 19:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab1EGR6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 13:58:12 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:35412 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1EGR6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 13:58:11 -0400
Received: by pxi16 with SMTP id 16so2858375pxi.4
        for <git@vger.kernel.org>; Sat, 07 May 2011 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hsoAmPkrmKNOVrmwjaV2PP+KICKBeJjzEJw8fx48Wc8=;
        b=p0AzZuvKCtucsqJS1bEof3XUGHtUc3NEfNWndJqt6IcyKLFLuAABMlnOfJjx56u0Xm
         aw0nE029scqcsNq9S1pM4u1HNhuhZ+jXJwt+bNi8iI+FlR+y1iavNAwfwawAI5m67853
         YFrjIALpDsWYNaSsazX6GaFVqnmdFXepzDkw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FtShuIzvjAN8lCEsCTjoI6cyeVXvj2sbbtmwLcrwlBFi6rh5+0UZgzhM0Bnkk0Epl5
         w51A9pznupEAYHaHtt4IvgjhLUzwpL/V11bp1GqPTGB9niJKsj8pNgp8c9XrxlzcOszR
         Mu0LS9UTJWT2gb9XKj47lIl3FPjH1tDqPCQVs=
Received: by 10.68.50.161 with SMTP id d1mr6935934pbo.439.1304791091185;
        Sat, 07 May 2011 10:58:11 -0700 (PDT)
Received: from scarlatti.dunvegan.biz (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id 3sm2944381pbd.100.2011.05.07.10.58.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 10:58:10 -0700 (PDT)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.75)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1QIllY-0000mQ-Np; Sat, 07 May 2011 10:58:08 -0700
X-Mailer: git-send-email 1.7.5.188.g4817
In-Reply-To: <BANLkTi=Y5o=KP1LnkKqGq31Sqfn-ZZCGNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173058>

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
index ed50271..7951cb7 100644
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
+   before finalizing the operation. See the ``Interactive Mode`` section of
+   linkgit:git-add[1] to learn how to operate these modes.
 
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
