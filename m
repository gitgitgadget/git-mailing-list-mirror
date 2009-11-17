From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH RFC v2] git remote: Separate usage strings for subcommands
Date: Mon, 16 Nov 2009 19:59:07 -0500
Message-ID: <4B01F55B.8050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NACPg-0007xh-Jt
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZKQA7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbZKQA7H
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:59:07 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:49440 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbZKQA7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:59:05 -0500
Received: by gxk26 with SMTP id 26so1368241gxk.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Vfje7ZHBasSLEX4TC4Uo8LOHRd70gB4Gi7RmP6nyNKQ=;
        b=hXD0SFir9CZkfaKGa9YA9Bgd7jGx2YM0sRDyDl2XbWjIVs/yWnQqKw5Vzemu3V2dJT
         6OpkpGdRiOyrpoP8xll3Q4/xxCoqgk18404pfkoWhL1i13PQ8Uk3ZN/22AeeAlVCimfV
         81Or2ranp7fQxunu6EbJf1g+DtiM/LM0+C25M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Bs/ft9yvvVmVl3pypR88hPcDHPXaHVY0sG9Uz7ayUNZkVk5sNPMxf8g6/vEVSv2HRC
         1aEz5ss3ecIdtU2JQ0kBchlmV1S4SXIuc0BkuNC4vfW/Tail3yyicG7SEHUB1zFG4nTy
         NN0DqC1Kn1Ac7cnc72dNhGCluMBJTBqNgTa3k=
Received: by 10.91.26.14 with SMTP id d14mr4506635agj.84.1258419550234;
        Mon, 16 Nov 2009 16:59:10 -0800 (PST)
Received: from ?192.168.1.70? ([75.38.216.51])
        by mx.google.com with ESMTPS id 36sm52305yxh.67.2009.11.16.16.59.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 16:59:09 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133048>

When the usage string for a subcommand must be printed,
only print the information relevant to that command.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This is a resend -- v1 had line wrap issues.  Sorry for the noise.

This patch is based on:
http://article.gmane.org/gmane.comp.version-control.git/132953

All usage strings are still only located at the top of file.  However,
separate usage string arrays have been created for each subcommand.

Does this look like a sane way to structure the code?


 builtin-remote.c |   57 +++++++++++++++++++++++++++++++++--------------------
 1 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..ec65a4b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -7,18 +7,35 @@
 #include "run-command.h"
 #include "refs.h"
 
+#define REMOTE_BARE_USAGE	"git remote [-v | --verbose]"
+#define REMOTE_ADD_USAGE	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>"
+#define REMOTE_RENAME_USAGE	"git remote rename <old> <new>"
+#define REMOTE_RM_USAGE		"git remote rm <name>"
+#define REMOTE_SETHEAD_USAGE	"git remote set-head <name> [-a | -d | <branch>]"
+#define REMOTE_SHOW_USAGE	"git remote show [-n] <name>"
+#define REMOTE_PRUNE_USAGE	"git remote prune [-n | --dry-run] <name>"
+#define REMOTE_UPDATE_USAGE	"git remote [-v | --verbose] update [-p | --prune] [group]"
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
@@ -1334,7 +1348,6 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT__VERBOSE(&verbose),
 		OPT_END()
 	};
 	int result;
-- 1.6.5.2.185.gb7fba.dirty 
