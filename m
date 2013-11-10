From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 2/4] tar-tree: remove deprecated command
Date: Sun, 10 Nov 2013 15:47:29 +0000
Message-ID: <d29327f6eb6e999ef31c3130ad2bab712a5d280b.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 10 16:48:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfXFF-0000NX-TT
	for gcvg-git-2@plane.gmane.org; Sun, 10 Nov 2013 16:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab3KJPsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 10:48:06 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:50444 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab3KJPsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 10:48:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id A073760653E;
	Sun, 10 Nov 2013 15:48:01 +0000 (GMT)
X-Quarantine-ID: <GGFtvIPoDQyc>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GGFtvIPoDQyc; Sun, 10 Nov 2013 15:47:51 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id F216F60654E;
	Sun, 10 Nov 2013 15:47:47 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.rc0.170.g772b8ec
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
In-Reply-To: <cover.1384098226.git.john@keeping.me.uk>
References: <cover.1384098226.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237590>

"git tar-tree" has been a thin wrapper around "git archive" since commit
fd88d9c (Remove upload-tar and make git-tar-tree a thin wrapper to
git-archive, 2006-09-24), which also made it print a message indicating
that git-tar-tree is deprecated.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 .gitignore                             |  1 -
 Documentation/git-tar-tree.txt         | 82 ----------------------------------
 builtin/tar-tree.c                     | 62 -------------------------
 command-list.txt                       |  1 -
 contrib/completion/git-completion.bash |  1 -
 git.c                                  |  1 -
 t/t4116-apply-reverse.sh               |  4 +-
 t/t5000-tar-tree.sh                    | 16 ++-----
 t/t5001-archive-attr.sh                | 10 -----
 9 files changed, 5 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/git-tar-tree.txt

diff --git a/.gitignore b/.gitignore
index 3bc1b08..88b313a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -158,7 +158,6 @@
 /git-svn
 /git-symbolic-ref
 /git-tag
-/git-tar-tree
 /git-unpack-file
 /git-unpack-objects
 /git-update-index
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
deleted file mode 100644
index f7362dc..0000000
--- a/Documentation/git-tar-tree.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-git-tar-tree(1)
-===============
-
-NAME
-----
-git-tar-tree - Create a tar archive of the files in the named tree object
-
-
-SYNOPSIS
---------
-[verse]
-'git tar-tree' [--remote=<repo>] <tree-ish> [ <base> ]
-
-DESCRIPTION
------------
-THIS COMMAND IS DEPRECATED.  Use 'git archive' with `--format=tar`
-option instead (and move the <base> argument to `--prefix=base/`).
-
-Creates a tar archive containing the tree structure for the named tree.
-When <base> is specified it is added as a leading path to the files in the
-generated tar archive.
-
-'git tar-tree' behaves differently when given a tree ID versus when given
-a commit ID or tag ID.  In the first case the current time is used as
-modification time of each file in the archive.  In the latter case the
-commit time as recorded in the referenced commit object is used instead.
-Additionally the commit ID is stored in a global extended pax header.
-It can be extracted using 'git get-tar-commit-id'.
-
-OPTIONS
--------
-
-<tree-ish>::
-	The tree or commit to produce tar archive for.  If it is
-	the object name of a commit object.
-
-<base>::
-	Leading path to the files in the resulting tar archive.
-
---remote=<repo>::
-	Instead of making a tar archive from local repository,
-	retrieve a tar archive from a remote repository.
-
-CONFIGURATION
--------------
-
-tar.umask::
-	This variable can be used to restrict the permission bits of
-	tar archive entries.  The default is 0002, which turns off the
-	world write bit.  The special value "user" indicates that the
-	archiving user's umask will be used instead.  See umask(2) for
-	details.
-
-EXAMPLES
---------
-`git tar-tree HEAD junk | (cd /var/tmp/ && tar xf -)`::
-
-	Create a tar archive that contains the contents of the
-	latest commit on the current branch, and extracts it in
-	`/var/tmp/junk` directory.
-
-`git tar-tree v1.4.0 git-1.4.0 | gzip >git-1.4.0.tar.gz`::
-
-	Create a tarball for v1.4.0 release.
-
-`git tar-tree v1.4.0^{tree} git-1.4.0 | gzip >git-1.4.0.tar.gz`::
-
-	Create a tarball for v1.4.0 release, but without a
-	global extended pax header.
-
-`git tar-tree --remote=example.com:git.git v1.4.0 >git-1.4.0.tar`::
-
-	Get a tarball v1.4.0 from example.com.
-
-`git tar-tree HEAD:Documentation/ git-docs > git-1.4.0-docs.tar`::
-
-	Put everything in the current head's Documentation/ directory
-	into 'git-1.4.0-docs.tar', with the prefix 'git-docs/'.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index ba3ffe6..aa72596 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -7,71 +7,9 @@
 #include "builtin.h"
 #include "quote.h"
 
-static const char tar_tree_usage[] =
-"git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
-"*** Note that this command is now deprecated; use \"git archive\" instead.";
-
 static const char builtin_get_tar_commit_id_usage[] =
 "git get-tar-commit-id < <tarfile>";
 
-int cmd_tar_tree(int argc, const char **argv, const char *prefix)
-{
-	/*
-	 * "git tar-tree" is now a wrapper around "git archive --format=tar"
-	 *
-	 * $0 --remote=<repo> arg... ==>
-	 *	git archive --format=tar --remote=<repo> arg...
-	 * $0 tree-ish ==>
-	 *	git archive --format=tar tree-ish
-	 * $0 tree-ish basedir ==>
-	 * 	git archive --format-tar --prefix=basedir tree-ish
-	 */
-	const char **nargv = xcalloc(sizeof(*nargv), argc + 3);
-	struct strbuf sb = STRBUF_INIT;
-	char *basedir_arg;
-	int nargc = 0;
-
-	nargv[nargc++] = "archive";
-	nargv[nargc++] = "--format=tar";
-
-	if (2 <= argc && !prefixcmp(argv[1], "--remote=")) {
-		nargv[nargc++] = argv[1];
-		argv++;
-		argc--;
-	}
-
-	/*
-	 * Because it's just a compatibility wrapper, tar-tree supports only
-	 * the old behaviour of reading attributes from the work tree.
-	 */
-	nargv[nargc++] = "--worktree-attributes";
-
-	switch (argc) {
-	default:
-		usage(tar_tree_usage);
-		break;
-	case 3:
-		/* base-path */
-		basedir_arg = xmalloc(strlen(argv[2]) + 11);
-		sprintf(basedir_arg, "--prefix=%s/", argv[2]);
-		nargv[nargc++] = basedir_arg;
-		/* fallthru */
-	case 2:
-		/* tree-ish */
-		nargv[nargc++] = argv[1];
-	}
-	nargv[nargc] = NULL;
-
-	fprintf(stderr,
-		"*** \"git tar-tree\" is now deprecated.\n"
-		"*** Running \"git archive\" instead.\n***");
-	sq_quote_argv(&sb, nargv, 0);
-	strbuf_addch(&sb, '\n');
-	fputs(sb.buf, stderr);
-	strbuf_release(&sb);
-	return cmd_archive(nargc, nargv, prefix);
-}
-
 /* ustar header + extended global header content */
 #define RECORDSIZE	(512)
 #define HEADERSIZE (2 * RECORDSIZE)
diff --git a/command-list.txt b/command-list.txt
index f2bf684..f8fc5b8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -126,7 +126,6 @@ git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain common
-git-tar-tree                            plumbinginterrogators	deprecated
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c6063c9..1081ad1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -706,7 +706,6 @@ __git_list_porcelain_commands ()
 		ssh-*)            : transport;;
 		stripspace)       : plumbing;;
 		symbolic-ref)     : plumbing;;
-		tar-tree)         : deprecated;;
 		unpack-file)      : plumbing;;
 		unpack-objects)   : plumbing;;
 		update-index)     : plumbing;;
diff --git a/git.c b/git.c
index 0c9dde2..5c9858f 100644
--- a/git.c
+++ b/git.c
@@ -437,7 +437,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
-		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 2298ece..1e4d438 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -48,12 +48,12 @@ test_expect_success 'apply in reverse' '
 
 test_expect_success 'setup separate repository lacking postimage' '
 
-	git tar-tree initial initial | $TAR xf - &&
+	git archive --format=tar --prefix=initial/ initial | $TAR xf - &&
 	(
 		cd initial && git init && git add .
 	) &&
 
-	git tar-tree second second | $TAR xf - &&
+	git archive --format=tar --prefix=second/ second | $TAR xf - &&
 	(
 		cd second && git init && git add .
 	)
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index c2023b1..11bf0b8 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -3,7 +3,7 @@
 # Copyright (C) 2005 Rene Scharfe
 #
 
-test_description='git tar-tree and git get-tar-commit-id test
+test_description='git archive and git get-tar-commit-id test
 
 This test covers the topics of file contents, commit date handling and
 commit id embedding:
@@ -13,11 +13,11 @@ commit id embedding:
   binary file (/bin/sh).  Only paths shorter than 99 characters are
   used.
 
-  git tar-tree applies the commit date to every file in the archive it
+  git archive applies the commit date to every file in the archive it
   creates.  The test sets the commit date to a specific value and checks
   if the tar archive contains that value.
 
-  When giving git tar-tree a commit id (in contrast to a tree id) it
+  When giving git archive a commit id (in contrast to a tree id) it
   embeds this commit id into the tar archive as a comment.  The test
   checks the ability of git get-tar-commit-id to figure it out from the
   tar file.
@@ -196,16 +196,6 @@ test_expect_success \
     'git get-tar-commit-id <b.tar >b.commitid &&
      test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
 
-test_expect_success 'git tar-tree' '
-	git tar-tree HEAD >tar-tree.tar &&
-	test_cmp b.tar tar-tree.tar
-'
-
-test_expect_success 'git tar-tree with prefix' '
-	git tar-tree HEAD prefix >tar-tree_with_prefix.tar &&
-	test_cmp with_prefix.tar tar-tree_with_prefix.tar
-'
-
 test_expect_success 'git archive with --output, override inferred format' '
 	git archive --format=tar --output=d4.zip HEAD &&
 	test_cmp b.tar d4.zip
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index f47d871..51dedab 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -87,14 +87,4 @@ test_expect_success 'export-subst' '
 	test_cmp substfile2 archive/substfile2
 '
 
-test_expect_success 'git tar-tree vs. git archive with worktree attributes' '
-	git tar-tree HEAD >tar-tree.tar &&
-	test_cmp worktree.tar tar-tree.tar
-'
-
-test_expect_success 'git tar-tree vs. git archive with worktree attrs, bare' '
-	(cd bare && git tar-tree HEAD) >bare-tar-tree.tar &&
-	test_cmp bare-worktree.tar bare-tar-tree.tar
-'
-
 test_done
-- 
1.8.5.rc0.170.g772b8ec
