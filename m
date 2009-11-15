From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH RFC] git remote: Separate usage strings for subcommands
Date: Sun, 15 Nov 2009 16:43:40 -0500
Message-ID: <32c343770911151343y1ed0aak83b43a4ab57eb6ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9muA-0002Y5-Jf
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbZKOVnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 16:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbZKOVnh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:43:37 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42812 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbZKOVng (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 16:43:36 -0500
Received: by bwz27 with SMTP id 27so5088699bwz.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 13:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=71kt8ZLVOedvR0K+DhoDSYxRehcrz4KE7zkTJ6mgg7M=;
        b=sB1OTwC6NGOZuoikzRyoZcNMLtlsjhW2SDeVUAkaOvXduPj7ZDbKvsblKHDJSMcbb5
         EK+ThuBdUA+//EZGXvNv++hs1uATGW24nJmuDUKVKGb3XVzD/5oV5Huq7iwLjCgRmupw
         JHfKB+/8zPyTQZRiBdxhTJ5UqrLBdHkwqEUVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=s2FO5wywjG957PSY0u7rtlyJNJs7uWf+4lSlDdeUpQ/+kCE+5pmynIQHtJ8kuVjTnT
         j8T9pZZ3BCoGezH6e/LftxlRBGz2mPXIXugIAtj9v5fAU2ixnEu1iaNO0EefSwnEffGN
         1EC10G1sOvNZlJHgITOWQGY6tKj2ZpoqaF0hk=
Received: by 10.216.85.213 with SMTP id u63mr390603wee.15.1258321420845; Sun, 
	15 Nov 2009 13:43:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132968>

When the usage string for a subcommand must be printed,
only print the information relevant to that command.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This patch is based on:
http://article.gmane.org/gmane.comp.version-control.git/132953

All usage strings are still only located at the top of file.  However,
separate usage
string arrays have been created for each subcommand.

Does this look like a sane way to structure the code?

If anyone else should be added to the CC list, please let me know.


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
+#define REMOTE_ADD_USAGE	"git remote add [-t <branch>] [-m <master>]
[-f] [--mirror] <name> <url>"
+#define REMOTE_RENAME_USAGE	"git remote rename <old> <new>"
+#define REMOTE_RM_USAGE		"git remote rm <name>"
+#define REMOTE_SETHEAD_USAGE	"git remote set-head <name> [-a | -d | <branch>]"
+#define REMOTE_SHOW_USAGE	"git remote show [-n] <name>"
+#define REMOTE_PRUNE_USAGE	"git remote prune [-n | --dry-run] <name>"
+#define REMOTE_UPDATE_USAGE	"git remote [-v | --verbose] update [-p |
--prune] [group]"
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

+static const char * const builtin_remote_add_usage[] = {
REMOTE_ADD_USAGE, NULL };
+static const char * const builtin_remote_rename_usage[] = {
REMOTE_RENAME_USAGE, NULL };
+static const char * const builtin_remote_rm_usage[] = {
REMOTE_RM_USAGE, NULL };
+static const char * const builtin_remote_sethead_usage[] = {
REMOTE_SETHEAD_USAGE, NULL };
+static const char * const builtin_remote_show_usage[] = {
REMOTE_SHOW_USAGE, NULL };
+static const char * const builtin_remote_prune_usage[] = {
REMOTE_PRUNE_USAGE, NULL };
+static const char * const builtin_remote_update_usage[] = {
REMOTE_UPDATE_USAGE, NULL };
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
-- 
1.6.5.2.185.gb7fba.dirty
