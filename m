From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Add --info-path and --man-path options to git.
Date: Sun,  1 May 2011 18:16:25 +1000
Message-ID: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 10:19:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGRrm-0000Vj-CB
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 10:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab1EAISh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 04:18:37 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63579 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1EAISd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 04:18:33 -0400
Received: by pzk9 with SMTP id 9so2685004pzk.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=/S6jTwkicPoWKWVYrHGKiq382f/+14mxkEyeTqUtTNc=;
        b=C47IH0EO2NMZbiW6X27kQT12OE5z1P9xiggXOdEUbLxRHnhjBPQH1Bmfj6QOZIIY7f
         WSSsQR85vx0yxI0vFHa75epFPe/qaOnPuTV5HARXSPui2zwkDMfX2jgMxsl4Vk3OzD+b
         SLPtTLIQhLAxH2OBLr8wCLTl809cnc872I5V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ok6f3ESyCaF8VZJUHzOdDnBUNht2tCwDx1B51//0HT9nLST0aBXjgwvkPQetJmuT6f
         KekC7AAlhgbioVQvuIW/iiMakoH4clbhpcdL2DiRzdvsbnb7cNOMshFywRGkrJfLGS2w
         Duyjc/ijdDnzwG1+z0/BlHsFunMTWvXSll0q0=
Received: by 10.68.17.65 with SMTP id m1mr7250412pbd.70.1304237913283;
        Sun, 01 May 2011 01:18:33 -0700 (PDT)
Received: from localhost.localdomain (124-149-125-183.dyn.iinet.net.au [124.149.125.183])
        by mx.google.com with ESMTPS id k7sm3048294pbe.32.2011.05.01.01.18.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 01 May 2011 01:18:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc3.46.g7f712.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172531>

To better support git extensions provided by 3rd parties
which would like to install their own man pages and Info files
in the same place as git's own man pages and Info files
add support for --man-path and --info-path options.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git.txt |   10 +++++++++-
 Makefile              |    4 +++-
 git.c                 |    8 +++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e4d43a9..c495322 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--exec-path[=<path>]] [--html-path]
+'git' [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects]
     [--bare] [--git-dir=<path>] [--work-tree=<path>]
     [-c <name>=<value>]
@@ -285,6 +285,14 @@ help ...`.
 	Print the path to wherever your git HTML documentation is installed
 	and exit.
 
+--man-path::
+	Print the path to wherever your git man pages are installed
+	and exit.
+
+--info-path::
+	Print the path to wherever your git Info files are installed
+	and exit.
+
 -p::
 --paginate::
 	Pipe all output into 'less' (or if set, $PAGER) if standard
diff --git a/Makefile b/Makefile
index f5308fe..9119aaa 100644
--- a/Makefile
+++ b/Makefile
@@ -1684,7 +1684,9 @@ strip: $(PROGRAMS) git$X
 
 git.o: common-cmds.h
 git.s git.o: EXTRA_CPPFLAGS = -DGIT_VERSION='"$(GIT_VERSION)"' \
-	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
+	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
+	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
+	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
diff --git a/git.c b/git.c
index ef598c3..60a9403 100644
--- a/git.c
+++ b/git.c
@@ -6,7 +6,7 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=<path>]] [--html-path]\n"
+	"git [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects]\n"
 	"           [--bare] [--git-dir=<path>] [--work-tree=<path>]\n"
 	"           [-c name=value] [--help]\n"
@@ -95,6 +95,12 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (!strcmp(cmd, "--html-path")) {
 			puts(system_path(GIT_HTML_PATH));
 			exit(0);
+		} else if (!strcmp(cmd, "--man-path")) {
+			puts(system_path(GIT_MAN_PATH));
+			exit(0);
+		} else if (!strcmp(cmd, "--info-path")) {
+			puts(system_path(GIT_INFO_PATH));
+			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
-- 
1.7.5.rc3.46.g7f712.dirty
