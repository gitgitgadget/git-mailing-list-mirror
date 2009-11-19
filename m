From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v4] git remote: Separate usage strings for subcommands
Date: Wed, 18 Nov 2009 21:59:46 -0500
Message-ID: <4B04B4A2.8090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 19 04:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAxFe-0005hA-Rb
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 04:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbZKSC7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 21:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbZKSC7u
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 21:59:50 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:63298 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361AbZKSC7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 21:59:47 -0500
Received: by ywh40 with SMTP id 40so946116ywh.33
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 18:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=YbyXEWeouKcjLqQkHv7HZgecHGWrhwGlWTg3ILxAUY4=;
        b=YXaBs9Of5Rs8uSzFFIm/9PoxQNXRwSA0QEd4nuhyVq1/BSexdsVmE2GYlx5W5sXv0I
         v6DXrhJbafWoYuroRrl6VJtnoGvIlQIK2UkziIm+BGqGxUCvwQPvHXwxQXaUXm+CeM4p
         EgEZ2bmS6g6sYNq0HGtM5BcMw1NBCVKpIaOtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=stSxXp5t8SB7k4fEFAJJuUtW3DoF4NHQxwzwJQ4k8lm20HJvQrzhkJdrNe5oNjFVrf
         jLrHR3SWlaYIRnGAFjlGdGPoESNpfkmxPvnHRB4ULL9TO+nU3Y4ynWevhTpJ1KtaAEAc
         BCmF27ZkMaR6NylO/vauUV68Tyfn7dbTXgOTA=
Received: by 10.150.250.33 with SMTP id x33mr600576ybh.31.1258599593290;
        Wed, 18 Nov 2009 18:59:53 -0800 (PST)
Received: from ?192.168.1.70? ([75.38.216.51])
        by mx.google.com with ESMTPS id 20sm50485ywh.47.2009.11.18.18.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Nov 2009 18:59:52 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133209>

When the usage string for a subcommand must be printed,
only print the information relevant to that command.

This commit also removes the options from the first line
of the usage string (replacing them with '<options>'
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

v4 changes include:
 - Changed usage strings to use '<options>' rather than
   '<options>...' based on feedback from Jonathan Nieder.
   See [1] for details.
 - Corrected "git remote set-head" usage string to show the
   required [-a | -d | <branch>] portion of the command.
 - Corrected "git remote update" usage string to show the
   optional, but not otherwise documented [<group> | <remote>]
   portion of the command.
 - Removed 2 more instances of "<subcommand> specific options".

[1] http://thread.gmane.org/gmane.comp.version-control.git/133151/focus=133160


 Documentation/git-remote.txt |   13 +++++----
 builtin-remote.c             |   60 +++++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 82a3d29..ee3dc80 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -9,14 +9,14 @@ git-remote - manage set of tracked repositories
 SYNOPSIS
 --------
 [verse]
-'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
+'git remote' [<options>]
+'git remote add' [<options>] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
-'git remote set-head' <name> [-a | -d | <branch>]
-'git remote show' [-n] <name>
-'git remote prune' [-n | --dry-run] <name>
-'git remote update' [-p | --prune] [group | remote]...
+'git remote set-head' <name> [<options>] [-a | -d | <branch>]
+'git remote show' [<options>] <name>
+'git remote prune' [<options>] <name>
+'git remote update' [<options>] [<group> | <remote>]...
 
 DESCRIPTION
 -----------
@@ -30,6 +30,7 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
+	NOTE: This must be placed between `remote` and `subcommand`.
 
 
 COMMANDS
diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..24a3ec0 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -7,18 +7,35 @@
 #include "run-command.h"
 #include "refs.h"
 
+#define REMOTE_BARE_USAGE "git remote [<options>]"
+#define REMOTE_ADD_USAGE "git remote add [<options>] <name> <url>"
+#define REMOTE_RENAME_USAGE "git remote rename <old> <new>"
+#define REMOTE_RM_USAGE "git remote rm <name>"
+#define REMOTE_SETHEAD_USAGE "git remote set-head <name> [-a | -d | <branch>]"
+#define REMOTE_SHOW_USAGE "git remote show [<options>] <name>"
+#define REMOTE_PRUNE_USAGE "git remote prune [<options>] <name>"
+#define REMOTE_UPDATE_USAGE "git remote update [<options>] [<group> | <remote>]..."
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
@@ -976,7 +992,6 @@ static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
-		OPT_GROUP("show specific options"),
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
 		OPT_END()
 	};
@@ -984,7 +999,7 @@ static int show(int argc, const char **argv)
 	struct string_list info_list = { NULL, 0, 0, 0 };
 	struct show_info info;
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
 			     0);
 
 	if (argc < 1)
@@ -1081,14 +1096,13 @@ static int set_head(int argc, const char **argv)
 	char *head_name = NULL;
 
 	struct option options[] = {
-		OPT_GROUP("set-head specific options"),
 		OPT_BOOLEAN('a', "auto", &opt_a,
 			    "set refs/remotes/<name>/HEAD according to remote"),
 		OPT_BOOLEAN('d', "delete", &opt_d,
 			    "delete refs/remotes/<name>/HEAD"),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_sethead_usage,
 			     0);
 	if (argc)
 		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
@@ -1114,7 +1128,7 @@ static int set_head(int argc, const char **argv)
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
 			result |= error("Could not delete %s", buf.buf);
 	} else
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_sethead_usage, options);
 
 	if (head_name) {
 		unsigned char sha1[20];
@@ -1138,16 +1152,15 @@ static int prune(int argc, const char **argv)
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
@@ -1228,13 +1241,12 @@ static int update(int argc, const char **argv)
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
@@ -1334,7 +1346,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT__VERBOSE(&verbose),
+		OPT_BOOLEAN('v', "verbose", &verbose, "be verbose; must be placed before a subcommand"),
 		OPT_END()
 	};
 	int result;
-- 
1.6.5.2.186.ga4d60
