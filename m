From: Greg Price <price@ksplice.com>
Subject: [PATCH] commit: --cleanup is a message option
Date: Tue, 29 Dec 2009 16:54:49 -0500
Message-ID: <1262123689-28789-1-git-send-email-price@ksplice.com>
Cc: git@vger.kernel.org, Greg Price <price@ksplice.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPk59-0003Ub-TI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZL2V6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZL2V6S
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:58:18 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:63062 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751482AbZL2V6R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2009 16:58:17 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nBTLsOWD011984;
	Tue, 29 Dec 2009 16:54:25 -0500 (EST)
Received: from localhost (KID-ICARUS.MIT.EDU [18.187.2.218])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nBTLtEnf001550;
	Tue, 29 Dec 2009 16:55:14 -0500 (EST)
X-Mailer: git-send-email 1.6.6
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135839>

In the usage message for "git commit", the --cleanup option appeared
at the end, as one of the "contents options":

usage: git commit [options] [--] <filepattern>...
...
Commit message options
...
Commit contents options
...
    --allow-empty         ok to record an empty change
    --cleanup <default>   how to strip spaces and #comments from message

This is confusing, in part because it makes it ambiguous whether
--allow-empty, just above, refers to an empty diff or an empty message.

Move --cleanup into the 'message options' group.  Also add a pair of
comments to prevent similar oversights in the future.

Signed-off-by: Greg Price <price@ksplice.com>
---
Apologies to Junio for the duplicate; vger.kernel.org didn't like the envelope
sender on my last message.

 builtin-commit.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f54772f..33aa593 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -86,8 +86,8 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 static struct option builtin_commit_options[] = {
 	OPT__QUIET(&quiet),
 	OPT__VERBOSE(&verbose),
-	OPT_GROUP("Commit message options"),
 
+	OPT_GROUP("Commit message options"),
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
@@ -97,6 +97,8 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
+	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
+	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
 	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
@@ -108,7 +110,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
-	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
+	/* end commit contents options */
 
 	OPT_END()
 };
-- 
1.6.6
