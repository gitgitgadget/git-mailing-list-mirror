From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Teach git-ls-files about '--' to denote end of options.
Date: Sun, 2 Oct 2005 17:33:38 +0200
Message-ID: <20051002153338.GA1685@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Oct 02 17:35:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM5qb-0008Gp-Vl
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 17:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVJBPdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVJBPdr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 11:33:47 -0400
Received: from [85.8.31.11] ([85.8.31.11]:12987 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751110AbVJBPdq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 11:33:46 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id F04854100; Sun,  2 Oct 2005 17:39:50 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EM5qN-0006eO-00; Sun, 02 Oct 2005 17:33:39 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9618>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 Documentation/git-ls-files.txt |    9 ++++++++-
 ls-files.c                     |    5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

1d1f81648fe42497daff2e95320698fa22ca6440
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 		(-[c|d|o|i|s|u|k|m])\*
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
-		[--exclude-per-directory=<file>]
+		[--exclude-per-directory=<file>] [--] [<file>]\*
 
 DESCRIPTION
 -----------
@@ -77,6 +77,13 @@ OPTIONS
 	K	to be killed
 	?	other
 
+--::
+	Do not interpret any more arguments as options.
+
+<file>:: 
+	Files to show. If no files are given all files which match the other
+	specified criteria are shown.
+
 Output
 ------
 show files just outputs the filename unless '--stage' is specified in
diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -530,7 +530,7 @@ static void verify_pathspec(void)
 static const char ls_files_usage[] =
 	"git-ls-files [-z] [-t] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
-	"[ --exclude-per-directory=<filename> ]";
+	"[ --exclude-per-directory=<filename> ] [--] [<file>]*";
 
 int main(int argc, const char **argv)
 {
@@ -544,6 +544,9 @@ int main(int argc, const char **argv)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
+		if (!strcmp(arg, "--")) {
+			break;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_terminator = 0;
 			continue;
