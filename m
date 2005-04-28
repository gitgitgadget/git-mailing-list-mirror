From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add short options to show-files
Date: Thu, 28 Apr 2005 17:48:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504281742580.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:43:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGmr-0006KX-7T
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVD1Vsn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVD1Vsn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:48:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23075 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262264AbVD1Vse
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:48:34 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFO006TLF8YH8@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Apr 2005 17:48:34 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The show-files long options are cumbersome to type.  This patch adds 
equivalent short options.

Also add missing "unmerged" to usage string.

Finally reduce the number of lines for argument parsing in half.

Signed-off-by: Nicolas Pitre <nico@cam.org>

--- k/show-files.c
+++ l/show-files.c
@@ -206,6 +206,10 @@ static void show_files(void)
 	}
 }
 
+static const char *show_files_usage =
+	"show-files [-z] (--[cached|deleted|others|stage|unmerged])* "
+	"[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]";
+
 int main(int argc, char **argv)
 {
 	int i;
@@ -215,55 +219,30 @@ int main(int argc, char **argv)
 
 		if (!strcmp(arg, "-z")) {
 			line_terminator = 0;
-			continue;
-		}
-
-		if (!strcmp(arg, "--cached")) {
+		} else if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
 			show_cached = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--deleted")) {
+		} else if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
 			show_deleted = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--others")) {
+		} else if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
 			show_others = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--ignored")) {
+		} else if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
 			show_ignored = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--stage")) {
+		} else if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
 			show_stage = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--unmerged")) {
+		} else if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
 			// There's no point in showing unmerged unless you also show the stage information
 			show_stage = 1;
 			show_unmerged = 1;
-			continue;
-		}
-
-		if (!strcmp(arg, "-x") && i+1 < argc) {
+		} else if (!strcmp(arg, "-x") && i+1 < argc) {
 			add_exclude(argv[++i]);
-			continue;
-		}
-		if (!strncmp(arg, "--exclude=", 10)) {
+		} else if (!strncmp(arg, "--exclude=", 10)) {
 			add_exclude(arg+10);
-			continue;
-		}
-		if (!strcmp(arg, "-X") && i+1 < argc) {
+		} else if (!strcmp(arg, "-X") && i+1 < argc) {
 			add_excludes_from_file(argv[++i]);
-			continue;
-		}
-		if (!strncmp(arg, "--exclude-from=", 15)) {
+		} else if (!strncmp(arg, "--exclude-from=", 15)) {
 			add_excludes_from_file(arg+15);
-			continue;
-		}
-
-		usage("show-files [-z] (--[cached|deleted|others|stage])* "
-		      "[ --ignored [--exclude=<pattern>] [--exclude-from=<file>) ]");
+		} else
+			usage(show_files_usage);
 	}
 
 	if (show_ignored && !nr_excludes) {
