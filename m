From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv5 5/8] commit: --fixup option for use with rebase
 --autosquash
Date: Thu, 7 Oct 2010 13:10:54 -0600
Message-ID: <1286478657-61581-6-git-send-email-patnotz@gmail.com>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 21:12:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vso-0005oH-Ov
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530Ab0JGTL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:11:26 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:35383 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab0JGTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:11:17 -0400
X-WSS-ID: 0L9XPAM-0C-C73-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 18EE8532775
	for <git@vger.kernel.org>; Thu,  7 Oct 2010 13:11:10 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 07 Oct 2010 13:11:05 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o97JAoRF014917 for
 <git@vger.kernel.org>; Thu, 7 Oct 2010 13:10:55 -0600
Received: from sacv8030nk.sandia.gov (134.253.116.144) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 7 Oct 2010 13:11:01 -0600
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.10.7.190315
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODY_SIZE_4000_4999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS
 0, DATE_TZ_NA 0, __CT 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0,
 __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20101007191108; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34434145314234432E303030413A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 60B0C4C32JS4401106-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158439>

This option makes it convenient to construct commit messages for use
with 'rebase --autosquash'.  The resulting commit message will be
"fixup! ..." where "..." is the subject line of the specified commit
message.

Example usage:
  $ git commit --fixup HEAD~2

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 Documentation/git-commit.txt |   14 ++++++++++----
 builtin/commit.c             |   20 ++++++++++++++++----
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 42fb1f5..f4a2b8c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,10 +9,10 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
-	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status] [--]
-	   [[-i | -o ]<file>...]
+	   [(-c | -C | --fixup) <commit>] [-F <file> | -m <msg>]
+	   [--reset-author] [--allow-empty] [--allow-empty-message] [--no-verify]
+	   [-e] [--author=<author>] [--date=<date>] [--cleanup=<mode>]
+	   [--status | --no-status] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -70,6 +70,12 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
+--fixup=<commit>::
+	Construct a commit message for use with `rebase --autosquash`.
+	The commit message will be the subject line from the specified
+	commit with a prefix of "fixup! ".  See linkgit:git-rebase[1]
+	for details.
+
 --reset-author::
 	When used with -C/-c/--amend options, declare that the
 	authorship of the resulting commit now belongs of the committer.
diff --git a/builtin/commit.c b/builtin/commit.c
index e66f10c..851bb59 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -69,6 +69,7 @@ static enum {
 static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
+static char *fixup_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
@@ -124,6 +125,7 @@ static struct option builtin_commit_options[] = {
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
+	OPT_STRING(0, "fixup", &fixup_message, "COMMIT", "use autosquash formatted message to fixup specified commit"),
 	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
@@ -586,6 +588,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
+	} else if (fixup_message) {
+		struct pretty_print_context ctx = {0};
+		struct commit *commit;
+		const char *out_enc;
+		commit = lookup_commit_reference_by_name(fixup_message);
+		out_enc = get_commit_output_encoding();
+		format_commit_message(commit, "fixup! %s\n\n", &sb, &ctx, out_enc);
+		hook_arg1 = "message";
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
 			die_errno("could not read MERGE_MSG");
@@ -863,7 +873,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die("Using both --reset-author and --author does not make sense");
 
-	if (logfile || message.len || use_message)
+	if (logfile || message.len || use_message || fixup_message)
 		use_editor = 0;
 	if (edit_flag)
 		use_editor = 1;
@@ -883,15 +893,17 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		f++;
 	if (edit_message)
 		f++;
+	if (fixup_message)
+		f++;
 	if (logfile)
 		f++;
 	if (f > 1)
-		die("Only one of -c/-C/-F can be used.");
+		die("Only one of -c/-C/-F/--fixup can be used.");
 	if (message.len && f > 0)
-		die("Option -m cannot be combined with -c/-C/-F.");
+		die("Option -m cannot be combined with -c/-C/-F/--fixup.");
 	if (edit_message)
 		use_message = edit_message;
-	if (amend && !use_message)
+	if (amend && !use_message && !fixup_message)
 		use_message = "HEAD";
 	if (!use_message && renew_authorship)
 		die("--reset-author can be used only with -C, -c or --amend.");
-- 
1.7.3.1
