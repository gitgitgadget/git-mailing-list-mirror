From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Make git status usage say git status instead of git commit
Date: Sun,  2 Dec 2007 23:02:09 -0600
Message-ID: <1196658129-16708-1-git-send-email-shawn.bohrer@gmail.com>
Cc: gitster@pobox.com, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 06:02:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3Rr-0002uM-6K
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbXLCFCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXLCFCH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:02:07 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:7194 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXLCFCF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:02:05 -0500
Received: by an-out-0708.google.com with SMTP id d31so673860and
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 21:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=3aobqwseN9W4FU6JYhRoQksXmUkuG5BuAA9fRCZWN+U=;
        b=h/v8/flOl6+CuJn+GZyp/L1Etb1U1tQISSKv2N5LfBb94LrLxHmaQ/Y/WBYldA2tP0PO9iXaXdS8Iz8pT+28fr8TXL9nPhZBDOyPKd3ideD/fc6H6klK7WtiFsVNhZlXFZwD1mA+UJeINUFzAIbr090PuXfiHNrJniCCZV6qz6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=N3BlGIvYFDZAUqI0OmqcNsXmBMjtbd5nw/30TnpjEr1fv2kTea1xTOE5GU13Ia5L3+aqXb20zbXffEOop/vufKgqJ3AGJuMkFIWnM4tjU6JeWBvbCMtdKyCBxgXL0XmjKY+FP6lRv/AwhL1mdzsMUjs/dYua3nRiV8s4UHxYu7I=
Received: by 10.100.171.10 with SMTP id t10mr19171238ane.1196658124000;
        Sun, 02 Dec 2007 21:02:04 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id l43sm2738949wrl.2007.12.02.21.02.01
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 21:02:02 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Sun,  2 Dec 2007 23:02:09 -0600
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66861>

git status shares the same usage information as git commit since it
shows what would be committed if the same options are given.  However,
when displaying the usage information for git status it should say it
is for git status not git commit.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---

As a side question, should the usage information also use the non dash
notation of the command since it is deprecated?  I noticed all of the
other commands are presently using the dash form, so I left it as is for
now.

 builtin-commit.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f6e8e44..5e85a22 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -27,6 +27,11 @@ static const char * const builtin_commit_usage[] = {
 	NULL
 };
 
+static const char * const builtin_status_usage[] = {
+	"git-status [options] [--] <filepattern>...",
+	NULL
+};
+
 static unsigned char head_sha1[20], merge_head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
@@ -495,12 +500,12 @@ static void determine_author_info(struct strbuf *sb)
 	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, 1));
 }
 
-static int parse_and_validate_options(int argc, const char *argv[])
+static int parse_and_validate_options(int argc, const char *argv[],
+				      const char * const usage[])
 {
 	int f = 0;
 
-	argc = parse_options(argc, argv, builtin_commit_options,
-			     builtin_commit_usage, 0);
+	argc = parse_options(argc, argv, builtin_commit_options, usage, 0);
 
 	if (logfile || message.len || use_message)
 		no_edit = 1;
@@ -597,7 +602,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	git_config(git_status_config);
 
-	argc = parse_and_validate_options(argc, argv);
+	argc = parse_and_validate_options(argc, argv, builtin_status_usage);
 
 	index_file = prepare_index(argc, argv, prefix);
 
@@ -689,7 +694,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	git_config(git_commit_config);
 
-	argc = parse_and_validate_options(argc, argv);
+	argc = parse_and_validate_options(argc, argv, builtin_commit_usage);
 
 	index_file = prepare_index(argc, argv, prefix);
 
-- 
1.5.3.6
