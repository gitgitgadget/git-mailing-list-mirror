From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH] Add support for -p/--patch to git-commit
Date: Sun, 26 Dec 2010 17:56:09 +0000
Message-ID: <E1PWvWg-000293-WA@scarlatti.dunvegan.biz>
References: <E1PWsuV-0000FH-90@scarlatti.dunvegan.biz>
	<vpqr5d4cx9e.fsf@bauges.imag.fr>
Cc: git@vger.kernel.org
To: Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Sun Dec 26 19:44:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWvZc-0001lg-T3
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 19:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab0LZSnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 13:43:15 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43067 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0LZSnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 13:43:14 -0500
Received: by wwa36 with SMTP id 36so8531011wwa.1
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id
         :in-reply-to:references:from:date:subject:to:cc;
        bh=IQgBZQiVSbCz6XyL4CIVRv1YC7t5zrsohCLr1BNFl3g=;
        b=HtvH639yxYKwBJ+Rqjb+uc0l6KrRehE74N3V0B1RpywEEkv8kTE8PJc0ZnyRih+dOI
         vhaM2nMqlk49nFlDyXt7AGE5Ro9yZ/ttitGkJegtLl8AyQXCL1oT+JNh3PtAckVXpT4e
         7XhwqR4SU3mXlg534C2kZibV4pYFlU7eem83k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:in-reply-to:references:from:date:subject:to:cc;
        b=dW+aaLbCYnDzjsuABNuhhL1iMECg7iraV2nYb/glv1OU1wg49Ts8KUXgny4Rc1JjCw
         fFj4nxRXnf8zT/34Jx3KEQqTiYPQZI1kJfSiQbHeVpsAQ7EP/e5AiCHDwQZdmhD3LI4N
         cEcZlFgdXU6A1+JM45hhLn+s43E1ieuQUIvtk=
Received: by 10.227.132.209 with SMTP id c17mr6941488wbt.135.1293388992703;
        Sun, 26 Dec 2010 10:43:12 -0800 (PST)
Received: from scarlatti.dunvegan.biz (host86-159-223-152.range86-159.btcentralplus.com [86.159.223.152])
        by mx.google.com with ESMTPS id 11sm7829360wbj.19.2010.12.26.10.43.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 10:43:12 -0800 (PST)
Received: from root by scarlatti.dunvegan.biz with local (Exim 4.72)
	(envelope-from <0e7c5991d55765b8b41917159da681585be2b722@scarlatti.dunvegan.biz>)
	id 1PWvWg-000293-WA; Sun, 26 Dec 2010 18:41:03 +0000
In-Reply-To: <vpqr5d4cx9e.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164195>

This works in the same was as git commit --interactive, and is
equivalent to running git add -p before git commit.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---

On 26 December 2010 16:30, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
> At least one mistake:
>
> To: unlisted-recipients:; (no To-header on input)
>
> (I guess you've Bcc-ed the Git list, please don't do that)

Sorry, failed to use sendmail. (having read dire warnings about sending
patches with gmail), second time lucky...

> > While this patch works as advertised, I wonder if it would be nicer to
> > change the behaviour of git commit --interactive and git commit -p to
> > act on a temporary copy of the index rather than mutating the existing
> > index. I've no idea how to go about that yet, but is it something that
> > should be changed?
>
> I don't think so. After a commit, I usually expect the index to be
> clean, ready to start preparing the next commit (except if I
> explicitely asked the opposite), which implies that the index used for
> commit (-i|-p) is the same as the usual one.

The reason I suggested this is so that if you abort the commit (by
leaving the commit message empty), the index would be unchanged; at the
moment if you abort the commit the git-add is remembered. Certainly any
changes committed would be removed from the index. It also would allow
for git commit -p --only instead of having it always work like --include
(which might even be better default behaviour). (It's also worth noting
that git commit -i is --include, not --interactive)

>
> If I read correctly, this forbids "git commit --interactive --patch",
> while "git add --interactive --patch" is allowed, and equivalent to
> "--patch" alone.

Well spotted :). Relatedly, git-commit currently forbids --interactive
with paths, which should also be changed (though in a different commit I
assume); I did not copy that limitation to --patch.

I've updated this patch, thank you very much for the feedback.

Conrad


 Documentation/git-commit.txt |   24 ++++++++++++++++--------
 builtin/add.c                |    6 +++---
 builtin/commit.c             |   11 ++++++-----
 commit.h                     |    2 +-
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..6e7ab5a 100644
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
@@ -39,9 +40,10 @@ The content to be added can be specified in several ways:
    that have been removed from the working tree, and then perform the
    actual commit;
 
-5. by using the --interactive switch with the 'commit' command to decide one
-   by one which files should be part of the commit, before finalizing the
-   operation.  Currently, this is done by invoking 'git add --interactive'.
+5. by using the --interactive or --patch switches with the 'commit' command
+   to decide one by one which files or hunks should be part of the commit,
+   before finalizing the operation.  Currently, this is done by invoking
+   'git add --interactive' or 'git add --patch'.
 
 The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
@@ -59,6 +61,12 @@ OPTIONS
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
index 22ba54f..454308e 100644
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
@@ -296,8 +297,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
-	if (interactive) {
-		if (interactive_add(argc, argv, prefix) != 0)
+	if (interactive || patch_interactive) {
+		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die("interactive add failed");
 		if (read_cache_preload(NULL) < 0)
 			die("index file corrupt");
@@ -969,8 +970,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			use_message_buffer = xstrdup(commit->buffer);
 	}
 
-	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.");
+	if (!!also + !!only + !!all + !!(interactive || patch_interactive) > 1)
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
1.7.3.4.627.g3cfc9
