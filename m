From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/7] add OPT__FORCE
Date: Mon, 08 Nov 2010 19:01:54 +0100
Message-ID: <4CD83B12.8050205@lsrfire.ath.cx>
References: <4CD83917.3040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Nov 08 19:02:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFW2r-0004Wu-5R
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374Ab0KHSCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:02:05 -0500
Received: from india601.server4you.de ([85.25.151.105]:47814 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126Ab0KHSCD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:02:03 -0500
Received: from [10.0.1.100] (p4FC56F37.dip.t-dialin.net [79.197.111.55])
	by india601.server4you.de (Postfix) with ESMTPSA id 857B72F807B;
	Mon,  8 Nov 2010 19:01:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CD83917.3040801@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160956>

Add OPT__FORCE as a helper macro in the same spirit as OPT__VERBOSE
et.al. to simplify defining -f/--force options.

Signed-off-by: Rene Scharfe <rene.scharfe@lstfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    3 +++
 builtin/add.c                                 |    2 +-
 builtin/branch.c                              |    2 +-
 builtin/checkout-index.c                      |    3 +--
 builtin/checkout.c                            |    2 +-
 builtin/clean.c                               |    2 +-
 builtin/fetch.c                               |    3 +--
 builtin/mv.c                                  |    2 +-
 builtin/notes.c                               |    4 ++--
 builtin/rm.c                                  |    2 +-
 builtin/tag.c                                 |    2 +-
 builtin/update-server-info.c                  |    3 +--
 parse-options.h                               |    1 +
 13 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 248a66d..f6a4a36 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -121,6 +121,9 @@ There are some macros to easily define options:
 `OPT__DRY_RUN(&int_var, description)`::
 	Add `-n, \--dry-run`.
 
+`OPT__FORCE(&int_var, description)`::
+	Add `-f, \--force`.
+
 `OPT__QUIET(&int_var, description)`::
 	Add `-q, \--quiet`.
 
diff --git a/builtin/add.c b/builtin/add.c
index 9625cee..71f9b04 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -319,7 +319,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
 	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('e', "edit", &edit_interactive, "edit current diff and apply"),
-	OPT_BOOLEAN('f', "force", &ignored_too, "allow adding otherwise ignored files"),
+	OPT__FORCE(&ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, "record only the fact that the path will be added later"),
 	OPT_BOOLEAN('A', "all", &addremove, "add all, noticing removal of tracked files"),
diff --git a/builtin/branch.c b/builtin/branch.c
index 10788fc..e388edc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -651,7 +651,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
-		OPT_BOOLEAN('f', "force", &force_create, "force creation (when already exists)"),
+		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
 			"commit", "print only not merged branches",
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 7ba0913..91fb9bf 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -217,8 +217,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOLEAN('a', "all", &all,
 			"checks out all files in the index"),
-		OPT_BOOLEAN('f', "force", &force,
-			"forces overwrite of existing files"),
+		OPT__FORCE(&force, "forces overwrite of existing files"),
 		OPT__QUIET(&quiet, "be quiet"),
 		OPT_BOOLEAN('n', "no-create", &not_new,
 			"don't checkout new files"),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a952477..f275570 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -699,7 +699,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    2),
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "checkout their version for unmerged files",
 			    3),
-		OPT_BOOLEAN('f', "force", &opts.force, "force checkout (throw away local modifications)"),
+		OPT__FORCE(&opts.force, "force checkout (throw away local modifications)"),
 		OPT_BOOLEAN('m', "merge", &opts.merge, "perform a 3-way merge with the new branch"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
diff --git a/builtin/clean.c b/builtin/clean.c
index 449d2a3..9146bf3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -50,7 +50,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, "be quiet"),
 		OPT__DRY_RUN(&show_only, "dry run"),
-		OPT_BOOLEAN('f', "force", &force, "force"),
+		OPT__FORCE(&force, "force"),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, "pattern",
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d35f000..6aaf8e9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -43,8 +43,7 @@ static struct option builtin_fetch_options[] = {
 		    "append to .git/FETCH_HEAD instead of overwriting"),
 	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
 		   "path to upload pack on remote end"),
-	OPT_BOOLEAN('f', "force", &force,
-		    "force overwrite of local branch"),
+	OPT__FORCE(&force, "force overwrite of local branch"),
 	OPT_BOOLEAN('m', "multiple", &multiple,
 		    "fetch from multiple remotes"),
 	OPT_SET_INT('t', "tags", &tags,
diff --git a/builtin/mv.c b/builtin/mv.c
index 8677bd2..93e8995 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -56,7 +56,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
 		OPT__DRY_RUN(&show_only, "dry run"),
-		OPT_BOOLEAN('f', "force", &force, "force move/rename even if target exists"),
+		OPT__FORCE(&force, "force move/rename even if target exists"),
 		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
 		OPT_END(),
 	};
diff --git a/builtin/notes.c b/builtin/notes.c
index 2ab070f..c85cbf5 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -538,7 +538,7 @@ static int add(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', "reuse-message", &msg, "OBJECT",
 			"reuse specified note object", PARSE_OPT_NONEG,
 			parse_reuse_arg},
-		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
+		OPT__FORCE(&force, "replace existing notes"),
 		OPT_END()
 	};
 
@@ -594,7 +594,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	const char *rewrite_cmd = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
+		OPT__FORCE(&force, "replace existing notes"),
 		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
 			   "load rewriting config for <command> (implies "
diff --git a/builtin/rm.c b/builtin/rm.c
index 49461b6..9a59905 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -142,7 +142,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, "dry run"),
 	OPT__QUIET(&quiet, "be quiet"),
 	OPT_BOOLEAN( 0 , "cached",         &index_only, "only remove from the index"),
-	OPT_BOOLEAN('f', "force",          &force,      "override the up-to-date check"),
+	OPT__FORCE(&force, "override the up-to-date check"),
 	OPT_BOOLEAN('r', NULL,             &recursive,  "allow recursive removal"),
 	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
 				"exit with a zero status even if nothing matched"),
diff --git a/builtin/tag.c b/builtin/tag.c
index d311491..d1d7d87 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -390,7 +390,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
-		OPT_BOOLEAN('f', "force", &force, "replace the tag if exists"),
+		OPT__FORCE(&force, "replace the tag if exists"),
 
 		OPT_GROUP("Tag listing options"),
 		{
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 2b3fddc..b90dce6 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -11,8 +11,7 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('f', "force", &force,
-			"update the info files from scratch"),
+		OPT__FORCE(&force, "update the info files from scratch"),
 		OPT_END()
 	};
 
diff --git a/parse-options.h b/parse-options.h
index 3dd3a94..ae8647d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -206,6 +206,7 @@ extern int parse_opt_tertiary(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, "be more quiet", \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var, h)  OPT_BOOLEAN('n', "dry-run", (var), (h))
+#define OPT__FORCE(var, h)    OPT_BOOLEAN('f', "force",   (var), (h))
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), "n", \
 	  "use <n> digits to display SHA-1s", \
-- 
1.7.3
