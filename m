From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v6 2/3] merge: Make '--log' an integer option for number of shortlog entries
Date: Wed, 25 Aug 2010 16:18:49 +0530
Message-ID: <1282733330-32334-3-git-send-email-artagnon@gmail.com>
References: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 12:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoDZe-0001Cc-G7
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 12:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435Ab0HYKvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 06:51:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43217 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab0HYKvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 06:51:09 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so152024pvg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OD2os1EkRB38SDPkTFB7lN2Um3I6KDs0m7rez3yJOzg=;
        b=bX0UpqNXUlDXIjcdauRUSPQzqBXLWJTupe2QfOtCDgDKMgis7awZ2uDaiYI3CLf1kd
         hTeefY7+EDXNlCMgzsTidxKWVPoaVevtvQ+o5OlUT2q90KkEuyIv1pe1m0FOIkpLlUQN
         zDdg48VhU+J4r5Wkjt0J479OCM/3akzSLL87g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TypglGnHHBEpTsUFM+qGWXWgR1OdA3PHqBvRJNW2+gntB1NmBn6+IkrZKu3U8bPduD
         6RWspiD6NoUlPsJ3QDduvshezj+W+pKDmVvjZAvBJzJTs7AaAJXnk92WJ8qZ0JgocM/6
         2LA+u/U5n1nVCFAAF+DleQwzO0GS+kORV24fE=
Received: by 10.114.137.15 with SMTP id k15mr9186694wad.217.1282733468765;
        Wed, 25 Aug 2010 03:51:08 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d38sm2037882wam.20.2010.08.25.03.51.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 03:51:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154440>

Change the command-line '--log' option from a boolean option to an
integer option, and parse the optional integer provided on the
command-line into the 'shortlog_len' variable. Also update the
documentation accordingly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Reported-by: Yaroslav Halchenko <debian@onerussian.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fmt-merge-msg.txt |   10 ++++++----
 Documentation/merge-options.txt     |    6 +++---
 builtin/fmt-merge-msg.c             |   26 ++++++++++++++++----------
 builtin/merge.c                     |   13 +++++++------
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 302f56b..f04a9ff 100644
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
@@ -24,10 +24,12 @@ automatically invoking 'git merge'.
 OPTIONS
 -------
 
---log::
+--log[=<n>]::
 	In addition to branch names, populate the log message with
 	one-line descriptions from the actual commits that are being
-	merged.
+	merged.  At most <n> commits from each merge parent will be
+	used (20 if <n> is omitted).  This overrides the `merge.log`
+	configuration variable.
 
 --no-log::
 	Do not list one-line descriptions from the actual commits being
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 722d704..e33e0f8 100644
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
+	one-line descriptions from at most <n> actual commits that are being
+	merged. See also linkgit:git-fmt-merge-msg[1].
 +
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7f06b95..ec933df 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -7,21 +7,24 @@
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
+		shortlog_len = git_config_bool(key, value) ? DEFAULT_MERGE_LOG_LEN : 0;
+		return 0;
+	}
+	if (!found_merge_log && !strcmp("merge.summary", key)) {
+		shortlog_len = git_config_bool(key, value) ? DEFAULT_MERGE_LOG_LEN : 0;
+		return 0;
 	}
-	if (!found_merge_log && !strcmp("merge.summary", key))
-		merge_summary = git_config_bool(key, value);
 	return 0;
 }
 
@@ -318,10 +321,13 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *inpath = NULL;
 	const char *message = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
-		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
+		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
+		  "populate log with <n> entries from shortlog",
+		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
+		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
 		  "alias for --log (deprecated)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL,
+		  DEFAULT_MERGE_LOG_LEN},
 		OPT_STRING('m', "message", &message, "text",
 			"use <text> as start of message"),
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
@@ -337,7 +343,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	if (message && !merge_summary) {
+	if (message && !shortlog_len) {
 		char nl = '\n';
 		write_in_full(STDOUT_FILENO, message, strlen(message));
 		write_in_full(STDOUT_FILENO, &nl, 1);
@@ -357,7 +363,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		strbuf_addstr(&output, message);
 	ret = fmt_merge_msg(&input, &output,
 			    message ? 0 : 1,
-			    merge_summary ? DEFAULT_MERGE_LOG_LEN : 0);
+			    shortlog_len);
 
 	if (ret)
 		return ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index 1f4d68d..b067b84 100644
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
+	  "add (at most <n>) entries from shortlog to merge commit message",
+	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 	OPT_BOOLEAN(0, "squash", &squash,
 		"create a single commit instead of doing a merge"),
 	OPT_BOOLEAN(0, "commit", &option_commit,
@@ -507,7 +508,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	else if (!strcmp(k, "pull.octopus"))
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
-		option_log = git_config_bool(k, v);
+		shortlog_len = git_config_bool(k, v) ? DEFAULT_MERGE_LOG_LEN : 0;
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
 	return git_diff_ui_config(k, v, cb);
@@ -1017,9 +1018,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < argc; i++)
 			merge_name(argv[i], &merge_names);
 
-		if (!have_message || option_log) {
+		if (!have_message || shortlog_len) {
 			fmt_merge_msg(&merge_names, &merge_msg, !have_message,
-				      option_log ? DEFAULT_MERGE_LOG_LEN : 0);
+				      shortlog_len);
 			if (merge_msg.len)
 				strbuf_setlen(&merge_msg, merge_msg.len - 1);
 		}
-- 
1.7.2.2.409.gdbb11.dirty
