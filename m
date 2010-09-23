From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv4 3/4] commit: --squash option for use with rebase
 --autosquash
Date: Thu, 23 Sep 2010 11:14:35 -0600
Message-ID: <1285262076-20134-4-git-send-email-patnotz@gmail.com>
References: <1285262076-20134-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 19:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OypP1-00040g-Ay
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab0IWRPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 13:15:09 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:50566 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927Ab0IWRPD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 13:15:03 -0400
X-WSS-ID: 0L97MKY-0C-01D-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 14FCF4FAA9B
	for <git@vger.kernel.org>; Thu, 23 Sep 2010 11:14:47 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 23 Sep 2010 11:14:46 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o8NHEKMu026702 for
 <git@vger.kernel.org>; Thu, 23 Sep 2010 11:14:37 -0600
Received: from s919422.srn.sandia.gov (134.253.71.44) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 23 Sep 2010 11:14:37 -0600
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1285262076-20134-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.9.23.170030
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODY_SIZE_5000_5999 0, BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, __CT
 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __FRAUD_REFNUM 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20100923171447; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230312E34433942384230362E303043373A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 6085548C29K4566328-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156884>

This option makes it convenient to construct commit messages for use
with 'rebase --autosquash'.  The resulting commit message will be
"squash! ..." where "..." is the subject line of the specified commit
message.  This option can be used with other commit message options
such as -m, -c, -C and -F.

If an editor is invoked (as with -c or -eF or no message options) the
commit message is seeded with the correctly formatted subject line.

Example usage:
  $ git commit --squash HEAD~2
  $ git commit --squash HEAD~2 -m "clever comment"
  $ git commit --squash HEAD~2 -F msgfile
  $ git commit --squash HEAD~2 -C deadbeef

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 Documentation/git-commit.txt |    9 ++++++++-
 builtin/commit.c             |   37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f4a2b8c..6e4c220 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C | --fixup) <commit>] [-F <file> | -m <msg>]
+	   [(-c | -C | --fixup | --squash) <commit>] [-F <file> | -m <msg>]
 	   [--reset-author] [--allow-empty] [--allow-empty-message] [--no-verify]
 	   [-e] [--author=<author>] [--date=<date>] [--cleanup=<mode>]
 	   [--status | --no-status] [--] [[-i | -o ]<file>...]
@@ -76,6 +76,13 @@ OPTIONS
 	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
 	for details.
 
+--squash=<commit>::
+	Construct a commit message for use with `rebase --autosquash`.
+	The commit message subject line is taken from the specified
+	commit with a prefix of "squash! ".  Can be used with additional
+	commit message options (`-m`/`-c`/`-C`/`-F`). See
+	linkgit:git-rebase[1] for details.
+
 --reset-author::
 	When used with -C/-c/--amend options, declare that the
 	authorship of the resulting commit now belongs of the committer.
diff --git a/builtin/commit.c b/builtin/commit.c
index 0901616..d28b2ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -69,7 +69,7 @@ static enum {
 static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
-static char *fixup_message;
+static char *fixup_message, *squash_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
@@ -126,6 +126,7 @@ static struct option builtin_commit_options[] = {
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_STRING(0, "fixup", &fixup_message, "COMMIT", "use autosquash formatted message to fixup specified commit"),
+	OPT_STRING(0, "squash", &squash_message, "COMMIT", "use autosquash formatted message to squash specified commit"),
 	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
@@ -567,6 +568,27 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
 
+	if (squash_message) {
+		/*
+		 * Insert the proper subject line before other commit
+		 * message options add their content.
+		 */
+		unsigned char sha1[20];
+		struct commit *commit;
+		struct pretty_print_context ctx = {0};
+
+		if (get_sha1(squash_message, sha1))
+			die("could not lookup commit %s", squash_message);
+		commit = lookup_commit_reference(sha1);
+		if (!commit || parse_commit(commit))
+			die("could not parse commit %s", squash_message);
+
+		if(use_message && strcmp(use_message, squash_message) == 0)
+			strbuf_addstr(&sb,"squash! ");
+		else
+			format_commit_message(commit, "squash! %s\n\n", &sb, &ctx);
+	}
+
 	if (message.len) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
@@ -620,6 +642,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	else if (in_merge)
 		hook_arg1 = "merge";
 
+	if (squash_message) {
+		/*
+		 * If squash_commit was used for the commit subject,
+		 * then we're possibly hijacking other commit log options.
+		 * Reset the hook args to tell the real story.
+		 */
+		hook_arg1 = "message";
+		hook_arg2 = "";
+	}
+
 	fp = fopen(git_path(commit_editmsg), "w");
 	if (fp == NULL)
 		die_errno("could not open '%s'", git_path(commit_editmsg));
@@ -891,7 +923,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("You have nothing to amend.");
 	if (amend && in_merge)
 		die("You are in the middle of a merge -- cannot amend.");
-
+	if (fixup_message && squash_message)
+		die("Options --squash and --fixup cannot be used together");
 	if (use_message)
 		f++;
 	if (edit_message)
-- 
1.7.3
