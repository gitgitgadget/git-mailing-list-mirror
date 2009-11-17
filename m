From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3] git remote: Separate usage strings for subcommands
Date: Mon, 16 Nov 2009 21:23:27 -0500
Message-ID: <4B02091F.7020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 03:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NADkA-0007oI-Mx
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 03:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbZKQCX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 21:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbZKQCX0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 21:23:26 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:42738 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbZKQCXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 21:23:25 -0500
Received: by yxe17 with SMTP id 17so459439yxe.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 18:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=5/G3rG0dp2uKsmwXIgNM7rUcm+Amc3odQEq1HB5Wv1c=;
        b=Dr5SAHjmrhAiMtBlNXwgPM4BrhkDsHDFcfdTG0/hfajxCDooX+AH8edjv/RAQAb3Eo
         ZmBzKuk6Ub5hudP/brpgy/cGgE8znJxZMCSQlm2lYWXlClYlBkLRq73ecTlq0QKE32pu
         /5B1si+Tsjcn6uY9bHo0Ggn7tvAbHtFK/oeOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=KOvtNF/QD6HS+XvlK+d8Kx69pkJ1z/zB/IvcpRAUr82X2dFLu8TQxK4Z6XyIr0K0WF
         nS/BKO5NCEk4XoX8Y+qZbsa/NpzvIGOv9CWHYkjzTiHuy4KRaYBObZQw2bE3vIV1XhRm
         /eClOYlh6++JkN6jRJxD08/TAGSs/pM8qxCaE=
Received: by 10.150.77.41 with SMTP id z41mr15058072yba.126.1258424610570;
        Mon, 16 Nov 2009 18:23:30 -0800 (PST)
Received: from ?192.168.1.70? ([75.38.216.51])
        by mx.google.com with ESMTPS id 22sm866089ywh.45.2009.11.16.18.23.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 18:23:29 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133052>

When the usage string for a subcommand must be printed,
only print the information relevant to that command.

This commit also removes the options from the first line
of the usage string (replacing them with '<options>...'
and lets them be documented in the paragraph below.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This patch is based on:
http://article.gmane.org/gmane.comp.version-control.git/132953

All usage strings are still only located at the top of file.  However,
separate usage string arrays have been created for each subcommand.

v2 fixed line wrap issues present in v1.

v3 changes include:
  - Changed usage strings to use '<options>...' rather than document
    the options both in the actual string and in the OPT_x array
    (as recommended by Junio).
  - Removed the change made to the usage string array constructed
    in 'cmd_remote'. v2 was broken because that change had made
    the command stop recognizing the '-v' option. Added an extra
    note here which explains that '-v' is only valid when placed
    after 'git remote' and before any 'subcommand'.
  - Updated the man page.


 Documentation/git-remote.txt |   13 +++++----
 builtin-remote.c             |   58 ++++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 82a3d29..c84265a 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -9,14 +9,14 @@ git-remote - manage set of tracked repositories
 SYNOPSIS
 --------
 [verse]
-'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote' [<options>...]
+'git remote add' [<options>...] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
-'git remote set-head' <name> [-a | -d | <branch>]
-'git remote show' [-n] <name>
-'git remote prune' [-n | --dry-run] <name>
-'git remote update' [-p | --prune] [group | remote]...
+'git remote set-head' <name> [<options>...]
+'git remote show' [<options>...] <name>
+'git remote prune' [<options>...] <name>
+'git remote update' [<options>...] [group | remote]...
 
 DESCRIPTION
 -----------
@@ -30,6 +30,7 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
+	NOTE: This must be placed between `remote` and `subcommand`.
 
 
 COMMANDS
diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..ee86810 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -7,18 +7,35 @@
 #include "run-command.h"
 #include "refs.h"
 
+#define REMOTE_BARE_USAGE "git remote [<options>...]"
+#define REMOTE_ADD_USAGE "git remote add [<options>...] <name> <url>"
+#define REMOTE_RENAME_USAGE "git remote rename <old> <new>"
+#define REMOTE_RM_USAGE "git remote rm <name>"
+#define REMOTE_SETHEAD_USAGE "git remote set-head <name> [<options>...]"
+#define REMOTE_SHOW_USAGE "git remote show [<options>...] <name>"
+#define REMOTE_PRUNE_USAGE "git remote prune [<options>...] <name>"
+#define REMOTE_UPDATE_USAGE "git remote update [<options>...]"
+
 static const char * const builtin_remote_usage[] = {
-	"git remote [-v | --verbose]",
-	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
-	"git remote rename <old> <new>",
-	"git remote rm <name>",
-	"git remote set-head <name> [-a | -d | <branch>]",
-	"git remote show [-n] <name>",
-	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [group]",
+	REMOTE_BARE_USAGE,
+	REMOTE_ADD_USAGE,
+	REMOTE_RENAME_USAGE,
+	REMOTE_RM_USAGE,
+	REMOTE_SETHEAD_USAGE,
+	REMOTE_SHOW_USAGE,
+	REMOTE_PRUNE_USAGE,
+	REMOTE_UPDATE_USAGE,
 	NULL
 };
 
+static const char * const builtin_remote_add_usage[] = { REMOTE_ADD_USAGE, NULL };
+static const char * const builtin_remote_rename_usage[] = { REMOTE_RENAME_USAGE, NULL };
+static const char * const builtin_remote_rm_usage[] = { REMOTE_RM_USAGE, NULL };
+static const char * const builtin_remote_sethead_usage[] = { REMOTE_SETHEAD_USAGE, NULL };
+static const char * const builtin_remote_show_usage[] = { REMOTE_SHOW_USAGE, NULL };
+static const char * const builtin_remote_prune_usage[] = { REMOTE_PRUNE_USAGE, NULL };
+static const char * const builtin_remote_update_usage[] = { REMOTE_UPDATE_USAGE, NULL };
+
 #define GET_REF_STATES (1<<0)
 #define GET_HEAD_NAMES (1<<1)
 #define GET_PUSH_REF_STATES (1<<2)
@@ -70,7 +87,6 @@ static int add(int argc, const char **argv)
 	int i;
 
 	struct option options[] = {
-		OPT_GROUP("add specific options"),
 		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
 		OPT_CALLBACK('t', "track", &track, "branch",
 			"branch(es) to track", opt_parse_track),
@@ -79,11 +95,11 @@ static int add(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_add_usage,
 			     0);
 
 	if (argc < 2)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_add_usage, options);
 
 	name = argv[0];
 	url = argv[1];
@@ -540,7 +556,7 @@ static int mv(int argc, const char **argv)
 	int i;
 
 	if (argc != 3)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_rename_usage, options);
 
 	rename.old = argv[1];
 	rename.new = argv[2];
@@ -681,7 +697,7 @@ static int rm(int argc, const char **argv)
 	int i, result;
 
 	if (argc != 2)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_rm_usage, options);
 
 	remote = remote_get(argv[1]);
 	if (!remote)
@@ -984,7 +1000,7 @@ static int show(int argc, const char **argv)
 	struct string_list info_list = { NULL, 0, 0, 0 };
 	struct show_info info;
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
 			     0);
 
 	if (argc < 1)
@@ -1088,7 +1104,7 @@ static int set_head(int argc, const char **argv)
 			    "delete refs/remotes/<name>/HEAD"),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_sethead_usage,
 			     0);
 	if (argc)
 		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
@@ -1114,7 +1130,7 @@ static int set_head(int argc, const char **argv)
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
 			result |= error("Could not delete %s", buf.buf);
 	} else
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_sethead_usage, options);
 
 	if (head_name) {
 		unsigned char sha1[20];
@@ -1138,16 +1154,15 @@ static int prune(int argc, const char **argv)
 {
 	int dry_run = 0, result = 0;
 	struct option options[] = {
-		OPT_GROUP("prune specific options"),
 		OPT__DRY_RUN(&dry_run),
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_prune_usage,
 			     0);
 
 	if (argc < 1)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_prune_usage, options);
 
 	for (; argc; argc--, argv++)
 		result |= prune_remote(*argv, dry_run);
@@ -1228,13 +1243,12 @@ static int update(int argc, const char **argv)
 	struct string_list list = { NULL, 0, 0, 0 };
 	static const char *default_argv[] = { NULL, "default", NULL };
 	struct option options[] = {
-		OPT_GROUP("update specific options"),
 		OPT_BOOLEAN('p', "prune", &prune,
 			    "prune remotes after fetching"),
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_update_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
 		argc = 2;
@@ -1334,7 +1348,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT__VERBOSE(&verbose),
+		OPT_BOOLEAN('v', "verbose", &verbose, "be verbose; must be placed before a subcommand"),
 		OPT_END()
 	};
 	int result;
-- 
1.6.5.2.186.g868bf.dirty
