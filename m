From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 2/5] merge: Make '--log' an integer option for number of shortlog entries
Date: Sun, 22 Aug 2010 21:56:35 +0530
Message-ID: <1282494398-20542-3-git-send-email-artagnon@gmail.com>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 22 18:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnDQE-0003gO-0k
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab0HVQ3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 12:29:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39817 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab0HVQ3C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 12:29:02 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so1793710pwi.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KpH8Vaw9S4p/dJRbKy1+pJ9OzkRbAL8+JZTPtDSBrLg=;
        b=pyTN/xgjEImlaue0RbTq/wG8jm0CzV7yAA7P/ak5E7cFlqYAB9NXeyvKGVDfzQM2FE
         S6z147ErKoSLbcCgkRNIGJ9lE3PVQ+0+XzpafoJUZALWo468KBijQqQiSIg3TMEVSZeP
         2EmAMywY+3LyyPmfMqQBR+G8OsWRtt70ChSLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pRsCo5bmQDzhIcqLc77rEzZAKRd9lyWOarOqEbAT6TjUQr4IvTCgoj40No0qC3Vdbo
         dCBZCpMDqeYORRvwLNfAXTUTWeZo9NrHq5BZ+YZ4xBeV4/cln58KbKUfIo5esKKHRa/U
         SMMAzivgUMMImuIf6exLhMoCUin5sMNjql28o=
Received: by 10.142.154.7 with SMTP id b7mr3441252wfe.92.1282494541752;
        Sun, 22 Aug 2010 09:29:01 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm7089065wff.14.2010.08.22.09.28.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 09:29:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154184>

Change the command-line '--log' option from a boolean option to an
integer option, and parse the optional integer provided on the
command-line into the 'shortlog_len' variable. Also update the
documentation accordingly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Reported-by: Yaroslav Halchenko <debian@onerussian.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Johannes Sixt <j.sixt@viscovery.net>
---
 Documentation/git-fmt-merge-msg.txt |   10 +++++-----
 Documentation/merge-options.txt     |    6 +++---
 builtin/fmt-merge-msg.c             |   25 ++++++++++++++-----------
 builtin/merge.c                     |   18 ++++++++++--------
 4 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 302f56b..14ac466 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] <$GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
 DESCRIPTION
 -----------
@@ -24,10 +24,10 @@ automatically invoking 'git merge'.
 OPTIONS
 -------
 
---log::
+--log[=<n>]::
 	In addition to branch names, populate the log message with
-	one-line descriptions from the actual commits that are being
-	merged.
+	one-line descriptions from at most <n> actual commits that are
+	being merged. If omitted, <n> defaults to 20.
 
 --no-log::
 	Do not list one-line descriptions from the actual commits being
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 722d704..1083f19 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -16,11 +16,11 @@ inspect and further tweak the merge result before committing.
 With --no-ff Generate a merge commit even if the merge
 resolved as a fast-forward.
 
---log::
+--log[=<n>]::
 --no-log::
 	In addition to branch names, populate the log message with
-	one-line descriptions from the actual commits that are being
-	merged.
+	one-line descriptions from <n> actual commits that are being
+	merged. See also linkgit:git-fmt-merge-msg[1].
 +
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 4ed728a..1c5da95 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -7,21 +7,21 @@
 #include "string-list.h"
 
 static const char * const fmt_merge_msg_usage[] = {
-	"git fmt-merge-msg [-m <message>] [--log|--no-log] [--file <file>]",
+	"git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]",
 	NULL
 };
 
-static int merge_summary;
+static int shortlog_len;
 
 static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
 	static int found_merge_log = 0;
 	if (!strcmp("merge.log", key)) {
 		found_merge_log = 1;
-		merge_summary = git_config_bool(key, value);
+		shortlog_len = git_config_bool(key, value);
 	}
 	if (!found_merge_log && !strcmp("merge.summary", key))
-		merge_summary = git_config_bool(key, value);
+		shortlog_len = git_config_bool(key, value);
 	return 0;
 }
 
@@ -318,10 +318,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *inpath = NULL;
 	const char *message = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
-		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
-		  "alias for --log (deprecated)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
+		  "populate log with <n> entries from shortlog",
+		  PARSE_OPT_OPTARG, NULL, 20 },
+		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
+                  "alias for --log (deprecated)",
+		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL, 20 },
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
@@ -337,7 +339,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (message && !merge_summary) {
+	if (message && !shortlog_len) {
 		char nl = '\n';
 		write_in_full(STDOUT_FILENO, message, strlen(message));
 		write_in_full(STDOUT_FILENO, &nl, 1);
@@ -354,10 +356,11 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		die_errno("could not read input file");
 	if (message) {
 		strbuf_addstr(&output, message);
-		ret = fmt_merge_msg(&input, &output, 0, 20);
+		ret = fmt_merge_msg(&input, &output, 0,
+				    shortlog_len);
 	} else {
 		ret = fmt_merge_msg(&input, &output, 1,
-				    merge_summary ? 20 : 0);
+				    shortlog_len);
 	}
 	if (ret)
 		return ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index d47f48f..994b0c5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -42,7 +42,7 @@ static const char * const builtin_merge_usage[] = {
 	NULL
 };
 
-static int show_diffstat = 1, option_log, squash;
+static int show_diffstat = 1, shortlog_len, squash;
 static int option_commit = 1, allow_fast_forward = 1;
 static int fast_forward_only;
 static int allow_trivial = 1, have_message;
@@ -177,8 +177,9 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOLEAN(0, "stat", &show_diffstat,
 		"show a diffstat at the end of the merge"),
 	OPT_BOOLEAN(0, "summary", &show_diffstat, "(synonym to --stat)"),
-	OPT_BOOLEAN(0, "log", &option_log,
-		"add list of one-line log to merge commit message"),
+	{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
+	  "populate log with <n> entries from shortlog",
+	  PARSE_OPT_OPTARG, NULL, 20 },
 	OPT_BOOLEAN(0, "squash", &squash,
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
@@ -505,7 +506,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
-		option_log = git_config_bool(k, v);
+		shortlog_len = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
@@ -1013,14 +1014,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < argc; i++)
 			merge_name(argv[i], &merge_names);
 
-		if (have_message && option_log)
-			fmt_merge_msg(&merge_names, &merge_msg, 0, 20);
+		if (have_message && shortlog_len)
+			fmt_merge_msg(&merge_names, &merge_msg, 0,
+				      shortlog_len);
 		else if (!have_message)
 			fmt_merge_msg(&merge_names, &merge_msg, 1,
-				      option_log ? 20: 0);
+				      shortlog_len);
 
 
-		if (!(have_message && !option_log) && merge_msg.len)
+		if (!(have_message && !shortlog_len) && merge_msg.len)
 			strbuf_setlen(&merge_msg, merge_msg.len-1);
 	}
 
-- 
1.7.2.2.409.gdbb11.dirty
