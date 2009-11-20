From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v5] git remote: Separate usage strings for subcommands
Date: Fri, 20 Nov 2009 18:43:13 -0500
Message-ID: <4B072991.1090401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 00:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBd8U-0003MR-Bm
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 00:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbZKTXnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 18:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbZKTXnS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 18:43:18 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44574 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbZKTXnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 18:43:17 -0500
Received: by yxe17 with SMTP id 17so3377356yxe.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=K6a1Pn5DmEAgnTpIABm189lVsIBzOc7woDYvQCsEAJ4=;
        b=w0t6XL0yQOq6uNf2V4MHpcZd2N/N4XMmMbybQcP15Kde2N8I9O/TRZoMZRjYALsRcs
         2/lUY5N9nXX3C6vb8rWtP/U6nxgXgptT/MS7vkl33Zz8kKyvy+0LBPxY6VAqHP5743dI
         /KInThKEuQdTtgzTxA/1PnLyxOF5TJNqytqLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=c7hX2RFRjWDwgDg2C6exptU31gjIwr2DK75mNT0+GmPPTGFc8YOCXnUwqeyFWkVvRv
         i72YshkYG2AlWta4Y1I+gv9U7hwHyC1aI0I/WjLSO8khafB0TeUB1KLO5mdl3J3idTXx
         RoPjCh0ODKMFnbyrwjnnDBuxbo37RX1kbQWZ0=
Received: by 10.101.136.3 with SMTP id o3mr1746647ann.173.1258760600792;
        Fri, 20 Nov 2009 15:43:20 -0800 (PST)
Received: from ?192.168.1.70? ([75.38.216.51])
        by mx.google.com with ESMTPS id 21sm959027yxe.37.2009.11.20.15.43.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 15:43:19 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133387>

When the usage string for a subcommand must be printed,
only print the information relevant to that command.

This commit also removes the complete options list from
the first line of the subcommand usage string. Instead,
individual options are documented in the detailed
description following the general usage line.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This patch is based on:
http://article.gmane.org/gmane.comp.version-control.git/132953

After some misunderstanding on my part, this version of the patch
should be correct.  The following snippet [1] explains the intent:

> Junio C Hamano wrote:
>> Tim Henigan <tim.henigan@gmail.com> writes:
>> 
>> Using the 'add' subcommand as an example, the desired output is:
>>
>> Output of 'git remote -h':
>>     "git remote [-v | --verbose]"
>>     "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>"
>>     etc.
>>
>> Output of 'git remote add -h':
>>     "git remote add [<options>...] <name> <url>"
>>     followed by the detailed description given by 'parse_options()'.
>>
>> Text in 'man git-remote':
>>     "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>"
>>     with the options explained in detail later in the file.
>>
>> Thanks for your patience,
> 
> I think the above looks good;

[1]: http://thread.gmane.org/gmane.comp.version-control.git/133209/focus=133243


 Documentation/git-remote.txt |    7 ++--
 builtin-remote.c             |   66 ++++++++++++++++++++++++++++++-----------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 82a3d29..c272c92 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,10 +13,10 @@ SYNOPSIS
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
-'git remote set-head' <name> [-a | -d | <branch>]
-'git remote show' [-n] <name>
+'git remote set-head' <name> (-a | -d | <branch>)
+'git remote' [-v | --verbose] 'show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote update' [-p | --prune] [group | remote]...
+'git remote' [-v | --verbose] 'update' [-p | --prune] [group | remote]...
 
 DESCRIPTION
 -----------
@@ -30,6 +30,7 @@ OPTIONS
 -v::
 --verbose::
 	Be a little more verbose and show remote url after name.
+	NOTE: This must be placed between `remote` and `subcommand`.
 
 
 COMMANDS
diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..4f4cba4 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -12,13 +12,48 @@ static const char * const builtin_remote_usage[] = {
 	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
-	"git remote set-head <name> [-a | -d | <branch>]",
-	"git remote show [-n] <name>",
+	"git remote set-head <name> (-a | -d | <branch>)",
+	"git remote [-v | --verbose] show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
 	"git remote [-v | --verbose] update [-p | --prune] [group]",
 	NULL
 };
 
+static const char * const builtin_remote_add_usage[] = {
+	"git remote add [<options>] <name> <url>",
+	NULL
+};
+
+static const char * const builtin_remote_rename_usage[] = {
+	"git remote rename <old> <new>",
+	NULL
+};
+
+static const char * const builtin_remote_rm_usage[] = {
+	"git remote rm <name>",
+	NULL
+};
+
+static const char * const builtin_remote_sethead_usage[] = {
+	"git remote set-head <name> (-a | -d | <branch>])",
+	NULL
+};
+
+static const char * const builtin_remote_show_usage[] = {
+	"git remote show [<options>] <name>",
+	NULL
+};
+
+static const char * const builtin_remote_prune_usage[] = {
+	"git remote prune [<options>] <name>",
+	NULL
+};
+
+static const char * const builtin_remote_update_usage[] = {
+	"git remote update [<options>] [<group> | <remote>]...",
+	NULL
+};
+
 #define GET_REF_STATES (1<<0)
 #define GET_HEAD_NAMES (1<<1)
 #define GET_PUSH_REF_STATES (1<<2)
@@ -70,7 +105,6 @@ static int add(int argc, const char **argv)
 	int i;
 
 	struct option options[] = {
-		OPT_GROUP("add specific options"),
 		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
 		OPT_CALLBACK('t', "track", &track, "branch",
 			"branch(es) to track", opt_parse_track),
@@ -79,11 +113,11 @@ static int add(int argc, const char **argv)
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
@@ -540,7 +574,7 @@ static int mv(int argc, const char **argv)
 	int i;
 
 	if (argc != 3)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_rename_usage, options);
 
 	rename.old = argv[1];
 	rename.new = argv[2];
@@ -681,7 +715,7 @@ static int rm(int argc, const char **argv)
 	int i, result;
 
 	if (argc != 2)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_rm_usage, options);
 
 	remote = remote_get(argv[1]);
 	if (!remote)
@@ -976,7 +1010,6 @@ static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
-		OPT_GROUP("show specific options"),
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
 		OPT_END()
 	};
@@ -984,7 +1017,7 @@ static int show(int argc, const char **argv)
 	struct string_list info_list = { NULL, 0, 0, 0 };
 	struct show_info info;
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
 			     0);
 
 	if (argc < 1)
@@ -1081,14 +1114,13 @@ static int set_head(int argc, const char **argv)
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
@@ -1114,7 +1146,7 @@ static int set_head(int argc, const char **argv)
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
 			result |= error("Could not delete %s", buf.buf);
 	} else
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(builtin_remote_sethead_usage, options);
 
 	if (head_name) {
 		unsigned char sha1[20];
@@ -1138,16 +1170,15 @@ static int prune(int argc, const char **argv)
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
@@ -1228,13 +1259,12 @@ static int update(int argc, const char **argv)
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
@@ -1334,7 +1364,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-		OPT__VERBOSE(&verbose),
+		OPT_BOOLEAN('v', "verbose", &verbose, "be verbose; must be placed before a subcommand"),
 		OPT_END()
 	};
 	int result;
-- 
1.6.5.2.186.g3ccc3
