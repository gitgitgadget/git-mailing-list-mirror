From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/4] option-strings: use OPT_FILENAME
Date: Mon, 23 Feb 2015 17:17:44 +0100
Message-ID: <3af5c93959b22dc327d7fb3974d36764906c2969.1424707497.git.git@drmicha.warpmail.net>
References: <20150223144214.GA31624@peff.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 17:17:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPvhk-0003ia-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 17:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbbBWQRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 11:17:55 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37370 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752145AbbBWQRv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2015 11:17:51 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 413AC2080E
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 11:17:50 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Feb 2015 11:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=cg+XSkXDzV2y7EUarpBLE4qoytI=; b=cvFUiMXsxGbAlYz8cCMZ
	psFmert24X6KllLvPw06WUIIBgctGZ8cAe3Idu1ClHTZr80fbgqvohh+0eGeKj3q
	HdmKe8njzQKayflezJJ1SOAHZwWI4gRyg7d/QZKRDjj9sio8t/qMW40DJVG9+Xz2
	J1O/T7qDLtseG0PiYuOtrGs=
X-Sasl-enc: QxU2kuPah+yg0x8q9FtKm5SAEZRpXo/YcCOkgyjbPsC7 1424708270
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 89BC56800F4;
	Mon, 23 Feb 2015 11:17:50 -0500 (EST)
X-Mailer: git-send-email 2.3.0.296.g32c87e1
In-Reply-To: <20150223144214.GA31624@peff.net>
In-Reply-To: <cover.1424707497.git.git@drmicha.warpmail.net>
References: <cover.1424707497.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264267>

Some commands use OPT_STRING to specify a <file> argument. Let them use
OPT_FILENAME so that they can profit from path prefixing.

This excludes low-level commands like the credential helpers.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This could be before 1/4 but seemed more logical here.

 archive.c             | 2 +-
 builtin/archive.c     | 2 +-
 builtin/blame.c       | 4 ++--
 builtin/config.c      | 2 +-
 builtin/fast-export.c | 4 ++--
 builtin/hash-object.c | 2 +-
 builtin/ls-files.c    | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/archive.c b/archive.c
index 94a9981..b4da255 100644
--- a/archive.c
+++ b/archive.c
@@ -419,7 +419,7 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
 		OPT_STRING(0, "prefix", &base, N_("prefix"),
 			N_("prepend prefix to each pathname in the archive")),
-		OPT_STRING('o', "output", &output, N_("file"),
+		OPT_FILENAME('o', "output", &output,
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
diff --git a/builtin/archive.c b/builtin/archive.c
index a1e3b94..9c96681 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -85,7 +85,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *output = NULL;
 	const char *remote = NULL;
 	struct option local_opts[] = {
-		OPT_STRING('o', "output", &output, N_("file"),
+		OPT_FILENAME('o', "output", &output,
 			N_("write the archive to this file")),
 		OPT_STRING(0, "remote", &remote, N_("repo"),
 			N_("retrieve the archive from remote repository <repo>")),
diff --git a/builtin/blame.c b/builtin/blame.c
index 303e217..9b14c7c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2514,8 +2514,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
-		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
-		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
+		OPT_FILENAME('S', NULL, &revs_file, N_("Use revisions from <file> instead of calling git-rev-list")),
+		OPT_FILENAME(0, "contents", &contents_from, N_("Use <file>'s contents as the final image")),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
diff --git a/builtin/config.c b/builtin/config.c
index 8cc2604..b80922c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -54,7 +54,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
-	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
+	OPT_FILENAME('f', "file", &given_config_source.file, N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
 	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b8182c2..44f2600 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -983,9 +983,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("mode"),
 			     N_("select handling of tags that tag filtered objects"),
 			     parse_opt_tag_of_filtered_mode),
-		OPT_STRING(0, "export-marks", &export_filename, N_("file"),
+		OPT_FILENAME(0, "export-marks", &export_filename,
 			     N_("Dump marks to this file")),
-		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
+		OPT_FILENAME(0, "import-marks", &import_filename,
 			     N_("Import marks from this file")),
 		OPT_BOOL(0, "fake-missing-tagger", &fake_missing_tagger,
 			 N_("Fake a tagger when tags lack one")),
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 6158363..7b13940 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -98,7 +98,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
 		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
-		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
+		OPT_FILENAME( 0 , "path", &vpath, N_("process file as it were from this path")),
 		OPT_END()
 	};
 	int i;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 99cee20..0ddd3a8 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -489,7 +489,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
 			N_("exclude patterns are read from <file>"),
 			0, option_parse_exclude_from },
-		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("file"),
+		OPT_FILENAME(0, "exclude-per-directory", &dir.exclude_per_dir,
 			N_("read additional per-directory exclude patterns in <file>")),
 		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
 			N_("add the standard git exclusions"),
-- 
2.3.0.296.g32c87e1
